def convertSaveFolder
  folder = RTP.getSaveFolder
  #load in data needed for conversions
  File.open("Scripts/ConversionClasses.rb"){|f| eval(f.read) }
  #IDs are not compiled; this grabs them directly from their PBS hash
  File.open("Scripts/"+GAMEFOLDER+"/montext.rb"){|f| eval(f.read) }
  File.open("Scripts/"+GAMEFOLDER+"/movetext.rb"){|f| eval(f.read) }
  File.open("Scripts/"+GAMEFOLDER+"/itemtext.rb"){|f| eval(f.read) }
  File.open("Scripts/"+GAMEFOLDER+"/abiltext.rb"){|f| eval(f.read) }
  #errors here are terrifying and we like safety
  Dir.mkdir(folder+"Conversion Backup") unless (File.exists?(folder+"Conversion Backup"))
  filecount = Dir.new(folder).count{|file| file.end_with?(".rxdata")}
  conversioncount = 0
  return if filecount == 0

  backupSaveFiles(folder)
  
  Dir.foreach(folder) do |filename|
    next if filename == '.' || filename == '..' || filename == "Conversion Backup" || !filename.end_with?(".rxdata")
    next if filename != "Game.rxdata" && !(filename =~ /Game_\d+\.rxdata/)
    conversioncount += 1
    newsave = {}
    puts filename
    dir = folder + filename
    begin #protection for corrupt saves
      File.open(dir){|f|
        trainer    = Marshal.load(f)
        if trainer.is_a?(Hash) #if it's a hash, then this save has already been converted.
          conversioncount -= 1
          next
        end
        newsave[:playtime]   = Marshal.load(f)
        newsave[:system]     = Marshal.load(f)
        Marshal.load(f) #dropping pokemonsystem in favor of clientdata
        newsave[:map_id]    = Marshal.load(f) # Current map id no longer needed
        #REJUV SILLY MAPS GO HERE TO CATCH
        newsave[:switches]  = Marshal.load(f) # Why does removing these break shit
        newsave[:variable]  = Marshal.load(f)
        newsave[:self_switches]     = Marshal.load(f)
        newsave[:game_screen]   = Marshal.load(f)
        Marshal.load(f) #killing mapfactory????
        newsave[:game_player]   = Marshal.load(f)
        global     = Marshal.load(f)
        newsave[:PokemonMap] = Marshal.load(f)
        bag    = Marshal.load(f)
        storage    = Marshal.load(f)
        achievements = Marshal.load(f) if Rejuv
        
        bag = collectItems(bag,global.pcItemStorage)
        global.pcItemStorage = nil if global.pcItemStorage
        trainer = convertTrainer(trainer)
        storage = convertStorage(storage)
        trainer = convertDex(trainer,storage)
        global = convertGlobal(global,storage)
        newsave[:PokemonBag] = bag
        newsave[:Trainer] = trainer
        newsave[:Trainer].achievements = achievementConvert(achievements) if Rejuv
        newsave[:PokemonStorage] = storage
        newsave[:PokemonGlobal] = global
        #print "stop"
        save_data(newsave,dir)
        
      }
      percent = (100.0*conversioncount/filecount).round
      System.set_window_title("#{percent}\% converted...")
    rescue
      puts "Save '#{dir}' is corrupt!"
      filecount -= 1
      next
    end
  end
  System.set_window_title(GAMETITLE)
end

def backupSaveFiles(folder)
  Dir.mkdir(folder+"Conversion Backup") unless (File.exists?(folder+"Conversion Backup"))
  Dir.foreach(folder) do |filename|
    next if !filename.end_with?(".rxdata")
    File.open(folder + filename, "rb") do |input|
      File.open(folder + "Conversion Backup" + "/" + filename, "wb") do |output|
        while buff = input.read(4096)
          output.write(buff)
        end
      end
    end
  end
end

def collectItems(bag,pc)
  newbag = PokemonBag.new()
  for pocket in bag.pockets #get all of the items out of the bag
    next if pocket == nil
    for item in pocket #get all the items in a pocket
      next if item == nil
      itemsym = nil
      item[0] = itemfixer(item[0]) if Desolation
      for i in ITEMHASH.keys #convert pocket item to symbol
        if ITEMHASH[i][:ID] == item[0]
          itemsym = i
          break
        end
      end
      #puts itemsym
      newbag.pbStoreItem(itemsym,  item[1]) #it's basically just a discount hash.
    end
  end
  return newbag if !pc #if you don't have an item pc, you're free to go.
  for item in 0...pc.length #pc is a little less complicated.
    itemsym = nil
    for i in ITEMHASH.keys #convert pocket item to symbol
      if ITEMHASH[i][:ID] == item[0]
        itemsym = i
        break
      end
    end
    newbag.pbStoreItem(itemsym,  item[1]) #it's basically just a discount hash.
  end
  return newbag
end

def convertTrainer(trainer)
  newparty = []
  for mon in trainer.party
    newparty.push(convertMon(mon))
  end
  trainer.party = newparty
=begin
  $cache.trainertypes.each{|sym, data|
    $Trainer.trainertype = sym if data.checkFlag?(:ID) == $Trainer.trainertype
  }
  $Trainer.trainertype = $cache.trainertypes.keys[0] if $Trainer.trainertype.is_a?(Integer)
=end
  return trainer
end

def convertStorage(storage)
  for box in 0...storage.maxBoxes
    newbox = []
    for index in 0...storage[box].length
      mon = storage[box, index]
      next if !mon
      storage[box, index] = convertMon(mon)
    end
  end
  storage.upTotalBoxes(STORAGEBOXES)
  return storage
end

def convertDex(trainer,storage)
  #newtrainer = deep_copy(trainer)
  if !trainer.pokedex.nil?
    puts "Converting dex..."
    time = Time.now
    newdex = Pokedex.new()
    newdex.initDexList()
    for mon in 1...newdex.dexList.length
      symbol = $cache.pkmn.keys[mon - 1]
      newdex.dexList[symbol][:seen?] = trainer.seen[mon]
      newdex.dexList[symbol][:owned?] = trainer.owned[mon]
      newdex.dexList[symbol][:shadowCaught?] = trainer.shadowcaught[mon]
    end
    newdex.canViewDex = trainer.pokedex
    trainer.pokedex = newdex
    for boxes in storage.boxes
      for mon in boxes
        if mon != nil
          trainer.pokedex.setFormSeen(mon)
        end
      end
    end
    trainer.seen = nil
    trainer.owned = nil
    trainer.shadowcaught = nil
    trainer.formseen = nil
    trainer.formlastseen = nil
    puts "Done! - Took #{Time.now - time} sec"
  end
  return trainer
end

def convertGlobal(global,storage)
  daycare = []
  if global.daycare[0][0]
    newmon = convertMon(global.daycare[0][0])
    global.daycare[0][0] = newmon
  end
  if global.daycare[1][0]
    newmon = convertMon(global.daycare[1][0])
    global.daycare[1][0] = newmon
  end
  global.dependentEvents = [] if !global.dependentEvents
  global.hallOfFame = [] if !global.hallOfFame
  global.hallOfFameLastNumber = 0 if !global.hallOfFameLastNumber
  if !global.purifyChamber
    global.purifyChamber=PurifyChamber.new()
  else
    for i in 0...10
      setList = global.purifyChamber.setList(i)
      if setList.length > 0
        for j in 0...setList.length
          newmon = convertMon(setList[j])
          storage.pbStoreCaught(newmon)
        end
      end
      shadow = global.purifyChamber.getShadow(i)
      if !shadow.nil?
        newmon = convertMon(shadow)
        storage.pbStoreCaught(newmon)
        global.purifyChamber.setShadow(i,nil)
      end
      j = setList.length
      while j > -1
        global.purifyChamber.insertAt(i,j,nil)
        j -= 1
      end
    end
  end
  return global
end

def convertMon(mon)
  newmoves = []
  for move in mon.moves
    for i in MOVEHASH.keys
      if MOVEHASH[i][:ID] == move.id
        newmove = PBMove.new(i)
        newmove.pp = move.pp
        newmove.ppup = move.ppup
        newmoves.push(newmove)
        break
      end
    end
  end
  mon.moves = newmoves
  firstmoves = []
  if !mon.firstmoves.nil?
    for move in mon.firstmoves
      for j in MOVEHASH.keys
        if MOVEHASH[j][:ID] == move
          newmove = PBMove.new(j)
          firstmoves.push(newmove.move)
          break
        end
      end
    end
    mon.firstmoves = firstmoves
  end
  if mon.shadowmoves
    newShadows = []
    for move in mon.shadowmoves
      if move == 0
        newShadows.push(0)
        next
      end
      for i in MOVEHASH.keys
        if MOVEHASH[i][:ID] == move
          newShadows.push(i)
          break
        end
      end
    end
    mon.shadowmoves = newShadows
  end
  mon.item = nil if mon.item == 0
  mon.item = itemfixer(mon.item) if Desolation
  mon.item = zcrystalfix(mon.item) if !Desolation
  for i in ITEMHASH.keys
    if ITEMHASH[i][:ID] == mon.item
      mon.item = i 
      break
    end
  end
  mon.initZmoves(mon.item,true) if pbIsZCrystal?(mon.item)
  for i in BallHandlers::BallTypes.keys
    if i == mon.ballused
      mon.ballused = BallHandlers::BallTypes[i] 
      break
    end
  end
  for i in MONHASH.keys
    formname = MONHASH[i].keys[0]
    if MONHASH[i][formname][:dexnum] == mon.species
      mon.species = i 
      break
    end
  end
  mon.level = PBExp.levelFromExperience(mon.exp, mon.growthrate)
  if mon.level == 0
    mon.level = 1
    mon.exp = PBExp.startExperience(1,mon.growthrate)
  end
  mon.form = 0 if !mon.form
  mon.form = formfixer(mon) if Rejuv
  speed = mon.iv.delete_at(3)
  mon.iv.push(speed)
  speed = mon.ev.delete_at(3)
  mon.ev.push(speed)
  mon.initAbility
  mon.ability == :AURABREAK if mon.species == :ZYGARDE
  mon.setNature($cache.natures.keys[mon.natureflag]) if mon.natureflag != nil
  mon.nature = $cache.natures.keys[mon.personalID%25]
  mon.status = nil if mon.status == 0
  mon.fused = convertMon(mon.fused) if mon.fused.is_a?(PokeBattle_Pokemon)
  return mon
end

def tempConvertNatures
  for mon in $Trainer.party
    next if mon.nature.is_a?(Symbol)
    mon.setNature($cache.natures.keys[mon.natureflag]) if mon.natureflag != nil
    mon.nature = $cache.natures.keys[mon.personalID%25]
    
  end
  for box in 0...$PokemonStorage.maxBoxes
    for index in 0...$PokemonStorage[box].length
      mon = $PokemonStorage[box, index]
      next if !mon
      next if mon.nature.is_a?(Symbol)
      mon.setNature($cache.natures.keys[mon.natureflag]) if mon.natureflag != nil
      mon.nature = $cache.natures.keys[mon.personalID%25]

    end
  end
end

def zcrystalfix(item)
  crystals = [719,721,723,725,727,729,731,733,735,737,739,741,743,745,747,749,751,753,755,757,759,761,763,765,767,769,771,773]
  crystals += [782,784,786,788,790,792] if Reborn
  crystals += [843,845,847,849,851,853] if Rejuv
  return item - 1 if crystals.include?(item) 
  return nil if item == 1044 && Rejuv
  return item
end

def formfixer(mon)
  if mon.species == :LAPRAS
    return 1 if mon.form == 2
    return mon.form
  elsif mon.species == :AMPHAROS
    return 1 if mon.form == 2
    return mon.form
  elsif mon.species == :TOXTRICITY
    return 2 if mon.form == 4
    return mon.form
  else
    return mon.form
  end
end

def powerconstructhunt(storage,trainerparty,daycare)
  for box in 0...storage.maxBoxes
    for index in 0...storage[box].length
      mon = storage[box, index]
      next if !mon
      mon.ability = :AURABREAK if mon.species == :ZYGARDE
    end
  end
  for mon in trainerparty
    mon.ability = :AURABREAK if mon.species == :ZYGARDE
  end
  if daycare[0][0]
    daycare[0][0].ability = :AURABREAK if daycare[0][0].species == :ZYGARDE
  end
  if daycare[1][0]
    daycare[1][0].ability = :AURABREAK if daycare[1][0].species == :ZYGARDE
  end
end