################################################################################
# Make up internal names for things based on their actual names.
################################################################################
module MakeshiftConsts
  @@consts=[]

  def self.get(c,i,modname=nil)
    if !@@consts[c]
      @@consts[c]=[]
    end
    if @@consts[c][i]
      return @@consts[c][i]
    end
    if modname
      v=getConstantName(modname,i) rescue nil
      if v
        @@consts[c][i]=v
        return v
      end
    end
    trname=pbGetMessage(c,i)
    trconst=trname.gsub(/é/,"e")
    trconst=trconst.upcase
    trconst=trconst.gsub(/♀/,"fE")
    trconst=trconst.gsub(/♂/,"mA")
    trconst=trconst.gsub(/[^A-Za-z0-9_]/,"")
    if trconst.length==0
      return nil if trname.length==0
      trconst=sprintf("T_%03d",i)
    elsif !trconst[0,1][/[A-Z]/]
      trconst="T_"+trconst
    end
    while @@consts[c].include?(trconst)
      trconst=sprintf("%s_%03d",trconst,i)
    end
    @@consts[c][i]=trconst
    return trconst
  end
end



def pbGetTypeConst(i) #kill this
  ret=MakeshiftConsts.get(MessageTypes::Types,i,PBTypes)
  if !ret
    ret=["NORMAL","FIGHTING","FLYING","POISON","GROUND",
         "ROCK","BUG","GHOST","STEEL","QMARKS",
         "FIRE","WATER","GRASS","ELECTRIC",
         "PSYCHIC","ICE","DRAGON","DARK"][i]
  end
  return ret
end

def pbGetEvolutionConst(i)
  ret=["Unknown",
     "Happiness","HappinessDay","HappinessNight","Level","Trade",
     "TradeItem","Item","AttackGreater","AtkDefEqual","DefenseGreater",
     "Silcoon","Cascoon","Ninjask","Shedinja","Beauty",
     "ItemMale","ItemFemale","DayHoldItem","NightHoldItem","HasMove",
     "HasInParty","LevelMale","LevelFemale","Location","TradeSpecies",
     "Custom1","Custom2","Custom3","Custom4","Custom5","Custom6","Custom7"
  ]
  i=0 if i>=ret.length || i<0
  return ret[i]
end

def pbGetAbilityConst(i)#kill this
  return MakeshiftConsts.get(MessageTypes::Abilities,i,PBAbilities)
end

def pbGetMoveConst(i)#kill this
  return MakeshiftConsts.get(MessageTypes::Moves,i,PBMoves)
end

def pbGetItemConst(i)#kill this
  return MakeshiftConsts.get(MessageTypes::Items,i,PBItems)
end

def pbGetSpeciesConst(i)#kill this
  return MakeshiftConsts.get(MessageTypes::Species,i,PBSpecies)
end

def pbGetTrainerConst(i)#kill this
  name=MakeshiftConsts.get(MessageTypes::TrainerTypes,i,PBTrainers)
end



################################################################################
# Save data to PBS files
################################################################################

def normalizeConnectionPoint(conn)
  ret=conn.clone
  if conn[1]<0 && conn[4]<0
  elsif conn[1]<0 || conn[4]<0
    ret[4]=-conn[1]
    ret[1]=-conn[4]
  end
  if conn[2]<0 && conn[5]<0
  elsif conn[2]<0 || conn[5]<0
    ret[5]=-conn[2]
    ret[2]=-conn[5]
  end
  return ret
end

def writeConnectionPoint(map1,x1,y1,map2,x2,y2)
  dims1=MapFactoryHelper.getMapDims(map1)
  dims2=MapFactoryHelper.getMapDims(map2)
  if x1==0 && x2==dims2[0]
    return sprintf("%d,West,%d,%d,East,%d\r\n",map1,y1,map2,y2)
  elsif y1==0 && y2==dims2[1]
    return sprintf("%d,North,%d,%d,South,%d\r\n",map1,x1,map2,x2)
  elsif x1==dims1[0] && x2==0
    return sprintf("%d,East,%d,%d,West,%d\r\n",map1,y1,map2,y2)
  elsif y1==dims1[1] && y2==0
    return sprintf("%d,South,%d,%d,North,%d\r\n",map1,x1,map2,x2)
  else
    return sprintf("%d,%d,%d,%d,%d,%d\r\n",map1,x1,y1,map2,x2,y2)
  end
end

def pbSaveConnectionData
  data=load_data("Data/connections.dat") rescue nil
  return if !data
  pbSerializeConnectionData(data,$cache.mapinfos)
end

def pbSerializeConnectionData(conndata,mapinfos)
  File.open("PBS/connections.txt","wb"){|f|
     for conn in conndata
       if mapinfos
         # Skip if map no longer exists
         next if !mapinfos[conn[0]] || !mapinfos[conn[3]]
         f.write(sprintf("# %s (%d) - %s (%d)\r\n",
            mapinfos[conn[0]] ? mapinfos[conn[0]].name : "???",conn[0],
            mapinfos[conn[3]] ? mapinfos[conn[3]].name : "???",conn[3]))
         end
         if conn[1].is_a?(String) || conn[4].is_a?(String)
           f.write(sprintf("%d,%s,%d,%d,%s,%d\r\n",conn[0],conn[1],
              conn[2],conn[3],conn[4],conn[5]))
         else
           ret=normalizeConnectionPoint(conn)
           f.write(writeConnectionPoint(
              ret[0],
              ret[1],
              ret[2],
              ret[3],
              ret[4],
              ret[5]
           ))
         end
       end
  }
  save_data(conndata,"Data/connections.dat")
end

def pbSaveTownMap()
  mapdata=load_data("Data/townmap.dat") rescue nil
  return if !mapdata
  File.open("PBS/townmap.txt","wb"){|f|
     for i in 0...mapdata.length
       map=mapdata[i]
       return if !map
       f.write(sprintf("[%d]\r\n",i))
       f.write(sprintf("Name=%s\r\nFilename=%s\r\n",
          csvquote(map[0].is_a?(Array) ? map[0][0] : map[0]),
          csvquote(map[1].is_a?(Array) ? map[1][0] : map[1])))
       for loc in map[2]
         f.write("Point=")
         pbWriteCsvRecord(loc,f,[nil,"uussUUUU"])
         f.write("\r\n")
       end
     end
  }
end

def pbSaveBTTrainers(bttrainers,filename)
  return if !bttrainers || !filename
  btTrainersRequiredTypes={
     "Type"=>[0,"e",nil],# Specifies a trainer
     "Name"=>[1,"s"],
     "BeginSpeech"=>[2,"s"],
     "EndSpeechWin"=>[3,"s"],
     "EndSpeechLose"=>[4,"s"],
     "PokemonNos"=>[5,"*u"]
  }
  File.open(filename,"wb"){|f|
     for i in 0...bttrainers.length
       next if !bttrainers[i]
       f.write(sprintf("[%03d]\r\n",i))
       for key in btTrainersRequiredTypes.keys
         schema=btTrainersRequiredTypes[key]
         record=bttrainers[i][schema[0]]
         next if record==nil
         f.write(sprintf("%s=",key))
         if key=="Type"
           f.write((getConstantName(PBTrainers,record) rescue pbGetTrainerConst(record)))
         elsif key=="PokemonNos"
           f.write(record.join(",")) # pbWriteCsvRecord somehow won't work here
         else
           pbWriteCsvRecord(record,f,schema)
         end
         f.write(sprintf("\r\n"))
       end
     end
 }
end

def pbFastInspect(pkmn,moves,species,items,natures)
  c1=species[pkmn.species] ? species[pkmn.species] :
     (species[pkmn.species]=(getConstantName(PBSpecies,pkmn.species) rescue pbGetSpeciesConst(pkmn.species)))
  c2=items[pkmn.item] ? items[pkmn.item] :
     (items[pkmn.item]=(getItemName(pkmn.item) rescue pbGetItemConst(pkmn.item)))
  c3=natures[pkmn.nature] ? natures[pkmn.nature] :
     (natures[pkmn.nature]=getConstantName(PBNatures,pkmn.nature))
  evlist=""
  ev=pkmn.ev
  evs=["HP","ATK","DEF","SPD","SA","SD"]
  for i in 0...ev
    if ((ev&(1<<i))!=0)
      evlist+="," if evlist.length>0
      evlist+=evs[i]
    end
  end
  c4=moves[pkmn.move1] ? moves[pkmn.move1] :
     (moves[pkmn.move1]=(getMoveName(pkmn.move1) rescue pbGetMoveConst(pkmn.move1)))
  c5=moves[pkmn.move2] ? moves[pkmn.move2] :
     (moves[pkmn.move2]=(getMoveName(pkmn.move2) rescue pbGetMoveConst(pkmn.move2)))
  c6=moves[pkmn.move3] ? moves[pkmn.move3] :
     (moves[pkmn.move3]=(getMoveName(pkmn.move3) rescue pbGetMoveConst(pkmn.move3)))
  c7=moves[pkmn.move4] ? moves[pkmn.move4] :
     (moves[pkmn.move4]=(getMoveName(pkmn.move4) rescue pbGetMoveConst(pkmn.move4)))
  return "#{c1};#{c2};#{c3};#{evlist};#{c4},#{c5},#{c6},#{c7}"
end

def pbSaveAllData
  puts "Function disabled!"
  return
  pbSaveTypes; Graphics.update
  pbSaveAbilities; Graphics.update
  pbSaveMoveData; Graphics.update
  pbSaveConnectionData; Graphics.update
  pbSaveMetadata; Graphics.update
  pbSaveTrainerLists; Graphics.update
  pbSaveMachines; Graphics.update
  pbSaveEncounterData; Graphics.update
  pbSaveTrainerTypes; Graphics.update
  pbSaveTrainerBattles; Graphics.update
  pbSaveTownMap; Graphics.update
  pbSavePhoneData; Graphics.update
  pbSavePokemonData; Graphics.update
  pbSaveShadowMoves; Graphics.update
end



################################################################################
# Lists
################################################################################
def pbListWindow(cmds,width=256)
  list=Window_CommandPokemon.newWithSize(cmds,0,0,width,Graphics.height)
  list.index=0
  list.rowHeight=24
  pbSetSmallFont(list.contents)
  list.refresh
  return list
end

def pbChooseSpecies(default)
  cmdwin=pbListWindow([],200)
  commands=[]
  $cache.pkmn.each_with_index {|(key, value), i|
    commands.push(_ISPRINTF("{1:03d} {2:s}",i,getMonName(key)))
  }
  ret=pbCommands2(cmdwin,commands,-1,default-1,true)
  cmdwin.dispose
  return ret>=0 ? ret+1 : nil
end

def pbChooseSpeciesOrdered(default)
  cmdwin=pbListWindow([],200)
  commands = $cache.pkmn.map {|mon, mondata|
    [mondata.dexnum, getMonName(mon), mon]
  }
  commands.sort! {|a,b| a[1]<=>b[1]}
  realcommands=[]
  for command in commands
    realcommands.push(_ISPRINTF("{1:03d} {2:s}",command[0],command[1]))
  end
  ret=pbCommands2(cmdwin,realcommands,-1,default-1,true)
  cmdwin.dispose
  return ret>=0 ? commands[ret][2] : nil
end

# Displays a sorted list of Pokémon species, and returns the ID of the species
# selected or 0 if the selection was canceled.  defaultItemID, if specified,
# indicates the ID of the species initially shown on the list.
def pbChooseSpeciesList(defaultItemID=0)
  cmdwin=pbListWindow([],200)
  commands=[]
  itemDefault=0

  commands = $cache.pkmn.map { |pkmn, pkmndata| [pkmn, getMonName(pkmn)]}
  commands.sort! {|a,b| a[1]<=>b[1]}
  if defaultItemID>0
    commands.each_with_index {|item,index|
       itemDefault=index if item[0]==defaultItemID
    }
  end
  realcommands=[]
  for command in commands
    realcommands.push(_ISPRINTF("{1:s}",command[1]))
  end
  ret=pbCommands2(cmdwin,realcommands,-1,itemDefault,true) 
  cmdwin.dispose
  return ret>=0 ? commands[ret][0] : nil
end

# Displays a sorted list of moves, and returns the ID of the move selected or
# 0 if the selection was canceled.  defaultMoveID, if specified, indicates the
# ID of the move initially shown on the list.
def pbChooseMoveList(defaultMoveID=nil)
  cmdwin=pbListWindow([],200)
  moveDefault=0

  commands = $cache.moves.filter { |move| !PBStuff::ANIMATIONDUMMIES.include?(move) }.map { |move, movedata| [move, getMoveName(move)] }
  commands.sort! {|a,b| a[1]<=>b[1]}

  if defaultMoveID
    commands.each_with_index {|item,index|
       moveDefault=index if item[0]==defaultMoveID
    }
  end
  realcommands=[]
  for command in commands
    realcommands.push(_ISPRINTF("{1:s}",command[1]))
  end
  ret=pbCommands2(cmdwin,realcommands,-1,moveDefault,true) 
  cmdwin.dispose
  return ret>=0 ? commands[ret][0] : nil
end

def pbChooseTutorList(defaultMoveID=0)
  cmdwin=pbListWindow([],200)
  commands=[]
  moveDefault=0
  for i in $Trainer.tutorlist
    name=getMoveName(i)
    commands.push([i,name]) if name!=nil && name!=""
  end
  commands.sort! {|a,b| a[1]<=>b[1]}
  if defaultMoveID>0
    commands.each_with_index {|item,index|
       moveDefault=index if item[0]==defaultMoveID
    }
  end
  realcommands=[]
  for command in commands
    realcommands.push(_ISPRINTF("{1:s}",command[1]))
  end
  ret=pbCommands2(cmdwin,realcommands,-1,moveDefault,true) 
  cmdwin.dispose
  return ret>=0 ? commands[ret][0] : 0
end

def pbChooseTypeList(defaultMoveID=0,movetype=false)
  cmdwin=pbListWindow([],200)
  commands=[]
  moveDefault=0
  $cache.types.each {|key, value|
    commands.push([key,value.name]) unless key == :QMARKS || key == :SHADOW
  }
  commands.sort! {|a,b| a[1]<=>b[1]}
  if defaultMoveID>0
    commands.each_with_index {|item,index|
       moveDefault=index if item[0]==defaultMoveID
    }
  end
  realcommands=[]
  for command in commands
    realcommands.push(_ISPRINTF("{1:s}",command[1]))
  end
  loop do
    ret=pbCommands2(cmdwin,realcommands,-1,moveDefault,true) 
    retval=ret>=0 ? commands[ret][0] : 0
    cmdwin.dispose
    return retval
  end
end

# Displays a sorted list of items, and returns the ID of the item selected or
# 0 if the selection was canceled.  defaultItemID, if specified, indicates the
# ID of the item initially shown on the list.
def pbChooseItemList(defaultItemID=0)
  cmdwin=pbListWindow([],200)
  commands=[]
  moveDefault=0
  # basically make a list of all the items
  for c in PBItems.constants
    i=PBItems.const_get(c)
    if i.is_a?(Integer)
      commands.push([i,getItemName(i)])
    end
  end
  commands.sort! {|a,b| a[1]<=>b[1]}
  if defaultItemID>0
    commands.each_with_index {|item,index|
       moveDefault=index if item[0]==defaultItemID
    }
  end
  realcommands=[]
  for command in commands
    realcommands.push(_ISPRINTF("{1:s}",command[1]))
  end
  ret=pbCommands2(cmdwin,realcommands,-1,moveDefault,true) 
  cmdwin.dispose
  return ret>=0 ? commands[ret][0] : 0
end

# Displays a sorted list of abilities, and returns the ID of the ability selected
# or 0 if the selection was canceled.  defaultItemID, if specified, indicates the
# ID of the ability initially shown on the list.
def pbChooseAbilityList(defaultAbilityID=0)
  cmdwin=pbListWindow([],200)
  commands=[]
  abilityDefault=0
  for c in PBAbilities.constants
    i=PBAbilities.const_get(c)
    if i.is_a?(Integer)
      commands.push([i,getAbilityName(i)])
    end
  end
  commands.sort! {|a,b| a[1]<=>b[1]}
  if defaultAbilityID>0
    commands.each_with_index {|item,index|
       abilityDefault=index if item[0]==defaultAbilityID
    }
  end
  realcommands=[]
  for command in commands
    realcommands.push(sprintf("#{command[1]}"))
  end
  ret=pbCommands2(cmdwin,realcommands,-1,abilityDefault,true) 
  cmdwin.dispose
  return ret>=0 ? commands[ret][0] : 0
end

def pbCommands2(cmdwindow,commands,cmdIfCancel,defaultindex=-1,noresize=false)
  cmdwindow.z=99999
  cmdwindow.visible=true
  cmdwindow.commands=commands
  if !noresize
    cmdwindow.width=256
  else
    cmdwindow.height=Graphics.height
  end
  cmdwindow.height=Graphics.height if cmdwindow.height>Graphics.height
  cmdwindow.x=0
  cmdwindow.y=0
  cmdwindow.active=true
  cmdwindow.index=defaultindex if defaultindex>=0
  ret=0
  command=0
  loop do
    Graphics.update
    Input.update
    cmdwindow.update
    if Input.trigger?(Input::B)
      if cmdIfCancel>0
        command=cmdIfCancel-1
        break
      elsif cmdIfCancel<0
        command=cmdIfCancel
        break
      end
    end
    if Input.trigger?(Input::C)
      command=cmdwindow.index
      break
    end
  end
  ret=command
  cmdwindow.active=false
  return ret
end

def pbCommands3(cmdwindow,commands,cmdIfCancel,defaultindex=-1,noresize=false)
  cmdwindow.z=99999
  cmdwindow.visible=true
  cmdwindow.commands=commands
  if !noresize
    cmdwindow.width=256
  else
    cmdwindow.height=Graphics.height
  end
  cmdwindow.height=Graphics.height if cmdwindow.height>Graphics.height
  cmdwindow.x=0
  cmdwindow.y=0
  cmdwindow.active=true
  cmdwindow.index=defaultindex if defaultindex>=0
  ret=[]
  command=0
  loop do
    Graphics.update
    Input.update
    cmdwindow.update
    if Input.trigger?(Input::X)
      command=[5,cmdwindow.index]
      break
    end
    if Input.press?(Input::A)
      if Input.repeat?(Input::UP)
        command=[1,cmdwindow.index]
        break
      elsif Input.repeat?(Input::DOWN)
        command=[2,cmdwindow.index]
        break
      elsif Input.press?(Input::LEFT)
        command=[3,cmdwindow.index]
        break
      elsif Input.press?(Input::RIGHT)
        command=[4,cmdwindow.index]
        break
      end
    end
    if Input.trigger?(Input::B)
      if cmdIfCancel>0
        command=[0,cmdIfCancel-1]
        break
      elsif cmdIfCancel<0
        command=[0,cmdIfCancel]
        break
      end
    end
    if Input.trigger?(Input::C)
      command=[0,cmdwindow.index]
      break
    end
  end
  ret=command
  cmdwindow.active=false
  return ret
end



################################################################################
# Core lister script
################################################################################
def pbListScreen(title,lister)
  viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
  viewport.z=99999
  list=pbListWindow([],256)
  list.viewport=viewport
  list.z=2
  title=Window_UnformattedTextPokemon.new(title)
  title.x=256
  title.y=0
  title.width=Graphics.width-256
  title.height=64
  title.viewport=viewport
  title.z=2
  lister.setViewport(viewport)
  selectedmap=-1
  commands=lister.commands
  selindex=lister.startIndex
  if commands.length==0
    value=lister.value(-1)
    lister.dispose
    return value
  end
  list.commands=commands
  list.index=selindex
  loop do
    Graphics.update
    Input.update
    list.update
    if list.index!=selectedmap
      lister.refresh(list.index)
      selectedmap=list.index
    end
    if Input.trigger?(Input::C)
      break
    elsif Input.trigger?(Input::B)
      selectedmap=-1
      break
    end
  end
  value=lister.value(selectedmap)
  lister.dispose
  title.dispose
  list.dispose
  Input.update
  return value
end

def pbListScreenpop(title,lister)
  viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
  viewport.z=99999
  list=pbListWindow([],256)
  list.viewport=viewport
  list.z=2
  title=Window_UnformattedTextPokemon.new(title)
  title.x=256
  title.y=0
  title.width=Graphics.width-256
  title.height=64
  title.viewport=viewport
  title.z=2
  lister.setViewport(viewport)
  selectedmap=-1
  commands=lister.commands
  selindex=lister.startIndex
  selectedteams=[]
  if commands.length==0
    value=lister.value(-1)
    lister.dispose
    return value
  end
  list.commands=commands
  list.index=selindex
  loop do
    Graphics.update
    Input.update
    list.update
    if list.index!=selectedmap
      lister.refresh(list.index)
      selectedmap=list.index
    end
    if Input.trigger?(Input::C)
      selectedteams.push(lister.value(selectedmap))
      puts "Added."
    elsif Input.trigger?(Input::B)
      selectedmap=-1
      break
    end
  end
  lister.dispose
  title.dispose
  list.dispose
  Input.update
  return selectedteams
end

def pbListScreenBlock(title,lister)
  viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
  viewport.z=99999
  list=pbListWindow([],256)
  list.viewport=viewport
  list.z=2
  title=Window_UnformattedTextPokemon.new(title)
  title.x=256
  title.y=0
  title.width=Graphics.width-256
  title.height=64
  title.viewport=viewport
  title.z=2
  lister.setViewport(viewport)
  selectedmap=-1
  commands=lister.commands
  selindex=lister.startIndex
  if commands.length==0
    value=lister.value(-1)
    lister.dispose
    return value
  end
  list.commands=commands
  list.index=selindex
  loop do
    Graphics.update
    Input.update
    list.update
    if list.index!=selectedmap
      lister.refresh(list.index)
      selectedmap=list.index
    end
    if Input.trigger?(Input::A)
      yield(Input::A, lister.value(selectedmap))
      list.commands=lister.commands
      if list.index==list.commands.length
        list.index=list.commands.length
      end
      lister.refresh(list.index)
    elsif Input.trigger?(Input::C)
      yield(Input::C, lister.value(selectedmap))
      list.commands=lister.commands
      if list.index==list.commands.length
        list.index=list.commands.length
      end
      lister.refresh(list.index)
    elsif Input.trigger?(Input::B)
      break
    end
  end
  lister.dispose
  title.dispose
  list.dispose
  Input.update
end



################################################################################
# General listers
################################################################################
class GraphicsLister
  def initialize(folder,selection)
    @sprite=IconSprite.new(0,0)
    @sprite.bitmap=nil
    @sprite.z=2
    @folder=folder
    @selection=selection
    @commands=[]
    @index=0
  end

  def setViewport(viewport)
    @sprite.viewport=viewport
  end

  def startIndex
    return @index
  end

  def commands
    @commands.clear
    Dir.chdir(@folder){
       Dir.glob("*.png"){|f| @commands.push(f) }
       Dir.glob("*.PNG"){|f| @commands.push(f) }
       Dir.glob("*.gif"){|f| @commands.push(f) }
       Dir.glob("*.GIF"){|f| @commands.push(f) }
       Dir.glob("*.bmp"){|f| @commands.push(f) }
       Dir.glob("*.BMP"){|f| @commands.push(f) }
       Dir.glob("*.jpg"){|f| @commands.push(f) }
       Dir.glob("*.JPG"){|f| @commands.push(f) }
       Dir.glob("*.jpeg"){|f| @commands.push(f) }
       Dir.glob("*.JPEG"){|f| @commands.push(f) }
    }
    @commands.sort!
    @commands.length.times do |i|
      @index=i if @commands[i]==@selection
    end
    if @commands.length==0
      Kernel.pbMessage(_INTL("There are no files."))
    end
    return @commands
  end

  def value(index)
    return (index<0) ? "" : @commands[index]
  end

  def dispose
    @sprite.bitmap.dispose if @sprite.bitmap
    @sprite.dispose
  end

  def refresh(index)
    return if index<0
    @sprite.setBitmap(@folder+@commands[index])
    ww=@sprite.bitmap.width
    wh=@sprite.bitmap.height
    sx=(Graphics.width-256).to_f()/ww
    sy=(Graphics.height-64).to_f()/wh
    if sx<1.0 || sy<1.0
      if sx>sy
        ww=sy*ww
        wh=(Graphics.height-64).to_f()
      else
        wh=sx*wh
        ww=(Graphics.width-256).to_f()   
      end
    end
    @sprite.zoom_x=ww*1.0/@sprite.bitmap.width
    @sprite.zoom_y=wh*1.0/@sprite.bitmap.height
    @sprite.x=(Graphics.width-((Graphics.width-256)/2))-(ww/2)
    @sprite.y=(Graphics.height-((Graphics.height-64)/2))-(wh/2)
  end
end



class MusicFileLister
  def getPlayingBGM
    $game_system ? $game_system.getPlayingBGM : nil
  end

  def pbPlayBGM(bgm)
    if bgm
      pbBGMPlay(bgm)
    else
      pbBGMStop()
    end
  end

  def initialize(bgm,setting)
    @oldbgm=getPlayingBGM
    @commands=[]
    @bgm=bgm
    @setting=setting
    @index=0
  end

  def startIndex
    return @index
  end

  def setViewport(viewport)
  end

  def commands
    folder=(@bgm) ? "Audio/BGM/" : "Audio/ME/"
    @commands.clear
    Dir.chdir(folder){
       Dir.glob("*.mp3"){|f| @commands.push(f) }
       Dir.glob("*.MP3"){|f| @commands.push(f) }
       Dir.glob("*.mid"){|f| @commands.push(f) }
       Dir.glob("*.MID"){|f| @commands.push(f) }
    }
    @commands.sort!
    @commands.length.times do |i|
      @index=i if @commands[i]==@setting
    end
    if @commands.length==0
      Kernel.pbMessage(_INTL("There are no files."))
    end
    return @commands
  end

  def value(index)
    return (index<0) ? "" : @commands[index]
  end

  def dispose
    pbPlayBGM(@oldbgm)
  end

  def refresh(index)
    return if index<0
    if @bgm
      pbPlayBGM(@commands[index])
    else
      pbPlayBGM("../../Audio/ME/"+@commands[index])
    end
  end
end



class MapLister
  def initialize(selmap,addGlobal=false)
    @sprite=SpriteWrapper.new
    @sprite.bitmap=nil
    @sprite.z=2
    @commands=[]
    @maps=pbMapTree
    @addGlobalOffset=(addGlobal) ? 1 : 0
    @index=0
    for i in 0...@maps.length
      @index=i+@addGlobalOffset if @maps[i][0]==selmap
    end
  end

  def setViewport(viewport)
    @sprite.viewport=viewport
  end

  def startIndex
    return @index
  end

  def commands
    @commands.clear
    if @addGlobalOffset==1
      @commands.push(_INTL("[GLOBAL]"))
    end
    for i in 0...@maps.length
      @commands.push(sprintf("%s%03d %s",("  "*@maps[i][2]),@maps[i][0],@maps[i][1]))
    end
    return @commands
  end

  def value(index)
    if @addGlobalOffset==1
      return 0 if index==0
    end
    return (index<0) ? -1 : @maps[index-@addGlobalOffset][0]
  end

  def dispose
    @sprite.bitmap.dispose if @sprite.bitmap
    @sprite.dispose
  end

  def refresh(index)
    @sprite.bitmap.dispose if @sprite.bitmap
    return if index<0
    return if index==0 && @addGlobalOffset==1
    @sprite.bitmap=createMinimap(@maps[index-@addGlobalOffset][0])
    @sprite.x=(Graphics.width-((Graphics.width-256)/2))-(@sprite.bitmap.width/2)
    @sprite.y=(Graphics.height-((Graphics.height-64)/2))-(@sprite.bitmap.height/2)
  end
end



class ItemLister
  def initialize(selection)
    @sprite=IconSprite.new(0,0)
    @sprite.bitmap=nil
    @sprite.z=2
    @selection=selection
    @commands=[]
    @ids=[]
    @trainers=nil
    @index=0
  end

  def setViewport(viewport)
    @sprite.viewport=viewport
  end

  def startIndex
    return @index
  end

  def commands   # Sorted alphabetically
    @itemdata=$cache.items
    cmds = @itemdata.map {|item, itemdata| [item, itemdata.name]}
    cmds.sort! {|a,b| a[1]<=>b[1]}
=begin
    for item in @itemdata.keys
      next if !@itemdata[item]
      name = @itemdata[item].name
      id = @itemdata[item].checkFlag?(:ID)
      if name && name!=""
        cmds.push([id,name])
      end
    end
=end
    
    @commands = cmds.map {|i| i[1]}
    @ids = cmds.map {|i| i[0]}

    @index=@selection
    @index=@commands.length-1 if @index>=@commands.length
    @index=0 if @index<0
    return @commands
  end

  def value(index)
    return nil if (index<0)
    realIndex=index
    return @ids[realIndex]
  end

  def dispose
    @sprite.bitmap.dispose if @sprite.bitmap
    @sprite.dispose
  end

  def refresh(index)
    @sprite.bitmap.dispose if @sprite.bitmap
    return if index<0
    begin
      filename=pbItemIconFile(@ids[index])
      @sprite.setBitmap(filename,0)
    rescue
      @sprite.setBitmap(nil)
    end
    ww=@sprite.bitmap.width
    wh=@sprite.bitmap.height
    sx=(Graphics.width-256).to_f()/ww
    sy=(Graphics.height-64).to_f()/wh
    if sx<1.0 || sy<1.0
      if sx>sy
        ww=sy*ww
        wh=(Graphics.height-64).to_f()
      else
        wh=sx*wh
        ww=(Graphics.width-256).to_f()   
      end
    end
    @sprite.zoom_x=ww*1.0/@sprite.bitmap.width
    @sprite.zoom_y=wh*1.0/@sprite.bitmap.height
    @sprite.x=(Graphics.width-((Graphics.width-256)/2))-(ww/2)
    @sprite.y=(Graphics.height-((Graphics.height-64)/2))-(wh/2)
  end
end



class TrainerTypeLister
  def initialize(selection,includeNew)
    @sprite=IconSprite.new(0,0)
    @sprite.bitmap=nil
    @sprite.z=2
    @selection=selection
    @commands=[]
    @ids=[]
    @includeNew=includeNew
    @trainers=nil
    @index=0
  end

  def setViewport(viewport)
    @sprite.viewport=viewport
  end

  def startIndex
    return @index
  end

  def commands
    @commands.clear
    @ids.clear
    @trainers=load_data("Data/trainertypes.dat")
    if @includeNew
      @commands.push(_ISPRINTF("[NEW TRAINER TYPE]"))
      @ids.push(-1)
    end
    @trainers.length.times do |i|
      next if !@trainers[i]
      @commands.push(_ISPRINTF("{1:3d}: {2:s}",i,@trainers[i][2]))
      @ids.push(@trainers[i][0])
    end
    @commands.length.times do |i|
      @index=i if @ids[i]==@selection
    end
    return @commands
  end

  def value(index)
    return nil if (index<0)
    return [-1] if @ids[index]==-1
    return @trainers[@ids[index]]
  end

  def dispose
    @sprite.bitmap.dispose if @sprite.bitmap
    @sprite.dispose
  end

  def refresh(index)
    @sprite.bitmap.dispose if @sprite.bitmap
    return if index<0
    begin
      @sprite.setBitmap(pbTrainerSpriteFile(@ids[index]),0)
    rescue
      @sprite.setBitmap(nil)
    end
    ww=@sprite.bitmap.width
    wh=@sprite.bitmap.height
    sx=(Graphics.width-256).to_f()/ww
    sy=(Graphics.height-64).to_f()/wh
    if sx<1.0 || sy<1.0
      if sx>sy
        ww=sy*ww
        wh=(Graphics.height-64).to_f()
      else
        wh=sx*wh
        ww=(Graphics.width-256).to_f()   
      end
    end
    @sprite.zoom_x=ww*1.0/@sprite.bitmap.width
    @sprite.zoom_y=wh*1.0/@sprite.bitmap.height
    @sprite.x=(Graphics.width-((Graphics.width-256)/2))-(ww/2)
    @sprite.y=(Graphics.height-((Graphics.height-64)/2))-(wh/2)
  end
end



################################################################################
# General properties
################################################################################
class UIntProperty
  def initialize(maxdigits)
    @maxdigits=maxdigits
  end

  def set(settingname,oldsetting)
    params=ChooseNumberParams.new
    params.setMaxDigits(@maxdigits)
    params.setDefaultValue(oldsetting||0)
    return Kernel.pbMessageChooseNumber(
       _INTL("Set the value for {1}.",settingname),params)
  end

  def format(value)
    return value.inspect
  end

  def defaultValue
    return 0
  end
end



class LimitProperty
  def initialize(maxvalue)
    @maxvalue=maxvalue
  end

  def set(settingname,oldsetting)
    oldsetting=1 if !oldsetting
    params=ChooseNumberParams.new
    params.setRange(0,@maxvalue)
    params.setDefaultValue(oldsetting)
    ret=Kernel.pbMessageChooseNumber(
       _INTL("Set the value for {1}.",settingname),params)
    return ret
  end

  def format(value)
    return value.inspect
  end

  def defaultValue
    return 0
  end
end



class NonzeroLimitProperty
  def initialize(maxvalue)
    @maxvalue=maxvalue
  end

  def set(settingname,oldsetting)
    oldsetting=1 if !oldsetting
    params=ChooseNumberParams.new
    params.setRange(1,@maxvalue)
    params.setDefaultValue(oldsetting)
    ret=Kernel.pbMessageChooseNumber(
       _INTL("Set the value for {1}.",settingname),params)
    return ret
  end

  def format(value)
    return value.inspect
  end

  def defaultValue
    return 0
  end
end



class ReadOnlyProperty
  def self.set(settingname,oldsetting)
    Kernel.pbMessage(_INTL("This property cannot be edited."))
    return oldsetting
  end

  def self.format(value)
    return value.inspect
  end
end



module UndefinedProperty
  def self.set(settingname,oldsetting)
    Kernel.pbMessage(_INTL("This property can't be edited here at this time."))
    return oldsetting
  end

  def self.format(value)
    return value.inspect
  end
end



class EnumProperty
  def initialize(values)
    @values=values
  end

  def set(settingname,oldsetting)
    commands=[]
    for value in @values
      commands.push(value)   
    end
    cmd=Kernel.pbMessage(_INTL("Choose a value for {1}.",settingname),commands,-1)
    return oldsetting if cmd<0
    return cmd
  end

  def defaultValue
    return 0
  end

  def format(value)
    return value ? @values[value] : value.inspect
  end 
end



module BooleanProperty
  def self.set(settingname,oldsetting)
    return Kernel.pbConfirmMessage(_INTL("Enable the setting {1}?",settingname)) ? true : false
  end

  def self.format(value)
    return value.inspect
  end
end



module StringProperty
  def self.set(settingname,oldsetting)
    message=Kernel.pbMessageFreeText(_INTL("Set the value for {1}.",settingname),
       oldsetting ? oldsetting : "",false,256,Graphics.width)
  end

  def self.format(value)
    return value
  end
end



class LimitStringProperty
  def initialize(limit)
    @limit=limit
  end

  def set(settingname,oldsetting)
    message=Kernel.pbMessageFreeText(_INTL("Set the value for {1}.",settingname),
       oldsetting ? oldsetting : "",false,@limit)
  end

  def format(value)
    return value
  end
end



module BGMProperty
  def self.set(settingname,oldsetting)
    chosenmap=pbListScreen(settingname,MusicFileLister.new(true,oldsetting))
    return chosenmap && chosenmap!="" ? chosenmap : oldsetting
  end

  def self.format(value)
    return value
  end
end



module MEProperty
  def self.set(settingname,oldsetting)
    chosenmap=pbListScreen(settingname,MusicFileLister.new(false,oldsetting))
    return chosenmap && chosenmap!="" ? chosenmap : oldsetting
  end

  def self.format(value)
    return value
  end
end



module WindowskinProperty
  def self.set(settingname,oldsetting)
    chosenmap=pbListScreen(settingname,
       GraphicsLister.new("Graphics/Windowskins/",oldsetting))
    return chosenmap && chosenmap!="" ? chosenmap : oldsetting
  end

  def self.format(value)
    return value
  end
end



module TrainerTypeProperty
  def self.set(settingname,oldsetting)
    chosenmap=pbListScreen(settingname,
       TrainerTypeLister.new(oldsetting,false))
    return chosenmap ? chosenmap[0] : oldsetting
  end

  def self.format(value)
    return !value ? value.inspect : PBTrainers.getName(value)
  end
end



module SpeciesProperty
  def self.set(settingname,oldsetting)
    ret=pbChooseSpeciesList(oldsetting ? oldsetting : 1)
    return (ret<=0) ? (oldsetting ? oldsetting : 0) : ret
  end

  def self.format(value)
    return value ? getMonName(value) : "-"
  end

  def self.defaultValue
    return 0
  end
end



module TypeProperty
  def self.set(settingname,oldsetting)
    ret=pbChooseTypeList(oldsetting ? oldsetting : 0)
    return (ret<0) ? (oldsetting ? oldsetting : 0) : ret
  end

  def self.format(value)
    return value ? getTypeName(value) : "-"
  end

  def self.defaultValue
    return 0
  end
end



module MoveProperty
  def self.set(settingname,oldsetting)
    ret=pbChooseMoveList(oldsetting ? oldsetting : 1)
    return (ret<=0) ? (oldsetting ? oldsetting : 0) : ret
  end

  def self.format(value)
    return value ? getMoveName(value) : "-"
  end

  def self.defaultValue
    return 0
  end
end



module ItemProperty
  def self.set(settingname,oldsetting)
    ret=pbChooseItemList(oldsetting ? oldsetting : 1)
    return (ret<=0) ? (oldsetting ? oldsetting : 0) : ret
  end

  def self.format(value)
    return value ? getItemName(value) : "-"
  end

  def self.defaultValue
    return 0
  end
end



module NatureProperty
  def self.set(settingname,oldsetting)
    commands=[]
    (PBNatures.getCount).times do |i|
      commands.push(PBNatures.getName(i))
    end
    ret=Kernel.pbShowCommands(nil,commands,-1)
    return ret
  end

  def self.format(value)
    return "" if !value
    return (value>=0) ? getConstantName(PBNatures,value) : ""
  end

  def self.defaultValue
    return 0
  end
end



################################################################################
# Core property editor script
################################################################################
def pbPropertyList(title,data,properties,saveprompt=false)
  viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
  viewport.z=99999
  list=pbListWindow([],Graphics.width*5/10)
  list.viewport=viewport
  list.z=2
  title=Window_UnformattedTextPokemon.new(title)
  title.x=list.width
  title.y=0
  title.width=Graphics.width*5/10
  title.height=64
  title.viewport=viewport
  title.z=2
  desc=Window_UnformattedTextPokemon.new("")
  desc.x=list.width
  desc.y=title.height
  desc.width=Graphics.width*5/10
  desc.height=Graphics.height-title.height
  desc.viewport=viewport
  desc.z=2
  selectedmap=-1
  index=0
  retval=nil
  commands=[]
  for i in 0...properties.length
    propobj=properties[i][1]
    commands.push(sprintf("%s=%s",properties[i][0],propobj.format(data[i])))
  end
  list.commands=commands
  list.index=0
  begin
    loop do
      Graphics.update
      Input.update
      list.update
      desc.update
      if list.index!=selectedmap
        desc.text=properties[list.index][2]
        selectedmap=list.index
      end
      if Input.trigger?(Input::A)
        propobj=properties[selectedmap][1]
        if propobj!=ReadOnlyProperty && !propobj.is_a?(ReadOnlyProperty) &&
           Kernel.pbConfirmMessage(_INTL("Reset the setting {1}?",properties[selectedmap][0]))
          if propobj.respond_to?("defaultValue")
            data[selectedmap]=propobj.defaultValue
          else
            data[selectedmap]=nil
          end
        end
        commands.clear
        for i in 0...properties.length
          propobj=properties[i][1]
          commands.push(sprintf("%s=%s",properties[i][0],propobj.format(data[i])))
        end
        list.commands=commands
      elsif Input.trigger?(Input::C)
        propobj=properties[selectedmap][1]
        oldsetting=data[selectedmap]
        newsetting=propobj.set(properties[selectedmap][0],oldsetting)
        data[selectedmap]=newsetting
        commands.clear
        for i in 0...properties.length
          propobj=properties[i][1]
          commands.push(sprintf("%s=%s",properties[i][0],propobj.format(data[i])))
        end
        list.commands=commands
        break
      elsif Input.trigger?(Input::B)
        selectedmap=-1
        break
      end
    end
    if selectedmap==-1 && saveprompt
      cmd=Kernel.pbMessage(_INTL("Save changes?"),
         [_INTL("Yes"),_INTL("No"),_INTL("Cancel")],3)
      if cmd==2
        selectedmap=list.index
      else
        retval=(cmd==0)
      end
    end
  end while selectedmap!=-1
  title.dispose
  list.dispose
  desc.dispose
  Input.update
  return retval
end



################################################################################
# Encounters editor
################################################################################
def pbEncounterEditorTypes(enc,enccmd)
  commands=[]
  indexes=[]
  haveblank=false
  if enc
    commands.push(_INTL("Density: {1},{2},{3}",
       enc[0][EncounterTypes::Land],
       enc[0][EncounterTypes::Cave],
       enc[0][EncounterTypes::Water]))
    indexes.push(-2)
    for i in 0...EncounterTypes::EnctypeChances.length
      if enc[1][i]
        commands.push(EncounterTypes::Names[i])
        indexes.push(i)
      else
        haveblank=true
      end
    end
  else
    commands.push(_INTL("Density: Not Defined Yet"))
    indexes.push(-2)
    haveblank=true
  end
  if haveblank
    commands.push(_INTL("[New Encounter Type]"))
    indexes.push(-3)
  end
  enccmd.z=99999
  enccmd.visible=true
  enccmd.commands=commands
  enccmd.height=Graphics.height if enccmd.height>Graphics.height
  enccmd.x=0
  enccmd.y=0
  enccmd.active=true
  enccmd.index=0
  ret=0
  command=0
  loop do
    Graphics.update
    Input.update
    enccmd.update
    if Input.trigger?(Input::A) && indexes[enccmd.index]>=0
      if Kernel.pbConfirmMessage(_INTL("Delete the encounter type {1}?",commands[enccmd.index]))
        enc[1][indexes[enccmd.index]]=nil
        commands.delete_at(enccmd.index)
        indexes.delete_at(enccmd.index)
        enccmd.commands=commands
        if enccmd.index>=enccmd.commands.length
          enccmd.index=enccmd.commands.length
        end
      end
    end
    if Input.trigger?(Input::B)
      command=-1
      break
    end
    if Input.trigger?(Input::C)
      command=enccmd.index
      break
    end
  end
  ret=command
  enccmd.active=false
  return ret<0 ? -1 : indexes[ret]
end

def pbNewEncounterType(enc)
  cmdwin=pbListWindow([])
  commands=[]
  indexes=[]
  for i in 0...EncounterTypes::EnctypeChances.length
    dogen=false
    if !enc[1][i]
      if i==0
        dogen=true unless enc[1][EncounterTypes::Cave]
      elsif i==1
        dogen=true unless enc[1][EncounterTypes::Land] || 
                          enc[1][EncounterTypes::LandMorning] || 
                          enc[1][EncounterTypes::LandDay] || 
                          enc[1][EncounterTypes::LandNight] || 
                          enc[1][EncounterTypes::BugContest]
      else
        dogen=true
      end
    end
    if dogen
      commands.push(EncounterTypes::Names[i])
      indexes.push(i)
    end
  end
  ret=pbCommands2(cmdwin,commands,-1)
  ret=(ret<0) ? -1 : indexes[ret]
  if ret>=0
    chances=EncounterTypes::EnctypeChances[ret]
    enc[1][ret]=[]
    for i in 0...chances.length
      enc[1][ret].push([1,5,5])
    end
  end
  cmdwin.dispose
  return ret
end

def pbEditEncounterType(enc,etype)
  commands=[]
  cmdwin=pbListWindow([])
  chances=EncounterTypes::EnctypeChances[etype]
  chancetotal=0
  chances.each {|a| chancetotal+=a}
  enctype=enc[1][etype]
  for i in 0...chances.length
    enctype[i]=[1,5,5] if !enctype[i]
  end
  ret=0
  loop do
    commands.clear
    for i in 0...enctype.length
      ch=chances[i]
      ch=sprintf("%.1f",100.0*chances[i]/chancetotal) if chancetotal!=100
      if enctype[i][1]==enctype[i][2]
        commands.push(_INTL("{1}% {2} (Lv.{3})",
           ch,getMonName(enctype[i][0]),
           enctype[i][1]
        ))
      else
        commands.push(_INTL("{1}% {2} (Lv.{3}-Lv.{4})",
           ch,getMonName(enctype[i][0]),
           enctype[i][1],
           enctype[i][2]
        ))
      end
    end
    ret=pbCommands2(cmdwin,commands,-1,ret)
    break if ret<0
    species=pbChooseSpecies(enctype[ret][0])
    next if species<=0
    enctype[ret][0]=species if species>0
    minlevel=0
    maxlevel=0
    params=ChooseNumberParams.new
    params.setRange(1,MAXIMUMLEVEL)
    params.setDefaultValue(enctype[ret][1])
    minlevel=Kernel.pbMessageChooseNumber(_INTL("Set the minimum level."),params)
    params=ChooseNumberParams.new
    params.setRange(minlevel,MAXIMUMLEVEL)
    params.setDefaultValue(minlevel)
    maxlevel=Kernel.pbMessageChooseNumber(_INTL("Set the maximum level."),params)
    enctype[ret][1]=minlevel  
    enctype[ret][2]=maxlevel
  end
  cmdwin.dispose
end

def pbEncounterEditorDensity(enc)
  params=ChooseNumberParams.new
  params.setRange(0,100)
  params.setDefaultValue(enc[0][EncounterTypes::Land])
  enc[0][EncounterTypes::Land]=Kernel.pbMessageChooseNumber(
     _INTL("Set the density of Pokémon on land (default {1}).",
        EncounterTypes::EnctypeDensities[EncounterTypes::Land]),params)
  params=ChooseNumberParams.new
  params.setRange(0,100)
  params.setDefaultValue(enc[0][EncounterTypes::Cave])
  enc[0][EncounterTypes::Cave]=Kernel.pbMessageChooseNumber(
     _INTL("Set the density of Pokémon in caves (default {1}).",
        EncounterTypes::EnctypeDensities[EncounterTypes::Cave]),params)
  params=ChooseNumberParams.new
  params.setRange(0,100)
  params.setDefaultValue(enc[0][EncounterTypes::Water])
  enc[0][EncounterTypes::Water]=Kernel.pbMessageChooseNumber(
      _INTL("Set the density of Pokémon on water (default {1}).",
         EncounterTypes::EnctypeDensities[EncounterTypes::Water]),params)
  for i in 0...EncounterTypes::EnctypeCompileDens.length
    t=EncounterTypes::EnctypeCompileDens[i]
    next if !t || t==0
    enc[0][i]=enc[0][EncounterTypes::Land] if t==1
    enc[0][i]=enc[0][EncounterTypes::Cave] if t==2
    enc[0][i]=enc[0][EncounterTypes::Water] if t==3
  end
end

def pbEncounterEditorMap(encdata,map)
  enccmd=pbListWindow([])
  # This window displays the help text
  enchelp=Window_UnformattedTextPokemon.new("")
  enchelp.z=99999
  enchelp.x=256
  enchelp.y=0
  enchelp.width=224
  enchelp.height=96
  mapname=$cache.mapinfos[map].name
  lastchoice=0
  loop do
    enc=encdata[map]
    enchelp.text=_INTL("{1}",mapname)
    choice=pbEncounterEditorTypes(enc,enccmd)
    if !enc
      enc=[EncounterTypes::EnctypeDensities.clone,[]]
      encdata[map]=enc
    end
    if choice==-2
      pbEncounterEditorDensity(enc)
    elsif choice==-1
      break
    elsif choice==-3
      ret=pbNewEncounterType(enc)
      if ret>=0
        enchelp.text=_INTL("{1}\r\n{2}",mapname,EncounterTypes::Names[ret])
        pbEditEncounterType(enc,ret)
      end
    else
      enchelp.text=_INTL("{1}\r\n{2}",mapname,EncounterTypes::Names[choice])
      pbEditEncounterType(enc,choice)
    end
  end
  if encdata[map][1].length==0
    encdata[map]=nil
  end
  enccmd.dispose
  enchelp.dispose
  Input.update
end

################################################################################
# Trainer editor
################################################################################
class TrainerBattleLister
  def initialize(selection,includeNew)
    @sprite=IconSprite.new
    @sprite.bitmap=nil
    @sprite.z=2
    @selection=selection
    @commands=[]
    @ids=[]
    @includeNew=includeNew
    @trainers=nil
    @index=0
  end

  def setViewport(viewport)
    @sprite.viewport=viewport
  end

  def startIndex
    return @index
  end

  def commands
    @commands.clear
    @ids.clear
    @trainers = unhashTRlist
    if @includeNew
      @commands.push(_ISPRINTF("[NEW TRAINER BATTLE]"))
      @ids.push(-1)
    end
    @trainers.length.times do |i|
      next if !@trainers[i]
      # Index: TrainerType TrainerName (version)
      @commands.push(_ISPRINTF("{1:3d}: {2:s} {3:s} ({4:s})",i,
         $cache.trainertypes[@trainers[i][0]].title,@trainers[i][1],@trainers[i][4])) # Trainer's name must not be localized
      # Trainer type ID
      @ids.push(@trainers[i][0])
    end
    @index=@selection
    @index=@commands.length-1 if @index>=@commands.length
    @index=0 if @index<0
    return @commands
  end

  def value(index)
    return nil if (index<0)
    return [-1,nil] if index==0 && @includeNew
    realIndex=(@includeNew) ? index-1 : index
    return [realIndex,@trainers[realIndex]]
  end

  def dispose
    @sprite.bitmap.dispose if @sprite.bitmap
    @sprite.dispose
  end

  def refresh(index)
    @sprite.bitmap.dispose if @sprite.bitmap
    return if index<0
    begin
      @sprite.setBitmap(pbTrainerSpriteFile(@ids[index]),0)
    rescue
      @sprite.setBitmap(nil)
    end
    ww=@sprite.bitmap.width
    wh=@sprite.bitmap.height
    sx=(Graphics.width-256).to_f()/ww
    sy=(Graphics.height-64).to_f()/wh
    if sx<1.0 || sy<1.0
      if sx>sy
        ww=sy*ww
        wh=(Graphics.height-64).to_f()
      else
        wh=sx*wh
        ww=(Graphics.width-256).to_f()   
      end
    end
    @sprite.zoom_x=ww*1.0/@sprite.bitmap.width
    @sprite.zoom_y=wh*1.0/@sprite.bitmap.height
    @sprite.x=(Graphics.width-((Graphics.width-256)/2))-(ww/2)
    @sprite.y=(Graphics.height-((Graphics.height-64)/2))-(wh/2)
  end
end

################################################################################
# Trainer Pokémon editor
################################################################################
module TrainerPokemonProperty
  def self.set(settingname,oldsetting)
    oldsetting=TPDEFAULTS.clone if !oldsetting
    properties=[
       [_INTL("Species"),SpeciesProperty,
           _INTL("Species of the Pokémon.")],
       [_INTL("Level"),NonzeroLimitProperty.new(MAXIMUMLEVEL),
           _INTL("Level of the Pokémon.")],
       [_INTL("Held item"),ItemProperty,
           _INTL("Item held by the Pokémon.")],
       [_INTL("Move 1"),MoveProperty2.new(oldsetting),
           _INTL("First move.  Leave all moves blank (use Z key) to give it a wild move set.")],
       [_INTL("Move 2"),MoveProperty2.new(oldsetting),
           _INTL("Second move.  Leave all moves blank (use Z key) to give it a wild move set.")],
       [_INTL("Move 3"),MoveProperty2.new(oldsetting),
           _INTL("Third move.  Leave all moves blank (use Z key) to give it a wild move set.")],
       [_INTL("Move 4"),MoveProperty2.new(oldsetting),
           _INTL("Fourth move.  Leave all moves blank (use Z key) to give it a wild move set.")],
       [_INTL("Ability"),LimitProperty.new(5),
           _INTL("Ability flag. 0=first ability, 1=second ability, 2-5=hidden ability.")],
       [_INTL("Gender"),LimitProperty.new(1),
           _INTL("Gender flag. 0=male, 1=female.")],
       [_INTL("Form"),LimitProperty.new(100),
           _INTL("Form of the Pokémon.")],
       [_INTL("Shiny"),BooleanProperty,
           _INTL("If set to true, the Pokémon is a different-colored Pokémon.")],
       [_INTL("Nature"),NatureProperty,
           _INTL("Nature of the Pokémon.")],
       [_INTL("IVs"),LimitProperty.new(31),
           _INTL("Individual values of each of the Pokémon's stats.")],
       [_INTL("Happiness"),LimitProperty.new(255),
           _INTL("Happiness of the Pokémon.")],
       [_INTL("Nickname"),StringProperty,
           _INTL("Name of the Pokémon.")],
       [_INTL("Shadow"),BooleanProperty,
           _INTL("If set to true, the Pokémon is a Shadow Pokémon.")],
       [_INTL("Ball"),BallProperty.new(oldsetting),
           _INTL("Number of the Poké Ball the Pokémon is kept in.")]
    ]
    pbPropertyList(settingname,oldsetting,properties,false)
    for i in 0...TPDEFAULTS.length
      oldsetting[i]=TPDEFAULTS[i] if !oldsetting[i]
    end
    moves=[]
    for i in [TPMOVE1,TPMOVE2,TPMOVE3,TPMOVE4]
      moves.push(oldsetting[i]) if oldsetting[i]!=0
    end
    oldsetting[TPMOVE1]=moves[0] ? moves[0] : TPDEFAULTS[TPMOVE1]
    oldsetting[TPMOVE2]=moves[1] ? moves[1] : TPDEFAULTS[TPMOVE2]
    oldsetting[TPMOVE3]=moves[2] ? moves[2] : TPDEFAULTS[TPMOVE3]
    oldsetting[TPMOVE4]=moves[3] ? moves[3] : TPDEFAULTS[TPMOVE4]
    oldsetting=nil if !oldsetting[TPSPECIES] || oldsetting[TPSPECIES]==0
    return oldsetting
  end

  def self.format(value)
    return (!value || !value[TPSPECIES] || value[TPSPECIES]==0) ? "-" : getMonName(value[TPSPECIES])
  end
end

class BallProperty
  def initialize(pokemondata)
    @pokemondata=pokemondata
  end

  def set(settingname,oldsetting)
    ret=pbChooseBallList(oldsetting ? oldsetting : -1)
    return (ret<=0) ? (oldsetting ? oldsetting : 0) : ret
  end

  def format(value)
    return value ? getItemName(pbBallTypeToBall(value)) : "-"
  end

  def defaultValue
    return 0
  end
end

def pbChooseBallList(defaultMoveID=-1)
  cmdwin=pbListWindow([],200)
  commands=[]
  moveDefault=0
  for item in $cache.items.keys
    if $cache.items[item].checkFlag?(:ball)
      commands.push([item,getItemName(item)])
    end
  end
  commands.sort! {|a,b| a[1]<=>b[1]}
  if defaultMoveID>=0
    for i in 0...commands.length
      moveDefault=i if defaultMoveID==commands[i][0]
    end
  end
  realcommands=[]
  for i in commands
    realcommands.push(i[1])
  end
  ret=pbCommands2(cmdwin,realcommands,-1,moveDefault,true) 
  cmdwin.dispose
  return ret>=0 ? commands[ret][0] : defaultMoveID
end

class MoveProperty2
  def initialize(pokemondata)
    @pokemondata=pokemondata
  end

  def set(settingname,oldsetting)
    ret=pbChooseMoveListForSpecies(@pokemondata[0],oldsetting ? oldsetting : 1)
    return (ret<=0) ? (oldsetting ? oldsetting : 0) : ret
  end

  def format(value)
    return value ? getMoveName(value) : "-"
  end

  def defaultValue
    return 0
  end
end

def pbChooseMoveListForSpecies(species,defaultMoveID=0)
  cmdwin=pbListWindow([],200)
  commands=[]
  moveDefault=0
  legalMoves=pbGetLegalMoves(species)
  for move in legalMoves
    commands.push([move,getMoveName(move)])
  end
  commands.sort! {|a,b| a[1]<=>b[1]}
  if defaultMoveID>0
    commands.each_with_index {|item,index|
       if moveDefault==0
         moveDefault=index if index[0]==defaultMoveID
       end
    }
  end
  commands2=[]
  for i in 1..PBMoves.maxValue
    if getMoveName(i)!=nil && getMoveName(i)!=""
      commands2.push([i,getMoveName(i)])
    end
  end
  commands2.sort! {|a,b| a[1]<=>b[1]}
  if defaultMoveID>0
    commands2.each_with_index {|item,index|
       if moveDefault==0
         moveDefault=index if index[0]==defaultMoveID
       end
    }
  end
  commands.concat(commands2)
  realcommands=[]
  for command in commands
    realcommands.push(_ISPRINTF("{2:s}",command[0],command[1]))
  end
  ret=pbCommands2(cmdwin,realcommands,-1,moveDefault,true) 
  cmdwin.dispose
  return ret>=0 ? commands[ret][0] : 0
end

################################################################################
# Metadata editor
################################################################################
module CharacterProperty
  def self.set(settingname,oldsetting)
    chosenmap=pbListScreen(settingname,
       GraphicsLister.new("Graphics/Characters/",oldsetting))
    return chosenmap && chosenmap!="" ? chosenmap : oldsetting
  end

  def self.format(value)
    return value
  end
end

module PlayerProperty
  def self.set(settingname,oldsetting)
    oldsetting=[0,"xxx","xxx","xxx","xxx","xxx","xxx","xxx"] if !oldsetting
    properties=[
       [_INTL("Trainer Type"),TrainerTypeProperty,
           _INTL("Trainer type of this player.")],
       [_INTL("Sprite"),CharacterProperty,
           _INTL("Walking character sprite.")],
       [_INTL("Bike"),CharacterProperty,
           _INTL("Cycling character sprite.")],
       [_INTL("Surfing"),CharacterProperty,
           _INTL("Surfing character sprite.")],
       [_INTL("Running"),CharacterProperty,
           _INTL("Running character sprite.")],
       [_INTL("Diving"),CharacterProperty,
           _INTL("Diving character sprite.")],
       [_INTL("Fishing"),CharacterProperty,
           _INTL("Fishing character sprite.")],
       [_INTL("Surf-Fishing"),CharacterProperty,
           _INTL("Fishing while surfing character sprite.")]
    ]
    pbPropertyList(settingname,oldsetting,properties,false)
    return oldsetting
  end

  def self.format(value)
    return value.inspect
  end
end

module MapSizeProperty
  def self.set(settingname,oldsetting)
    oldsetting=[0,""] if !oldsetting
    properties=[
       [_INTL("Width"),NonzeroLimitProperty.new(30),
           _INTL("The width of this map in Region Map squares.")],
       [_INTL("Valid Squares"),StringProperty,
           _INTL("A series of 1s and 0s marking which squares are part of this map (1=part, 0=not part).")],
    ]
    pbPropertyList(settingname,oldsetting,properties,false)
    return oldsetting
  end

  def self.format(value)
    return value.inspect
  end
end

module MapCoordsProperty
  def self.set(settingname,oldsetting)
    chosenmap=pbListScreen(settingname,MapLister.new(oldsetting ? oldsetting[0] : 0))
    if chosenmap>=0
      mappoint=chooseMapPoint(chosenmap)
      if mappoint
        return [chosenmap,mappoint[0],mappoint[1]]
      else
        return oldsetting
      end
    else
      return oldsetting
    end
  end

  def self.format(value)
    return value.inspect
  end
end

module MapCoordsFacingProperty
  def self.set(settingname,oldsetting)
    chosenmap=pbListScreen(settingname,MapLister.new(oldsetting ? oldsetting[0] : 0))
    if chosenmap>=0
      mappoint=chooseMapPoint(chosenmap)
      if mappoint
        facing=Kernel.pbMessage(_INTL("Choose the direction to face in."),
           [_INTL("Down"),_INTL("Left"),_INTL("Right"),_INTL("Up")],-1)
        if facing<0
          return oldsetting
        else
          return [chosenmap,mappoint[0],mappoint[1],[2,4,6,8][facing]]
        end
      else
        return oldsetting
      end
    else
      return oldsetting
    end
  end

  def self.format(value)
    return value.inspect
  end
end

module RegionMapCoordsProperty
  def self.set(settingname,oldsetting)
    regions=getMapNameList
    selregion=-1
    if regions.length==0
      Kernel.pbMessage(_INTL("No region maps are defined."))
      return oldsetting
    elsif regions.length==1
      selregion=regions[0][0]
    else
      cmds=[]
      for region in regions
        cmds.push(region[1])
      end
      selcmd=Kernel.pbMessage(_INTL("Choose a region map."),cmds,-1)
      if selcmd>=0
        selregion=regions[selcmd][0]
      else
        return oldsetting
      end
    end
    mappoint=chooseMapPoint(selregion,true)
    if mappoint
      return [selregion,mappoint[0],mappoint[1]]
    else
      return oldsetting
    end
  end

  def self.format(value)
    return value.inspect
  end
end

module WeatherEffectProperty
  def self.set(settingname,oldsetting)
    cmd=Kernel.pbMessage(_INTL("Choose a weather effect."),[
       _INTL("No weather"),
       _INTL("Rain"),
       _INTL("Storm"),
       _INTL("Snow"),
       _INTL("Sandstorm"),
       _INTL("Sunny"),
       _INTL("HeavyRain"),
       _INTL("Blizzard")
    ],1)
    if cmd==0
      return nil
    else
      params=ChooseNumberParams.new
      params.setRange(0,100)
      params.setDefaultValue(oldsetting ? oldsetting[1] : 100)
      number=Kernel.pbMessageChooseNumber(_INTL("Set the probability of the weather."),params)
      return [cmd,number]
    end
  end

  def self.format(value)
    return value.inspect
  end
end



module MapProperty
  def self.set(settingname,oldsetting)
    chosenmap=pbListScreen(settingname,MapLister.new(oldsetting ? oldsetting : 0))
    return chosenmap>0 ? chosenmap : oldsetting
  end

  def self.format(value)
    return value.inspect
  end

  def self.defaultValue
    return 0
  end
end

def pbMetadataScreen(defaultMapId=nil)
  metadata=nil
  mapinfos=$cache.mapinfos
  metadata=load_data("Data/metadata.dat")
  map=defaultMapId ? defaultMapId : 0
  loop do
    map=pbListScreen(_INTL("SET METADATA"),MapLister.new(map,true))
    break if map<0
    mapname=(map==0) ? _INTL("Global Metadata") : mapinfos[map].name
    data=[]
    properties=(map==0) ? MapScreenScene::GLOBALMETADATA :
                          MapScreenScene::LOCALMAPS
    for i in 0...properties.length
      data.push(metadata[map] ? metadata[map][i+1] : nil)
    end
    pbPropertyList(mapname,data,properties)
    for i in 0...properties.length
      if !metadata[map]
        metadata[map]=[]
      end
      metadata[map][i+1]=data[i]
    end
  end
  pbSerializeMetadata(metadata,mapinfos) if metadata
end

################################################################################
# Map drawing
################################################################################
class MapSprite
  def initialize(map,viewport=nil)
    @sprite=Sprite.new(viewport)
    @sprite.bitmap=createMinimap(map)
    @sprite.x=(Graphics.width/2)-(@sprite.bitmap.width/2)
    @sprite.y=(Graphics.height/2)-(@sprite.bitmap.height/2)
  end

  def dispose
    @sprite.bitmap.dispose
    @sprite.dispose
  end

  def z=(value)
    @sprite.z=value
  end

  def getXY
    return nil if !Input.triggerex?(0x01)
    mouse=Mouse::getMousePos(true)
    if mouse[0]<@sprite.x||mouse[0]>=@sprite.x+@sprite.bitmap.width
      return nil
    end
    if mouse[1]<@sprite.y||mouse[1]>=@sprite.y+@sprite.bitmap.height
      return nil
    end
    x=mouse[0]-@sprite.x
    y=mouse[1]-@sprite.y
    return [x/4,y/4]
  end
end



class SelectionSprite < Sprite
  def initialize(viewport=nil)
    @sprite=Sprite.new(viewport)
    @sprite.bitmap=nil  
    @sprite.z=2
    @othersprite=nil
  end

  def disposed?
    return @sprite.disposed?
  end

  def dispose
    @sprite.bitmap.dispose if @sprite.bitmap
    @othersprite=nil
    @sprite.dispose
  end

  def othersprite=(value)
    @othersprite=value
    if @othersprite && !@othersprite.disposed? &&
       @othersprite.bitmap && !@othersprite.bitmap.disposed?
      @sprite.bitmap=pbDoEnsureBitmap(
         @sprite.bitmap,@othersprite.bitmap.width,@othersprite.bitmap.height)
      red=Color.new(255,0,0)
      @sprite.bitmap.clear
      @sprite.bitmap.fill_rect(0,0,@othersprite.bitmap.width,2,red)
      @sprite.bitmap.fill_rect(0,@othersprite.bitmap.height-2,
         @othersprite.bitmap.width,2,red)
      @sprite.bitmap.fill_rect(0,0,2,@othersprite.bitmap.height,red)
      @sprite.bitmap.fill_rect(@othersprite.bitmap.width-2,0,2,
         @othersprite.bitmap.height,red)
    end
  end

  def update
    if @othersprite && !@othersprite.disposed?
      @sprite.visible=@othersprite.visible
      @sprite.x=@othersprite.x
      @sprite.y=@othersprite.y
    else
      @sprite.visible=false
    end
  end
end



class RegionMapSprite
  def initialize(map,viewport=nil)
    @sprite=Sprite.new(viewport)
    @sprite.bitmap=createRegionMap(map)
    @sprite.x=(Graphics.width/2)-(@sprite.bitmap.width/2)
    @sprite.y=(Graphics.height/2)-(@sprite.bitmap.height/2)
  end

  def dispose
    @sprite.bitmap.dispose
    @sprite.dispose
  end

  def z=(value)
    @sprite.z=value
  end

  def getXY
    return nil if !Input.triggerex?(0x01)
    mouse=Mouse::getMousePos(true)
    if mouse[0]<@sprite.x||mouse[0]>=@sprite.x+@sprite.bitmap.width
      return nil
    end
    if mouse[1]<@sprite.y||mouse[1]>=@sprite.y+@sprite.bitmap.height
      return nil
    end
    x=mouse[0]-@sprite.x
    y=mouse[1]-@sprite.y
    return [x/8,y/8]
  end
end



def createRegionMap(map)
  pbRgssOpen("Data/townmap.dat","rb"){|f|
     mapdata=Marshal.load(f)
  }
  map=mapdata[map]
  bitmap=AnimatedBitmap.new("Graphics/Pictures/#{map[1]}").deanimate
  retbitmap=BitmapWrapper.new(bitmap.width/2,bitmap.height/2)
  retbitmap.stretch_blt(
     Rect.new(0,0,bitmap.width/2,bitmap.height/2),
     bitmap,
     Rect.new(0,0,bitmap.width,bitmap.height)
  )
  bitmap.dispose
  return retbitmap
end

def getMapNameList#kill this
  pbRgssOpen("Data/townmap.dat","rb"){|f|
     mapdata=Marshal.load(f)
  }
  ret=[]
  for i in 0...mapdata.length
    next if !mapdata[i]
    ret.push(
       [i,pbGetMessage(MessageTypes::RegionNames,i)]
    )
  end
  return ret
end

def createMinimap2(mapid)
  map=load_data(sprintf("Data/Map%03d.rxdata",mapid)) rescue nil
  return BitmapWrapper.new(32,32) if !map
  bitmap=BitmapWrapper.new(map.width*4,map.height*4)
  black=Color.new(0,0,0)
  bigmap=(map.width>40 && map.height>40)
  tilesets=load_data("Data/Tilesets.rxdata")
  tileset=tilesets[map.tileset_id]
  return bitmap if !tileset
  helper=TileDrawingHelper.fromTileset(tileset)
  for y in 0...map.height
    for x in 0...map.width
      if bigmap
        next if (x>8 && x<=map.width-8 && y>8 && y<=map.height-8)
      end
      for z in 0..2
        id=map.data[x,y,z]
        next if id==0 || !id
        helper.bltSmallTile(bitmap,x*4,y*4,4,4,id)
      end
    end
  end
  bitmap.fill_rect(0,0,bitmap.width,1,black)
  bitmap.fill_rect(0,bitmap.height-1,bitmap.width,1,black)
  bitmap.fill_rect(0,0,1,bitmap.height,black)
  bitmap.fill_rect(bitmap.width-1,0,1,bitmap.height,black)
  return bitmap
end

def createMinimap(mapid)
  map=load_data(sprintf("Data/Map%03d.rxdata",mapid)) rescue nil
  return BitmapWrapper.new(32,32) if !map
  bitmap=BitmapWrapper.new(map.width*4,map.height*4)
  black=Color.new(0,0,0)
  tilesets=load_data("Data/Tilesets.rxdata")
  tileset=tilesets[map.tileset_id]
  return bitmap if !tileset
  helper=TileDrawingHelper.fromTileset(tileset)
  for y in 0...map.height
    for x in 0...map.width
      for z in 0..2
        id=map.data[x,y,z]
        id=0 if !id
        helper.bltSmallTile(bitmap,x*4,y*4,4,4,id)
      end
    end
  end
  bitmap.fill_rect(0,0,bitmap.width,1,black)
  bitmap.fill_rect(0,bitmap.height-1,bitmap.width,1,black)
  bitmap.fill_rect(0,0,1,bitmap.height,black)
  bitmap.fill_rect(bitmap.width-1,0,1,bitmap.height,black)
  return bitmap
end

def chooseMapPoint(map,rgnmap=false)
  viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
  viewport.z=99999
  title=Window_UnformattedTextPokemon.new(_INTL("Click a point on the map."))
  title.x=0
  title.y=Graphics.height-64
  title.width=Graphics.width
  title.height=64
  title.viewport=viewport
  title.z=2
  if rgnmap
    sprite=RegionMapSprite.new(map,viewport)
  else
    sprite=MapSprite.new(map,viewport)
  end
  sprite.z=2
  ret=nil
  loop do
    Graphics.update
    Input.update
    xy=sprite.getXY
    if xy
      ret=xy
      break
    end
    if Input.trigger?(Input::B)
      ret=nil
      break
    end
  end
  sprite.dispose
  title.dispose
  return ret
end



################################################################################
# Visual Editor (map connections)
################################################################################
class MapScreenScene
LOCALMAPS=[
   ["Outdoor",BooleanProperty,
        _INTL("If true, this map is an outdoor map and will be tinted according to time of day.")],
   ["ShowArea",BooleanProperty,
       _INTL("If true, the game will display the map's name upon entry.")],
   ["Bicycle",BooleanProperty,
       _INTL("If true, the bicycle can be used on this map.")],
   ["BicycleAlways",BooleanProperty,
       _INTL("If true, the bicycle will be mounted automatically on this map and cannot be dismounted.")],
   ["HealingSpot",MapCoordsProperty,
        _INTL("Map ID of this Pokemon Center's town, and X and Y coordinates of its entrance within that town.")],
   ["Weather",WeatherEffectProperty,
       _INTL("Weather conditions in effect for this map.")],
   ["MapPosition",RegionMapCoordsProperty,
       _INTL("Identifies the point on the regional map for this map.")],
   ["DiveMap",MapProperty,
       _INTL("Specifies the underwater layer of this map.  Use only if this map has deep water.")],
   ["DarkMap",BooleanProperty,
       _INTL("If true, this map is dark and a circle of light appears around the player. Flash can be used to expand the circle.")],
   ["SafariMap",BooleanProperty,
       _INTL("If true, this map is part of the Safari Zone (both indoor and outdoor).  Not to be used in the reception desk.")],
   ["SnapEdges",BooleanProperty,
       _INTL("If true, when the player goes near this map's edge, the game doesn't center the player as usual.")],
   ["Dungeon",BooleanProperty,
       _INTL("If true, this map has a randomly generated layout. See the wiki for more information.")],
   ["BattleBack",StringProperty,
       _INTL("PNG files named 'battlebgXXX', 'enemybaseXXX', 'playerbaseXXX' in Battlebacks folder, where XXX is this property's value.")],
   ["WildBattleBGM",BGMProperty,
       _INTL("Default BGM for wild Pokémon battles on this map.")],
   ["TrainerBattleBGM",BGMProperty,
       _INTL("Default BGM for trainer battles on this map.")],
   ["WildVictoryME",MEProperty,
       _INTL("Default ME played after winning a wild Pokémon battle on this map.")],
   ["TrainerVictoryME",MEProperty,
       _INTL("Default ME played after winning a Trainer battle on this map.")],
   ["MapSize",MapSizeProperty,
       _INTL("The width of the map in Town Map squares, and a string indicating which squares are part of this map.")],
]
GLOBALMETADATA=[
   ["Home",MapCoordsFacingProperty,
       _INTL("Map ID and X and Y coordinates of where the player goes if no Pokémon Center was entered after a loss.")],
   ["WildBattleBGM",BGMProperty,
       _INTL("Default BGM for wild Pokémon battles.")],
   ["TrainerBattleBGM",BGMProperty,
       _INTL("Default BGM for Trainer battles.")],
   ["WildVictoryME",MEProperty,
       _INTL("Default ME played after winning a wild Pokémon battle.")],
   ["TrainerVictoryME",MEProperty,
       _INTL("Default ME played after winning a Trainer battle.")],
   ["SurfBGM",BGMProperty,
       _INTL("BGM played while surfing.")],
   ["BicycleBGM",BGMProperty,
       _INTL("BGM played while on a bicycle.")],
       ["PlayerA",PlayerProperty, _INTL("Specifies player A.")],
       ["PlayerB",PlayerProperty, _INTL("Specifies player B.")],
       ["PlayerC",PlayerProperty, _INTL("Specifies player C.")],
       ["PlayerD",PlayerProperty, _INTL("Specifies player D.")],
       ["PlayerE",PlayerProperty, _INTL("Specifies player E.")],
       ["PlayerF",PlayerProperty, _INTL("Specifies player F.")],
       ["PlayerG",PlayerProperty, _INTL("Specifies player G.")],
        ["PlayerH",PlayerProperty, _INTL("Specifies player H.")],
       ["PlayerI",PlayerProperty, _INTL("Specifies player I.")],
       ["PlayerJ",PlayerProperty, _INTL("Specifies player J.")],
       ["PlayerK",PlayerProperty, _INTL("Specifies player K.")],
       ["PlayerL",PlayerProperty, _INTL("Specifies player L.")],
       ["PlayerM",PlayerProperty, _INTL("Specifies player M.")],
       ["PlayerN",PlayerProperty, _INTL("Specifies player N.")],
       ["PlayerO",PlayerProperty, _INTL("Specifies player O.")],
           ["PlayerP",PlayerProperty, _INTL("Specifies player P.")],
           ["PlayerQ",PlayerProperty, _INTL("Specifies player Q.")],
           ["PlayerR",PlayerProperty, _INTL("Specifies player R.")],
           ["PlayerS",PlayerProperty, _INTL("Specifies player S.")],
           ["PlayerT",PlayerProperty, _INTL("Specifies player T.")],
           ["PlayerU",PlayerProperty, _INTL("Specifies player U.")],
           ["PlayerV",PlayerProperty, _INTL("Specifies player V.")],
           ["PlayerW",PlayerProperty, _INTL("Specifies player W.")],
           ["PlayerX",PlayerProperty, _INTL("Specifies player X.")],
]

  def getMapSprite(id)
    if !@mapsprites[id]
      @mapsprites[id]=Sprite.new(@viewport)
      @mapsprites[id].z=0
      @mapsprites[id].bitmap=nil
    end
    if !@mapsprites[id].bitmap || @mapsprites[id].bitmap.disposed?
      @mapsprites[id].bitmap=createMinimap(id)
    end
    return @mapsprites[id]
  end

  def close
    pbDisposeSpriteHash(@sprites)
    pbDisposeSpriteHash(@mapsprites)
    @viewport.dispose
  end

  def setMapSpritePos(id,x,y)
    sprite=getMapSprite(id)
    sprite.x=x
    sprite.y=y
    sprite.visible=true
  end

  def putNeighbors(id,sprites)
    conns=@mapconns
    mapsprite=getMapSprite(id)
    dispx=mapsprite.x
    dispy=mapsprite.y
    for conn in conns
      if conn[0]==id
        b=sprites.any? {|i| i==conn[3] }
        if !b
          x=(conn[1]-conn[4])*4+dispx
          y=(conn[2]-conn[5])*4+dispy
          setMapSpritePos(conn[3],x,y)
          sprites.push(conn[3])
          putNeighbors(conn[3],sprites)
        end
      elsif conn[3]==id
        b=sprites.any? {|i| i==conn[0] }
        if !b
          x=(conn[4]-conn[1])*4+dispx
          y=(conn[5]-conn[2])*4+dispy
          setMapSpritePos(conn[0],x,y)
          sprites.push(conn[3])
          putNeighbors(conn[0],sprites)
        end
      end
    end
  end

  def hasConnections?(conns,id)
    for conn in conns
      return true if conn[0]==id || conn[3]==id
    end
    return false
  end

  def connectionsSymmetric?(conn1,conn2)
    if conn1[0]==conn2[0]
      # Equality
      return false if conn1[1]!=conn2[1]
      return false if conn1[2]!=conn2[2]
      return false if conn1[3]!=conn2[3]
      return false if conn1[4]!=conn2[4]
      return false if conn1[5]!=conn2[5]
      return true
    elsif conn1[0]==conn2[3]
      # Symmetry
      return false if conn1[1]!=-conn2[1]
      return false if conn1[2]!=-conn2[2]
      return false if conn1[3]!=conn2[0]
      return false if conn1[4]!=-conn2[4]
      return false if conn1[5]!=-conn2[5]
      return true
    end
    return false
  end

  def removeOldConnections(ret,mapid)
    for i in 0...ret.length
      ret[i]=nil if ret[i][0]==mapid || ret[i][3]==mapid
    end
    ret.compact!
  end

# Returns the maps within _keys_ that are directly connected to this map, _map_.
  def getDirectConnections(keys,map)
    thissprite=getMapSprite(map)
    thisdims=MapFactoryHelper.getMapDims(map)
    ret=[]
    for i in keys
      next if i==map
      othersprite=getMapSprite(i)
      otherdims=MapFactoryHelper.getMapDims(i)
      x1=(thissprite.x-othersprite.x)/4
      y1=(thissprite.y-othersprite.y)/4
      if (x1==otherdims[0] || x1==-thisdims[0] || 
          y1==otherdims[1] || y1==-thisdims[1])
        ret.push(i)
      end  
    end
    # If no direct connections, add an indirect connection
    if ret.length==0
      key=(map==keys[0]) ? keys[1] : keys[0]
      ret.push(key)
    end
    return ret
  end

  def generateConnectionData
    ret=[]
    # Create a clone of current map connection
    for conn in @mapconns
      ret.push(conn.clone)
    end
    keys=@mapsprites.keys
    return ret if keys.length<2
    # Remove all connections containing any sprites on the canvas from the array
    for i in keys
      removeOldConnections(ret,i)
    end
    # Rebuild connections
    for i in keys
      refs=getDirectConnections(keys,i)
      for refmap in refs
        othersprite=getMapSprite(i)
        refsprite=getMapSprite(refmap)
        c1=(refsprite.x-othersprite.x)/4
        c2=(refsprite.y-othersprite.y)/4
        conn=[refmap,0,0,i,c1,c2]
        j=0;while j<ret.length && !connectionsSymmetric?(ret[j],conn)
          j+=1
        end
        if j==ret.length
          ret.push(conn)
        end
      end
    end
    return ret
  end

  def serializeConnectionData
    conndata=generateConnectionData()
    pbSerializeConnectionData(conndata,@mapinfos)
    @mapconns=conndata
  end

  def putSprite(id)
    addSprite(id)
    putNeighbors(id,[])
  end

  def addSprite(id)
    mapsprite=getMapSprite(id)
    x=(Graphics.width-mapsprite.bitmap.width)/2
    y=(Graphics.height-mapsprite.bitmap.height)/2
    mapsprite.x=x.to_i&~3
    mapsprite.y=y.to_i&~3
  end

  def saveMapSpritePos
    @mapspritepos.clear
    for i in @mapsprites.keys
      s=@mapsprites[i]
      @mapspritepos[i]=[s.x,s.y] if s && !s.disposed?
    end
  end

  def mapScreen
    @sprites={}
    @mapsprites={}
    @mapspritepos={}
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @lasthitmap=-1
    @lastclick=-1
    @oldmousex=nil
    @oldmousey=nil
    @dragging=false
    @dragmapid=-1
    @dragOffsetX=0
    @dragOffsetY=0
    @selmapid=-1
    addBackgroundPlane(@sprites,"background","trainercardbg",@viewport)
    @sprites["selsprite"]=SelectionSprite.new(@viewport)
    @sprites["title"]=Window_UnformattedTextPokemon.new(_INTL("F5: Help"))
    @sprites["title"].x=0
    @sprites["title"].y=Graphics.height-64
    @sprites["title"].width=Graphics.width
    @sprites["title"].height=64
    @sprites["title"].viewport=@viewport
    @sprites["title"].z=2
    @mapinfos=$cache.mapinfos
    @encdata=load_data("Data/encounters.dat")
    conns=MapFactoryHelper.getMapConnections
    @mapconns=[]
    for c in conns
      @mapconns.push(c.clone)
    end
    @metadata=load_data("Data/metadata.dat")
    if $game_map
      @currentmap=$game_map.map_id
    else
      system=load_data("Data/System.rxdata")
      @currentmap=system.edit_map_id
    end
    putSprite(@currentmap)
  end

  def setTopSprite(id)
    for i in @mapsprites.keys
      if i==id
        @mapsprites[i].z=1
      else
        @mapsprites[i].z=0
      end
    end
  end

  def getMetadata(mapid,metadataType)
    return @metadata[mapid][metadataType] if @metadata[mapid]
  end

  def setMetadata(mapid,metadataType,data)
    @metadata[mapid]=[] if !@metadata[mapid]
    @metadata[mapid][metadataType]=data
  end

  def serializeMetadata
    pbSerializeMetadata(@metadata,@mapinfos)
  end

  def helpWindow
    helptext=_INTL("A: Add map to canvas\r\n")
    helptext+=_INTL("DEL: Delete map from canvas\r\n")
    helptext+=_INTL("S: Go to another map\r\n")
    helptext+=_INTL("Click to select a map\r\n")
    helptext+=_INTL("Double-click: Edit map's metadata\r\n")
    helptext+=_INTL("E: Edit map's encounters\r\n")
    helptext+=_INTL("Drag map to move it\r\n")
    helptext+=_INTL("Arrow keys/drag canvas: Move around canvas")
    title=Window_UnformattedTextPokemon.new(helptext)
    title.x=0
    title.y=0
    title.width=Graphics.width*8/10
    title.height=Graphics.height
    title.viewport=@viewport
    title.z=2
    loop do
      Graphics.update
      Input.update
      break if Input.trigger?(Input::C)
      break if Input.trigger?(Input::B)
    end
    Input.update
    title.dispose
  end

  def propertyList(map,properties)
    infos=$cache.mapinfos
    mapname=(map==0) ? _INTL("Global Metadata") : infos[map].name
    data=[]
    for i in 0...properties.length
      data.push(getMetadata(map,i+1))
    end
    pbPropertyList(mapname,data,properties)
    for i in 0...properties.length
      setMetadata(map,i+1,data[i])
    end
  end

  def getMapRect(mapid)
    sprite=getMapSprite(mapid)
    if sprite
      return [
         sprite.x,
         sprite.y,
         sprite.x+sprite.bitmap.width,
         sprite.y+sprite.bitmap.height
      ]
    else
      return nil
    end
  end

  def onDoubleClick(mapid)
    if mapid>=0
      propertyList(mapid,LOCALMAPS)
    else
      propertyList(0,GLOBALMETADATA)
    end
  end

  def onClick(mapid,x,y)
    if @lastclick>0 && Graphics.frame_count-@lastclick<15
      onDoubleClick(mapid)
      @lastclick=-1
    else
      @lastclick=Graphics.frame_count
      if mapid>=0
        @dragging=true
        @dragmapid=mapid
        sprite=getMapSprite(mapid)
        @sprites["selsprite"].othersprite=sprite
        @selmapid=mapid
        @dragOffsetX=sprite.x-x
        @dragOffsetY=sprite.y-y
        setTopSprite(mapid)
      else
        @sprites["selsprite"].othersprite=nil
        @dragging=true
        @dragmapid=mapid
        @selmapid=-1
        @dragOffsetX=x
        @dragOffsetY=y
        saveMapSpritePos
      end
    end
  end

  def onRightClick(mapid,x,y)
#   echo("rightclick (#{mapid})\r\n")
  end

  def onMouseUp(mapid)
#   echo("mouseup (#{mapid})\r\n")
    @dragging=false if @dragging
  end

  def onRightMouseUp(mapid)
#   echo("rightmouseup (#{mapid})\r\n")
  end

  def onMouseOver(mapid,x,y)
#   echo("mouseover (#{mapid},#{x},#{y})\r\n")
  end

  def onMouseMove(mapid,x,y)
#   echo("mousemove (#{mapid},#{x},#{y})\r\n")
    if @dragging
      if @dragmapid>=0
        sprite=getMapSprite(@dragmapid)
        x=x+@dragOffsetX
        y=y+@dragOffsetY
        sprite.x=x&~3
        sprite.y=y&~3
        @sprites["title"].text=_ISPRINTF("F5: Help [{1:03d} {2:s}]",mapid,@mapinfos[@dragmapid].name)
      else
        xpos=x-@dragOffsetX
        ypos=y-@dragOffsetY
        for i in @mapspritepos.keys
          sprite=getMapSprite(i)
          sprite.x=(@mapspritepos[i][0]+xpos)&~3
          sprite.y=(@mapspritepos[i][1]+ypos)&~3
        end
        @sprites["title"].text=_INTL("F5: Help")
      end
    else
      if mapid>=0
        @sprites["title"].text=_ISPRINTF("F5: Help [{1:03d} {2:s}]",mapid,@mapinfos[mapid].name)
      else
        @sprites["title"].text=_INTL("F5: Help")
      end
    end
  end

  def hittest(x,y)
    for i in @mapsprites.keys
      sx=@mapsprites[i].x
      sy=@mapsprites[i].y
      sr=sx+@mapsprites[i].bitmap.width
      sb=sy+@mapsprites[i].bitmap.height
      return i if x>=sx && x<sr && y>=sy && y<sb
    end
    return -1
  end

  def chooseMapScreen(title,currentmap)
    return pbListScreen(title,MapLister.new(currentmap))
  end

  def update
    mousepos=Mouse::getMousePos
    if mousepos
      hitmap=hittest(mousepos[0],mousepos[1])
      if Input.triggerex?(0x01)
        onClick(hitmap,mousepos[0],mousepos[1])   
      elsif Input.triggerex?(0x02)
        onRightClick(hitmap,mousepos[0],mousepos[1])
      elsif Input.releaseex?(0x01)
        onMouseUp(hitmap)
      elsif Input.releaseex?(0x02)
        onRightMouseUp(hitmap)
      else
        if @lasthitmap!=hitmap
          onMouseOver(hitmap,mousepos[0],mousepos[1])
          @lasthitmap=hitmap
        end
        if @oldmousex!=mousepos[0]||@oldmousey!=mousepos[1]
          onMouseMove(hitmap,mousepos[0],mousepos[1])
          @oldmousex=mousepos[0]
          @oldmousey=mousepos[1]
        end
      end
    end
    if Input.press?(Input::UP)
      for i in @mapsprites
        next if !i
        i[1].y+=4
      end
    end
    if Input.press?(Input::DOWN)
      for i in @mapsprites
        next if !i
        i[1].y-=4
      end
    end
    if Input.press?(Input::LEFT)
      for i in @mapsprites
        next if !i
        i[1].x+=4
      end
    end
    if Input.press?(Input::RIGHT)
      for i in @mapsprites
        next if !i
        i[1].x-=4
      end
    end
    if Input.triggerex?(Input::A)
      id=chooseMapScreen(_INTL("Add Map"),@currentmap)
      if id>0
        addSprite(id)
        setTopSprite(id)
        @mapconns=generateConnectionData
      end
    elsif Input.triggerex?(Input::Y)
      id=chooseMapScreen(_INTL("Go to Map"),@currentmap)
      if id>0
        @mapconns=generateConnectionData
        pbDisposeSpriteHash(@mapsprites)
        @mapsprites.clear
        @sprites["selsprite"].othersprite=nil
        @selmapid=-1
        putSprite(id)
        @currentmap=id
      end
    elsif Input.triggerex?(0x2E) # Delete
      if @mapsprites.keys.length>1 && @selmapid>=0
        @mapsprites[@selmapid].bitmap.dispose
        @mapsprites[@selmapid].dispose
        @mapsprites.delete(@selmapid)
        @sprites["selsprite"].othersprite=nil
        @selmapid=-1
      end
    elsif Input.triggerex?(Input::L)
      pbEncounterEditorMap(@encdata,@selmapid) if @selmapid>=0
    elsif Input.trigger?(Input::F5)
      helpWindow
    end
    pbUpdateSpriteHash(@sprites)
  end

  def pbMapScreenLoop
    loop do
      Graphics.update
      Input.update
      update
      if Input.trigger?(Input::B)
        if Kernel.pbConfirmMessage(_INTL("Save changes?"))
          serializeConnectionData
          serializeMetadata
          save_data(@encdata,"Data/encounters.dat")
          pbSaveEncounterData()
          pbClearData
        end
        break if Kernel.pbConfirmMessage(_INTL("Exit from the editor?"))
      end
    end
  end
end

def pbEditorScreen
  pbCriticalCode {
     mapscreen=MapScreenScene.new
     mapscreen.mapScreen
     mapscreen.pbMapScreenLoop
     mapscreen.close
  }
end
