class PBEvolution
  Unknown        = 0 # Do not use
  Happiness      = 1
  HappinessDay   = 2
  HappinessNight = 3
  Level          = 4
  Trade          = 5
  TradeItem      = 6
  Item           = 7
  AttackGreater  = 8
  AtkDefEqual    = 9
  DefenseGreater = 10
  Silcoon        = 11
  Cascoon        = 12
  Ninjask        = 13
  Shedinja       = 14
  Beauty         = 15
  ItemMale       = 16
  ItemFemale     = 17
  DayHoldItem    = 18
  NightHoldItem  = 19
  HasMove        = 20
  HasInParty     = 21
  LevelMale      = 22
  LevelFemale    = 23
  Location       = 24
  TradeSpecies   = 25
  BadInfluence   = 26
  Affection      = 27
  LevelRain      = 28
  LevelDay       = 29
  LevelNight     = 30
  Sirfetchd      = 31 # Will be for Farfetch'd/Sirfetch'd
  Runerigus      = 32 # Will be for Yamask/Runerigas
  CollectItem    = 33 # Gen 9 Mod - Gimmighoul
  LevelWalk      = 34 # Gen 9 Mod - Pawmot, Brambleghast, Rabsca
  LevelUseMove   = 35 # Gen 9 Mod - Annihilape (Maybe others)
  EnemyDefeat    = 36 # Gen 9 Mod - Kingambit
  Palafin        = 37 # Gen 9 Mod - Palafin

  EVONAMES=["Unknown",
    "Happiness","HappinessDay","HappinessNight","Level","Trade",
    "TradeItem","Item","AttackGreater","AtkDefEqual","DefenseGreater",
    "Silcoon","Cascoon","Ninjask","Shedinja","Beauty",
    "ItemMale","ItemFemale","DayHoldItem","NightHoldItem","HasMove",
    "HasInParty","LevelMale","LevelFemale","Location","TradeSpecies",
    "BadInfluence","Affection","LevelRain","LevelDay","LevelNight","Sirfetchd","Runerigus",
    # Gen 9 Mod - Added CollectItem, LevelWalk, LevelUseMove, EnemyDefeat, and Palafin evolution methods
    "CollectItem","LevelWalk","LevelUseMove","EnemyDefeat","Palafin"
  ]

  # 0 = no parameter
  # 1 = Positive integer
  # 2 = Item internal name
  # 3 = Move internal name
  # 4 = Species internal name
  # 5 = Type internal name
  EVOPARAM=[0,     # Unknown (do not use)
     0,0,0,1,0,    # Happiness, HappinessDay, HappinessNight, Level, Trade
     2,2,1,1,1,    # TradeItem, Item, AttackGreater, AtkDefEqual, DefenseGreater
     1,1,1,1,1,    # Silcoon, Cascoon, Ninjask, Shedinja, Beauty
     2,2,2,2,3,    # ItemMale, ItemFemale, DayHoldItem, NightHoldItem, HasMove
     4,1,1,1,4,    # HasInParty, LevelMale, LevelFemale, Location, TradeSpecies
     1,1,1,1,1,    # BadInfluence, Affection, LevelRain, LevelDay, LevelNight
     0,0,2,1,1,    # Sirfetch'd, Runerigus, CollectItem, LevelWalk, LevelUseMove
     1,1           # EnemyDefeat, Palafin
  ]
end

class SpriteMetafile
  VIEWPORT      = 0
  TONE          = 1
  SRC_RECT      = 2
  VISIBLE       = 3
  X             = 4
  Y             = 5
  Z             = 6
  OX            = 7
  OY            = 8
  ZOOM_X        = 9
  ZOOM_Y        = 10
  ANGLE         = 11
  MIRROR        = 12
  BUSH_DEPTH    = 13
  OPACITY       = 14
  BLEND_TYPE    = 15
  COLOR         = 16
  FLASHCOLOR    = 17
  FLASHDURATION = 18
  BITMAP        = 19

  def length
    return @metafile.length
  end

  def [](i)
    return @metafile[i]
  end

  def initialize(viewport=nil)
    @metafile=[]
    @values=[
       viewport,
       Tone.new(0,0,0,0),Rect.new(0,0,0,0),
       true,
       0,0,0,0,0,100,100,
       0,false,0,255,0,
       Color.new(0,0,0,0),Color.new(0,0,0,0),
       0
    ]
  end

  def disposed?
    return false
  end

  def dispose
  end

  def flash(color,duration)
    if duration>0
      @values[FLASHCOLOR]=color.clone
      @values[FLASHDURATION]=duration
      @metafile.push([FLASHCOLOR,color])
      @metafile.push([FLASHDURATION,duration])
    end
  end

  def x
    return @values[X]
  end

  def x=(value)
    @values[X]=value
    @metafile.push([X,value])
  end

  def y
    return @values[Y]
  end

  def y=(value)
    @values[Y]=value
    @metafile.push([Y,value])
  end

  def bitmap
    return nil
  end

  def bitmap=(value)
    if value && !value.disposed?
      @values[SRC_RECT].set(0,0,value.width,value.height)
      @metafile.push([SRC_RECT,@values[SRC_RECT].clone])
    end
  end

  def src_rect
    return @values[SRC_RECT]
  end

  def src_rect=(value)
    @values[SRC_RECT]=value
   @metafile.push([SRC_RECT,value])
 end

  def visible
    return @values[VISIBLE]
  end

  def visible=(value)
    @values[VISIBLE]=value
    @metafile.push([VISIBLE,value])
  end

  def z
    return @values[Z]
  end

  def z=(value)
    @values[Z]=value
    @metafile.push([Z,value])
  end

  def ox
    return @values[OX]
  end

  def ox=(value)
    @values[OX]=value
    @metafile.push([OX,value])
  end

  def oy
    return @values[OY]
  end

  def oy=(value)
    @values[OY]=value
    @metafile.push([OY,value])
  end

  def zoom_x
    return @values[ZOOM_X]
  end

  def zoom_x=(value)
    @values[ZOOM_X]=value
    @metafile.push([ZOOM_X,value])
  end

  def zoom_y
    return @values[ZOOM_Y]
  end

  def zoom_y=(value)
    @values[ZOOM_Y]=value
    @metafile.push([ZOOM_Y,value])
  end

  def angle
    return @values[ANGLE]
  end

  def zoom=(value)
    @values[ZOOM_X]=value
    @metafile.push([ZOOM_X,value])
    @values[ZOOM_Y]=value
    @metafile.push([ZOOM_Y,value])
  end

  def angle=(value)
    @values[ANGLE]=value
    @metafile.push([ANGLE,value])
  end

  def mirror
    return @values[MIRROR]
  end

  def mirror=(value)
    @values[MIRROR]=value
    @metafile.push([MIRROR,value])
  end

  def bush_depth
    return @values[BUSH_DEPTH]
  end

  def bush_depth=(value)
    @values[BUSH_DEPTH]=value
    @metafile.push([BUSH_DEPTH,value])
  end

  def opacity
    return @values[OPACITY]
  end

  def opacity=(value)
    @values[OPACITY]=value
    @metafile.push([OPACITY,value])
  end

  def blend_type
    return @values[BLEND_TYPE]
  end

  def blend_type=(value)
    @values[BLEND_TYPE]=value
    @metafile.push([BLEND_TYPE,value])
  end

  def color
    return @values[COLOR]
  end

  def color=(value)
    @values[COLOR]=value.clone
    @metafile.push([COLOR,@values[COLOR]])
  end

  def tone
    return @values[TONE]
  end

  def tone=(value)
    @values[TONE]=value.clone
    @metafile.push([TONE,@values[TONE]])
  end

  def update
    @metafile.push([-1,nil])
  end
end

class SpriteMetafilePlayer
  def initialize(metafile,sprite=nil)
    @metafile=metafile
    @sprites=[]
    @playing=false
    @index=0
    @sprites.push(sprite) if sprite
  end

  def add(sprite)
    @sprites.push(sprite)
  end

  def playing?
    return @playing
  end

  def play
    @playing=true
    @index=0
  end

  def update
    if @playing
      for j in @index...@metafile.length
        @index=j+1
        break if @metafile[j][0]<0
        code=@metafile[j][0]
        value=@metafile[j][1]
        for sprite in @sprites
          case code
            when SpriteMetafile::X
              sprite.x=value
            when SpriteMetafile::Y
              sprite.y=value
            when SpriteMetafile::OX
              sprite.ox=value
            when SpriteMetafile::OY
              sprite.oy=value
            when SpriteMetafile::ZOOM_X
              sprite.zoom_x=value
            when SpriteMetafile::ZOOM_Y
              sprite.zoom_y=value
            when SpriteMetafile::SRC_RECT
              sprite.src_rect=value
            when SpriteMetafile::VISIBLE
              sprite.visible=value
            when SpriteMetafile::Z
              sprite.z=value
            # prevent crashes
            when SpriteMetafile::ANGLE
              sprite.angle=(value==180) ? 179.9 : value
            when SpriteMetafile::MIRROR
              sprite.mirror=value
            when SpriteMetafile::BUSH_DEPTH
              sprite.bush_depth=value
            when SpriteMetafile::OPACITY
              sprite.opacity=value
            when SpriteMetafile::BLEND_TYPE
              sprite.blend_type=value
            when SpriteMetafile::COLOR
              sprite.color=value
            when SpriteMetafile::TONE
              sprite.tone=value
          end
        end
      end
      @playing=false if @index==@metafile.length
    end
  end
end

#####################

class PokemonEvolutionScene
  def pbGenerateMetafiles(s1x,s1y,s2x,s2y)
    sprite=SpriteMetafile.new
    sprite2=SpriteMetafile.new
    sprite.opacity=255
    sprite2.opacity=255
    sprite2.zoom=0.0
    sprite.ox=s1x
    sprite.oy=s1y
    sprite2.ox=s2x
    sprite2.oy=s2y
    alpha=0
    for j in 0...26
      sprite.color.red=255
      sprite.color.green=255
      sprite.color.blue=255
      sprite.color.alpha=alpha
      sprite.color=sprite.color
      sprite2.color=sprite.color
      sprite2.color.alpha=255
      sprite.update
      sprite2.update
      alpha+=5
    end
    totaltempo=0
    currenttempo=25
    maxtempo=280
    while totaltempo<maxtempo
      for j in 0...currenttempo
        if alpha<255
          sprite.color.red=255
          sprite.color.green=255
          sprite.color.blue=255
          sprite.color.alpha=alpha
          sprite.color=sprite.color
          alpha+=10
        end
        sprite.zoom=[1.1*(currenttempo-j-1)/currenttempo,1.0].min
        sprite2.zoom=[1.1*(j+1)/currenttempo,1.0].min
        sprite.update
        sprite2.update
      end
      totaltempo+=currenttempo
      if totaltempo+currenttempo<maxtempo
        for j in 0...currenttempo
          sprite.zoom=[1.1*(j+1)/currenttempo,1.0].min
          sprite2.zoom=[1.1*(currenttempo-j-1)/currenttempo,1.0].min
          sprite.update
          sprite2.update
        end
      end
      totaltempo+=currenttempo
      currenttempo=[(currenttempo/1.5).floor,5].max
    end
    @metafile1=sprite
    @metafile2=sprite2
  end

  def pbSaveSpriteState(sprite)
    state=[]
    return state if !sprite || sprite.disposed?
    state[SpriteMetafile::BITMAP]     = sprite.x
    state[SpriteMetafile::X]          = sprite.x
    state[SpriteMetafile::Y]          = sprite.y
    state[SpriteMetafile::SRC_RECT]   = sprite.src_rect.clone
    state[SpriteMetafile::VISIBLE]    = sprite.visible
    state[SpriteMetafile::Z]          = sprite.z
    state[SpriteMetafile::OX]         = sprite.ox
    state[SpriteMetafile::OY]         = sprite.oy
    state[SpriteMetafile::ZOOM_X]     = sprite.zoom_x
    state[SpriteMetafile::ZOOM_Y]     = sprite.zoom_y
    state[SpriteMetafile::ANGLE]      = sprite.angle
    state[SpriteMetafile::MIRROR]     = sprite.mirror
    state[SpriteMetafile::BUSH_DEPTH] = sprite.bush_depth
    state[SpriteMetafile::OPACITY]    = sprite.opacity
    state[SpriteMetafile::BLEND_TYPE] = sprite.blend_type
    state[SpriteMetafile::COLOR]      = sprite.color.clone
    state[SpriteMetafile::TONE]       = sprite.tone.clone
    return state
  end

  def pbRestoreSpriteState(sprite,state)
    return if !state || !sprite || sprite.disposed?
    sprite.x          = state[SpriteMetafile::X]
    sprite.y          = state[SpriteMetafile::Y]
    sprite.src_rect   = state[SpriteMetafile::SRC_RECT]
    sprite.visible    = state[SpriteMetafile::VISIBLE]
    sprite.z          = state[SpriteMetafile::Z]
    sprite.ox         = state[SpriteMetafile::OX]
    sprite.oy         = state[SpriteMetafile::OY]
    sprite.zoom_x     = state[SpriteMetafile::ZOOM_X]
    sprite.zoom_y     = state[SpriteMetafile::ZOOM_Y]
    sprite.angle      = state[SpriteMetafile::ANGLE]
    sprite.mirror     = state[SpriteMetafile::MIRROR]
    sprite.bush_depth = state[SpriteMetafile::BUSH_DEPTH]
    sprite.opacity    = state[SpriteMetafile::OPACITY]
    sprite.blend_type = state[SpriteMetafile::BLEND_TYPE]
    sprite.color      = state[SpriteMetafile::COLOR]
    sprite.tone       = state[SpriteMetafile::TONE]
  end

  def pbSaveSpriteStateAndBitmap(sprite)
    return [] if !sprite || sprite.disposed?
    state=pbSaveSpriteState(sprite)
    state[SpriteMetafile::BITMAP]=sprite.bitmap
    return state
  end

  def pbRestoreSpriteStateAndBitmap(sprite,state)
    return if !state || !sprite || sprite.disposed?
    sprite.bitmap=state[SpriteMetafile::BITMAP]
    pbRestoreSpriteState(sprite,state)
    return state
  end

  # Starts the evolution screen with the given Pokemon and new Pokemon species.

  def pbUpdate(animating=false)
    if animating      # Pokémon shouldn't animate during the evolution animation
      @sprites["background"].update
    else
      pbUpdateSpriteHash(@sprites)
    end
  end

  def pbUpdateNarrowScreen
    if @bgviewport.rect.y<20*4
      @bgviewport.rect.height-=2*4
      if @bgviewport.rect.height<Graphics.height-64
        @bgviewport.rect.y+=4
        @sprites["background"].oy=@bgviewport.rect.y
      end
    end
  end

  def pbUpdateExpandScreen
    if @bgviewport.rect.y>0
      @bgviewport.rect.y-=4
      @sprites["background"].oy=@bgviewport.rect.y
    end
    if @bgviewport.rect.height<Graphics.height
      @bgviewport.rect.height+=2*4
    end
  end

  def pbFlashInOut(canceled,oldstate,oldstate2)
    tone=0
    loop do
      Graphics.update
      pbUpdate(true)
      pbUpdateExpandScreen
      tone+=10
      @viewport.tone.set(tone,tone,tone,0)
      break if tone>=255
    end
    @bgviewport.rect.y=0
    @bgviewport.rect.height=Graphics.height
    @sprites["background"].oy=0
    if canceled
      pbRestoreSpriteState(@sprites["rsprite1"],oldstate)
      pbRestoreSpriteState(@sprites["rsprite2"],oldstate2)
      @sprites["rsprite1"].visible=true
      @sprites["rsprite1"].zoom_x=1.0
      @sprites["rsprite1"].zoom_y=1.0
      @sprites["rsprite1"].color.alpha=0
      @sprites["rsprite2"].visible=false
    else
      @sprites["rsprite1"].visible=false
      @sprites["rsprite2"].visible=true
      @sprites["rsprite2"].zoom_x=1.0
      @sprites["rsprite2"].zoom_y=1.0
      @sprites["rsprite2"].color.alpha=0
    end
    10.times do
      Graphics.update
      pbUpdate(true)
    end
    tone=255
    loop do
      Graphics.update
      pbUpdate
      tone=[tone-20,0].max
      @viewport.tone.set(tone,tone,tone,0)
      break if tone<=0
    end
  end

  def pbStartScreen(pokemon,newspecies,item=nil)
    @sprites={}
    @bgviewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @bgviewport.z=99999
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @pokemon=pokemon
    @newspecies=newspecies
    startform=@pokemon.form
    addBackgroundOrColoredPlane(@sprites,"background","evolutionbg",
       Color.new(248,248,248),@bgviewport)
    rsprite1=PokemonSprite.new(@viewport)
    rsprite2=PokemonSprite.new(@viewport)
    rsprite1.setPokemonBitmap(@pokemon,false)
    @pokemon.form=getEvolutionForm(@pokemon,item)
    rsprite2.setPokemonBitmapSpecies(@pokemon,@newspecies,false)
    @pokemon.form=startform
    rsprite1.ox=rsprite1.bitmap.width/2
    rsprite1.oy=rsprite1.bitmap.height/2
    rsprite2.ox=rsprite2.bitmap.width/2
    rsprite2.oy=rsprite2.bitmap.height/2
    rsprite1.x=Graphics.width/2
    rsprite1.y=(Graphics.height-64)/2
    rsprite2.x=rsprite1.x
    rsprite2.y=rsprite1.y
    rsprite2.opacity=0
    @sprites["rsprite1"]=rsprite1
    @sprites["rsprite2"]=rsprite2
    pbGenerateMetafiles(rsprite1.ox,rsprite1.oy,rsprite2.ox,rsprite2.oy)
    @sprites["msgwindow"]=Kernel.pbCreateMessageWindow(@viewport)
    pbFadeInAndShow(@sprites)
  end

  # Closes the evolution screen.
  def pbEndScreen
    Kernel.pbDisposeMessageWindow(@sprites["msgwindow"])
    pbFadeOutAndHide(@sprites)
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end

  # Opens the evolution screen
  def pbEvolution(cancancel=true,item=nil)
    pbBGMStop()
    pbBGMPlay("Evolution")
    metaplayer1=SpriteMetafilePlayer.new(@metafile1,@sprites["rsprite1"])
    metaplayer2=SpriteMetafilePlayer.new(@metafile2,@sprites["rsprite2"])
    metaplayer1.play
    metaplayer2.play

    pbPlayCry(@pokemon)
    pkmnname=@pokemon.name
    pkmnname["\\"]="\\"+00.chr if pkmnname.include?("\\")
    Kernel.pbMessageDisplay(@sprites["msgwindow"],
       _INTL("\\se[]What?\r\n{1} is evolving!\\^",pkmnname))
    Kernel.pbMessageWaitForInput(@sprites["msgwindow"],100,true)
    pbPlayDecisionSE()
    oldstate=pbSaveSpriteState(@sprites["rsprite1"])
    oldstate2=pbSaveSpriteState(@sprites["rsprite2"])

    @canceled= (@pokemon.species == :INKAY)

    begin
      pbUpdateNarrowScreen
      metaplayer1.update
      metaplayer2.update
      Graphics.update
      Input.update
      pbUpdate(true)
      if Input.trigger?(Input::B) && cancancel
        if @pokemon.species == :INKAY
          @canceled=false
        else
          @canceled=true
          pbRestoreSpriteState(@sprites["rsprite1"],oldstate)
          pbRestoreSpriteState(@sprites["rsprite2"],oldstate2)
          Graphics.update
          break
        end
      end
    end while metaplayer1.playing? && metaplayer2.playing?
    pbFlashInOut(@canceled,oldstate,oldstate2)
    if @canceled
      if @pokemon.species == :INKAY
        pbRestoreSpriteState(@sprites["rsprite1"],oldstate)
        pbRestoreSpriteState(@sprites["rsprite2"],oldstate2)
        Graphics.update
      end
      pbPlayCancelSE()
      Kernel.pbMessageDisplay(@sprites["msgwindow"], _INTL("Huh?\r\n{1} stopped evolving!",pkmnname))
      pbBGMStop()

    else
      removeItem=false
      createSpecies=checkEvolutionEx(@pokemon){|pokemon,method,condition,evo|
        case method
          when :Shedinja then next evo if $PokemonBag.pbHasItem?(:POKEBALL)
          when :TradeItem, :DayHoldItem, :NightHoldItem
            if evo==@newspecies
              removeItem=true  # Item is now consumed
              next
            end
          # Gen 9 Mod - Remove Gimmighoul coins from bag when Gimmighoul evolves.
          when :CollectItem then $PokemonBag.pbDeleteItem(:GIMMIGHOULCOIN,999) if evo==@newspecies
        end
      }
      newspeciesname=getMonName(@newspecies)
      oldspeciesname=getMonName(@pokemon.species)
      abillist = @pokemon.getAbilityList
      if abillist.include?(@pokemon.ability)
        abilindex= abillist.index(@pokemon.ability)
      else
        abilindex= @pokemon.personalID % (abillist.length)
      end
      ishidden= $cache.pkmn[@pokemon.species].checkFlag?(:HiddenAbilities)==@pokemon.ability
      @pokemon.form=getEvolutionForm(@pokemon,item)
      @pokemon.species=@newspecies
      @pokemon.ability= @pokemon.getAbilityList[abilindex]
      @pokemon.ability= @pokemon.abilityIndex if @pokemon.ability.nil? # because kakuna, metapod and vibrava are bitches
      frames=pbCryFrameLength(@pokemon)

      pbPlayCry(@pokemon)
      frames.times do
        Graphics.update
      end
      Kernel.pbMessageDisplay(@sprites["msgwindow"], _INTL("\\se[]Congratulations! Your {1} evolved into {2}!\\wt[80]", pkmnname, newspeciesname))
      @sprites["msgwindow"].text = ""
      if removeItem
        @pokemon.item = nil
        @pokemon.itemInitial = nil
        @pokemon.itemReallyInitialHonestlyIMeanItThisTime = nil
      end
      $Trainer.pokedex.dexList[@newspecies][:seen?] = true
      $Trainer.pokedex.dexList[@newspecies][:owned?] = true
      $Trainer.pokedex.refreshDex() if !$Trainer.pokedex.dexList[@pokemon.species][:formsOwned]
      $Trainer.pokedex.dexList[@newspecies][:formsOwned][@pokemon.form] = true
      $Trainer.pokedex.setFormSeen(@pokemon)
      @pokemon.name = newspeciesname if @pokemon.name == oldspeciesname
      @pokemon.calcStats
      # Check moves for new species
      movelist=@pokemon.getMoveList
      shedinjamoves=@pokemon.moves.clone
      for i in movelist
        if i[0] == 0 || (i[0] == @pokemon.level && (Gen <= 7 || @pokemon.level != 1)) # Learned a new move
          pbLearnMove(@pokemon,i[1],true)
        end
      end
      if !createSpecies.nil? && $Trainer.party.length<6
        newpokemon=@pokemon.clone
        newpokemon.moves=shedinjamoves
        newpokemon.iv=@pokemon.iv.clone
        newpokemon.ev=@pokemon.ev.clone
        newpokemon.species=createSpecies
        newpokemon.name=getMonName(createSpecies)
        newpokemon.initAbility
        newpokemon.setItem(nil)
        newpokemon.itemInitial=nil
        #newpokemon.clearAllRibbons
        newpokemon.markings=0
        newpokemon.ballused=:POKEBALL
        newpokemon.calcStats
        newpokemon.heal
        $Trainer.party.push(newpokemon)
        $Trainer.pokedex.dexList[createSpecies][:seen?]=true
        $Trainer.pokedex.dexList[createSpecies][:owned?]=true
        $Trainer.pokedex.setFormSeen(newpokemon)
        $PokemonBag.pbDeleteItem(:POKEBALL)
      end
    end
  end
end

def checkEvoConditions(pokemon,method,condition,evo)
  case method
    when :Trade, :TradeItem, :TradeSpecies, :Shedinja, :LandCritical then return nil
    #for organization, non-level evos go first, then we do a level check, then we continue.
    when :Happiness then return evo if pokemon.happiness>=220
    when :HappinessDay then return evo if pokemon.happiness>=220 && PBDayNight.isDay?(pbGetTimeNow)
    when :HappinessNight then return evo if pokemon.happiness>=220 && PBDayNight.isNight?(pbGetTimeNow)
    when :Affection
      for i in 0...4
        return evo if pokemon.happiness>=220 && pokemon.moves[i].type==condition
      end
    when :DayHoldItem
      return evo if pokemon.item==condition && PBDayNight.isDay?(pbGetTimeNow)
    when :NightHoldItem
      return evo if pokemon.item==condition && PBDayNight.isNight?(pbGetTimeNow)
    when :HasMove
      for i in 0...pokemon.moves.length
        return evo if pokemon.moves[i].move==condition
      end
    when :HasInParty
      for i in $Trainer.party
        return evo if !i.isEgg? && i.species==condition
      end
    when :Location
      case pokemon.species
        when :CRABRAWLER then return evo if Crabominable.include?($game_map.map_id)
        when :MAGNETON, :NOSEPASS, :CHARJABUG then return evo if Magnetic.include?($game_map.map_id)
        else return evo if $game_map.map_id==condition
      end
    when :Runerigus then return evo if (pokemon.totalhp-pokemon.hp>=49) && YamaskEvo.include?($game_map.map_id)
    # Gen 9 Mod - Added Gimmighoul evolution method.
    when :CollectItem
      if condition == :GIMMIGHOULCOIN
        return evo if $PokemonBag.pbQuantity(condition) >= 999
      end
    # Gen 9 Mod - Once enough steps have been taken with the species in the party, it will evolve after leveling up.
    when :LevelWalk
      pokemon.levelWalkSteps=0 if !pokemon.levelWalkSteps
      if pokemon.levelWalkSteps >= condition
        return evo
      end
    # Gen 9 Mod - Move had to be used the condition number of times
    when :LevelUseMove
      pokemon.usedMoves=0 if !pokemon.usedMoves
      if pokemon.usedMoves >= condition
        return evo
      end
    # Gen 9 Mod - Check if enough enemeis have been defeated. There is a conditional required items when the species needs them.
    when :EnemyDefeat
      pokemon.defeatedEnemies = 0 if !pokemon.defeatedEnemies
      if pokemon.defeatedEnemies >= condition
        return evo
      end
    # Gen 9 Mod - Added Finizen evolution method.
    when :Palafin
      if pokemon.level >= condition
        return evo if $game_variables[129] >= 19
      end
  end
  #the rest are level ups. get out of here if that's not you.
  return nil if !(condition.is_a? Integer) || pokemon.level<condition
  case method
    when :Level, :Ninjask then return evo
    when :AttackGreater then return evo if pokemon.attack>pokemon.defense
    when :AtkDefEqual then return evo if pokemon.attack==pokemon.defense
    when :DefenseGreater then return evo if pokemon.attack<pokemon.defense
    when :Silcoon then return evo if (((pokemon.personalID>>16)&0xFFFF)%10)<5
    when :Cascoon then return evo if (((pokemon.personalID>>16)&0xFFFF)%10)>=5
    when :LevelMale then return evo if pokemon.isMale?
    when :LevelFemale then return evo if pokemon.isFemale?
    when :BadInfluence
      for i in $Trainer.party
        return evo if !i.isEgg? && i.hasType?(:DARK)
      end
    when :LevelRain then return evo if [:Rain,:Storm,:Thunder,:RealThunder,:HeavyRain].include?($game_screen.weather_type)
    when :LevelDay then return evo if PBDayNight.isDay?(pbGetTimeNow)
    when :LevelNight then return evo if PBDayNight.isNight?(pbGetTimeNow)
  end
  return nil
end

def checkEvoConditionsItem(pokemon,method,condition,evo,item)
  return nil if condition!=item
  case method
    when :Item, :TradeItem, :Trade then return evo
    when :ItemMale then return evo if pokemon.isMale?
    when :ItemFemale then return evo if pokemon.isFemale?
  end
  return nil
end

def getEvolutionForm(mon,item=nil)
  species = mon.species
  form = mon.form
  nature = mon.nature
  case species
  when :CUBONE            # Cubone -> Marowak forms
    if PBDayNight.isNight?(pbGetTimeNow) || Marowak.include?($game_map.map_id)
      return 1
    elsif PBDayNight.isDay?(pbGetTimeNow)
      return 0
    end
  when :KOFFING then return  Weezing.include?($game_map.map_id) ? 1 : 0
  when :ROCKRUFF            # Rockruff -> Lycanroc forms
    if PBDayNight.isDusk?(pbGetTimeNow)
      return 2
    elsif PBDayNight.isNight?(pbGetTimeNow)
      return 1
    elsif PBDayNight.isDay?(pbGetTimeNow)
      return 0
    end
  when :SPEWPA
    if Desolation
      maps=Dreamscape
      if $game_map && maps.include?($game_map.map_id)
        return 1
      else
        return 0
      end
    else
      return (((mon.personalID>>16)&0xFFFF)%10)
    end
  when :PIKACHU
    if Rejuv && item == :APOPHYLLPAN
      return 1
    elsif !Rejuv && Raichu.include?($game_map.map_id)
      return 1
    else
      return 0
    end
  when :RUFFLET then return Braviary.include?($game_map.map_id) ? 1 : 0
  when :GOOMY then return Sliggoo.include?($game_map.map_id) ? 1 : 0
  when :PETILIL then return Lilligant.include?($game_map.map_id) ? 1 : 0
  when :BERGMITE
    if item == :FIRESTONE
      return 1
    elsif Avalugg.include?($game_map.map_id)
      return 1
    else
      return 0
    end
  when :QUILAVA then return item == :ANCIENTTEACH ? 1 : 0
  when :DEWOTT then return item == :ANCIENTTEACH ? 1 : 0
  when :DARTRIX then return item == :ANCIENTTEACH ? 1 : 0
  when :DARUMAKA then return (form==1) ? 2 : 0
  when :EXEGGCUTE then return Exeggutor.include?($game_map.map_id) ? 1 : 0
  when :MIMEJR then return MrMime.include?($game_map.map_id) ? 1 : 0      # Mime Jr -> Mr Mime forms
  when :FARFETCHD then return 0
  when :LINOONE then return 0
  when :YAMASK then return 0
  when :MEOWTH then return (form==2) ? 0 : form
  when :CORSOLA then return 0
  when :MRMIME then return 0
  when :SWABLU then return form == 1 ? 2 : 0
  when :CAPSAKID
    if KAIZOMOD && item == :APOPHYLLPAN
      return 1
    else
      return 0
    end
  when :TOXEL
    if Rejuv && item == :FIRESTONE
      return 2
    else
      return [:LONELY,:BOLD,:RELAXED,:TIMID,:SERIOUS,:MODEST,:MILD,:QUIET,:BASHFUL,:CALM,:GENTLE,:CAREFUL].include?(nature) ? 1 : 0
    end
  # Gen 9 Mod - Added forms for Maushold and Dudunsparce.
  when :TANDEMAUS
    return (((mon.personalID>>16)&0xFFFF)%10) < 9 ? 0 : 1
  when :DUNSPARCE
    return (((mon.personalID>>16)&0xFFFF)%10) < 9 ? 0 : 1
  # Gen 9 Mod - Wooper evolution is always form 0.
  when :WOOPER then return 0
  # Gen 9 Mod - Gimmighoul evolution is always form 0.
  when :GIMMIGHOUL then return 0
  else return form
  end
end

# Checks whether a Pokemon can evolve now. If a block is given, calls the block
# with the following parameters:
#  Pokemon to check; evolution type; level or other parameter; ID of the new Pokemon species
def checkEvolutionEx(pokemon)
  return nil if pokemon.species.nil? || pokemon.isEgg?
  return nil if [:EVERSTONE,:EEVIUMZ,:EVIOLITE].include?(pokemon.item)
  ret=nil
  d= pbGetEvolvedFormData(pokemon.species,pokemon)
  if !d.nil?
    for form in d
      ret=yield pokemon,form[1],form[2],form[0]
      break if !ret.nil?
    end
  else
    ret = nil
  end
  return ret
end

# Checks whether a Pokemon can evolve now. If an item is used on the Pokémon,
# checks whether the Pokemon can evolve with the given item.
def checkEvolution(pokemon,item=nil)
  if item.nil?
    return checkEvolutionEx(pokemon){|pokemon,method,condition,evo|
       next checkEvoConditions(pokemon,method,condition,evo)
    }
  else
    return checkEvolutionEx(pokemon){|pokemon,method,condition,evo|
       next checkEvoConditionsItem(pokemon,method,condition,evo,item)
    }
  end
end

def pbGetEvolvedFormData(species,pokemon=nil)
  # Alternate evo methods for forms
  if pokemon!=nil
    return pokemon.formCheck(:evolutions) if pokemon.formCheck(:evolutions) != nil
  end
  return defined?($cache.pkmn[species].evolutions) ? $cache.pkmn[species].evolutions : nil
end

def pbGetPreviousForm(species,form=0)
  prespecies = species
  preform = form
  if !$cache.pkmn[species].preevo.nil?
    prespecies = $cache.pkmn[species].preevo[:species]
    preform = $cache.pkmn[species].preevo[:form]
  end
  if form != 0
    if $cache.pkmn[species].forms
      formname = $cache.pkmn[species].forms[form]
      if $cache.pkmn[species].formData[formname]
        if !$cache.pkmn[species].formData[formname][:preevo].nil?
          prespecies = $cache.pkmn[species].formData[formname][:preevo][:species]
          preform = $cache.pkmn[species].formData[formname][:preevo][:form]
        end
      end
    end
  end
  return [prespecies,preform]
end

def pbGetBabySpecies(species,form=0)
  prespecies = [nil,nil]
  while species != prespecies[0]
    species = prespecies[0] if !prespecies[0].nil?
    form = prespecies[1] if !prespecies[1].nil?
    prespecies = pbGetPreviousForm(species,form)
  end
  return [species,form]
end
