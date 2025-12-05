################################################################################
# General purpose utilities
################################################################################
def _pbNextComb(comb,length)
  i=comb.length-1
  begin
    valid=true
    for j in i...comb.length
      if j==i
        comb[j]+=1
      else
        comb[j]=comb[i]+(j-i)
      end
      if comb[j]>=length
        valid=false
        break
      end
    end
    return true if valid
    i-=1
  end while i>=0
  return false
end

# Iterates through the array and yields each combination of _num_ elements in
# the array.
def pbEachCombination(array,num)
  return if array.length<num || num<=0
  if array.length==num
    yield array
    return
  elsif num==1
    for x in array
      yield [x]
    end
    return
  end
  currentComb=[]
  arr=[]
  for i in 0...num
    currentComb[i]=i
  end
  begin
    for i in 0...num
      arr[i]=array[currentComb[i]]
    end
    yield arr
  end while _pbNextComb(currentComb,array.length)
end

def gameGoByeByeNow
  $scene = nil
  return
end

# Returns a language ID
def pbGetLanguage()
  return System.user_language
end

################################################################################
# Player-related utilities, random name generator
################################################################################
def pbChangePlayer(id)
  return false if id<0
  meta=$cache.metadata[:Players][id]
  return false if !meta
  $Trainer.trainertype=meta[:tclass] if $Trainer
  $game_player.character_name=meta[:walk]
  $game_player.character_hue=0
  $PokemonGlobal.playerID=id
  $Trainer.metaID=id if $Trainer
end

def pbGetPlayerGraphic
  id=$PokemonGlobal.playerID
  return "" if id<0
  meta=$cache.metadata[:Players][id]
  return "" if !meta
  return pbPlayerSpriteFile(meta[:tclass])
end
 
def pbGetPlayerID(variableNumber)
  ret=$PokemonGlobal.playerID
  pbSet(variableNumber,ret)
  return nil
end
 
def pbGetPlayerTrainerType
  id=$PokemonGlobal.playerID
  return 0 if id<0
  meta=$cache.metadata[:Players][id]
  return 0 if !meta
  return meta[:tclass]
end 

def pbGetTrainerTypeGender(trainertype)
  return 2
end

def pbTrainerName(name=nil)
  if $PokemonGlobal.playerID<0
    pbChangePlayer(0)
  end
  trainertype=pbGetPlayerTrainerType
  trname=name
  if trname==nil
 trname=pbEnterText(_INTL("Your name?"),0,12)
 gender=pbGetTrainerTypeGender(trainertype) 
    if trname==""
      trname=pbSuggestTrainerName(gender)
    end
  end
  $Trainer=PokeBattle_Trainer.new(trname,trainertype)
  $PokemonBag=PokemonBag.new
  $PokemonTemp.begunNewGame=true
end

def pbSuggestTrainerName(gender)
  userName=pbGetUserName()
  userName=userName.gsub(/\s+.*$/,"")
  if userName.length>0 && userName.length<12
    userName[0,1]=userName[0,1].upcase
    return userName
  end
  userName=userName.gsub(/\d+$/,"")
  if userName.length>0 && userName.length<12
    userName[0,1]=userName[0,1].upcase
    return userName
  end
  return getRandomNameEx(gender,nil,1,7)
end

def pbGetUserName()
  return ["Frank","Johnathan","Joelle","Charlene"][rand(4)] if $Settings.streamermode && $Settings.streamermode==1
  return System.user_name
end

def pbGuessPlayerName()
  userName=pbGetUserName()
  userName=userName.gsub(/\s+.*$/,"")
  if userName.length>0
    userName[0,1]=userName[0,1].upcase
    return userName
  end
  userName=userName.gsub(/\d+$/,"")
  if userName.length>0
    userName[0,1]=userName[0,1].upcase
    return userName
  end
  print("couldn't get username [ #{userName}] please report this message: ")
  #owner=MiniRegistry.get(MiniRegistry::HKEY_LOCAL_MACHINE,
  #   "SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion",
  #   "RegisteredOwner","")
  #owner=owner.gsub(/\s+.*$/,"")
  #if owner.length>0 && owner.length<7
  #  owner[0,1]=owner[0,1].upcase
  #  return owner
  #end
  return 0
end

def getRandomNameEx(type,variable,upper,maxLength=100)
  return "" if maxLength<=0
  name=""
  50.times {
    name=""
    formats=[]
    case type
      when 0 # Names for males
        formats=%w( F5 BvE FE FE5 FEvE )
      when 1 # Names for females
        formats=%w( vE6 vEvE6 BvE6 B4 v3 vEv3 Bv3 )
      when 2 # Neutral gender names
        formats=%w( WE WEU WEvE BvE BvEU BvEvE )
      else
        return ""
    end
    format=formats[rand(formats.length)]
    format.scan(/./) {|c|
       case c
         when "c" # consonant
           set=%w( b c d f g h j k l m n p r s t v w x z )
           name+=set[rand(set.length)]
         when "v" # vowel
           set=%w( a a a e e e i i i o o o u u u )
           name+=set[rand(set.length)]
         when "W" # beginning vowel
           set=%w( a a a e e e i i i o o o u u u au au ay ay 
              ea ea ee ee oo oo ou ou )
           name+=set[rand(set.length)]
         when "U" # ending vowel
           set=%w( a a a a a e e e i i i o o o o o u u ay ay ie ie ee ue oo )
           name+=set[rand(set.length)]
         when "B" # beginning consonant
           set1=%w( b c d f g h j k l l m n n p r r s s t t v w y z )
           set2=%w(
              bl br ch cl cr dr fr fl gl gr kh kl kr ph pl pr sc sk sl
              sm sn sp st sw th tr tw vl zh )
           name+=rand(3)>0 ? set1[rand(set1.length)] : set2[rand(set2.length)]
         when "E" # ending consonant
           set1=%w( b c d f g h j k k l l m n n p r r s s t t v z )
           set2=%w( bb bs ch cs ds fs ft gs gg ld ls
              nd ng nk rn kt ks
              ms ns ph pt ps sk sh sp ss st rd
              rn rp rm rt rk ns th zh)
           name+=rand(3)>0 ? set1[rand(set1.length)] : set2[rand(set2.length)]
         when "f" # consonant and vowel
           set=%w( iz us or )
           name+=set[rand(set.length)]
         when "F" # consonant and vowel
           set=%w( bo ba be bu re ro si mi zho se nya gru gruu glee gra glo ra do zo ri
              di ze go ga pree pro po pa ka ki ku de da ma mo le la li )
           name+=set[rand(set.length)]
         when "2"
           set=%w( c f g k l p r s t )
           name+=set[rand(set.length)]
         when "3"
           set=%w( nka nda la li ndra sta cha chie )
           name+=set[rand(set.length)]
         when "4"
           set=%w( una ona ina ita ila ala ana ia iana )
           name+=set[rand(set.length)]
         when "5"
           set=%w( e e o o ius io u u ito io ius us )
           name+=set[rand(set.length)]
         when "6"
           set=%w( a a a elle ine ika ina ita ila ala ana )
           name+=set[rand(set.length)]
       end
    }
    break if name.length<=maxLength
  }
  name=name[0,maxLength]
  case upper
    when 0
      name=name.upcase
    when 1
      name[0,1]=name[0,1].upcase
  end
  if $game_variables && variable
    $game_variables[variable]=name
    $game_map.need_refresh = true if $game_map
  end
  return name
end

def getRandomName(maxLength=100)
  return getRandomNameEx(2,nil,nil,maxLength)
end

def loadTrainerCard(trainername,trainermoney=0,trainerbadges=0,trainerid=$Trainer.id)
  $Trainer.tempname = $Trainer.name
  $Trainer.tempmoney = $Trainer.money
  $Trainer.tempbadges = $Trainer.badges
  $Trainer.tempid = $Trainer.id
  $Trainer.name = trainername
  $Trainer.money = trainermoney
  badgearray = []
  for i in 0...17
    badgearray[i]=  i < trainerbadges ? true : nil
  end
  $Trainer.badges = badgearray
  $Trainer.id = trainerid
end

def restoreTrainerCard
  $Trainer.name = $Trainer.tempname
  $Trainer.money = $Trainer.tempmoney
  $Trainer.badges = $Trainer.tempbadges
  $Trainer.id = $Trainer.tempid
end

################################################################################
# Event timing utilities
################################################################################
def pbTimeEvent(variableNumber,secs=86400)
  if variableNumber && variableNumber>=0
    if $game_variables
      secs=0 if secs<0
      timenow=pbGetTimeNow
      $game_variables[variableNumber]=[timenow.to_f,secs]
      $game_map.refresh if $game_map
    end
  end
end

def pbTimeEventDays(variableNumber,days=0)
  if variableNumber && variableNumber>=0
    if $game_variables
      days=0 if days<0
      timenow=pbGetTimeNow
      time=timenow.to_f
      expiry=(time%86400.0)+(days*86400.0)
      $game_variables[variableNumber]=[time,expiry-time]
      $game_map.refresh if $game_map
    end
  end
end

def pbTimeEventValid(variableNumber)
  retval=false
  if variableNumber && variableNumber>=0 && $game_variables
    value=$game_variables[variableNumber]
    if value.is_a?(Array)
      timenow=pbGetTimeNow
      retval=(timenow.to_f - value[0] > value[1]) # value[1] is age in seconds
      retval=false if value[1]<=0 # zero age
    end
    if !retval
      $game_variables[variableNumber]=0
      $game_map.refresh if $game_map
    end
  end
  return retval
end



################################################################################
# Constants utilities
################################################################################
def hasConst?(mod,constant)
  return false if !mod || !constant || constant==""
  begin
    return mod.const_defined?(constant.to_sym) 
  rescue 
    print("broken constant #{constant}")
    print caller
    return false
  end
end

def getConst(mod,constant)
  return nil if !mod || !constant
  begin
    return mod.const_get(constant.to_sym)
  rescue 
    return nil
  end
end

################################################################################
# Implements methods that act on arrays of items.  Each element in an item
# array is itself an array of [itemID, itemCount].
# Used by the Bag, PC item storage, and Triple Triad.
################################################################################
module ItemStorageHelper
  # Returns the quantity of the given item in the items array, maximum size per slot, and item ID
  def self.pbQuantity(items,maxsize,item)
    ret=0
    for i in 0...maxsize
      itemslot=items[i]
      if itemslot && itemslot[0]==item
        ret+=itemslot[1]
      end
    end
    return ret
  end

  # Deletes an item from items array, maximum size per slot, item, and number of items to delete
  def self.pbDeleteItem(items,maxsize,item,qty)
    raise "Invalid value for qty: #{qty}" if qty<0
    return true if qty==0
    ret=false
    for i in 0...maxsize
      itemslot=items[i]
      if itemslot && itemslot[0]==item
        amount=[qty,itemslot[1]].min
        itemslot[1]-=amount
        qty-=amount
        items[i]=nil if itemslot[1]==0
        if qty==0
          ret=true
          break
        end
      end
    end
    items.compact!
    return ret
  end

  def self.pbCanStore?(items,maxsize,maxPerSlot,item,qty)
    raise "Invalid value for qty: #{qty}" if qty<0
    return true if qty==0
    for i in 0...maxsize
      itemslot=items[i]
      if !itemslot
        qty-=[qty,maxPerSlot].min
        return true if qty==0
      elsif itemslot[0]==item && itemslot[1]<maxPerSlot
        newamt=itemslot[1]
        newamt=[newamt+qty,maxPerSlot].min
        qty-=(newamt-itemslot[1])
        return true if qty==0
      end
    end
    return false
  end

  def self.pbStoreItem(items,maxsize,maxPerSlot,item,qty,sorting=false)
    raise "Invalid value for qty: #{qty}" if qty<0
    return true if qty==0
    for i in 0...maxsize 
      itemslot=items[i]
      if !itemslot     
        items[i]=[item,[qty,maxPerSlot].min]
        qty-=items[i][1]
        if sorting && POCKETAUTOSORT[pbGetPocket(item)]
          if  pbGetPocket(item)==4
           pocket  = items
           counter = 1
           while counter < pocket.length
             index     = counter
             while index > 0
               indexPrev = index - 1
               firstName  = (((getItemName(pocket[indexPrev][0])).sub("TM","00")).sub("X","100")).to_i
               secondName = (((getItemName(pocket[index][0])).sub("TM","00")).sub("X","100")).to_i
               if firstName > secondName
                 aux               = pocket[index] 
                 pocket[index]     = pocket[indexPrev]
                 pocket[indexPrev] = aux
               end
               index -= 1
             end
             counter += 1
           end
          elsif pbGetPocket(item)==5
           items.sort!
          end         
        end
        return true if qty==0
      elsif itemslot[0]==item && itemslot[1]<maxPerSlot
        newamt=itemslot[1]
        newamt=[newamt+qty,maxPerSlot].min
        qty-=(newamt-itemslot[1])
        itemslot[1]=newamt
        return true if qty==0
      end
    end
    return false
  end
end

################################################################################
# General-purpose utilities with dependencies
################################################################################
# Similar to pbFadeOutIn, but pauses the music as it fades out.
# Requires scripts "Audio" (for bgm_pause) and "SpriteWindow" (for pbFadeOutIn).
def pbFadeOutInWithMusic(zViewport)
  playingBGS=$game_system.getPlayingBGS
  playingBGM=$game_system.getPlayingBGM
  $game_system.bgm_pause(1.0)
  $game_system.bgs_pause(1.0)
  pos=$game_system.bgm_position
  pbFadeOutIn(zViewport) {
     yield
     $game_system.bgm_position=pos
     $game_system.bgm_resume(playingBGM)
     $game_system.bgs_resume(playingBGS)
  }
end

def pbHideVisibleObjects
  begin
    visibleObjects=[]
    ObjectSpace.each_object(Viewport){|o|
      if !o.disposed? && o.visible
        visibleObjects.push(o)
        o.visible=false
      end
    }
    ObjectSpace.each_object(Tilemap){|o|
      if !o.disposed? && o.visible
        visibleObjects.push(o)
        o.visible=false
      end
    }
    # ObjectSpace.each_object(Window){|o|
    #   if !o.disposed? && o.visible
    #     visibleObjects.push(o)
    #     o.visible=false
    #   end
    # }
  rescue
    visibleObjects=[]
  end
    return visibleObjects
end

def pbShowObjects(visibleObjects)
  for o in visibleObjects
    if !pbDisposed?(o)
      o.visible=true
    end
  end
end

def pbLoadRpgxpScene(scene)
  return if !$scene.is_a?(Scene_Map)
  oldscene=$scene
  $scene=scene
  Graphics.freeze
  oldscene.disposeSpritesets
  visibleObjects=pbHideVisibleObjects
  
  Graphics.transition(15)
  Graphics.freeze
  Graphics.update
  
  while $scene && !$scene.is_a?(Scene_Map)
    $scene.main
  end
  Graphics.transition(15)
  Graphics.freeze
  oldscene.createSpritesets
  pbShowObjects(visibleObjects)
  Graphics.transition(20)
  $scene=oldscene
end

# Runs a common event and waits until the common event is finished.
# Requires the script "PokemonMessages"
def pbCommonEvent(id)
  return false if id<0
  ce=$cache.RXevents[id]
  return false if !ce
  celist=ce.list
  interp=Interpreter.new
  interp.setup(celist,0)
  begin
    Graphics.update
    Input.update
    interp.update
    pbUpdateSceneMap
  end while interp.running?
  return true
end

def pbExclaim(event,id=EXCLAMATION_ANIMATION_ID,tinting=false)
  if event.is_a?(Array)
    sprite=nil
    done=[]
    for i in event
      if !done.include?(i.id)
        sprite=$scene.spriteset.addUserAnimation(id,i.x,i.y-1,tinting)
        done.push(i.id)
      end
    end
  else
    sprite=$scene.spriteset.addUserAnimation(id,event.x,event.y-1,tinting)
  end
  while !sprite.disposed?
    Graphics.update
    Input.update
    pbUpdateSceneMap
  end
end

def pbNoticePlayer(event)
#  if !pbFacingEachOther(event,$game_player)
    pbExclaim(event)
 # end
  pbTurnTowardEvent($game_player,event)
  Kernel.pbMoveTowardPlayer(event)
end
  

################################################################################
# Loads Pokémon/item/trainer graphics
################################################################################
def pbPokemonBitmap(species, shiny=false, back=false, gender=nil, form = 0, looped = false)   # Used by the Pokédex
  return false if species == nil
  gender = $Trainer.pokedex.dexList[species][:lastSeen][:gender] if gender == nil && species != 0 && !looped
  if form.is_a?(String)
    form = $Trainer.pokedex.dexList[species][:forms].keys.index(form)
  end
  form = 0 if cancelledgenders.include?(species) || form == nil
  formnumber = form == 0 ? "" : "_"+form.to_s
  formname = $cache.pkmn[species].forms[form]
  gendermod = gender == "Female" ? "_f" : ""
  dexnum = $cache.pkmn[species].dexnum if !looped #.name.downcase
  dexname = species.to_s.downcase
  bitmapFileName=sprintf("Graphics/Battlers/%03d%s",dexnum,gendermod)
  bitmapFileName=sprintf("Graphics/Battlers/%03d",dexnum) if !pbResolveBitmap(bitmapFileName)
  bitmapFileName=sprintf("Graphics/Battlers/%s%s",dexname,gendermod) if !pbResolveBitmap(bitmapFileName)
  bitmapFileName=sprintf("Graphics/Battlers/%s",dexname) if !pbResolveBitmap(bitmapFileName)
  toobig = $cache.pkmn[species].flags[:toobig] || ($cache.pkmn[species].formData[formname] != nil && $cache.pkmn[species].formData[formname][:toobig])
  if toobig
    backtag = back ? "b" : ""
    shinytag = shiny ? "s" : ""
    bitmapFileName=sprintf("Graphics/Battlers/%03d%s%s%s%s.png",dexnum,gendermod,shinytag,backtag,formnumber)
    bitmapFileName=sprintf("Graphics/Battlers/%03d%s%s%s.png",dexnum,shinytag,backtag,formnumber) if !pbResolveBitmap(bitmapFileName)
    bitmapFileName=sprintf("Graphics/Battlers/%s%s%s%s%s.png",dexname,gendermod,shinytag,backtag,formnumber) if !pbResolveBitmap(bitmapFileName)
    bitmapFileName=sprintf("Graphics/Battlers/%s%s%s%s.png",dexname,shinytag,backtag,formnumber) if !pbResolveBitmap(bitmapFileName)
  end
  return nil if !pbResolveBitmap(bitmapFileName)
  monbitmap = RPG::Cache.load_bitmap(bitmapFileName)
  if !toobig
    x = shiny ? 192 : 0
    y = 0 + form*384
    y+= 192 if back
  else
    x = 0
    y = 0
  end
  maxx = toobig ? monbitmap.width : 192
  maxy = toobig ? monbitmap.height : 192
  if monbitmap.height <= y
    resetHeight = true
    y = 0
  end
  bitmap=Bitmap.new(maxx,maxy)
  rectangle = Rect.new(x,y,maxx,maxy)
  bitmap.blt(0,0,monbitmap,rectangle)
  return bitmap if !resetHeight
  if looped
    p "#{$cache.pkmn.keys[$cache.pkmn[species].dexnum - 1]} form #{form}#{back ? " back" : ""} missing graphic"
    return nil
  end
  return pbPokemonBitmap(species,shiny,back,gender,form,true)
end

def pbLoadPokemonBitmap(pokemon, back=false)
  return pbLoadPokemonBitmapSpecies(pokemon,nil,back) if pokemon == "substitute"
  return pbLoadPokemonBitmapSpecies(pokemon,pokemon.species,back)
end

def HiddenPowerChanger(mon)
  pbHiddenPower(mon) if !mon.hptype
  oldtype=mon.hptype
  typechoices = [_INTL("Bug"),_INTL("Dark"),_INTL("Dragon"),_INTL("Electric"),_INTL("Fairy"),_INTL("Fighting"),_INTL("Fire"),_INTL("Flying"),_INTL("Ghost"),_INTL("Grass"),_INTL("Ground"),_INTL("Ice"),_INTL("Poison"),_INTL("Psychic"),_INTL("Rock"),_INTL("Steel"),_INTL("Water"),_INTL("Cancel")]
  choosetype = Kernel.pbMessage(_INTL("Which type should its move become?"),typechoices,18)
  case choosetype
    when 0 then newtype=:BUG
    when 1 then newtype=:DARK
    when 2 then newtype=:DRAGON
    when 3 then newtype=:ELECTRIC
    when 4 then newtype=:FAIRY
    when 5 then newtype=:FIGHTING
    when 6 then newtype=:FIRE
    when 7 then newtype=:FLYING
    when 8 then newtype=:GHOST
    when 9 then newtype=:GRASS
    when 10 then newtype=:GROUND
    when 11 then newtype=:ICE
    when 12 then newtype=:POISON
    when 13 then newtype=:PSYCHIC
    when 14 then newtype=:ROCK
    when 15 then newtype=:STEEL
    when 16 then newtype=:WATER
    else newtype=-1
  end
  if newtype == -1
    Kernel.pbMessage(_INTL("Changed your mind?"))
    return false
  end
  if (choosetype >= 0) && (choosetype < 17) && newtype!=oldtype
    mon.hptype=newtype
    Kernel.pbMessage(_INTL("The Hidden Power of your {1} is now {2} type.", mon.name, mon.hptype)) # Gen 9 Mod - Added message mentioning the new type
    return true
  end
  if newtype==oldtype
    Kernel.pbMessage(_INTL("It's already that type!"))
  else
    Kernel.pbMessage(_INTL("Changed your mind?"))
  end
  return false
end

ShitList = [:EXEGGUTOR,:KYUREM,:STEELIX,:CLAWITZER,:SWALOT]
ShitList = [:EXEGGUTOR,:KYUREM,:STEELIX,:AVALUGG,:CLAWITZER,:SWALOT,:TANGROWTH] if Reborn
# This is a lie now; leaving it in case we care later: Note: Returns an AnimatedBitmap, not a Bitmap
def pbLoadPokemonBitmapSpecies(pokemon, species, back=false)
  #load dummy bitmap
  #ret=AnimatedBitmap.new(pbResolveBitmap("Graphics/pixel"))
  if pokemon=="substitute"
    if !back
      bitmapFileName=sprintf("Graphics/Battlers/substitute")
    else
      bitmapFileName=sprintf("Graphics/Battlers/substitute_b")
    end    
    bitmapFileName=pbResolveBitmap(bitmapFileName)
    ret=Bitmap.new(bitmapFileName)
    return ret
  end
  dexnum = $cache.pkmn[species].dexnum
  dexname = species.to_s.downcase
  formname = $cache.pkmn[species].forms[pokemon.form]
  toobig = $cache.pkmn[species].flags[:toobig] || ($cache.pkmn[species].formData[formname] != nil && $cache.pkmn[species].formData[formname][:toobig])
  if (pokemon.form !=0 && (ShitList.include?(species))) || toobig
    if !(species == :STEELIX && pokemon.form == 1)  #mega steelix is excused.
      shinytag = pokemon.isShiny? ? "s" : ""
      formnumber = pokemon.form == 0 ? "" : "_"+pokemon.form.to_s
      backtag = back ? "b" : ""
      bitmapfilename2 = sprintf("Graphics/Battlers/%03d%s%s%s",dexnum,shinytag,backtag,formnumber)
      bitmapfilename2 = sprintf("Graphics/Battlers/%03d%s%s",dexnum,shinytag,backtag) if !pbResolveBitmap(bitmapfilename2)
      bitmapfilename2 = sprintf("Graphics/Battlers/%s%s%s%s",dexname,shinytag,backtag,formnumber) if !pbResolveBitmap(bitmapfilename2)
      bitmapfilename2 = sprintf("Graphics/Battlers/%s%s%s",dexname,shinytag,backtag) if !pbResolveBitmap(bitmapfilename2)
      if pbResolveBitmap(bitmapfilename2)
        bitmap = RPG::Cache.load_bitmap(bitmapfilename2)
        if toobig #accounting for the sprite being sized directly to the pokemon with no blank space
          bitmapResize = Bitmap.new(bitmap.width + 8, bitmap.height + 8)
          bitmapResize.blt(4,4,bitmap,Rect.new(0,0,bitmap.width,bitmap.height))
          bitmap=bitmapResize
          #bitmap.to_file(sprintf("test.png"))
        end
        if Rejuv
          if pokemon.item == :BLKPRISM || (pokemon.ability == :PRISMPOWER && pokemon.prismPower == true)
            bitmap = makePrismBitmap(bitmap, bitmap.width, bitmap.height) 
          else
            bitmap = makeShadowBitmap(bitmap, bitmap.width, bitmap.height) if pokemon.isShadow?
            bitmap = makePetrifiedBitmap(bitmap, bitmap.width, bitmap.height) if pokemon.status == :PETRIFIED
          end
        else
          bitmap = makeShadowBitmap(bitmap, bitmap.width, bitmap.height) if pokemon.isShadow?
          bitmap = makePetrifiedBitmap(bitmap, bitmap.width, bitmap.height) if pokemon.status == :PETRIFIED
        end
        return bitmap
      end
    end
  end
  x = pokemon.isShiny? ? 192 : 0
  x = 0 if pokemon.isPulse? || toobig || pokemon.isRift?
  y = pokemon.form*384
  y = 8*384 if (species == :SILVALLY && pokemon.form == 19) #Vulpes abusing her dev priviledges
  y = pokemon.form*192 if pokemon.isEgg?
  y += back ? 192 : 0
  y = 0 if toobig
  gendermod = pokemon.gender == 1 ? "f" : ""
  height = 192
  if pokemon.isEgg?
    #eggs are 64*64 instead of 192*192
    x/=3
    y/=3
    height/=3
    shinytag = pokemon.isShiny? ==true ? "s" : ""
    bitmapFileName=sprintf("Graphics/Battlers/%03d%s%sEgg",dexnum,gendermod,shinytag)
    bitmapFileName=sprintf("Graphics/Battlers/%s%s%sEgg",dexname,gendermod,shinytag) if !pbResolveBitmap(bitmapFileName)
    if pbResolveBitmap(bitmapFileName)
      x = 0
    end
    bitmapFileName=sprintf("Graphics/Battlers/%03d%sEgg",dexnum,gendermod) if !pbResolveBitmap(bitmapFileName)
    bitmapFileName=sprintf("Graphics/Battlers/%03dEgg",dexnum) if !pbResolveBitmap(bitmapFileName)
    bitmapFileName=sprintf("Graphics/Battlers/%s%sEgg",dexname,gendermod) if !pbResolveBitmap(bitmapFileName)
    bitmapFileName=sprintf("Graphics/Battlers/%sEgg",dexname) if !pbResolveBitmap(bitmapFileName)
    bitmapFileName=sprintf("Graphics/Battlers/Egg") if !pbResolveBitmap(bitmapFileName)
    bitmapFileName=pbResolveBitmap(bitmapFileName)
  else
    bitmapFileName=pbCheckPokemonBitmapFiles(dexname,dexnum,pokemon.isFemale?)
    bitmapFileName=pbCheckPokemonBitmapFiles(dexname,dexnum,false) if !pbResolveBitmap(bitmapFileName)
    bitmapFileName=sprintf("Graphics/Battlers/000") if !pbResolveBitmap(bitmapFileName)
    # Alter bitmap if supported
  end
  spritesheet = RPG::Cache.load_bitmap(bitmapFileName)
  bitmap=Bitmap.new(height,height)
  if spritesheet.height <= y && pokemon.isFemale? && !pokemon.isEgg?
    bitmapFileName=pbCheckPokemonBitmapFiles(dexname,dexnum)
    spritesheet = RPG::Cache.load_bitmap(bitmapFileName)
    bitmap=Bitmap.new(height,height)
  end
  if spritesheet.height <= y
    y = 0
    y += back ? 192 : 0
  end
  rectangle = Rect.new(x,y,height,height)
  bitmap.blt(0,0,spritesheet,rectangle)
  bitmapResize = Bitmap.new(bitmap.width + 8, bitmap.height + 8)
  bitmapResize.blt(4,4,bitmap,Rect.new(0,0,bitmap.width,bitmap.height))
  bitmap=bitmapResize
  bitmap = makeShadowBitmap(bitmap, bitmap.width, height) if pokemon.isShadow?
  bitmap = makePrismBitmap(bitmap, bitmap.width, height) if pokemon.item == :BLKPRISM 
  bitmap = makePetrifiedBitmap(bitmap, bitmap.width, height) if pokemon.status == :PETRIFIED
  if pokemon.species == :SPINDA && !pokemon.isEgg?
    #bitmap.each {|bitmap|
    pbSpindaSpots(pokemon,bitmap)
    #}
  end
  return bitmap
end

def makePrismBitmapOld(bitmap, width, height)
  newbitmap = Bitmap.new(width,height)
  newbitmap2 = Bitmap.new(width,height)
  min = width+1
  max = -1
  for w in 0...width/2
    for h in 0...height/2
      pixcolor = bitmap.get_pixel(w*2,h*2)
      next if pixcolor.alpha != 255
      if w < min
        min = w
      end
      if w > max
        max = w
      end
    end
  end
  size = (max - min)
  add = 0
  for w in 0...width/2
    if w >= min
      rgb = hslToRGB(0+add,100,50)
      col = Color.new(rgb[0],rgb[1],rgb[2], 200)
      col2 = Color.new(rgb[0],rgb[1],rgb[2], 70)
      add += (360/size)
    end
    for h in 0...height/2
      border = []
      pixcolor = bitmap.get_pixel(w*2,h*2)
      next if pixcolor.alpha != 255

      border.push([w*2+2,h*2]) if bitmap.get_pixel(w*2+2,h*2).alpha != 255 #right
      border.push([w*2-2,h*2]) if bitmap.get_pixel(w*2-2,h*2).alpha != 255 #left
      border.push([w*2,h*2+2]) if bitmap.get_pixel(w*2,h*2+2).alpha != 255 #down
      border.push([w*2,h*2-2]) if bitmap.get_pixel(w*2,h*2-2).alpha != 255 #up
      for loc in border
        border2 = []
        newbitmap.set_pixel(loc[0],loc[1],col)
        newbitmap.set_pixel(loc[0]+1,loc[1],col)
        newbitmap.set_pixel(loc[0],loc[1]+1,col)
        newbitmap.set_pixel(loc[0]+1,loc[1]+1,col)
      
        border2.push([loc[0]+2,loc[1]]) if bitmap.get_pixel(loc[0]+2,loc[1]).alpha < 200 #right
        border2.push([loc[0]-2,loc[1]]) if bitmap.get_pixel(loc[0]-2,loc[1]).alpha < 200 #left
        border2.push([loc[0],loc[1]+2]) if bitmap.get_pixel(loc[0],loc[1]+2).alpha < 200 #down
        border2.push([loc[0],loc[1]-2]) if bitmap.get_pixel(loc[0],loc[1]-2).alpha < 200 #up
        for loc2 in border2
          newbitmap2.set_pixel(loc2[0],loc2[1],col2)
          newbitmap2.set_pixel(loc2[0]+1,loc2[1],col2)
          newbitmap2.set_pixel(loc2[0],loc2[1]+1,col2)
          newbitmap2.set_pixel(loc2[0]+1,loc2[1]+1,col2)
        end
      end
    end
  end
  bitmap.blt(0,0,newbitmap2,Rect.new(0,0,width,height))
  bitmap.blt(0,0,newbitmap,Rect.new(0,0,width,height))
  return bitmap
end

def makePrismBitmap(bitmap, width, height)
  colors = bitmap.raw_data.unpack("I*").map{|i| i.to_color }
  min = width+1
  max = -1
  for x in 0...width/2
    for y in 0...height/2
      color = colors[bitmap.pixel(x*2, y*2)]
      next if color.alpha != 255
      if x < min
        min = x
      end
      if x > max
        max = x
      end
    end
  end
  max += 2
  min -= 2
  #hacky stuff to cheat intiializing to stay within gradient
  size = (max - min)
  add = 0

  for x in 0...width/2
    if x >= min
      rgb = hslToRGB(0+add,100,50)
      rainbowAura1 = Color.new(rgb[0],rgb[1],rgb[2], 200)
      rainbowAura2 = Color.new(rgb[0],rgb[1],rgb[2], 70)
      add += (360/size)
    end
    for y in 0...height/2
      realX = x*2
      realY = y*2
      color = colors[bitmap.pixel(realX, realY)]
      next if color.alpha == 255
      #aura
      #first layer
      testX = realX + 2
      if testX < width
        offsetColor = colors[bitmap.pixel(testX, realY)]
        if offsetColor.alpha == 255
          colors[bitmap.pixel(realX,realY)] = rainbowAura1
          colors[bitmap.pixel(realX+1,realY)] = rainbowAura1
          colors[bitmap.pixel(realX+1,realY+1)] = rainbowAura1
          colors[bitmap.pixel(realX,realY+1)] = rainbowAura1
          next
        end
      end

      testX = realX - 2
      if testX > 0
        offsetColor = colors[bitmap.pixel(testX, realY)]
        if offsetColor.alpha == 255
          colors[bitmap.pixel(realX,realY)] = rainbowAura1
          colors[bitmap.pixel(realX+1,realY)] = rainbowAura1
          colors[bitmap.pixel(realX+1,realY+1)] = rainbowAura1
          colors[bitmap.pixel(realX,realY+1)] = rainbowAura1
          next
        end
      end

      testY = realY + 2
      if testY < height
        offsetColor = colors[bitmap.pixel(realX, testY)]
        if offsetColor.alpha == 255
          colors[bitmap.pixel(realX,realY)] = rainbowAura1
          colors[bitmap.pixel(realX+1,realY)] = rainbowAura1
          colors[bitmap.pixel(realX+1,realY+1)] = rainbowAura1
          colors[bitmap.pixel(realX,realY+1)] = rainbowAura1
          next
        end
      end

      testY = realY - 2
      if testY > 0
        offsetColor = colors[bitmap.pixel(realX, testY)]
        if offsetColor && offsetColor.alpha == 255
          colors[bitmap.pixel(realX,realY)] = rainbowAura1
          colors[bitmap.pixel(realX+1,realY)] = rainbowAura1
          colors[bitmap.pixel(realX+1,realY+1)] = rainbowAura1
          colors[bitmap.pixel(realX,realY+1)] = rainbowAura1
          next
        end
      end

      #second layer
      testX = realX + 4
      if testX < width
        offsetColor = colors[bitmap.pixel(testX, realY)]
        if offsetColor.alpha == 255
          colors[bitmap.pixel(realX,realY)] = rainbowAura2
          colors[bitmap.pixel(realX+1,realY)] = rainbowAura2
          colors[bitmap.pixel(realX+1,realY+1)] = rainbowAura2
          colors[bitmap.pixel(realX,realY+1)] = rainbowAura2
          next
        end
      end

      testX = realX - 4
      if testX > 0
        offsetColor = colors[bitmap.pixel(testX, realY)]
        if offsetColor.alpha == 255
          colors[bitmap.pixel(realX,realY)] = rainbowAura2
          colors[bitmap.pixel(realX+1,realY)] = rainbowAura2
          colors[bitmap.pixel(realX+1,realY+1)] = rainbowAura2
          colors[bitmap.pixel(realX,realY+1)] = rainbowAura2
          next
        end
      end

      testY = realY + 4
      if testY < height
        offsetColor = colors[bitmap.pixel(realX, testY)]
        if offsetColor.alpha == 255
          colors[bitmap.pixel(realX,realY)] = rainbowAura2
          colors[bitmap.pixel(realX+1,realY)] = rainbowAura2
          colors[bitmap.pixel(realX+1,realY+1)] = rainbowAura2
          colors[bitmap.pixel(realX,realY+1)] = rainbowAura2
          next
        end
      end

      testY = realY - 4
      if testY > 0
        offsetColor = colors[bitmap.pixel(realX, testY)]
        if offsetColor.alpha == 255
          colors[bitmap.pixel(realX,realY)] = rainbowAura2
          colors[bitmap.pixel(realX+1,realY)] = rainbowAura2
          colors[bitmap.pixel(realX+1,realY+1)] = rainbowAura2
          colors[bitmap.pixel(realX,realY+1)] = rainbowAura2
          next
        end
      end

      for i in 0...4
        case i
          when 0
            testX = realX + 2
            testY = realY + 2
          when 1
            testX = realX - 2
            testY = realY + 2
          when 2
            testX = realX + 2
            testY = realY - 2
          when 3
            testX = realX - 2
            testY = realY - 2
        end
        if testY < height && testX < width
          offsetColor = colors[bitmap.pixel(testX, testY)]
          if offsetColor.alpha == 255
            colors[bitmap.pixel(realX,realY)] = rainbowAura2
            colors[bitmap.pixel(realX+1,realY)] = rainbowAura2
            colors[bitmap.pixel(realX+1,realY+1)] = rainbowAura2
            colors[bitmap.pixel(realX,realY+1)] = rainbowAura2
            next
          end
        end
      end
    end
  end
  bitmap.raw_data = colors.map{|c| c.to_i}.pack("I*")
  return bitmap
end

def makeShadowBitmapOld(bitmap, width, height)
  newbitmap = Bitmap.new(width, height)
  for w in 0...width/2
    for h in 0...height/2
      border = []
      pixcolor = bitmap.get_pixel(w*2,h*2)
      next if pixcolor.alpha != 255
      rgb = [grayscale(pixcolor, :L)]*3
      hsl = rbgToHSL(rgb[0],rgb[1],rgb[2])
      hsl[0] = 270
      hsl[1] = 75
      rgb = hslToRGB(hsl[0],hsl[1],hsl[2])
      newbitmap.set_pixel(w*2,h*2,Color.new(rgb[0],rgb[1],rgb[2]))
      newbitmap.set_pixel(w*2+1,h*2,Color.new(rgb[0],rgb[1],rgb[2]))
      newbitmap.set_pixel(w*2,h*2+1,Color.new(rgb[0],rgb[1],rgb[2]))
      newbitmap.set_pixel(w*2+1,h*2+1,Color.new(rgb[0],rgb[1],rgb[2]))

      border.push([w*2+2,h*2]) if bitmap.get_pixel(w*2+2,h*2).alpha != 255 #right
      border.push([w*2-2,h*2]) if bitmap.get_pixel(w*2-2,h*2).alpha != 255 #left
      border.push([w*2,h*2+2]) if bitmap.get_pixel(w*2,h*2+2).alpha != 255 #down
      border.push([w*2,h*2-2]) if bitmap.get_pixel(w*2,h*2-2).alpha != 255 #up
      for loc in border
        newbitmap.set_pixel(loc[0],loc[1],Color.new(220, 90, 255, 200))
        newbitmap.set_pixel(loc[0]+1,loc[1],Color.new(220, 90, 255, 200))
        newbitmap.set_pixel(loc[0],loc[1]+1,Color.new(220, 90, 255, 200))
        newbitmap.set_pixel(loc[0]+1,loc[1]+1,Color.new(220, 90, 255, 200))
      end
    end
  end
  #layer 2
  newbitmap2 = Bitmap.new(width, height)
  for w in 0...width/2
    for h in 0...height/2
      border = []
      pixcolor = newbitmap.get_pixel(w*2,h*2)
      next if pixcolor.alpha != 200
      border.push([w*2+2,h*2]) if newbitmap.get_pixel(w*2+2,h*2).alpha < 200 #right
      border.push([w*2-2,h*2]) if newbitmap.get_pixel(w*2-2,h*2).alpha < 200 #left
      border.push([w*2,h*2+2]) if newbitmap.get_pixel(w*2,h*2+2).alpha < 200 #down
      border.push([w*2,h*2-2]) if newbitmap.get_pixel(w*2,h*2-2).alpha < 200 #up
      for loc in border
        newbitmap2.set_pixel(loc[0],loc[1],Color.new(220, 90, 255, 70))
        newbitmap2.set_pixel(loc[0]+1,loc[1],Color.new(220, 90, 255, 70))
        newbitmap2.set_pixel(loc[0],loc[1]+1,Color.new(220, 90, 255, 70))
        newbitmap2.set_pixel(loc[0]+1,loc[1]+1,Color.new(220, 90, 255, 70))
      end
    end
  end
  newbitmap2.blt(0,0,newbitmap,Rect.new(0,0,width, height))
  newbitmap2.raw_data.each_char{|str| cprint str.ord }
  return newbitmap2
end

def makeShadowBitmap(bitmap, width, height)
  shadowAura1 = Color.new(220, 90, 255, 200)
  shadowAura2 = Color.new(220, 90, 255, 70)
  colors = bitmap.raw_data.unpack("I*").map{|i| i.to_color }
  for x in 0...width/2
    for y in 0...height/2
      realX = x*2
      realY = y*2
      color = colors[bitmap.pixel(realX, realY)]
      if realY - 2 == 96
        puts bitmap.raw_data[bitmap.pixel(realX, realY - 2)].unpack("I*")
      end

      if color.alpha == 255
        #purplfy them
        rgb = [grayscale(color, :L)]*3
        hsl = rbgToHSL(rgb[0],rgb[1],rgb[2])
        hsl[0] = 270
        hsl[1] = 75
        rgb = hslToRGB(hsl[0],hsl[1],hsl[2])
        shadowCol = Color.new(rgb[0],rgb[1],rgb[2])
        colors[bitmap.pixel(realX,realY)] = shadowCol
        colors[bitmap.pixel(realX+1,realY)] = shadowCol
        colors[bitmap.pixel(realX+1,realY+1)] = shadowCol
        colors[bitmap.pixel(realX,realY+1)] = shadowCol
        next
      else
        #aura
        #first layer
        testX = realX + 2
        if testX < width
          offsetColor = colors[bitmap.pixel(testX, realY)]
          if offsetColor.alpha == 255
            colors[bitmap.pixel(realX,realY)] = shadowAura1
            colors[bitmap.pixel(realX+1,realY)] = shadowAura1
            colors[bitmap.pixel(realX+1,realY+1)] = shadowAura1
            colors[bitmap.pixel(realX,realY+1)] = shadowAura1
            next
          end
        end

        testX = realX - 2
        if testX > 0
          offsetColor = colors[bitmap.pixel(testX, realY)]
          if offsetColor.alpha == 255
            colors[bitmap.pixel(realX,realY)] = shadowAura1
            colors[bitmap.pixel(realX+1,realY)] = shadowAura1
            colors[bitmap.pixel(realX+1,realY+1)] = shadowAura1
            colors[bitmap.pixel(realX,realY+1)] = shadowAura1
            next
          end
        end

        testY = realY + 2
        if testY < height
          offsetColor = colors[bitmap.pixel(realX, testY)]
          if offsetColor.alpha == 255
            colors[bitmap.pixel(realX,realY)] = shadowAura1
            colors[bitmap.pixel(realX+1,realY)] = shadowAura1
            colors[bitmap.pixel(realX+1,realY+1)] = shadowAura1
            colors[bitmap.pixel(realX,realY+1)] = shadowAura1
            next
          end
        end

        testY = realY - 2
        if testY > 0
          offsetColor = colors[bitmap.pixel(realX, testY)]
          if offsetColor.alpha == 255
            colors[bitmap.pixel(realX,realY)] = shadowAura1
            colors[bitmap.pixel(realX+1,realY)] = shadowAura1
            colors[bitmap.pixel(realX+1,realY+1)] = shadowAura1
            colors[bitmap.pixel(realX,realY+1)] = shadowAura1
            next
          end
        end

        #second layer
        testX = realX + 4
        if testX < width
          offsetColor = colors[bitmap.pixel(testX, realY)]
          if offsetColor.alpha == 255
            colors[bitmap.pixel(realX,realY)] = shadowAura2
            colors[bitmap.pixel(realX+1,realY)] = shadowAura2
            colors[bitmap.pixel(realX+1,realY+1)] = shadowAura2
            colors[bitmap.pixel(realX,realY+1)] = shadowAura2
            next
          end
        end

        testX = realX - 4
        if testX > 0
          offsetColor = colors[bitmap.pixel(testX, realY)]
          if offsetColor.alpha == 255
            colors[bitmap.pixel(realX,realY)] = shadowAura2
            colors[bitmap.pixel(realX+1,realY)] = shadowAura2
            colors[bitmap.pixel(realX+1,realY+1)] = shadowAura2
            colors[bitmap.pixel(realX,realY+1)] = shadowAura2
            next
          end
        end

        testY = realY + 4
        if testY < height
          offsetColor = colors[bitmap.pixel(realX, testY)]
          if offsetColor.alpha == 255
            colors[bitmap.pixel(realX,realY)] = shadowAura2
            colors[bitmap.pixel(realX+1,realY)] = shadowAura2
            colors[bitmap.pixel(realX+1,realY+1)] = shadowAura2
            colors[bitmap.pixel(realX,realY+1)] = shadowAura2
            next
          end
        end

        testY = realY - 4
        if testY > 0
          offsetColor = colors[bitmap.pixel(realX, testY)]
          if offsetColor.alpha == 255
            colors[bitmap.pixel(realX,realY)] = shadowAura2
            colors[bitmap.pixel(realX+1,realY)] = shadowAura2
            colors[bitmap.pixel(realX+1,realY+1)] = shadowAura2
            colors[bitmap.pixel(realX,realY+1)] = shadowAura2
            next
          end
        end

        for i in 0...4
          case i
            when 0
              testX = realX + 2
              testY = realY + 2
            when 1
              testX = realX - 2
              testY = realY + 2
            when 2
              testX = realX + 2
              testY = realY - 2
            when 3
              testX = realX - 2
              testY = realY - 2
          end
          if testY < height && testX < width
            offsetColor = colors[bitmap.pixel(testX, testY)]
            if offsetColor.alpha == 255
              colors[bitmap.pixel(realX,realY)] = shadowAura2
              colors[bitmap.pixel(realX+1,realY)] = shadowAura2
              colors[bitmap.pixel(realX+1,realY+1)] = shadowAura2
              colors[bitmap.pixel(realX,realY+1)] = shadowAura2
              next
            end
          end
        end
      end
    end
  end
  bitmap.raw_data = colors.map{|c| c.to_i}.pack("I*")
  return bitmap
end

def makePetrifiedBitmap(bitmap, width, height)
  for w in 0...width/2
    for h in 0...height/2
      pixcolor = bitmap.get_pixel(w*2,h*2)
      next if pixcolor.alpha != 255
      rgb = [grayscale(pixcolor,:L)]*3
      bitmap.set_pixel(w*2,h*2,Color.new(rgb[0],rgb[1],rgb[2]))
      bitmap.set_pixel(w*2+1,h*2,Color.new(rgb[0],rgb[1],rgb[2]))
      bitmap.set_pixel(w*2,h*2+1,Color.new(rgb[0],rgb[1],rgb[2]))
      bitmap.set_pixel(w*2+1,h*2+1,Color.new(rgb[0],rgb[1],rgb[2]))
    end
  end
  return bitmap
end

def pbCheckPokemonBitmapFiles(dexname,dexnum,girl=false)
  gendermod = girl ? "_f" : ""
  dexnum = dexnum[1] if dexnum.kind_of?(Array)
  bitmapFileName=sprintf("Graphics/Battlers/%03d%s",dexnum,gendermod)
  ret=pbResolveBitmap(bitmapFileName)
  return ret if ret
  bitmapFileName=sprintf("Graphics/Battlers/%03d",dexnum)
  ret=pbResolveBitmap(bitmapFileName)
  return ret if ret
  bitmapFileName=sprintf("Graphics/Battlers/%s%s",dexname,gendermod)
  ret=pbResolveBitmap(bitmapFileName)
  return ret if ret
  bitmapFileName=sprintf("Graphics/Battlers/%s",dexname)
  ret=pbResolveBitmap(bitmapFileName)
  return ret if ret
  return pbResolveBitmap(sprintf("Graphics/Battlers/substitute")) 
end

def pbLoadPokemonIcon(pokemon)
  return pbPokemonIconBitmap(pokemon)
end

def pbPokemonIconBitmap(pokemon,egg=false)   # pbpokemonbitmap, but for icons
  shiny = pokemon.isShiny?
  girl = pokemon.isFemale? ? "f" : ""
  form = pokemon.form
  egg = egg ? "egg" : ""
  species = $cache.pkmn[pokemon.species].dexnum 
  name = pokemon.species.downcase
  filename=sprintf("Graphics/Icons/icon%03d%s%s",species,girl,egg)
  filename=sprintf("Graphics/Icons/icon%03d%s", species,egg) if !pbResolveBitmap(filename)
  filename=sprintf("Graphics/Icons/%s%s%s",name,girl,egg) if !pbResolveBitmap(filename)
  filename=sprintf("Graphics/Icons/%s%s",name,egg) if !pbResolveBitmap(filename)
  filename=sprintf("Graphics/Icons/iconEgg") if !pbResolveBitmap(filename)
  filename=sprintf("Graphics/Icons/icon000") if !pbResolveBitmap(filename)
  iconbitmap = RPG::Cache.load_bitmap(filename)
  bitmap=Bitmap.new(128,64)
  x = shiny ? 128 : 0
  y = form*64
  y = 0 if iconbitmap.height <= y
  rectangle = Rect.new(x,y,128,64)
  bitmap.blt(0,0,iconbitmap,rectangle)
  bitmap = makeShadowBitmap(bitmap, 128, 64) if pokemon.isShadow?
  return bitmap
end

def pbIconBitmap(species,form=0,shiny=false,girl=false,egg=false)   # pbpokemonbitmap, but for icons
  egg = egg ? "egg" : ""
  if form.is_a?(String)
    form = $Trainer.pokedex.dexList[species][:forms].keys.index(form)
  end
  form = 0 if cancelledgenders.include?(species) || form == nil
  species = $cache.pkmn[species].dexnum #.name.downcase
  filename=sprintf("Graphics/Icons/%s",species) if form == 0
  filename=sprintf("Graphics/Icons/icon%03d%s%s",species,girl,egg) if !pbResolveBitmap(filename)
  filename=sprintf("Graphics/Icons/icon%03d%s", species,egg) if !pbResolveBitmap(filename)
  filename=sprintf("Graphics/Icons/iconEgg") if !pbResolveBitmap(filename)
  filename=sprintf("Graphics/Icons/icon000") if !pbResolveBitmap(filename)
  iconbitmap = RPG::Cache.load_bitmap(filename)
  bitmap=Bitmap.new(128,64)
  x = shiny ? 128 : 0
  y = form*64
  y = 0 if iconbitmap.height <= y
  rectangle = Rect.new(x,y,128,64)
  return bitmap
end

def pbPokemonIconFile(pokemon)
  bitmapFileName=pbResolveBitmap(sprintf("Graphics/Icons/icon000"))
  bitmapFileName=pbCheckPokemonIconFiles([pokemon.species, (pokemon.isFemale?), pokemon.isShiny?, (pokemon.form rescue 0), (pokemon.isShadow? rescue false)], pokemon.isEgg?)
  return bitmapFileName
end

def pbCheckPokemonIconFiles(params,egg=false)
  species=params[0]
  if egg
    formnumber = params[3].to_s rescue 0
    formmodifier = formnumber != 0 && formnumber != "0" ? "_"+formnumber.to_s : ""
    shiny = params[2] ? "s" : ""
    gendermod = params[1] ? "f" : ""
    bitmapFileName=sprintf("Graphics/Icons/icon%03d%s%s%segg",species,gendermod,shiny,formmodifier) rescue nil
    if !pbResolveBitmap(bitmapFileName)
      bitmapFileName=sprintf("Graphics/Icons/icon%segg",species) rescue nil
      if !pbResolveBitmap(bitmapFileName) 
        bitmapFileName=sprintf("Graphics/Icons/icon%03d%segg",species,formmodifier)
        if !pbResolveBitmap(bitmapFileName)
          bitmapFileName=sprintf("Graphics/Icons/icon%03degg",species) 
          if !pbResolveBitmap(bitmapFileName)
            bitmapFileName=sprintf("Graphics/Icons/iconEgg")
          end
        end
      end
    end
    return pbResolveBitmap(bitmapFileName)
  else
    factors=[]
    factors.push([4,params[4],false]) if params[4] && params[4]!=false     # shadow
    factors.push([1,params[1],false]) if params[1] && params[1]!=false     # gender
    factors.push([2,params[2],false]) if params[2] && params[2]!=false     # shiny
    factors.push([3,params[3].to_s,""]) if params[3] && params[3].to_s!="" &&
                                                        params[3].to_s!="0" # form
    tshadow=false
    tgender=false
    tshiny=false
    tform=""
    for i in 0...2**factors.length
      for j in 0...factors.length
        case factors[j][0]
          when 1   # gender
            tgender=((i/(2**j))%2==0) ? factors[j][1] : factors[j][2]
          when 2   # shiny
            tshiny=((i/(2**j))%2==0) ? factors[j][1] : factors[j][2]
          when 3   # form
            tform=((i/(2**j))%2==0) ? factors[j][1] : factors[j][2]
          when 4   # shadow
            tshadow=((i/(2**j))%2==0) ? factors[j][1] : factors[j][2]
        end
      end
      bitmapFileName=sprintf("Graphics/Icons/icon%s%s%s%s%s",
         species,
         tgender ? "f" : "",
         tshiny ? "s" : "",
         (tform!="" ? "_"+tform : ""),
         tshadow ? "_shadow" : "") rescue nil
      ret=pbResolveBitmap(bitmapFileName)
      return ret if ret
      bitmapFileName=sprintf("Graphics/Icons/icon%03d%s%s%s%s", species, tgender ? "f" : "", tshiny ? "s" : "", (tform!="" ? "_"+tform : ""), tshadow ? "_shadow" : "")
      ret=pbResolveBitmap(bitmapFileName)
      return ret if ret
    end
  end
  return pbResolveBitmap(sprintf("Graphics/Icons/icon000"))
end

def pbPokemonFootprintFile(species)   # Used by the Pokédex
  return nil if !species
  bitmapFileName=sprintf("Graphics/Icons/Footprints/footprint%s",species) rescue nil
  if !pbResolveBitmap(bitmapFileName)
    bitmapFileName=sprintf("Graphics/Icons/Footprints/footprint%03d",species)
  end
  return pbResolveBitmap(bitmapFileName)
end

def pbItemIconFile(item,conversion=false)
  return "Graphics/Icons/itemBack" if !item
  bitmapFileName=nil
  tmmove = $cache.items[item].checkFlag?(:tm)
  if tmmove
    type = $cache.moves[tmmove].type
    typename = getTypeName(type)
    return sprintf("Graphics/Icons/TM - %s",typename)
  end
  return sprintf("Graphics/Icons/application") if $cache.items[item].checkFlag?(:application)
  return sprintf("Graphics/Icons/lakekey") if $cache.items[item].checkFlag?(:lakekey)
  if !conversion
    bitmapFileName=sprintf("Graphics/Icons/%s.png",item) rescue nil
    if !pbResolveBitmap(bitmapFileName)
      bitmapFileName=sprintf("Graphics/Icons/%s.png",item)
    end
  else
    bitmapFileName=sprintf("Graphics/Icons/%s",$cache.items[item].checkFlag?(:ID)) rescue nil
    if !pbResolveBitmap(bitmapFileName)
      bitmapFileName=sprintf("Graphics/Icons/%03d",$cache.items[item].checkFlag?(:ID))
    end
  end
  return bitmapFileName
end

def pbMailBackFile(item)
  return nil if !item
  bitmapFileName=sprintf("Graphics/Pictures/mail%s",$cache.items[item].checkFlag?(:ID)) rescue nil
  if !pbResolveBitmap(bitmapFileName)
    bitmapFileName=sprintf("Graphics/Pictures/mail%03d",$cache.items[item].checkFlag?(:ID))
  end
  return bitmapFileName
end

def pbTrainerCharFile(type)
  return nil if !type
  type = $cache.trainertypes[type].checkFlag?(:ID) if type.is_a?(Symbol)
  bitmapFileName=sprintf("Graphics/Characters/trchar%03d",type)
  return bitmapFileName
end

def pbTrainerCharNameFile(type)
  return nil if !type
  type = $cache.trainertypes[type].checkFlag?(:ID) if type.is_a?(Symbol)
  bitmapFileName=sprintf("trchar%03d",type)
  return bitmapFileName
end

def pbTrainerHeadFile(type)
  return nil if !type
  type = $cache.trainertypes[type].checkFlag?(:ID) if type.is_a?(Symbol)
  bitmapFileName=sprintf("Graphics/Pictures#{Rejuv ? "/RegionMap" : ""}/mapPlayer%03d",type)
  return bitmapFileName
end

def pbPlayerHeadFile(type)
  return nil if !type
  type = $cache.trainertypes[type].checkFlag?(:ID) if type.is_a?(Symbol)
  outfit=$Trainer ? $Trainer.outfit : 0
  bitmapFileName=sprintf("Graphics/Pictures#{Rejuv ? "/RegionMap" : ""}/mapPlayer%03d_%d",type,outfit)
  if !pbResolveBitmap(bitmapFileName)
    bitmapFileName=pbTrainerHeadFile(type)
  end
  return bitmapFileName
end

def pbTrainerSpriteFile(type,outfit=0)
  return nil if !type
  type = $cache.trainertypes[type].checkFlag?(:ID) if type.is_a?(Symbol)
  if outfit > 0
    bitmapFileName=sprintf("Graphics/Characters/trainer%s_%d",type,outfit) rescue nil
    bitmapFileName=sprintf("Graphics/Characters/trainer%s",type) rescue nil if !pbResolveBitmap(bitmapFileName)
  else
    bitmapFileName=sprintf("Graphics/Characters/trainer%s",type) rescue nil
  end
  if !pbResolveBitmap(bitmapFileName)
    if outfit > 0
      bitmapFileName=sprintf("Graphics/Characters/trainer%03d_%d",type,outfit) rescue nil
      bitmapFileName=sprintf("Graphics/Characters/trainer%03d",type) rescue nil if !pbResolveBitmap(bitmapFileName)
    else
      bitmapFileName=sprintf("Graphics/Characters/trainer%03d",type)
    end
  end
  return bitmapFileName
end

def pbTrainerSpriteBackFile(type)
  return nil if !type
  type = $cache.trainertypes[type].checkFlag?(:ID) if type.is_a?(Symbol)
  bitmapFileName=sprintf("Graphics/Characters/trback%03d",type)
  return bitmapFileName
end

def pbPlayerSpriteFile(type)
  return nil if !type
  type = $cache.trainertypes[type].checkFlag?(:ID) if type.is_a?(Symbol)
  outfit=$Trainer ? $Trainer.outfit : 0
  bitmapFileName=sprintf("Graphics/Characters/trainer%s_%d",type,outfit) rescue nil
  if !pbResolveBitmap(bitmapFileName)
    bitmapFileName=sprintf("Graphics/Characters/trainer%03d_%d",type,outfit)
    if !pbResolveBitmap(bitmapFileName)
      bitmapFileName=pbTrainerSpriteFile(type)
    end
  end
  return bitmapFileName
end

def pbPlayerSpriteBackFile(type)
  return nil if !type
  type = $cache.trainertypes[type].checkFlag?(:ID) if type.is_a?(Symbol)
  outfit=$Trainer ? $Trainer.outfit : 0
  bitmapFileName=sprintf("Graphics/Characters/trback%s_%d",type,outfit) rescue nil
  if !pbResolveBitmap(bitmapFileName)
    bitmapFileName=sprintf("Graphics/Characters/trback%03d_%d",type,outfit)
    if !pbResolveBitmap(bitmapFileName)
      bitmapFileName=pbTrainerSpriteBackFile(type)
    end
  end
  return bitmapFileName
end


def unhashTRlist(file="Data/trainers.dat")
  trainerlist = load_data(file)
  dehashedlist = []
  #hash of all classes
    #hash of all names in class
      #array of all teams in name
  for tclass in trainerlist.keys
    classhash = trainerlist[tclass]
    for name in classhash.keys
      namearray = classhash[name]
      for partydata in namearray
        dehashedlist.push([tclass,name,partydata[1],partydata[0],partydata[0]])
      end
    end
  end
  return dehashedlist
end

################################################################################
# Loads music and sound effects
################################################################################
def pbResolveAudioSE(file)
  return nil if !file
  if RTP.exists?("Audio/SE/"+file,["",".wav",".mp3",".ogg"])
    return RTP.getPath("Audio/SE/"+file,["",".wav",".mp3",".ogg"])
  end
  return nil
end

def getPlayTime(filename)
  if safeExists?(filename)
    return [getPlayTime2(filename),0].max
  elsif safeExists?(filename+".wav")
    return [getPlayTime2(filename+".wav"),0].max
  elsif safeExists?(filename+".mp3")
    return [getPlayTime2(filename+".mp3"),0].max
  elsif safeExists?(filename+".ogg")
    return [getPlayTime2(filename+".ogg"),0].max
  else
    return 0
  end
end

def getPlayTime2(filename)
  time=-1
  return -1 if !safeExists?(filename)
  fgetdw=proc{|file|
     (file.eof? ? 0 : (file.read(4).unpack("V")[0] || 0))
  }
  fgetw=proc{|file|
     (file.eof? ? 0 : (file.read(2).unpack("v")[0] || 0))
  }
  File.open(filename,"rb"){|file|
     file.pos=0
     fdw=fgetdw.call(file)
     if fdw==0x46464952 # "RIFF"
       filesize=fgetdw.call(file)
       wave=fgetdw.call(file)
       if wave!=0x45564157 # "WAVE"
         return -1
       end
       fmt=fgetdw.call(file)
       if fmt!=0x20746d66 # "fmt "
         return -1
       end
       fmtsize=fgetdw.call(file)
       format=fgetw.call(file)
       channels=fgetw.call(file)
       rate=fgetdw.call(file)
       bytessec=fgetdw.call(file)
       if bytessec==0
         return -1
       end
       bytessample=fgetw.call(file)
       bitssample=fgetw.call(file)
       data=fgetdw.call(file)
       if data!=0x61746164 # "data"
         return -1
       end
       datasize=fgetdw.call(file)
       time=(datasize*1.0)/bytessec
       return time
     elsif fdw==0x5367674F # "OggS"
       file.pos=0
       time=oggfiletime(file)
       return time
     end
     file.pos=0
     # Find the length of an MP3 file
     while true
       rstr=""
       ateof=false
       while !file.eof?
         if (file.read(1)[0] rescue 0)==0xFF
           begin; rstr=file.read(3); break; rescue; ateof=true; break; end
         end
       end
       break if ateof || !rstr || rstr.length!=3
       if rstr[0]==0xFB
         t=rstr[1]>>4
         next if t==0 || t==15
         freqs=[44100,22050,11025,48000]
         bitrates=[32,40,48,56,64,80,96,112,128,160,192,224,256,320]
         bitrate=bitrates[t]
         t=(rstr[1]>>2)&3
         freq=freqs[t]
         t=(rstr[1]>>1)&1
         filesize=FileTest.size(filename)
         frameLength=((144000*bitrate)/freq)+t
         numFrames=filesize/(frameLength+4)
         time=(numFrames*1152.0/freq)
         break
       end
     end
  }
  return time
end

# internal function
def oggfiletime(file)
  fgetdw = proc { |file|
    (file.eof? ? 0 : (file.read(4).unpack("V")[0] || 0))
  }
  pages = []
  page = nil
  loop do
    page = getOggPage(file)
    break if !page
    pages.push(page)
    file.pos = page[3]
  end
  return -1 if pages.length == 0
  curserial = nil
  i = -1
  pcmlengths = []
  rates = []
  for page in pages
    header = page[0]
    serial = header[10, 4].unpack("V")
    frame = header[2, 8].unpack("C*")
    frameno = frame[7]
    frameno = (frameno << 8) | frame[6]
    frameno = (frameno << 8) | frame[5]
    frameno = (frameno << 8) | frame[4]
    frameno = (frameno << 8) | frame[3]
    frameno = (frameno << 8) | frame[2]
    frameno = (frameno << 8) | frame[1]
    frameno = (frameno << 8) | frame[0]
    if serial != curserial
      curserial = serial
      file.pos = page[1]
      packtype = (file.read(1)[0].ord rescue 0)
      string = file.read(6)
      return -1 if string != "vorbis"
      return -1 if packtype != 1
      i += 1
      version = fgetdw.call(file)
      return -1 if version != 0
      rates[i] = fgetdw.call(file)
    end
    pcmlengths[i] = frameno
  end
  ret = 0.0
  for i in 0...pcmlengths.length
    ret += pcmlengths[i].to_f / rates[i].to_f
  end
  return ret * 256.0
end

def getOggPage(file)
  fgetdw = proc { |file|
    (file.eof? ? 0 : (file.read(4).unpack("V")[0] || 0))
  }
  dw = fgetdw.call(file)
  return nil if dw != 0x5367674F
  header = file.read(22)
  bodysize = 0
  hdrbodysize = (file.read(1)[0].ord rescue 0)
  hdrbodysize.times do
    bodysize += (file.read(1)[0].ord rescue 0)
  end
  ret = [header, file.pos, bodysize, file.pos + bodysize]
  return ret
end

def pbCryFrameLength(pokemon,pitch=nil)
  return 0 if !pokemon
  pitch=100 if !pitch
  pitch=pitch.to_f/100
  return 0 if pitch<=0
  playtime=0.0
  if pokemon.is_a?(Numeric)
    pkmnwav=pbResolveAudioSE(pbCryFile(pokemon))
    playtime=getPlayTime(pkmnwav) if pkmnwav
  elsif !pokemon.isEgg?
    if pokemon.respond_to?("chatter") && pokemon.chatter
      playtime=pokemon.chatter.time
      pitch=1.0
    else
      pkmnwav=pbResolveAudioSE(pbCryFile(pokemon))
      playtime=getPlayTime(pkmnwav) if pkmnwav
    end 
  end
  playtime/=pitch # sound is lengthened the lower the pitch
  # 4 is added to provide a buffer between sounds
  return (playtime*Graphics.frame_rate).ceil+4
end

def pbPlayCry(pokemon,volume=90,pitch=nil)
  return if !pokemon
  #pokemon = $cache.pkmn[pokemon.species].dexnum
  if pokemon.is_a?(Numeric)
    pkmnwav=pbCryFile(pokemon)
    if pkmnwav
      pbSEPlay(RPG::AudioFile.new(pkmnwav,volume,pitch ? pitch : 100)) rescue nil
    end
  elsif !pokemon.isEgg?
    if pokemon.respond_to?("chatter") && pokemon.chatter
      pokemon.chatter.play
    else
      pkmnwav=pbCryFile(pokemon)
      if pkmnwav
        pbSEPlay(RPG::AudioFile.new(pkmnwav,volume,
           pitch ? pitch : (pokemon.hp*25/pokemon.totalhp)+75)) rescue nil
      end
    end
  end
end

def pbCryFile(pokemon)
  return nil if !pokemon
  if pokemon.is_a?(Numeric)
    filename=sprintf("%03dCry",pokemon) if !pbResolveAudioSE(filename)
    return filename if pbResolveAudioSE(filename)
  elsif !pokemon.isEgg?
    filename=sprintf("%sCry_%d",pokemon.dexnum,(pokemon.form rescue 0)) rescue nil
    filename=sprintf("%03dCry_%d",pokemon.dexnum,(pokemon.form rescue 0)) if !pbResolveAudioSE(filename)
    if !pbResolveAudioSE(filename)
      filename=sprintf("%sCry",pokemon.dexnum) rescue nil
    end
    filename=sprintf("%03dCry",pokemon.dexnum) if !pbResolveAudioSE(filename)
    return filename if pbResolveAudioSE(filename)
  end
  return nil
end

def pbGetWildBattleBGM(species)
  return $PokemonGlobal.nextBattleBGM.clone if $PokemonGlobal.nextBattleBGM
  return pbStringToAudioFile("Battle- Legendary") if PBStuff::LEGENDARYLIST.include?(species)
  music=$cache.mapdata[$game_map.map_id].WildBattleBGM
  return pbStringToAudioFile(music) if music
  music=$cache.metadata[:WildBattle]
  return pbStringToAudioFile(music) if music
  return pbStringToAudioFile("Battle- Wild")
end

def pbGetWildVictoryME
  return $PokemonGlobal.nextBattleME.clone if $PokemonGlobal.nextBattleME
  music=$cache.mapdata[$game_map.map_id].WildVictoryME
  return pbStringToAudioFile(music) if music
  music=$cache.metadata[:WildVictory]
  return pbStringToAudioFile(music) if music
  return ""
end

def pbPlayTrainerIntroME(trainertype)
  if $cache.trainertypes[trainertype]
    bgm=$cache.trainertypes[trainertype].checkFlag?(:introBGM)
    if bgm && bgm!=""
      bgm=pbStringToAudioFile(bgm)
      pbMEPlay(bgm)
      return
    end
  end
end

def pbGetTrainerBattleBGM(trainer) # can be a PokeBattle_Trainer or an array of PokeBattle_Trainer  
  if $PokemonGlobal.nextBattleBGM
    return $PokemonGlobal.nextBattleBGM.clone
  end
  music=nil
  trainerarray=trainer
  trainerarray=[trainer] if !trainer.is_a?(Array)
  for i in 0...trainerarray.length
    trainertype=trainerarray[i].trainertype
    if $cache.trainertypes[trainertype]
      music=$cache.trainertypes[trainertype].checkFlag?(:battleBGM)
      music=$cache.trainertypes[trainertype].battleBGM
    end
  end
  return pbStringToAudioFile(music) if music && music!=""
  music=$cache.mapdata[$game_map.map_id].TrainerBattleBGM
  return pbStringToAudioFile(music) if music
  music=$cache.metadata[:TrainerBattle]
  return pbStringToAudioFile(music) if music
  return nil
end

def pbGetTrainerBattleBGMFromType(trainertype)
  if $PokemonGlobal.nextBattleBGM
    return $PokemonGlobal.nextBattleBGM.clone
  end
  music=nil
  if $cache.trainertypes[trainertype]
    music=$cache.trainertypes[trainertype].checkFlag?(:battleBGM)
  end
  return pbStringToAudioFile(music) if music && music!=""
  music=$cache.mapdata[$game_map.map_id].TrainerBattleBGM
  return pbStringToAudioFile(music) if music
  music=$cache.metadata[:TrainerBattle]
  return pbStringToAudioFile(music) if music
  return nil
end

def pbGetOnlineBattleBGM(trainer) # can be a PokeBattle_Trainer or an array of PokeBattle_Trainer  
  if trainer.onlineMusic == nil
    trainer.onlineMusic = "Battle- Trainer.mp3"
  end  
  music = trainer.onlineMusic
  ret=nil
  if music && music!=""
    ret=pbStringToAudioFile(music)
  end
  return ret
end

def pbGetTrainerVictoryME(trainer) # can be a PokeBattle_Trainer or an array of PokeBattle_Trainer
  if $PokemonGlobal.nextBattleME
    return $PokemonGlobal.nextBattleME.clone
  end
  music=nil
  trainerarray=trainer
  trainerarray=[trainer] if !trainer.is_a?(Array)
  for i in 0...trainerarray.length
    trainertype=trainerarray[i].trainertype
    if $cache.trainertypes[trainertype]
      music=$cache.trainertypes[trainertype].winBGM
    end
  end
  return pbStringToAudioFile(music) if music && music!=""
  music=$cache.mapdata[$game_map.map_id].TrainerVictoryME
  return pbStringToAudioFile(music) if music
  music=$cache.metadata[:TrainerVictory]
  return pbStringToAudioFile(music) if music
  return nil
end



################################################################################
# Creating and storing Pokémon
################################################################################
def pbBoxesFull?
  return !$Trainer || ($Trainer.party.length==6 && $PokemonStorage.full?)
end

def pbNickname(pokemon)
  speciesname=getMonName(pokemon.species)
  return "" if !Kernel.pbConfirmMessage(_INTL("Would you like to give a nickname to {1}?",speciesname))
  
  helptext=_INTL("{1}'s nickname?",speciesname)
  newname=pbEnterText(helptext,0,12,"",2,pokemon)
  pokemon.name=newname if newname!=""
  return newname
end

def pbStorePokemon(pokemon)
  if pbBoxesFull?
    Kernel.pbMessage(_INTL("There's no more room for Pokémon!\1"))
    Kernel.pbMessage(_INTL("The Pokémon Boxes are full and can't accept any more!"))
    return
  end
  pokemon.pbRecordFirstMoves
  addPkmnToPartyOrPC(pokemon)
end

def pbNicknameAndStore(pokemon)
  if pbBoxesFull?
    Kernel.pbMessage(_INTL("There's no more room for Pokémon!\1"))
    Kernel.pbMessage(_INTL("The Pokémon Boxes are full and can't accept any more!"))
    return
  end
  species = pokemon.species
  $Trainer.pokedex.setOwned(pokemon)
  $Trainer.pokedex.setSeen(pokemon)
  pbNickname(pokemon)
  #pbEnterPokemonName(helptext,0,12,"",pokemon)
  pbStorePokemon(pokemon)
end

def pbAddPokemon(species,level=nil,seeform=true,form=0)
  return if !species || !$Trainer
  if pbBoxesFull?
    Kernel.pbMessage(_INTL("There's no more room for Pokémon!\1"))
    Kernel.pbMessage(_INTL("The Pokémon Boxes are full and can't accept any more!"))
    return false
  end
  if !species.is_a?(PokeBattle_Pokemon)
    pokemon=PokeBattle_Pokemon.new(species,level,$Trainer,true,form)
    speciesname=getMonName(pokemon.species)
  else
    pokemon=species
    speciesname=getMonName(species.species)
  end
  pokemon.timeReceived=Time.new
  if pokemon.ot == ""
    pokemon.ot = $Trainer.name 
    pokemon.trainerID = $Trainer.id
  end  
  
  Kernel.pbMessage(_INTL("{1} obtained {2}!\\se[itemlevel]\1",$Trainer.name,speciesname))
  pbNicknameAndStore(pokemon)
  $Trainer.pokedex.setFormSeen(pokemon) if seeform
  return true
end

def pbAddPokemonSilent(pokemon,level=nil,seeform=true,ivs=[],ability=nil,moves=nil,female=nil,obtainText=nil,name=nil,ot=nil,shiny=nil,evs=[],nature=nil,item=nil,form=0)
  return false if !pokemon || pbBoxesFull? || !$Trainer
  if !pokemon.is_a? PokeBattle_Pokemon
    pokemon=PokeBattle_Pokemon.new(pokemon,level,$Trainer,true,form)
  end
  if pokemon.ot == ""
    pokemon.ot = $Trainer.name 
    pokemon.trainerID = $Trainer.id
  end  
  # frankly how often does it come up that you want to register the species you are getting but not the form, i am using this now as a blanket dex exclusion
  if pokemon.eggsteps<=0 && seeform
    $Trainer.pokedex.dexList[pokemon.species][:seen?]=true
    $Trainer.pokedex.dexList[pokemon.species][:owned?]=true
    $Trainer.pokedex.setFormSeen(pokemon)
  end
  pokemon.timeReceived=Time.new
  pokemon.pbRecordFirstMoves
  for i in 0...6
    pokemon.iv[i] = ivs[i] if ivs[i]
    pokemon.ev[i] = evs[i] if evs[i]
  end
  pokemon.calcStats
  pokemon.setAbility(ability) if ability
  if moves
    moves.each{|move| pokemon.pbLearnMove(move)}
  end
  pokemon.item = item if item
  pokemon.initZmoves(item,false) if pbIsZCrystal?(item)
  if !female.nil?
    val = female ? 1 : 0
    pokemon.setGender(val)
  end
  pokemon.obtainText = obtainText if obtainText
  pokemon.name = name if name
  pokemon.ot = ot if ot
  pokemon.makeShiny if shiny == 1
  pokemon.setNature(nature) if nature
  addPkmnToPartyOrPC(pokemon)
  return true
end

def pbAddRentalPokemonSilent(pokemon,level=nil)
  return false if !pokemon || pbBoxesFull? || !$Trainer
  pokemon=PokeBattle_Pokemon.new(pokemon,level,$Trainer)
  if pokemon.ot == ""
    pokemon.ot = $Trainer.name 
    pokemon.trainerID = $Trainer.id
  end
  pokemon.pbRecordFirstMoves
  if $Trainer.party.length<6
    $Trainer.party[$Trainer.party.length]=pokemon
  else
    $PokemonStorage.pbStoreCaught(pokemon)
  end
  return true
end

def pbAddToParty(pokemon,level=nil,seeform=true)
  return false if !pokemon || !$Trainer# || $Trainer.party.length>=6
  pokemon=PokeBattle_Pokemon.new(pokemon,level,$Trainer)
  speciesname=getMonName(pokemon.species)
  Kernel.pbMessage(_INTL("{1} obtained {2}!\\se[itemlevel]\1",$Trainer.name,speciesname))
  # pbNicknameAndStore(pokemon)
  pbNickname(pokemon)
  addPkmnToPartyOrPC(pokemon)
  if seeform
    $Trainer.pokedex.dexList[pokemon.species][:seen?]=true
    $Trainer.pokedex.dexList[pokemon.species][:owned?]=true
    $Trainer.pokedex.setFormSeen(pokemon)
  end
  return true
end

def pbAddToPartySilent(pokemon,level=nil,seeform=true)
  return false if !pokemon || !$Trainer || $Trainer.party.length>=6
  pokemon=PokeBattle_Pokemon.new(pokemon,level,$Trainer)
  $Trainer.pokedex.dexList[pokemon.species][:seen?]=true
  $Trainer.pokedex.dexList[pokemon.species][:owned?]=true
  $Trainer.pokedex.setFormSeen(pokemon) if seeform
  pokemon.pbRecordFirstMoves
  $Trainer.party[$Trainer.party.length]=pokemon
  return true
end

def pbAddForeignPokemon(pokemon,level=nil,ownerName=nil,nickname=nil,ownerGender=0,seeform=true)
  return false if !pokemon || !$Trainer || $Trainer.party.length>=6
  pokemon=PokeBattle_Pokemon.new(pokemon,level,$Trainer)
  # Set original trainer to a foreign one (if ID isn't already foreign)
  if pokemon.trainerID==$Trainer.id
    pokemon.trainerID=$Trainer.getForeignID
    pokemon.ot=ownerName if ownerName && ownerName!=""
  end
  # Set nickname
  pokemon.name=nickname[0,12] if nickname && nickname!=""
  # Recalculate stats
  pokemon.calcStats
  if ownerName
    Kernel.pbMessage(_INTL("{1} received a Pokémon from {2}.\1",$Trainer.name,ownerName))
  else
    Kernel.pbMessage(_INTL("{1} received a Pokémon.\1",$Trainer.name))
  end
  pbStorePokemon(pokemon)
  $Trainer.pokedex.dexList[pokemon.species][:seen?]=true
  $Trainer.pokedex.dexList[pokemon.species][:owned?]=true
  $Trainer.pokedex.setFormSeen(pokemon) if seeform
  return true
end

def pbGenerateEgg(pokemon,form=0,text="")
  return false if !pokemon || !$Trainer
  pokemon=PokeBattle_Pokemon.new(pokemon,EGGINITIALLEVEL,$Trainer,true,form)
  # Set egg's details
  pokemon.name=_INTL("Egg")
  pokemon.eggsteps=$cache.pkmn[pokemon.species].EggSteps
  pokemon.obtainText=text
  # Add egg to party
  #$Trainer.party[$Trainer.party.length]=pokemon
  return pokemon
  #return true
end

def pbRemovePokemonAt(index)
  return false if index<0 || index>=$Trainer.party.length
  haveAble=false
  for i in 0...$Trainer.party.length
    next if i==index
    haveAble=true if $Trainer.party[i].hp>0 && !$Trainer.party[i].isEgg?
  end
  return false if !haveAble
  $Trainer.party.delete_at(index)
  return true
end

def pbSeenForm(poke,gender=0,form=0)
  $Trainer.formseen=[] if !$Trainer.formseen
  $Trainer.formlastseen=[] if !$Trainer.formlastseen
  if poke.is_a?(PokeBattle_Pokemon)
    gender=poke.gender
    form = poke.form
    species=poke.dexnum
  else
    species=poke
  end
  gender=0 if gender>1
  $Trainer.formseen[species][gender][form]=true
  $Trainer.formlastseen[species]=[] if !$Trainer.formlastseen[species]
  $Trainer.formlastseen[species]=[gender,form] if $Trainer.formlastseen[species]==[]
end
#formseen, formlastseen

def LevelLimitExpGain(pokemon, exp) # For exp candies
  leadersDefeated = $Trainer.numbadges
  if pokemon.level >= LEVELCAPS[leadersDefeated] || pokemon.level >= 100 + $game_variables[:Extended_Max_Level] || noExp?
    return -1
  elsif pokemon.level < LEVELCAPS[leadersDefeated]
    levelcap = [LEVELCAPS[leadersDefeated], 100 + $game_variables[:Extended_Max_Level]].min
    totalExpNeeded = PBExp.startExperience(levelcap, pokemon.growthrate)
    currExpNeeded = totalExpNeeded - pokemon.exp
    if exp > currExpNeeded
      return currExpNeeded
    end
  end

  return exp
end

def addPkmnToPartyOrPC(pokemon)
  if $Trainer.party.length<6
    $Trainer.party[$Trainer.party.length]=pokemon
  else
    monsent=false
    while !monsent
      if Kernel.pbConfirmMessageSerious(_INTL("The party is full; do you want to send a party member to the PC?"))
        iMon = -2
        unusablecount = 0
        for i in $Trainer.party
          next if i.isEgg?
          next if i.hp<1
          unusablecount += 1
        end
        pbFadeOutIn(99999){
          scene=PokemonScreen_Scene.new
          screen=PokemonScreen.new(scene,$Trainer.party)
          screen.pbStartScene(_INTL("Choose a Pokémon."),false)
          loop do
            iMon=screen.pbChoosePokemon
            if iMon>=0 && [:CUT, :ROCKSMASH, :STRENGTH, :SURF, :MAGMADRIFT, :WATERFALL, :DIVE, :ROCKCLIMB, :FLASH, :FLY].any? {|tmmove| $Trainer.party[iMon].knowsMove?(tmmove) && !$PokemonBag.pbHasItem?(PBStuff::HMTOGOLDITEM[tmmove])} && !$game_switches[:EasyHMs_Password]
              Kernel.pbMessage("You can't return a Pokémon that knows a TMX move to the PC.")
              iMon=-2
            elsif unusablecount<=1 && !($Trainer.party[iMon].isEgg?) && $Trainer.party[iMon].hp>0 && pokemon.isEgg?
              Kernel.pbMessage("That's your last Pokémon!")
            else
              screen.pbEndScene
              break
            end
          end
        }
        if !(iMon < 0)
          iBox = $PokemonStorage.pbStoreCaught($Trainer.party[iMon])
          if iBox >= 0
            monsent=true
            $Trainer.party[iMon].heal
            Kernel.pbMessage(_INTL("{1} was sent to {2}.", $Trainer.party[iMon].name, $PokemonStorage[iBox].name))
            $Trainer.party[iMon] = nil
            $Trainer.party.compact!
            $Trainer.party[$Trainer.party.length]=pokemon
          else
            Kernel.pbMessage("No space left in the PC")
            return false
          end
        end
      else
        monsent=true
        oldcurbox=$PokemonStorage.currentBox
        storedbox=$PokemonStorage.pbStoreCaught(pokemon)
        curboxname=$PokemonStorage[oldcurbox].name
        boxname=$PokemonStorage[storedbox].name
        creator=nil
        creator=Kernel.pbGetStorageCreator if $PokemonGlobal.seenStorageCreator
        if storedbox!=oldcurbox
          if creator
            Kernel.pbMessage(_INTL("Box \"{1}\" on {2}'s PC was full.\1",curboxname,creator))
          else
            Kernel.pbMessage(_INTL("Box \"{1}\" on someone's PC was full.\1",curboxname))
          end
          Kernel.pbMessage(_INTL("{1} was transferred to box \"{2}.\"",pokemon.name,boxname))
        else
          if creator
            Kernel.pbMessage(_INTL("{1} was transferred to {2}'s PC.\1",pokemon.name,creator))
          else
            Kernel.pbMessage(_INTL("{1} was transferred to someone's PC.\1",pokemon.name))
          end
          Kernel.pbMessage(_INTL("It was stored in box \"{1}\".",boxname))
        end
      end
    end
  end
end

################################################################################
# Analysing Pokémon
################################################################################
# Heals all Pokémon in the party.
def pbHealAll
  return if !$Trainer
  for i in $Trainer.party
    if !$game_switches[:Nuzlocke_Mode] || i.hp>0
      i.heal
    end
  end
end

def convertBalls
  for i in $Trainer.party
    if i.ballused.is_a?(Integer)
      for j in BallHandlers::BallTypes.keys
        i.ballused = BallHandlers::BallTypes[j] if j == i.ballused
      end
    end
  end
  for x in 0...$PokemonStorage.maxBoxes
    for y in 0...$PokemonStorage.maxPokemon(x)
      if $PokemonStorage[x,y]
        i=$PokemonStorage[x,y]
        if i.ballused.is_a?(Integer)
          for j in BallHandlers::BallTypes.keys
            i.ballused = BallHandlers::BallTypes[j] if j == i.ballused
          end
        end
      end
    end
  end
  for i in $PokemonGlobal.daycare
    if i[0] && $PokemonGlobal.daycare[i][0].ballused.is_a?(Integer)
      for j in BallHandlers::BallTypes.keys
        i[0].ballused = BallHandlers::BallTypes[j] if j == i[0].ballused
      end
    end
  end
end

def pbBallRenaming(battle=false)
  if battle==true
    BallHandlers::BallTypes.each do |key, data|
        oldfilename=sprintf("Graphics/Pictures/Battle/ball%02d",key.to_s)
        if pbResolveBitmap(oldfilename)
            original = RPG::Cache.load_bitmap(oldfilename)
            original.to_file(sprintf("Graphics/Pictures/Battle/#{data.to_s}.png"))
            File.delete(sprintf("%s.png",oldfilename))
        end
        oldfilenameopen=sprintf("Graphics/Pictures/Battle/ball%02d_open",key.to_s)
        if pbResolveBitmap(oldfilenameopen)
            originalopen = RPG::Cache.load_bitmap(oldfilenameopen)
            originalopen.to_file(sprintf("Graphics/Pictures/Battle/#{data.to_s}_open.png"))
            File.delete(sprintf("%s.png",oldfilenameopen))
        end
    end
  else
    BallHandlers::BallTypes.each do |key, data|
      oldfilename=sprintf("Graphics/Pictures/Summary/summaryball%02d",key.to_s)
      if pbResolveBitmap(oldfilename)
          original = RPG::Cache.load_bitmap(oldfilename)
          original.to_file(sprintf("Graphics/Pictures/Summary/summaryball#{data.to_s}.png"))
          File.delete(sprintf("%s.png",oldfilename))
      end
      # oldfilenameopen=sprintf("Graphics/Pictures/Summary/ball%02d_open",key.to_s)
      # if pbResolveBitmap(oldfilenameopen)
      #     originalopen = RPG::Cache.load_bitmap(oldfilenameopen)
      #     originalopen.to_file(sprintf("Graphics/Pictures/Summary/#{data.to_s}_open.png"))
      #     File.delete(sprintf("%s.png",oldfilenameopen))
      # end
    end
  end
end

def pbStatusRenaming
  height = 16
  width = 48
  oldfilename=sprintf("Graphics/Pictures/Battle/battleStatuses")
  if pbResolveBitmap(oldfilename)
    statuses = ["Sleep","Burn","Frozen","Poison","Paralysis"]
    original = RPG::Cache.load_bitmap(oldfilename)
    for status in 1...5
      rectangle = Rect.new(0,(status)*16,width,height)
      newbitmap = Bitmap.new(width,height)
      newbitmap.blt(0,0,original,rectangle)
      newbitmap.to_file(sprintf("Graphics/Pictures/Battle/battleStatuses%s.png",statuses[status]))
    end
    File.delete(sprintf("%s.png",oldfilename))
  end
end

def pbFightIconRenaming
  height = 46
  width = 384
  oldfilename=sprintf("Graphics/Pictures/Battle/battleFightButtons")
  if pbResolveBitmap(oldfilename)
    types = ["NORMAL",
              "FIGHTING",
              "FLYING",
              "POISON",
              "GROUND",
              "ROCK",
              "BUG",
              "GHOST",
              "STEEL",
              "QMARKS",
              "FIRE",
              "WATER",
              "GRASS",
              "ELECTRIC",
              "PSYCHIC",
              "ICE",
              "DRAGON",
              "DARK",
              "FAIRY",
              "SHADOW"]
    original = RPG::Cache.load_bitmap(oldfilename)
    for type in 0...20
      rectangle = Rect.new(0,(type)*46,width,height)
      newbitmap = Bitmap.new(width,height)
      newbitmap.blt(0,0,original,rectangle)
      newbitmap.to_file(sprintf("Graphics/Pictures/Battle/battleFightButtons%s.png",types[type]))
    end
    File.delete(sprintf("%s.png",oldfilename))
  end
end


def pbBattlerRenamer
  $cache.pkmn.each do |key, data|
    id = $cache.pkmn[key].dexnum
    currentform = 0
    oldfilename=sprintf("Graphics/Battlers/%03d",id)
    oldfilenameegg=sprintf("Graphics/Battlers/%03degg",id)
    oldfilenamef=sprintf("Graphics/Battlers/%03df",id)
    oldfilenameeggf=sprintf("Graphics/Battlers/%03dfegg",id)
    if pbResolveBitmap(oldfilename)
      original = RPG::Cache.load_bitmap(oldfilename)
      original.to_file(sprintf("Graphics/Battlers/#{key.to_s.downcase!}.png"))
      File.delete(sprintf("%s.png",oldfilename))
    end
    if pbResolveBitmap(oldfilenamef)
      originalf = RPG::Cache.load_bitmap(oldfilenamef)
      originalf.to_file(sprintf("Graphics/Battlers/#{key.to_s.downcase!}f.png"))
      File.delete(sprintf("%s.png",oldfilenamef))
    end
    if pbResolveBitmap(oldfilenameegg)
     originalegg = RPG::Cache.load_bitmap(oldfilenameegg)
     originalegg.to_file(sprintf("Graphics/Battlers/#{key.to_s.downcase!}egg.png"))
     File.delete(sprintf("%s.png",oldfilenameegg))
    end
    if pbResolveBitmap(oldfilenameeggf)
      originaleggf = RPG::Cache.load_bitmap(oldfilenameeggf)
      originaleggf.to_file(sprintf("Graphics/Battlers/#{key.to_s.downcase!}fegg.png"))
      File.delete(sprintf("%s.png",oldfilenameeggf))
    end
    if ShitList.include?(key.to_sym) || key.to_sym == :GARDEVOIR
      for i in 0...5
        oldfilenameforms=sprintf("Graphics/Battlers/%03d_%s",id,i)
        oldfilenameformsshiny=sprintf("Graphics/Battlers/%03ds_%s",id,i)
        oldfilenameformsback=sprintf("Graphics/Battlers/%03db_%s",id,i)
        oldfilenameformsbackshiny=sprintf("Graphics/Battlers/%03dsb_%s",id,i)
        if pbResolveBitmap(oldfilenameforms)
          originalforms = RPG::Cache.load_bitmap(oldfilenameforms)
          originalforms.to_file(sprintf("Graphics/Battlers/#{key.to_s.downcase!}_%s.png",i))
          File.delete(sprintf("%s.png",oldfilenameforms))
        end
        if pbResolveBitmap(oldfilenameformsshiny)
          originalforms = RPG::Cache.load_bitmap(oldfilenameformsshiny)
          originalforms.to_file(sprintf("Graphics/Battlers/#{key.to_s.downcase!}s_%s.png",i))
          File.delete(sprintf("%s.png",oldfilenameformsshiny))
        end
        if pbResolveBitmap(oldfilenameformsback)
          originalformsback = RPG::Cache.load_bitmap(oldfilenameformsback)
          originalformsback.to_file(sprintf("Graphics/Battlers/#{key.to_s.downcase!}b_%s.png",i))
          File.delete(sprintf("%s.png",oldfilenameformsback))
        end
        if pbResolveBitmap(oldfilenameformsbackshiny)
          originalformsbackshiny = RPG::Cache.load_bitmap(oldfilenameformsbackshiny)
          originalformsbackshiny.to_file(sprintf("Graphics/Battlers/#{key.to_s.downcase!}sb_%s.png",i))
          File.delete(sprintf("%s.png",oldfilenameformsbackshiny))
        end
      end
    end
  end
end

def pbIconRenamer
  $cache.pkmn.each do |key, data|
    id = $cache.pkmn[key].dexnum
    oldfilename=sprintf("Graphics/Icons/icon%03d",id)
    oldfilenameegg=sprintf("Graphics/Icons/icon%03degg",id)
    oldfilenamef=sprintf("Graphics/Icons/icon%03df",id)
    oldfilenameeggf=sprintf("Graphics/Icons/icon%03dfegg",id)
    if pbResolveBitmap(oldfilename)
      original = RPG::Cache.load_bitmap(oldfilename)
      original.to_file(sprintf("Graphics/Icons/#{key.to_s.downcase!}.png"))
      File.delete(sprintf("%s.png",oldfilename))
    end
    if pbResolveBitmap(oldfilenamef)
      originalf = RPG::Cache.load_bitmap(oldfilenamef)
      originalf.to_file(sprintf("Graphics/Icons/#{key.to_s.downcase!}f.png"))
      File.delete(sprintf("%s.png",oldfilenamef))
    end
    if pbResolveBitmap(oldfilenameegg)
     originalegg = RPG::Cache.load_bitmap(oldfilenameegg)
     originalegg.to_file(sprintf("Graphics/Icons/#{key.to_s.downcase!}egg.png"))
     File.delete(sprintf("%s.png",oldfilenameegg))
    end
    if pbResolveBitmap(oldfilenameeggf)
      originaleggf = RPG::Cache.load_bitmap(oldfilenameeggf)
      originaleggf.to_file(sprintf("Graphics/Icons/#{key.to_s.downcase!}fegg.png"))
      File.delete(sprintf("%s.png",oldfilenameeggf))
    end
  end
end

# Heals all Pokémon in the party of Status.
def pbHealAllStatus
  return if !$Trainer
  for i in $Trainer.party
    i.healStatus
    i.healStatus
  end
end

# Heals all surviving Pokemon in party.
def pbPartialHeal
  return if !$Trainer
  for i in $Trainer.party
    if i&& !i.isEgg? && i.hp>0
      i.healStatus
      i.healHP
    end
  end
end

# Heals all surviving Pokemon in party.
def pbReviveHeal
  return if !$Trainer
  for i in $Trainer.party
    if i&& !i.isEgg? && i.hp==0
      i.status=nil
      i.hp=1+(i.totalhp/2.0).floor
    end
  end
end


# Returns the first unfainted, non-egg Pokémon in the player's party.
def pbFirstAblePokemon(variableNumber)
  for i in 0...$Trainer.party.length
    p=$Trainer.party[i]
    if p && !p.isEgg? && p.hp>0
      pbSet(variableNumber,i)
      return $Trainer.party[i]
    end
  end
  pbSet(variableNumber,-1)
  return nil
end

# Checks whether the player would still have an unfainted Pokémon if the
# Pokémon given by _pokemonIndex_ were removed from the party.
def pbCheckAble(pokemonIndex)
  for i in 0...$Trainer.party.length
    p=$Trainer.party[i]
    next if i==pokemonIndex
    return true if p && !p.isEgg? && p.hp>0
  end
  return false
end

# Returns true if there are no usable Pokémon in the player's party.
def pbAllFainted
  for i in $Trainer.party
    return false if !i.isEgg? && i.hp>0
  end
  return true
end

# Returns true if the given species can be legitimately obtained as an egg.
def pbHasEgg?(pkmn)
  evospecies=pbGetEvolvedFormData(pkmn.species,pkmn)
  compatspecies=(evospecies && evospecies[0]) ? evospecies[0][2] : pkmn.species
  compat1=$cache.pkmn[pkmn.species].EggGroups   # Get egg group of this species
  return false if compat1.include?(:Undiscovered) || pkmn.species == :DITTO  # Ditto or can't breed
  baby=pbGetBabySpecies(pkmn.species,pkmn.form)[0]
  return true if pkmn.species==baby   # Is a basic species
  baby=pbGetNonIncenseLowestSpecies(baby,pkmn.form)[0]
  return true if pkmn.species==baby   # Is an egg species without incense
  return false
end



################################################################################
# Look through Pokémon in storage, choose a Pokémon in the party
################################################################################
# Yields every Pokémon/egg in storage in turn.
def pbEachPokemon
  for i in -1...$PokemonStorage.maxBoxes
    for j in 0...$PokemonStorage.maxPokemon(i)
      poke=$PokemonStorage[i][j]
      yield(poke,i) if poke
    end
  end
end

# Yields every Pokémon in storage in turn.
def pbEachNonEggPokemon
  pbEachPokemon{|pokemon,box|
     yield(pokemon,box) if !pokemon.isEgg?
  }
end

# Choose a Pokémon/egg from the party.
# Stores result in variable _variableNumber_ and the chosen Pokémon's name in
# variable _nameVarNumber_; result is -1 if no Pokémon was chosen
# If giveAway is true then it will be impossible to select the last non-fainted pokemon.
def pbChoosePokemon(variableNumber,nameVarNumber,ableProc=nil,allowIneligible=false,giveAway=false)
  chosen=0
  pbFadeOutIn(99999){
     scene=PokemonScreen_Scene.new
     screen=PokemonScreen.new(scene,$Trainer.party)
     if ableProc
       chosen=screen.pbChooseAblePokemon(ableProc,allowIneligible,giveAway)
     else
       screen.pbStartScene(_INTL("Choose a Pokémon."),false)
       chosen=screen.pbChoosePokemon
       screen.pbEndScene
     end
  }
  pbSet(variableNumber,chosen)
  if chosen>=0
    pbSet(nameVarNumber,$Trainer.party[chosen].name)
  else
    pbSet(nameVarNumber,"")
  end
end

def pbChooseNonEggPokemon(variableNumber,nameVarNumber)
  pbChoosePokemon(variableNumber,nameVarNumber,proc {|poke|
     !poke.isEgg?
  })
end

def pbChooseAblePokemon(variableNumber,nameVarNumber)
  pbChoosePokemon(variableNumber,nameVarNumber,proc {|poke|
    !poke.isEgg? && poke.hp>0
  })
end

def pbHasSpecies?(species)
  for pokemon in $Trainer.party
    next if pokemon.isEgg?
    if pokemon.species==species
      pbSet(1,$Trainer.party.index(pokemon))
      return true 
    end
  end
  return false
end

def pbHasFatefulSpecies?(species)
  for pokemon in $Trainer.party
    next if pokemon.isEgg?
    return true if pokemon.species==species && pokemon.obtainMode==4
  end
  return false
end

# Deletes the move at the given index from the given Pokémon.
def pbDeleteMove(pokemon,index)
  pokemon.moves.delete_at(index)
  if !pokemon.zmoves.nil? && pokemon.item !=:INTERCEPTZ
    pokemon.zmoves.delete_at(index)
    pokemon.zmoves.push(nil)
  end
end

# Deletes the given move from the given Pokémon.
def pbDeleteMoveByID(pokemon,id)
  return if id.nil? || !pokemon
  index = pokemon.moves.find_index {|move| move && move.move == id}
  return if index.nil?
  pbDeleteMove(pokemon,index)
end

# Checks whether any Pokémon in the party knows the given move, and returns
# the index of that Pokémon, or nil if no Pokémon has that move.
def pbCheckMove(move)
  if $game_switches[:EasyHMs_Password]
    for item in $cache.items.keys
      aItem = $cache.items[item]
      next if aItem.checkFlag?(:tm) != move
      next if $PokemonBag.pbQuantity(item) == 0
      aIDs = []
      for i in 0...$Trainer.party.length
        aPoke = $Trainer.party[i]
        if !aPoke.isEgg? && aPoke.hp>0
          aIDs.push(i)
        end
      end
      aID = aIDs[rand(aIDs.length)]
      return $Trainer.party[aID]
    end
    if move == (:HEADBUTT)
      aIDs = []
      for i in 0...$Trainer.party.length
        aPoke = $Trainer.party[i]
        if !aPoke.isEgg? && aPoke.hp>0
          aIDs.push(i)
        end
      end
      aID = aIDs[rand(aIDs.length)]
      return $Trainer.party[aID]
    end
  end
  
  for i in $Trainer.party
    next if i.isEgg?
    for j in i.moves
      return i if j.move==move
    end
  end
  return nil
end

def pbCheckMoveType(move)
  return nil if !move
  if $cache.types.keys.include?(move)
    for i in $Trainer.party
      next if i.isEgg?
      for j in i.moves
        return i if j.type==move
      end
    end
  end
  return nil
end

################################################################################
# Regional and National Pokédexes
################################################################################
# Gets the Regional Pokédex number of the national species for the specified
# Regional Dex.  The parameter "region" is zero-based.  For example, if two
# regions are defined, they would each be specified as 0 and 1.
def pbGetRegionalNumber(region, nationalSpecies)
  if nationalSpecies<=0 || nationalSpecies>$cache.pkmn.length
    # Return 0 if national species is outside range
    return 0
  end
  if $cache.regions[region][nationalSpecies]
    return $cache.regions[region][nationalSpecies]
  else
    return 0
  end
end

# Gets the National Pokédex number of the specified species and region.  The
# parameter "region" is zero-based.  For example, if two regions are defined,
# they would each be specified as 0 and 1.
def pbGetNationalNumber(region, regionalSpecies)
  for i in 1...$cache.regions[region].length
    next if $cache.regions[region][i].nil?
    return i if $cache.regions[region][i] == regionalSpecies
  end
  return 0
end

# Gets an array of all national species within the given Regional Dex, sorted by
# Regional Dex number.  The number of items in the array should be the
# number of species in the Regional Dex plus 1, since index 0 is considered
# to be empty.  The parameter "region" is zero-based.  For example, if two
# regions are defined, they would each be specified as 0 and 1.
def pbAllRegionalSpecies(region)
  ret=[0]
  if region>=0
    for i in 1...$cache.regions[region].length
      next if $cache.regions[region][i].nil?
      regionalNum = $cache.regions[region][i]
      ret[regionalNum] = i if regionalNum!=0
    end
    for i in 0...ret.length
      ret[i]=0 if !ret[i]
    end
  end
  return ret
end

# Gets the ID number for the current region based on the player's current
# position.  Returns the value of "defaultRegion" (optional, default is -1) if
# no region was defined in the game's metadata.  The ID numbers returned by
# this function depend on the current map's position metadata.
def pbGetCurrentRegion(defaultRegion=-1)
  return defaultRegion if !$cache.mapdata[$game_map.map_id].MapPosition
  return pbUnpackMapHash[0] if $cache.mapdata[$game_map.map_id].MapPosition.is_a?(Hash)
  return $cache.mapdata[$game_map.map_id].MapPosition[0]
end

# Decides which Dex lists are able to be viewed (i.e. they are unlocked and have
# at least 1 seen species in them), and saves all viable dex region numbers
# (National Dex comes after regional dexes).
# If the Dex list shown depends on the player's location, this just decides if
# a species in the current region has been seen - doesn't look at other regions.
# Here, just used to decide whether to show the Pokédex in the Pause menu.
def pbSetViableDexes
  return # unused by all 3 main games. almost certainly does not work.
  $PokemonGlobal.pokedexViable=[]
  if DEXDEPENDSONLOCATION
    region=pbGetCurrentRegion
    region=-1 if region>=$PokemonGlobal.pokedexUnlocked.length-1
    if $Trainer.pokedex.getSeenCount(region)>0
      $PokemonGlobal.pokedexViable[0]=region
    end
  else
    numDexes=$PokemonGlobal.pokedexUnlocked.length
    case numDexes
      when 1          # National Dex only
        if $PokemonGlobal.pokedexUnlocked[0]
          if $Trainer.pokedex.getSeenCount>0
            $PokemonGlobal.pokedexViable.push(0)
          end
        end
      else            # Regional dexes + National Dex
        for i in 0...numDexes
          regionToCheck=(i==numDexes-1) ? -1 : i
          if $PokemonGlobal.pokedexUnlocked[i]
            if $Trainer.pokedex.getSeenCount>0
              $PokemonGlobal.pokedexViable.push(i)
            end
          end
        end
    end
  end
end

# Unlocks a Dex list.  The National Dex is -1 here (or nil argument).
def pbUnlockDex(dex=-1)
  $Trainer.pokedex.canViewDex=true
  index=dex
  index=$PokemonGlobal.pokedexUnlocked.length-1 if index<0
  index=$PokemonGlobal.pokedexUnlocked.length-1 if index>$PokemonGlobal.pokedexUnlocked.length-1
  $PokemonGlobal.pokedexUnlocked[index]=true
end

# Locks a Dex list.  The National Dex is -1 here (or nil argument).
def pbLockDex(dex=-1)
  index=dex
  index=$PokemonGlobal.pokedexUnlocked.length-1 if index<0
  index=$PokemonGlobal.pokedexUnlocked.length-1 if index>$PokemonGlobal.pokedexUnlocked.length-1
  $PokemonGlobal.pokedexUnlocked[index]=false
end



################################################################################
# Other utilities
################################################################################
def pbTextEntry(helptext,minlength,maxlength,variableNumber)
  $game_variables[variableNumber]=pbEnterText(helptext,minlength,maxlength)
  $game_map.need_refresh = true if $game_map
end

def pbMoveTutorAnnotations(move,movelist=nil)
  ret=[]
  for i in 0...6
    ret[i]=nil
    next if i>=$Trainer.party.length
    found=false
    for j in 0...($Trainer.party[i].moves.length)
      if !$Trainer.party[i].isEgg? && $Trainer.party[i].moves[j].move==move
        ret[i]=_INTL("LEARNED")
        found=true
      end
    end
    next if found
    species=$Trainer.party[i].species
    if !$Trainer.party[i].isEgg? && movelist && movelist.any?{|j| j==species }
      # Checked data from movelist
      ret[i]=_INTL("ABLE")
    elsif !$Trainer.party[i].isEgg? && $Trainer.party[i].SpeciesCompatible?(move)
      # Checked data from PBS/tm.txt
      ret[i]=_INTL("ABLE")
    else
      ret[i]=_INTL("NOT ABLE")
    end
  end
  return ret
end

def pbMoveTutorListAdd(move)
  if !$Trainer.tutorlist
    $Trainer.tutorlist = []
  end
  if $Trainer.tutorlist == []
    gear = Rejuv ? "Cybernav" : "Pokégear"
    Kernel.pbMessage(_INTL("Hey did you know us Move Tutors have an app set up? Check it out on your {1}!", gear))
  end
  if !$Trainer.tutorlist.include?(move)
    $Trainer.tutorlist.push(move)
  end
  reorderTutorMoves
end

def reorderTutorMoves
  $Trainer.tutorlist = $Trainer.tutorlist.uniq.sort_by do |a|
    getMoveName(a)
  end
end

def moveTutorRibbon(pokemon)
  ret=false
  if pokemon.canRelearnAll?
    Kernel.pbMessage(_INTL("It can already remember everything."))
  else
    pokemon.activateRelearner()
    ret=true
  end
  return ret
end


def pbMoveTutorChoose(move,movelist=nil,bymachine=false)
  ret=false
  pbFadeOutIn(99999){
     scene=PokemonScreen_Scene.new
     movename=getMoveName(move)
     screen=PokemonScreen.new(scene,$Trainer.party)
     annot=pbMoveTutorAnnotations(move,movelist)
     screen.pbStartScene(_INTL("Teach which Pokémon?"),false,annot)
     loop do
       chosen=screen.pbChoosePokemon
       if chosen>=0
         pokemon=$Trainer.party[chosen]
         if pokemon.isEgg?
           Kernel.pbMessage(_INTL("{1} can't be taught to an Egg.",movename))
         elsif (pokemon.isShadow? rescue false)
           Kernel.pbMessage(_INTL("Shadow Pokémon can't be taught any moves."))
         elsif movelist && !movelist.any?{|j| j==pokemon.species }
           Kernel.pbMessage(_INTL("{1} is not compatible with {2}.",pokemon.name,movename))
           Kernel.pbMessage(_INTL("{1} can't be learned.",movename))
         elsif !pokemon.SpeciesCompatible?(move)
           Kernel.pbMessage(_INTL("{1} is not compatible with {2}.",pokemon.name,movename))
           Kernel.pbMessage(_INTL("{1} can't be learned.",movename))
         else
           if pbLearnMove(pokemon,move,false,bymachine)
             ret=true
             break
           end
         end
       else
         break
       end  
     end
     screen.pbEndScene
  }
  return ret # Returns whether the move was learned by a Pokemon
end

def pbChooseMove(pokemon,variableNumber,nameVarNumber)
  return if !pokemon
  ret=-1
  pbFadeOutIn(99999){
     scene=PokemonSummaryScene.new
     screen=PokemonSummary.new(scene)
     ret=screen.pbStartForgetScreen([pokemon],0,0)
  }
  $game_variables[variableNumber]=ret
  if ret>=0
    $game_variables[nameVarNumber]=getMoveName(pokemon.moves[ret].move)
  else
    $game_variables[nameVarNumber]=""
  end
  $game_map.need_refresh = true if $game_map
end

# Opens the Pokémon screen
def pbPokemonScreen
  return if !$Trainer
  sscene=PokemonScreen_Scene.new
  sscreen=PokemonScreen.new(sscene,$Trainer.party)
  pbFadeOutIn(99999) { sscreen.pbPokemonScreen }
end

def pbSaveScreen
  ret=false
  scene=PokemonSaveScene.new
  screen=PokemonSave.new(scene)
  ret=screen.pbSaveScreen
  return ret
end

def pbCommaNumber(number)
  return number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\1,').reverse
end

# Ruby 2.7
if ! Array.method_defined?(:nitems)
  class Array
    def nitems
      count{|x| !x.nil?}
    end
  end
end

module Input
  LeftMouseKey  = 1
  RightMouseKey = 2
  F3    = 23
  F4    = 24
  F5    = 25
  PAGEUP = L
  PAGEDOWN = R
  ITEMKEYS      = [Input::F5,Input::F4,Input::F3]
  ITEMKEYSNAMES = [_INTL("F5"),_INTL("F4"),_INTL("F3")]

  def self.getstate(button)
    self.pressex?(button)
  end
end

module Mouse
  module_function

  # Returns the position of the mouse relative to the game window.
  def getMousePos(catch_anywhere = false)
    return nil unless Input.mouse_in_window? || catch_anywhere
    return Input.mouse_x, Input.mouse_y
  end
end

def startTimer
  $timer = Time.now
end

def stopTimer
  puts Time.now - $timer
end

  #gotta put this here so saves don't crash
  class BugContestState
  end

def rotomScript(numform)
  poke=pbGetPokemon(1)
  poke.form=numform
  pokemon=pbGetPokemon(1)
  form = pokemon.form

  moves=[
     :OVERHEAT,  # Heat, Microwave
     :HYDROPUMP, # Wash, Washing Machine
     :BLIZZARD,  # Frost, Refrigerator
     :HURRICANE,  # Fan
     :MOWDOWN,  # Mow, Lawnmower
     :HEATWAVE,
     :SCALD,
     :FREEZEDRY,
     :AIRSLASH,
     :GRASSYGLIDE 
  ]
  moves.each{|move|
     pbDeleteMoveByID(pokemon,move)
  }
  if form>0
    pokemon.pbLearnMove(moves[form-1])
  end
  if pokemon.moves.find_all{|i| i.move!=0}.length==0
    pokemon.pbLearnMove(:THUNDERSHOCK)
  end
end

def noExp?
  return true if $game_switches[:No_EXP_Gain]
  return $game_switches[:Percent_Exp_Gains] && $game_variables[:Exp_Percent] == 0
end