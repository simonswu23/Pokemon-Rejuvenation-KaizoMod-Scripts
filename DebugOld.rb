class PokemonDataCopy
  attr_accessor :dataOldHash
  attr_accessor :dataNewHash
  attr_accessor :dataTime
  attr_accessor :data

  def crc32(x)
    return Zlib::crc32(x)
  end

  def readfile(filename)
    File.open(filename, "rb"){|f|
       f.read
    }
  end

  def writefile(str,filename)
    File.open(filename, "wb"){|f|
       f.write(str)
    }
  end

  def filetime(filename)
    File.open(filename, "r"){|f|
       f.mtime
    }
  end

  def initialize(data,datasave)
    @datafile=data
    @datasave=datasave
    @data=readfile(@datafile)
    @dataOldHash=crc32(@data)
    @dataTime=filetime(@datafile)
  end

  def changed?
    ts=readfile(@datafile)
    tsDate=filetime(@datafile)
    tsHash=crc32(ts)
    return tsHash!=@dataNewHash && tsHash!=@dataOldHash && tsDate > @dataTime
  end

  def save(newtilesets)
    newdata=Marshal.dump(newtilesets)
    if !changed?
      @data=newdata
      @dataNewHash=crc32(newdata)
      writefile(newdata,@datafile)
    else
      @dataOldHash=crc32(@data)
      @dataNewHash=crc32(newdata)
      @dataTime=filetime(@datafile)
      @data=newdata
      writefile(newdata,@datafile)
    end
    save_data(self,@datasave)
  end
end



class PokemonDataWrapper
  attr_reader :data

  def initialize(file,savefile,prompt)
    @savefile=savefile
    @file=file
    if pbRgssExists?(@savefile)
      @ts=load_data(@savefile)
      if !@ts.changed? || prompt.call==true
        @data=Marshal.load(@ts.data)
      else
        @ts=PokemonDataCopy.new(@file,@savefile)
        @data=load_data(@file)
      end
    else
      @ts=PokemonDataCopy.new(@file,@savefile)
      @data=load_data(@file)
    end
  end

  def save
    @ts.save(@data)
  end
end

def pbMapTree
  maplevels=[]
  retarray=[]
  for i in $cache.mapinfos.keys
    info=$cache.mapinfos[i]
    level=-1
    while info
      info=$cache.mapinfos[info.parent_id]
      level+=1
    end
    if level>=0
      info=$cache.mapinfos[i]
      maplevels.push([i,level,info.parent_id,info.order])
    end
  end
  maplevels.sort!{|a,b|
     next a[1]<=>b[1] if a[1]!=b[1] # level
     next a[2]<=>b[2] if a[2]!=b[2] # parent ID
     next a[3]<=>b[3] # order
  }
  stack=[]
  stack.push(0,0)
  while stack.length>0
    parent = stack[stack.length-1]
    index = stack[stack.length-2]
    if index>=maplevels.length
      stack.pop
      stack.pop
      next
    end
    maplevel=maplevels[index]
    stack[stack.length-2]+=1
    if maplevel[2]!=parent
      stack.pop
      stack.pop
      next
    end
    retarray.push([maplevel[0],$cache.mapinfos[maplevel[0]].name,maplevel[1]])
    for i in index+1...maplevels.length
      if maplevels[i][2]==maplevel[0]
        stack.push(i)
        stack.push(maplevel[0])
        break
      end
    end
  end
  return retarray
end

def pbExtractText #kill this
  msgwindow=Kernel.pbCreateMessageWindow
  Kernel.pbMessageDisplay(msgwindow,_INTL("Please wait.\\wtnp[0]"))
  MessageTypes.extract("intl.txt")
  Kernel.pbMessageDisplay(msgwindow,
     _INTL("All text in the game was extracted and saved to intl.txt.\1"))
  Kernel.pbMessageDisplay(msgwindow,
     _INTL("To localize the text for a particular language, translate every second line in the file.\1"))
  Kernel.pbMessageDisplay(msgwindow,
     _INTL("After translating, choose \"Compile Text.\""))
  Kernel.pbDisposeMessageWindow(msgwindow)
end

def pbCompileTextUI
  msgwindow=Kernel.pbCreateMessageWindow
  Kernel.pbMessageDisplay(msgwindow,_INTL("Please wait.\\wtnp[0]"))
  begin
    pbCompileText
    Kernel.pbMessageDisplay(msgwindow,
       _INTL("Successfully compiled text and saved it to intl.dat."))
    Kernel.pbMessageDisplay(msgwindow,
       _INTL("To use the file in a game, place the file in the Data folder under a different name, and edit the LANGUAGES array in the Settings script."))
    rescue RuntimeError
    Kernel.pbMessageDisplay(msgwindow,
       _INTL("Failed to compile text:  {1}",$!.message))
  end
  Kernel.pbDisposeMessageWindow(msgwindow)
end



class CommandList
  def initialize
    @commandHash={}
    @commands=[]
  end

  def getCommand(index)
    for key in @commandHash.keys
      return key if @commandHash[key]==index
    end
    return nil
  end

  def add(key,value)
    @commandHash[key]=@commands.length
    @commands.push(value)
  end

  def list
    @commands.clone
  end
end



def pbDefaultMap()
  return $game_map.map_id if $game_map
  return $cache.RXsystem.edit_map_id if $cache.RXsystem
  return 0
end

def pbWarpToMap()
  if Input.pressex?(:A)
    params=ChooseNumberParams.new
    params.setRange(1,999)
    params.setInitialValue(0)
    params.setCancelValue(0)
    mapid=Kernel.pbMessageChooseNumber('To which map id do you want to warp to?',params)
  else 
    mapid=pbListScreen(_INTL("WARP TO MAP"),MapLister.new(pbDefaultMap()))
  end
  if mapid>0
    map=Game_Map.new
    map.setup(mapid)
    success=false
    x=0
    y=0
    100.times do
      x=rand(map.width)
      y=rand(map.height)
      next if !map.passableStrict?(x,y,0,$game_player)
      blocked=false
      for event in map.events.values
        if event.x == x && event.y == y && !event.through
          blocked=true if self != $game_player || event.character_name != ""
        end
      end
      next if blocked
      success=true
      break
    end
    if !success
      x=rand(map.width)
      y=rand(map.height)
    end
    return [mapid,x,y]
  end
  return nil
end

def pbDebugMenu
  viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
  viewport.z=99999
  sprites={}
  commands=CommandList.new
  commands.add("switches",_INTL("Switches"))
  commands.add("variables",_INTL("Variables"))
  commands.add("refreshmap",_INTL("Refresh Map"))
  commands.add("warp",_INTL("Warp to Map (press A for map id)"))
  commands.add("healparty",_INTL("Heal Party"))
  commands.add("additem",_INTL("Add Item"))
  commands.add("clearbag",_INTL("Empty Bag"))
  commands.add("addpokemon",_INTL("Add Pokémon"))
  commands.add("teamyeet",_INTL("Export team to text"))
  commands.add("setplayer",_INTL("Set Player Character"))
  commands.add("renameplayer",_INTL("Rename Player"))
  commands.add("usepc",_INTL("Use PC"))
  commands.add("randomid",_INTL("Randomise Player's ID"))
  commands.add("changeoutfit",_INTL("Change Player Outfit"))
  commands.add("setmoney",_INTL("Set Money"))
  commands.add("setcoins",_INTL("Set Coins"))
  commands.add("setbadges",_INTL("Set Badges"))
  commands.add("toggleshoes",_INTL("Toggle Running Shoes Ownership"))
  commands.add("togglepokegear",_INTL("Toggle Pokégear Ownership"))
  commands.add("togglepokedex",_INTL("Toggle Pokédex Ownership"))
  commands.add("dexlists",_INTL("Dex List Accessibility"))
  commands.add("daycare",_INTL("Day Care Options..."))
  commands.add("quickhatch",_INTL("Quick Hatch"))
  commands.add("roamerstatus",_INTL("Roaming Pokémon Status"))
  commands.add("roam",_INTL("Advance Roaming"))
  commands.add("terraintags",_INTL("Set Terrain Tags"))
  commands.add("testwildbattle",_INTL("Test Wild Battle"))
  commands.add("testdoublewildbattle",_INTL("Test Double Wild Battle"))
  commands.add("testtrainerbattle",_INTL("Test Trainer Battle"))
  commands.add("testdoubletrainerbattle",_INTL("Test Double Trainer Battle"))
  commands.add("relicstone",_INTL("Relic Stone"))
  commands.add("purifychamber",_INTL("Purify Chamber"))
  commands.add("extracttext",_INTL("Extract Text"))
  commands.add("compiletext",_INTL("Compile Text"))
  commands.add("compiletrainers", _INTL("Compile Trainers"))
  commands.add("compiledata",_INTL("Compile All Data"))
  commands.add("mapconnections",_INTL("Map Connections"))
  commands.add("animeditor",_INTL("Animation Editor"))
  commands.add("togglelogging",_INTL("Toggle Battle Logging"))
  sprites["cmdwindow"]=Window_CommandPokemon.new(commands.list)
  cmdwindow=sprites["cmdwindow"]
  cmdwindow.viewport=viewport
  cmdwindow.resizeToFit(cmdwindow.commands)
  cmdwindow.height=Graphics.height if cmdwindow.height>Graphics.height
  cmdwindow.x=0
  cmdwindow.y=0
  cmdwindow.visible=true
  pbFadeInAndShow(sprites)
  ret=-1
  loop do
    loop do
      cmdwindow.update
      Graphics.update
      Input.update
      if Input.trigger?(Input::B)
        ret=-1
        break
      end
      if Input.trigger?(Input::C)
        ret=cmdwindow.index
        break
      end
    end
    break if ret==-1
    cmd=commands.getCommand(ret)
    if cmd=="switches"
      pbFadeOutIn(99999) { pbDebugScreen(0) }
    elsif cmd=="variables"
      pbFadeOutIn(99999) { pbDebugScreen(1) }
    elsif cmd=="refreshmap"
      $game_map.need_refresh = true
      Kernel.pbMessage(_INTL("The map will refresh."))
    elsif cmd=="warp"
      map=pbWarpToMap()
      if map
        pbFadeOutAndHide(sprites)
        pbDisposeSpriteHash(sprites)
        viewport.dispose
        if $scene.is_a?(Scene_Map)
          $game_temp.player_new_map_id=map[0]
          $game_temp.player_new_x=map[1]
          $game_temp.player_new_y=map[2]
          $game_temp.player_new_direction=2
          $scene.transfer_player
          $game_map.refresh
        else
          Kernel.pbCancelVehicles
          $MapFactory.setup(map[0])
          $game_player.moveto(map[1],map[2])
          $game_player.turn_down
          $game_map.update
          $game_map.autoplay
          $game_map.refresh
        end
        return
      end
    elsif cmd=="healparty"
      for i in $Trainer.party
        i.heal
      end
      Kernel.pbMessage(_INTL("Your Pokémon were healed."))
    elsif cmd=="additem"
      item=pbListScreen(_INTL("ADD ITEM"),ItemLister.new(0))
      if item
        params=ChooseNumberParams.new
        params.setRange(1,BAGMAXPERSLOT)
        params.setInitialValue(1)
        params.setCancelValue(0)
        qty=Kernel.pbMessageChooseNumber(
           _INTL("Choose the number of items."),params
        )
        if qty>0
          if qty==1
            Kernel.pbReceiveItem(item)
          else
            Kernel.pbMessage(_INTL("The item was added."))
            $PokemonBag.pbStoreItem(item,qty)
          end
        end
      end
    elsif cmd=="clearbag"
      $PokemonBag.clear
      Kernel.pbMessage(_INTL("The Bag was cleared."))
    elsif cmd=="addpokemon"
      species=pbChooseSpeciesOrdered(1)
      if species
        params=ChooseNumberParams.new
        params.setRange(1,MAXIMUMLEVEL)
        params.setInitialValue(5)
        params.setCancelValue(0)
        level=Kernel.pbMessageChooseNumber(_INTL("Set the Pokémon's level."),params)
        params=ChooseNumberParams.new
        params.setRange(0,$cache.pkmn[species].forms.length)
        params.setInitialValue(0)
        form=Kernel.pbMessageChooseNumber(_INTL("Set the Pokémon's form."),params)
        if level>0
          pbAddPokemon(species,level,true,form)
        end
      end
    elsif cmd=="usepc"
      pbPokeCenterPC
    elsif cmd=="teamyeet"
      teamtotext
    elsif cmd=="setplayer"
      limit=0
      for i in 0...$cache.metadata[:Players].length+1
        meta=$cache.metadata[:Players][i]
        if !meta
          limit=i
          break
        end
      end
      if limit<=1
        Kernel.pbMessage(_INTL("There is only one player defined."))
      else
        params=ChooseNumberParams.new
        params.setRange(0,23)
        params.setDefaultValue($PokemonGlobal.playerID)
        newid=Kernel.pbMessageChooseNumber(
           _INTL("Choose the new player character."),params)
        if newid!=$PokemonGlobal.playerID
          pbChangePlayer(newid)
          Kernel.pbMessage(_INTL("The player character was changed."))
        end
      end
    elsif cmd=="renameplayer"
      trname=pbEnterPlayerName("Your name?",0,12,$Trainer.name)
      if trname==""
        trainertype=pbGetPlayerTrainerType
        gender=pbGetTrainerTypeGender(trainertype) 
        trname=pbSuggestTrainerName(gender)
      end
      $Trainer.name=trname
      Kernel.pbMessage(_INTL("The player's name was changed to {1}.",$Trainer.name))
    elsif cmd=="randomid"
      $Trainer.id=rand(256)
      $Trainer.id|=rand(256)<<8
      $Trainer.id|=rand(256)<<16
      $Trainer.id|=rand(256)<<24
      Kernel.pbMessage(_INTL("The player's ID was changed to {1} (2).",$Trainer.publicID,$Trainer.id))
    elsif cmd=="changeoutfit"
      oldoutfit=$Trainer.outfit
      params=ChooseNumberParams.new
      params.setRange(0,99)
      params.setDefaultValue(oldoutfit)
      $Trainer.outfit=Kernel.pbMessageChooseNumber(_INTL("Set the player's outfit."),params)
      Kernel.pbMessage(_INTL("Player's outfit was changed.")) if $Trainer.outfit!=oldoutfit
    elsif cmd=="setmoney"
      params=ChooseNumberParams.new
      params.setMaxDigits(6)
      params.setDefaultValue($Trainer.money)
      $Trainer.money=Kernel.pbMessageChooseNumber(
         _INTL("Set the player's money."),params)
      Kernel.pbMessage(_INTL("You now have ${1}.",$Trainer.money))
    elsif cmd=="setcoins"
      params=ChooseNumberParams.new
      params.setRange(0,MAXCOINS)
      params.setDefaultValue($PokemonGlobal.coins)
      $PokemonGlobal.coins=Kernel.pbMessageChooseNumber(
         _INTL("Set the player's Coin amount."),params)
      Kernel.pbMessage(_INTL("You now have {1} Coins.",$PokemonGlobal.coins))
    elsif cmd=="setbadges"
      badgecmd=0
      loop do
        badgecmds=[]
        for i in 0...BADGECOUNT
          badgecmds.push(_INTL("{1} Badge {2}",$Trainer.badges[i] ? "[Y]" : "[N]",i+1))
        end
        badgecmd=Kernel.pbShowCommands(nil,badgecmds,-1,badgecmd)
        break if badgecmd<0
        $Trainer.badges[badgecmd] = !$Trainer.badges[badgecmd]
      end
    elsif cmd=="toggleshoes"
      $PokemonGlobal.runningShoes=!$PokemonGlobal.runningShoes
      Kernel.pbMessage(_INTL("Gave Running Shoes.")) if $PokemonGlobal.runningShoes
      Kernel.pbMessage(_INTL("Lost Running Shoes.")) if !$PokemonGlobal.runningShoes
    elsif cmd=="togglepokegear"
      $Trainer.pokegear=!$Trainer.pokegear
      Kernel.pbMessage(_INTL("Gave Pokégear.")) if $Trainer.pokegear
      Kernel.pbMessage(_INTL("Lost Pokégear.")) if !$Trainer.pokegear
    elsif cmd=="togglepokedex"
      $Trainer.pokedex.canViewDex=!$Trainer.pokedex.canViewDex
      Kernel.pbMessage(_INTL("Gave Pokédex.")) if $Trainer.pokedex.canViewDex
      Kernel.pbMessage(_INTL("Lost Pokédex.")) if !$Trainer.pokedex.canViewDex
    elsif cmd=="dexlists"
      dexescmd=0
      loop do
        dexescmds=[]
        d=pbDexNames
        for i in 0...d.length
          name=d[i]
          name=name[0] if name.is_a?(Array)
          dexindex=i
          unlocked=$PokemonGlobal.pokedexUnlocked[dexindex]
          dexescmds.push(_INTL("{1} {2}",unlocked ? "[Y]" : "[  ]",name))
        end
        dexescmd=Kernel.pbShowCommands(nil,dexescmds,-1,dexescmd)
        break if dexescmd<0
        dexindex=dexescmd
        if $PokemonGlobal.pokedexUnlocked[dexindex]
          pbLockDex(dexindex)
        else
          pbUnlockDex(dexindex)
        end
      end
    elsif cmd=="daycare"
      daycarecmd=0
      loop do
        daycarecmds=[
           _INTL("Summary"),
           _INTL("Deposit Pokémon"),
           _INTL("Withdraw Pokémon"),
           _INTL("Generate egg"),
           _INTL("Collect egg"),
           _INTL("Dispose egg")
        ]
        daycarecmd=Kernel.pbShowCommands(nil,daycarecmds,-1,daycarecmd)
        break if daycarecmd<0
        case daycarecmd
          when 0 # Summary
            if $PokemonGlobal.daycare
              num=pbDayCareDeposited
              Kernel.pbMessage(_INTL("{1} Pokémon are in the Day Care.",num))
              if num>0
                txt=""
                for i in 0...num
                  next if !$PokemonGlobal.daycare[i][0]
                  pkmn=$PokemonGlobal.daycare[i][0]
                  initlevel=$PokemonGlobal.daycare[i][1]
                  gender=[_INTL("♂"),_INTL("♀"),_INTL("genderless")][pkmn.gender]
                  txt+=_INTL("{1}) {2} ({3}), Lv.{4} (deposited at Lv.{5})",
                     i,pkmn.name,gender,pkmn.level,initlevel)
                  txt+="\n" if i<num-1
                end
                Kernel.pbMessage(txt)
              end
              if $PokemonGlobal.daycareEgg==1
                Kernel.pbMessage(_INTL("An egg is waiting to be picked up."))
              elsif pbDayCareDeposited==2
                if pbDayCareGetCompat==0
                  Kernel.pbMessage(_INTL("The deposited Pokémon can't breed."))
                else
                  Kernel.pbMessage(_INTL("The deposited Pokémon can breed."))
                end
              end
            end
          when 1 # Deposit Pokémon
            if pbEggGenerated?
              Kernel.pbMessage(_INTL("Egg is available, can't deposit Pokémon."))
            elsif pbDayCareDeposited==2
              Kernel.pbMessage(_INTL("Two Pokémon are deposited already."))
            elsif $Trainer.party.length==0
              Kernel.pbMessage(_INTL("Party is empty, can't desposit Pokémon."))
            else
              pbChooseNonEggPokemon(1,3)
              if pbGet(1)>=0
                pbDayCareDeposit(pbGet(1))
                Kernel.pbMessage(_INTL("Deposited {1}.",pbGet(3)))
              end
            end
          when 2 # Withdraw Pokémon
            if pbEggGenerated?
              Kernel.pbMessage(_INTL("Egg is available, can't withdraw Pokémon."))
            elsif pbDayCareDeposited==0
              Kernel.pbMessage(_INTL("No Pokémon are in the Day Care."))
            elsif $Trainer.party.length>=6
              Kernel.pbMessage(_INTL("Party is full, can't withdraw Pokémon."))
            else
              pbDayCareChoose(_INTL("Which one do you want back?"),1)
              if pbGet(1)>=0
                pbDayCareGetDeposited(pbGet(1),3,4)
                pbDayCareWithdraw(pbGet(1))
                Kernel.pbMessage(_INTL("Withdrew {1}.",pbGet(3)))
              end
            end
          when 3 # Generate egg
            if $PokemonGlobal.daycareEgg==1
              Kernel.pbMessage(_INTL("An egg is already waiting."))
            elsif pbDayCareDeposited!=2
              Kernel.pbMessage(_INTL("There aren't 2 Pokémon in the Day Care."))
            elsif pbDayCareGetCompat==0
              Kernel.pbMessage(_INTL("The Pokémon in the Day Care can't breed."))
            else
              $PokemonGlobal.daycareEgg=1
              Kernel.pbMessage(_INTL("An egg is now waiting in the Day Care."))
            end
          when 4 # Collect egg
            if $PokemonGlobal.daycareEgg!=1
              Kernel.pbMessage(_INTL("There is no egg available."))
            elsif $Trainer.party.length>=6
              Kernel.pbMessage(_INTL("Party is full, can't collect the egg."))
            else
              pbDayCareGenerateEgg
              $PokemonGlobal.daycareEgg=0
              $PokemonGlobal.daycareEggSteps=0
              Kernel.pbMessage(_INTL("Collected the {1} egg.",
                 getMonName($Trainer.party[$Trainer.party.length-1].species)))
            end
          when 5 # Dispose egg
            if $PokemonGlobal.daycareEgg!=1
              Kernel.pbMessage(_INTL("There is no egg available."))
            else
              $PokemonGlobal.daycareEgg=0
              $PokemonGlobal.daycareEggSteps=0
              Kernel.pbMessage(_INTL("Disposed of the egg."))
            end
        end
      end
    elsif cmd=="quickhatch"
      for pokemon in $Trainer.party
        pokemon.eggsteps=1 if pokemon.isEgg?
      end
      Kernel.pbMessage(_INTL("All eggs on your party now require one step to hatch."))
    elsif cmd=="roamerstatus"
      if RoamingSpecies.length==0
        Kernel.pbMessage(_INTL("No roaming Pokémon defined."))
      else
        text="\\l[8]"
        for i in 0...RoamingSpecies.length
          poke=RoamingSpecies[i]
          if $game_switches[poke[:switch]]
            status=$PokemonGlobal.roamPokemon[i]
            if status==true
              if $PokemonGlobal.roamPokemonCaught[i]
                text+=_INTL("{1} (Lv.{2}) caught.", getMonName(poke[:species]),poke[:level])
              else
                text+=_INTL("{1} (Lv.{2}) defeated.", getMonName(poke[:species]),poke[:level])
              end
            else
              curmap=$PokemonGlobal.roamPosition[i]
              if curmap
                $cache.mapinfos
                text+=_INTL("{1} (Lv.{2}) roaming on map {3} ({4}){5}",getMonName(poke[:species]),poke[:level],curmap,
                   $cache.mapinfos[curmap].name,(curmap==$game_map.map_id) ? _INTL("(this map)") : "")
              else
                text+=_INTL("{1} (Lv.{2}) roaming (map not set).",getMonName(poke[:species]),poke[:level])
              end
            end
          else
            text+=_INTL("{1} (Lv.{2}) not roaming (switch {3} is off).",getMonName(poke[:species]),poke[:level],poke[:switch])
          end
          text+="\n" if i<RoamingSpecies.length-1
        end
        Kernel.pbMessage(text)
      end
    elsif cmd=="roam"
      if RoamingSpecies.length==0
        Kernel.pbMessage(_INTL("No roaming Pokémon defined."))
      else
        pbRoamPokemon(true)
        #$PokemonGlobal.roamedAlready=false
        Kernel.pbMessage(_INTL("Pokémon have roamed."))
      end
    elsif cmd=="terraintags"
      pbFadeOutIn(99999) { pbTilesetScreen }
    elsif cmd=="testwildbattle"
      species=pbChooseSpeciesOrdered(1)
      if species
        params=ChooseNumberParams.new
        params.setRange(1,MAXIMUMLEVEL)
        params.setInitialValue(5)
        params.setCancelValue(0)
        level=Kernel.pbMessageChooseNumber(
           _INTL("Set the Pokémon's level."),params)
        if level>0
          pbWildBattle(species,level)
        end
      end
    elsif cmd=="testdoublewildbattle"
      Kernel.pbMessage(_INTL("Choose the first Pokémon."))
      species1=pbChooseSpeciesOrdered(1)
      if species1
        params=ChooseNumberParams.new
        params.setRange(1,MAXIMUMLEVEL)
        params.setInitialValue(5)
        params.setCancelValue(0)
        level1=Kernel.pbMessageChooseNumber(
           _INTL("Set the first Pokémon's level."),params)
        if level1>0
          Kernel.pbMessage(_INTL("Choose the second Pokémon."))
          species2=pbChooseSpeciesOrdered(1)
          if species2
            params=ChooseNumberParams.new
            params.setRange(1,MAXIMUMLEVEL)
            params.setInitialValue(5)
            params.setCancelValue(0)
            level2=Kernel.pbMessageChooseNumber(
               _INTL("Set the second Pokémon's level."),params)
            if level2>0
              pbDoubleWildBattle(species1,level1,species2,level2)
            end
          end
        end
      end
    elsif cmd=="testtrainerbattle"
      battle=pbListScreen(_INTL("SINGLE TRAINER"),TrainerBattleLister.new(0,false))
      if battle
        trainerdata=battle[1]
        pbTrainerBattle(trainerdata[0],trainerdata[1],"...",false,trainerdata[4],true)
      end
    elsif cmd=="testdoubletrainerbattle"
      battle1=pbListScreen(_INTL("DOUBLE TRAINER 1"),TrainerBattleLister.new(0,false))
      if battle1
        battle2=pbListScreen(_INTL("DOUBLE TRAINER 2"),TrainerBattleLister.new(0,false))
        if battle2
          trainerdata1=battle1[1]
          trainerdata2=battle2[1]
          pbDoubleTrainerBattle(trainerdata1[0],trainerdata1[1],trainerdata1[4],"...",
                                trainerdata2[0],trainerdata2[1],trainerdata2[4],"...",
                                true)
        end
      end
    elsif cmd=="relicstone"
      pbRelicStone()
    elsif cmd=="purifychamber"
      pbPurifyChamber()
    elsif cmd=="extracttext"
      pbExtractText
    elsif cmd=="compiletext"
      pbCompileTextUI
    elsif cmd=="compiletrainers"
      begin
        compileTrainers
        $cache.trainers=load_data("Data/trainers.dat")
        Kernel.pbMessage(_INTL("Trainers have been compiled."))
      rescue
        pbPrintException($!)
      end
    elsif cmd=="compiledata"
      compileAll
      Kernel.pbMessage(_INTL("All data has been compiled."))
    elsif cmd=="mapconnections"
      pbFadeOutIn(99999) { pbEditorScreen }
    elsif cmd=="animeditor"
      pbFadeOutIn(99999) { pbAnimationEditor }
    elsif cmd=="togglelogging"
      $INTERNAL=!$INTERNAL
      Kernel.pbMessage(_INTL("Debug logs for battles will be made in the Data folder.")) if $INTERNAL
      Kernel.pbMessage(_INTL("Debug logs for battles will not be made.")) if !$INTERNAL
    end
  end
  pbFadeOutAndHide(sprites)
  pbDisposeSpriteHash(sprites)
  viewport.dispose
end



class SpriteWindow_DebugRight < Window_DrawableCommand
  attr_reader :mode

  def initialize
    super(0, 0, Graphics.width, Graphics.height)
  end

  def shadowtext(x,y,w,h,t,align=0)
    width=self.contents.text_size(t).width
    if align==2
      x+=(w-width)
    elsif align==1
      x+=(w/2)-(width/2)
    end
    pbDrawShadowText(self.contents,x,y,[width,w].max,h,t,
       Color.new(12*8,12*8,12*8),Color.new(26*8,26*8,25*8))
  end

  def drawItem(index,count,rect)
    pbSetNarrowFont(self.contents)
    if @mode == 0
      name = $cache.RXsystem.switches[index+1]
      status = $game_switches[index+1] ? "[ON]" : "[OFF]"
    else
      name = $cache.RXsystem.variables[index+1]
      if !$game_variables[index+1].is_a?(Array)
        status = $game_variables[index+1].to_s
      else
        status = "(Can't display contents)"
      end
    end
    if name == nil
      name = ''
    end
    id_text = sprintf("%04d:", index+1)
    width = self.contents.text_size(id_text).width
    rect=drawCursor(index,rect)
    totalWidth=rect.width
    idWidth=totalWidth*15/100
    nameWidth=totalWidth*65/100
    statusWidth=totalWidth*20/100
    self.shadowtext(rect.x, rect.y, idWidth, rect.height, id_text)
    self.shadowtext(rect.x+idWidth, rect.y, nameWidth, rect.height, name)
    self.shadowtext(rect.x+idWidth+nameWidth, rect.y, statusWidth, rect.height, status, 2)
  end

  def itemCount
    return (@mode==0) ? $cache.RXsystem.switches.size-1 : $cache.RXsystem.variables.size-1
  end

  def mode=(mode)
    @mode = mode
    refresh
  end
end

def pbDebugSetVariable(id,diff)
  pbPlayCursorSE()
  $game_variables[id]=0 if $game_variables[id]==nil
  if $game_variables[id].is_a?(Numeric) && !$game_variables[id].is_a?(Array)
    $game_variables[id]=[$game_variables[id]+diff,99999999].min
    $game_variables[id]=[$game_variables[id],-99999999].max
  end
end

def pbDebugVariableScreen(id)
  value=0
  if $game_variables[id].is_a?(Numeric) && !$game_variables[id].is_a?(Array)
    value=$game_variables[id]
  end
  params=ChooseNumberParams.new
  params.setDefaultValue(value)
  params.setMaxDigits(8)
  params.setNegativesAllowed(true)
  value=Kernel.pbMessageChooseNumber(_INTL("Set variable {1}.",id),params)
  $game_variables[id]=[value,99999999].min
  $game_variables[id]=[$game_variables[id],-99999999].max
end

def pbDebugScreen(mode)
  viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
  viewport.z=99999
  sprites={}
  sprites["right_window"] = SpriteWindow_DebugRight.new  
  right_window=sprites["right_window"]
  right_window.mode=mode
  right_window.viewport=viewport
  right_window.active=true
  right_window.index=0
  pbFadeInAndShow(sprites)
  loop do
    Graphics.update
    Input.update
    pbUpdateSpriteHash(sprites)
    if Input.trigger?(Input::B)
      pbPlayCancelSE()
      break
    elsif Input.trigger?(Input::X)
      Input.text_input = true
      puts right_window.inspect
      switch = Kernel.pbMessageFreeText(_INTL("Jump to switch?"),"",false,999,500)
      if switch.to_i.to_s == switch
        switch = switch.to_i
        right_window.index = switch - 1
      else
        results = []
        if mode == 0
          for i in 1...$cache.RXsystem.switches.length
            results.push(right_window(i)) if $cache.RXsystem.switches[i].include?(switch)
          end
        elsif mode == 1
          for i in 1...$cache.RXsystem.variables.length
            results.push(right_window(i)) if $cache.RXsystem.variables[i].include?(switch)
          end
        end
        puts results
      end
      Input.text_input = false
    end
    current_id = right_window.index+1
    if mode == 0
      if Input.trigger?(Input::C)
        pbPlayDecisionSE()
        $game_switches[current_id] = (!$game_switches[current_id])
        right_window.refresh
      end
    elsif mode == 1
      if Input.repeat?(Input::RIGHT)
        pbDebugSetVariable(current_id,1)
        right_window.refresh
      elsif Input.repeat?(Input::LEFT)
        pbDebugSetVariable(current_id,-1)
        right_window.refresh
      elsif Input.trigger?(Input::C)
        pbDebugVariableScreen(current_id)
        right_window.refresh
      end
    end
  end
  pbFadeOutAndHide(sprites)
  pbDisposeSpriteHash(sprites)
  viewport.dispose
end

def pbPokemonDebug(origin, pkmn, pkmnid=nil, selected=nil, heldpoke=nil)
  command=0
  loop do
    menuoptions = [
      _INTL("HP/Status"),
      _INTL("Level"),
      _INTL("Species"),
      _INTL("Moves"),
      _INTL("Gender"),
      _INTL("Ability"),
      _INTL("Nature"),
      _INTL("Shininess"),
      _INTL("Form"),
      _INTL("Happiness"),
      _INTL("EV/IV/pID"),
      _INTL("Pokérus"),
      _INTL("Ownership"),
      _INTL("Nickname"),
      _INTL("Poké Ball"),
      _INTL("Egg"),
      _INTL("Shadow Pokémon"),
      _INTL("Duplicate"),
      _INTL("Delete"),
      _INTL("Cancel")
    ]
    command=@scene.pbShowCommands(_INTL("Do what with {1}?",pkmn.name),menuoptions,command)
    case menuoptions[command]
      ### Cancel ###
      when "Cancel"
        break

      ### HP/Status ###
      when "HP/Status"
        cmd=0
        loop do
          arr = [
            _INTL("Set HP"),
            _INTL("Status: Sleep"),
            _INTL("Status: Poison"),
            _INTL("Status: Burn"),
            _INTL("Status: Paralysis"),
            _INTL("Status: Frozen")
          ]
          arr.push(_INTL("Status: Petrified")) if Rejuv
          arr += [
            _INTL("Fainted"),
            _INTL("Heal")
          ]
          cmd=@scene.pbShowCommands(_INTL("Do what with {1}?",pkmn.name),arr,cmd)
          # Break
          if cmd==-1
            break
          # Set HP
          elsif cmd==0
            params=ChooseNumberParams.new
            params.setRange(0,pkmn.totalhp)
            params.setDefaultValue(pkmn.hp)
            newhp=Kernel.pbMessageChooseNumber(
               _INTL("Set the Pokémon's HP (max. {1}).",pkmn.totalhp),params) { @scene.update }
            if newhp!=pkmn.hp
              pkmn.hp=newhp
              pbDisplay(_INTL("{1}'s HP was set to {2}.",pkmn.name,pkmn.hp))
              @scene.pbHardRefresh
            end
          # Set status
          elsif cmd >= 1 && cmd < arr.length - 2
            if pkmn.hp>0
              statuses = [:SLEEP, :POISON, :BURN, :PARALYSIS, :FROZEN]
              statuses.push(:PETRIFIED) if Rejuv
              pkmn.status=statuses[cmd-1]
              pkmn.statusCount=0
              if pkmn.status== :SLEEP
                params=ChooseNumberParams.new
                params.setRange(0,9)
                params.setDefaultValue(0)
                sleep=Kernel.pbMessageChooseNumber(
                   _INTL("Set the Pokémon's sleep count."),params) { @scene.update }
                pkmn.statusCount=sleep
              end
              pbDisplay(_INTL("{1}'s status was changed.",pkmn.name))
              @scene.pbHardRefresh
            else
              pbDisplay(_INTL("{1}'s status could not be changed.",pkmn.name))
            end
          # Faint
          elsif cmd==arr.length - 2
            pkmn.hp=0
            pbDisplay(_INTL("{1}'s HP was set to 0.",pkmn.name))
            @scene.pbHardRefresh
          # Heal
          elsif cmd==arr.length - 1
            pkmn.heal
            pbDisplay(_INTL("{1} was fully healed.",pkmn.name))
            @scene.pbHardRefresh
          end
        end

      ### Level ###
      when "Level"
        params=ChooseNumberParams.new
        params.setRange(1,MAXIMUMLEVEL)
        params.setDefaultValue(pkmn.level)
        level=Kernel.pbMessageChooseNumber(
           _INTL("Set the Pokémon's level (max. {1}).",MAXIMUMLEVEL),params) { @scene.update }
        if level != pkmn.level
          pkmn.level=level
          pkmn.calcStats
          pkmn.exp=PBExp.startExperience(level,pkmn.growthrate)
          pbDisplay(_INTL("{1}'s level was set to {2}.",pkmn.name,pkmn.level))
          @scene.pbHardRefresh
        end

      ### Species ###
      when "Species"
        species=pbChooseSpecies(pkmn.dexnum)
        if species
          oldspeciesname=getMonName(pkmn.species)
          #pkmn.species=species
          pkmn.species=$cache.pkmn.fetch($cache.pkmn.keys[species-1]).mon
          pkmn.calcStats
          pkmn.initAbility
          pkmn.exp=PBExp.startExperience(pkmn.level,pkmn.growthrate)
          oldname=pkmn.name
          pkmn.name=getMonName(pkmn.species) if pkmn.name==oldspeciesname
          pbDisplay(_INTL("{1}'s species was changed to {2}.",oldname,getMonName(pkmn.species)))
          $Trainer.pokedex.setFormSeen(pkmn)
          @scene.pbHardRefresh
        end

      ### Moves ###
      when "Moves"
        cmd=0
        loop do
          cmd=@scene.pbShowCommands(_INTL("Do what with {1}?",pkmn.name),[
             _INTL("Teach move"),
             _INTL("Forget move"),
             _INTL("Reset movelist"),
             _INTL("Reset initial moves")],cmd)
          # Break
          if cmd==-1
            break
          # Teach move
          elsif cmd==0
            move=pbChooseMoveList
            if move
              pbLearnMove(pkmn,move)
              @scene.pbHardRefresh
            end
          # Forget move
          elsif cmd==1 && pkmn.moves.length > 0
            moveindex=origin.pbChooseMove(pkmn,_INTL("Choose move to forget."))
            if moveindex>=0 
              movename=getMoveName(pkmn.moves[moveindex].move)
              pbDeleteMove(pkmn,moveindex)
              pbDisplay(_INTL("{1} forgot {2}.",pkmn.name,movename))
              @scene.pbHardRefresh
            end
          # Reset movelist
          elsif cmd==2
            pkmn.resetMoves
            pbDisplay(_INTL("{1}'s moves were reset.",pkmn.name))
            @scene.pbHardRefresh
          # Reset initial moves
          elsif cmd==3
            pkmn.pbRecordFirstMoves
            pbDisplay(_INTL("{1}'s moves were set as its first-known moves.",pkmn.name))
            @scene.pbHardRefresh
          end
        end

      ### Gender ###
      when "Gender"
        if pkmn.gender==2
          pbDisplay(_INTL("{1} is genderless.",pkmn.name))
        else
          cmd=0
          loop do
            oldgender=(pkmn.isMale?) ? _INTL("male") : _INTL("female")
            msg=[_INTL("Gender {1} is natural.",oldgender),
                 _INTL("Gender {1} is being forced.",oldgender)][pkmn.genderflag ? 1 : 0]
            cmd=@scene.pbShowCommands(msg,[
               _INTL("Make male"),
               _INTL("Make female"),
               _INTL("Remove override")],cmd)
            # Break
            if cmd==-1
              break
            # Make male
            elsif cmd==0
              pkmn.setGender(0)
              if pkmn.isMale?
                pbDisplay(_INTL("{1} is now male.",pkmn.name))
              else
                pbDisplay(_INTL("{1}'s gender couldn't be changed.",pkmn.name))
              end
            # Make female
            elsif cmd==1
              pkmn.setGender(1)
              if pkmn.isFemale?
                pbDisplay(_INTL("{1} is now female.",pkmn.name))
              else
                pbDisplay(_INTL("{1}'s gender couldn't be changed.",pkmn.name))
              end
            # Remove override
            elsif cmd==2
              pkmn.genderflag=nil
              pbDisplay(_INTL("Gender override removed."))
            end
            $Trainer.pokedex.setFormSeen(pkmn)
            @scene.pbHardRefresh
          end
        end

      ### Ability ###
      when "Ability"
        loop do
          abils=pkmn.getAbilityList
          cmd = abils.find_index { |abil| abil == pkmn.ability}
          cmd = 0 if cmd.nil?
          commands=[]
          for i in 0..abils.length-1
           commands.push(((i < abils.length-1 || !$cache.pkmn[pkmn.species].checkFlag?(:HiddenAbilities)) ? "" : "(H) ")+getAbilityName(abils[i]))
          end
          msg=_INTL("Ability {1} is being forced.",getAbilityName(abils[cmd]))
          cmd=@scene.pbShowCommands(msg,commands,cmd)
          # Break
          if cmd==-1
            break
          # Set ability override
          elsif cmd>=0 && cmd<abils.length
            pkmn.setAbility(abils[cmd])
          end
          @scene.pbHardRefresh
        end

      ### Nature ###
      when "Nature"
        cmd=0
        loop do
          oldnature=pkmn.nature
          commands=[]
          (PBNatures.getCount).times do |i|
            commands.push(PBNatures.getName(i))
          end
          commands.push(_INTL("Remove override"))
          msg=[_INTL("Nature {1} is natural.",oldnature),
               _INTL("Nature {1} is being forced.",oldnature)][pkmn.natureflag ? 1 : 0]
          cmd=@scene.pbShowCommands(msg,commands,cmd)
          # Break
          if cmd==-1
            break
          # Set nature override
          elsif cmd>=0 && cmd<PBNatures.getCount
            pkmn.setNature(PBNatures.getName(cmd).intern.upcase)
            pkmn.calcStats
          # Remove override
          elsif cmd==PBNatures.getCount
            pkmn.natureflag=nil
          end
          @scene.pbHardRefresh
        end

      ### Shininess ###
      when "Shininess"
        cmd=0
        loop do
          oldshiny=(pkmn.isShiny?) ? _INTL("shiny") : _INTL("normal")
          msg=[_INTL("Shininess ({1}) is natural.",oldshiny),
               _INTL("Shininess ({1}) is being forced.",oldshiny)][pkmn.shinyflag!=nil ? 1 : 0]
          cmd=@scene.pbShowCommands(msg,[
               _INTL("Make shiny"),
               _INTL("Make normal"),
               _INTL("Remove override")],cmd)
          # Break
          if cmd==-1
            break
          # Make shiny
          elsif cmd==0
            pkmn.makeShiny
          # Make normal
          elsif cmd==1
            pkmn.makeNotShiny
          # Remove override
          elsif cmd==2
            pkmn.shinyflag=nil
          end
          @scene.pbHardRefresh
        end

      ### Form ###
      when "Form"
        params=ChooseNumberParams.new
        params.setRange(0,100)
        params.setDefaultValue(pkmn.form)
        f=Kernel.pbMessageChooseNumber(
           _INTL("Set the Pokémon's form."),params) { @scene.update }
        if f!=pkmn.form
          pkmn.form=f
          pkmn.initAbility
          pbDisplay(_INTL("{1}'s form was set to {2}.",pkmn.name,pkmn.form))
          $Trainer.pokedex.setFormSeen(pkmn)
          @scene.pbHardRefresh
        end

      ### Happiness ###
      when "Happiness"
        params=ChooseNumberParams.new
        params.setRange(0,255)
        params.setDefaultValue(pkmn.happiness)
        h=Kernel.pbMessageChooseNumber(
           _INTL("Set the Pokémon's happiness (max. 255)."),params) { @scene.update }
        if h!=pkmn.happiness
          pkmn.happiness=h
          pbDisplay(_INTL("{1}'s happiness was set to {2}.",pkmn.name,pkmn.happiness))
          @scene.pbHardRefresh
        end

      ### EV/IV/pID ###
      when "EV/IV/pID"
        stats=STATSTRINGS
        cmd=0
        loop do
          persid=sprintf("0x%08X",pkmn.personalID)
          cmd=@scene.pbShowCommands(_INTL("Personal ID is {1}.",persid),[
             _INTL("Set EVs"),
             _INTL("Set IVs"),
             _INTL("Randomise pID")],cmd)
          case cmd
            # Break
            when -1
              break
            # Set EVs
            when 0
              cmd2=0
              loop do
                evcommands=[]
                for i in 0...stats.length
                  evcommands.push(stats[i]+" (#{pkmn.ev[i]})")
                end
                cmd2=@scene.pbShowCommands(_INTL("Change which EV?"),evcommands,cmd2)
                if cmd2==-1
                  break
                elsif cmd2>=0 && cmd2<stats.length
                  params=ChooseNumberParams.new
                  params.setRange(0,255)
                  params.setDefaultValue(pkmn.ev[cmd2])
                  params.setCancelValue(pkmn.ev[cmd2])
                  f=Kernel.pbMessageChooseNumber(
                     _INTL("Set the EV for {1} (max. 255).",stats[cmd2]),params) { @scene.update }
                  pkmn.ev[cmd2]=f
                  pkmn.totalhp
                  pkmn.calcStats
                  @scene.pbHardRefresh
                end
              end
            # Set IVs
            when 1
              cmd2=0
              loop do
                hiddenpower=pbHiddenPower(pkmn)
                msg=_INTL("Hidden Power:\n{1}",getTypeName(hiddenpower))
                ivcommands=[]
                for i in 0...stats.length
                  ivcommands.push(stats[i]+" (#{pkmn.iv[i]})")
                end
                ivcommands.push(_INTL("Randomise all"))
                cmd2=@scene.pbShowCommands(msg,ivcommands,cmd2)
                if cmd2==-1
                  break
                elsif cmd2>=0 && cmd2<stats.length
                  params=ChooseNumberParams.new
                  params.setRange(0,31)
                  params.setDefaultValue(pkmn.iv[cmd2])
                  params.setCancelValue(pkmn.iv[cmd2])
                  f=Kernel.pbMessageChooseNumber(
                     _INTL("Set the IV for {1} (max. 31).",stats[cmd2]),params) { @scene.update }
                  pkmn.iv[cmd2]=f
                  pkmn.calcStats
                  @scene.pbHardRefresh
                elsif cmd2==ivcommands.length-1
                  pkmn.iv[0]=rand(32)
                  pkmn.iv[1]=rand(32)
                  pkmn.iv[2]=rand(32)
                  pkmn.iv[3]=rand(32)
                  pkmn.iv[4]=rand(32)
                  pkmn.iv[5]=rand(32)
                  pkmn.calcStats
                  @scene.pbHardRefresh
                end
              end
            # Randomise pID
            when 2
              pkmn.personalID=rand(256)
              pkmn.personalID|=rand(256)<<8
              pkmn.personalID|=rand(256)<<16
              pkmn.personalID|=rand(256)<<24
              pkmn.calcStats
              @scene.pbHardRefresh
          end
        end

      ### Pokérus ###
      when "Pokérus"
        cmd=0
        loop do
          pokerus=(pkmn.pokerus) ? pkmn.pokerus : 0
          msg=[_INTL("{1} doesn't have Pokérus.",pkmn.name),
               _INTL("Has strain {1}, infectious for {2} more days.",pokerus/16,pokerus%16),
               _INTL("Has strain {1}, not infectious.",pokerus/16)][pkmn.pokerusStage]
          cmd=@scene.pbShowCommands(msg,[
               _INTL("Give random strain"),
               _INTL("Make not infectious"),
               _INTL("Clear Pokérus")],cmd)
          # Break
          if cmd==-1
            break
          # Give random strain
          elsif cmd==0
            pkmn.givePokerus
          # Make not infectious
          elsif cmd==1
            strain=pokerus/16
            p=strain<<4
            pkmn.pokerus=p
          # Clear Pokérus
          elsif cmd==2
            pkmn.pokerus=0
          end
        end

      ### Ownership ###
      when "Ownership"
        cmd=0
        loop do
          msg=[_INTL("Player's Pokémon\n{1}\n{2} ({3})",pkmn.ot,pkmn.publicID,pkmn.trainerID),
               _INTL("Foreign Pokémon\n{1}\n{2} ({3})",pkmn.ot,pkmn.publicID,pkmn.trainerID)
              ][pkmn.isForeign?($Trainer) ? 1 : 0]
          cmd=@scene.pbShowCommands(msg,[
               _INTL("Make player's"),
               _INTL("Set OT's name"),
               _INTL("Random foreign ID"),
               _INTL("Set foreign ID")],cmd)
          # Break
          if cmd==-1
            break
          # Make player's
          elsif cmd==0
            pkmn.trainerID=$Trainer.id
            pkmn.ot=$Trainer.name
          # Set OT's name
          elsif cmd==1
            newot=pbEnterPlayerName(_INTL("{1}'s OT's name?",pkmn.name),1,12)
            pkmn.ot=newot
          # Set OT's gender
          elsif cmd==2
            pkmn.trainerID=$Trainer.getForeignID
          # Set foreign ID
          elsif cmd==3
            params=ChooseNumberParams.new
            params.setRange(0,65535)
            params.setDefaultValue(pkmn.publicID)
            val=Kernel.pbMessageChooseNumber(
               _INTL("Set the new ID (max. 65535)."),params) { @scene.update }
            pkmn.trainerID=val
            pkmn.trainerID|=val<<16
          end
        end

      ### Nickname ###
      when "Nickname"
        cmd=0
        loop do
          speciesname=getMonName(pkmn.species)
          msg=[_INTL("{1} has the nickname {2}.",speciesname,pkmn.name),
               _INTL("{1} has no nickname.",speciesname)][pkmn.name==speciesname ? 1 : 0]
          cmd=@scene.pbShowCommands(msg,[
               _INTL("Rename"),
               _INTL("Erase name")],cmd)
          # Break
          if cmd==-1
            break
          # Rename
          elsif cmd==0
            newname=pbEnterPokemonName(_INTL("{1}'s nickname?",speciesname),0,12,"",pkmn)
            pkmn.name=(newname=="") ? speciesname : newname
            @scene.pbHardRefresh
          # Erase name
          elsif cmd==1
            pkmn.name=speciesname
            @scene.pbHardRefresh
          end
        end

      ### Poké Ball ###
      when "Poké Ball"
        cmd=0
        loop do
          oldball=getItemName(pkmn.ballused)
          commands=[]; balls=[]
          for item in $cache.items.keys
            if $cache.items[item].checkFlag?(:ball)
              balls.push([item,getItemName(item)])
            end
          end
          balls.sort! {|a,b| a[1]<=>b[1]}
          for i in 0...commands.length
            cmd=i if pkmn.ballused==balls[i][0]
          end
          for i in balls
            commands.push(i[1])
          end
          cmd=@scene.pbShowCommands(_INTL("{1} used.",oldball),commands,cmd)
          if cmd==-1
            break
          else
            pkmn.ballused=balls[cmd][0]
          end
        end

      ### Egg ###
      when "Egg"
        cmd=0
        loop do
          msg=[_INTL("Not an egg"),
               _INTL("Egg with eggsteps: {1}.",pkmn.eggsteps)][pkmn.isEgg? ? 1 : 0]
          cmd=@scene.pbShowCommands(msg,[
               _INTL("Make egg"),
               _INTL("Make Pokémon"),
               _INTL("Set eggsteps to 1")],cmd)
          # Break
          if cmd==-1
            break
          # Make egg
          elsif cmd==0
            if pbHasEgg?(pkmn) ||
               pbConfirm(_INTL("{1} cannot be an egg. Make egg anyway?",getMonName(pkmn.species)))
              pkmn.level=EGGINITIALLEVEL
              pkmn.calcStats
              pkmn.name=_INTL("Egg")
              pkmn.eggsteps=$cache.pkmn[pkmn.species].EggSteps
              pkmn.hatchedMap=0
              pkmn.obtainMode=1
              @scene.pbHardRefresh
            end
          # Make Pokémon
          elsif cmd==1
            pkmn.name=getMonName(pkmn.species)
            pkmn.eggsteps=0
            pkmn.hatchedMap=0
            pkmn.obtainMode=0
            @scene.pbHardRefresh
          # Set eggsteps to 1
          elsif cmd==2
            pkmn.eggsteps=1 if pkmn.eggsteps>0
          end
        end

      ### Shadow Pokémon ###
      when "Shadow Pokémon"
        cmd=0
        loop do
          msg=[_INTL("Not a Shadow Pokémon."),
               _INTL("Heart gauge is {1}.",pkmn.heartgauge)][(pkmn.isShadow? rescue false) ? 1 : 0]
          cmd=@scene.pbShowCommands(msg,[
             _INTL("Make Shadow"),
             _INTL("Lower heart gauge"),
             _INTL("Purify")],cmd)
          # Break
          if cmd==-1
            break
          # Make Shadow
          elsif cmd==0
            if !(pkmn.isShadow? rescue false) && pkmn.respond_to?("makeShadow")
              pkmn.makeShadow
              pbDisplay(_INTL("{1} is now a Shadow Pokémon.",pkmn.name))
              @scene.pbHardRefresh
            else
              pbDisplay(_INTL("{1} is already a Shadow Pokémon.",pkmn.name))
            end
          # Lower heart gauge
          elsif cmd==1
            if (pkmn.isShadow? rescue false)
              prev=pkmn.heartgauge
              pkmn.adjustHeart(-768)
              Kernel.pbMessage(_INTL("{1}'s heart gauge was lowered from {2} to {3} (now stage {4}).",
                 pkmn.name,prev,pkmn.heartgauge,pkmn.heartStage))
              pbReadyToPurify(pkmn)
            else
              Kernel.pbMessage(_INTL("{1} is not a Shadow Pokémon.",pkmn.name))
            end
          # Purify
          elsif cmd == 2
            if !pkmn.isShadow?
              Kernel.pbMessage(_INTL("{1} is already purified!",pkmn.name))
            else
              pkmn.heartgauge=0
              #pkmn.pbUpdateShadowMoves() 
              pbPurify(pkmn,@scene)
              Kernel.pbMessage(_INTL("{1} has been purified!",pkmn.name))
            end
          end
        end

      ### Duplicate ###
      when "Duplicate"
        origin.duplicatePokemon(pkmn,selected)

      ### Delete ###
      when "Delete"
        origin.deletePokemon($Trainer.party.index(pkmn) ? $Trainer.party.index(pkmn) : 0,selected,heldpoke)
      else
        break
    end
  end
end

class Scene_Debug
  def main
    Graphics.transition(0)
    pbDebugMenu
    $scene=Scene_Map.new
    $game_map.refresh
    Graphics.freeze
  end
end