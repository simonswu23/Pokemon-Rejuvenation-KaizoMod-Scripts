def pbGetTutorableMoves
  tutormoves = [
    # Group 1
    [
      :INFESTATION, :WHIRLPOOL, :FLASH, :HIDDENPOWER, :MAGICALLEAF,
      :BIND, :COVET, :BLOCK, :SPITE, :SWIFT,
      :AFTERYOU, :GRAVITY, :MAGICCOAT, :VENOMDRENCH, :POISONSWEEP
    ],

    # Group 2
    [
      :QUASH, :ROCKSMASH, :ECHOEDVOICE, :SECRETPOWER, :EMBARGO,
      :VENOSHOCK, :FIRESPIN, :FLAMECHARGE, :STACKINGSHOT
    ],

    # Group 3
    [
      :PROTECT, :CUT, :FALSESWIPE, :FACADE
    ],

    # Group 4
    [
      :RECYCLE, :WORRYSEED, :SNORE, :SHOCKWAVE, :WATERPULSE,
      :SNATCH, :WONDERROOM, :MAGICROOM, :ROLEPLAY, :BULLDOZE,
      :SCREECH, :PAYDAY, :ROUND, :PAYBACK, :INCINERATE,
      :ROCKTOMB, :SHADOWBALL
    ],

    # Group 5
    [
      :NATUREPOWER, :CONFIDE, :ATTRACT, :BRINE, :ASSURANCE,
      :BULLETSEED
    ],

    # Group 6
    [
      :SURF, :SUPERFANG, :TRICK, :DUALCHOP, :HELPINGHAND,
      :GIGADRAIN, :SYNTHESIS, :MAGNETRISE, :UPROAR, :TELEKINESIS,
      :STRUGGLEBUG, :CROSSPOISON, :HEX, :SANDTOMB, :POWERUPPUNCH,
      :FLING, :LOWSWEEP, :SWAGGER, :RAZORSHELL, :BEATUP,
      :SKYDROP, :REST, :THIEF, :PINMISSILE, :TORMENT,
      :BRUTALSWING, :SLEEPTALK, :CHARGEBEAM, :MUDBARRAGE,
      :IRRITATION, :XSCISSOR
    ],

    # Group 7
    [
      :ROAR, :SAFEGUARD, :ROCKCLIMB, :MUDSHOT, :DELUGE,
      :WORKUP, :ROCKPOLISH, :SHADOWCLAW, :DOUBLETEAM
    ],

    # Group 8
    [
      :BUGBITE, :BOUNCE, :DRILLRUN, :ELECTROWEB, :GASTROACID,
      :FOCUSENERGY, :SKILLSWAP, :SIGNALBEAM, :COACHING, :AVALANCHE,
      :ZAPCANNON, :METRONOME, :RETALIATE, :DYANMICPUNCH, :VACUUMWAVE,
      :TRIATTACK, :ICEFANG, :FIREFANG, :THUNDERFANG, :PSYCHOCUT,
      :BREAKINGSWIPE, :THUNDERWAVE, :HAIL, :FROSTBREATH, :MAGMADRIFT,
      :POWERSWAP, :GUARDSWAP, :SPEEDSWAP, :SCARYFACE, :ICICLESPEAR,
      :TAILSLAP, :ROCKBLAST, :STEELWING, :SLUDGEBOMB, :GRASSKNOT,
      :FIREPUNCH, :ICEPUNCH, :THUNDERPUNCH, :HEALBELL, :BURNINGJEALOUSY,
      :SKITTERSMACK, :STOMPINGTANTRUM, :IRONTAIL, :ENDEAVOR,
      :IRONDEFENSE, :LASHOUT, :CORROSIVEGAS, :FIREPLEDGE,
      :WATERPLEDGE, :GRASSPLEDGE, :OVERHEAT
    ],

    # Group 9
    [
      :TRICKROOM, :AERIALACE, :POISONJAB, :FAKETEARS,
      :FRUSTRATION, :PSYCHUP, :EXPLOSION, :VOLTSWITCH
    ],

    # Group 10
    [
      :AQUATAIL, :LASERFOCUS, :SPIKES, :REVERSAL, :ENDURE,
      :AMNESIA, :ELECTROBALL, :ALLYSWITCH, :HYPERVOICE,
      :SELFDESTRUCT, :SLASHANDBURN, :DRAININGKISS, :SNARL,
      :RAINDANCE, :AIRSLASH, :SMACKDOWN, :MEGAPUNCH,
      :DARKPULSE, :ENERGYBALL
    ],

    # Group 11
    [
      :STRENGTH, :TAUNT, :LEECHLIFE, :SECRETPOWER, :EARTHPOWER,
      :FOCUSPUNCH, :DRAINPUNCH, :PAINSPLIT, :MISTYEXPLOSION,
      :FIREPLEDGE, :WATERPLEDGE, :GRASSPLEDGE, :DIVE,
      :BRICKBREAK, :ROOST, :DREAMEATER, :PSYCHIC
    ],

    # Group 12
    [
      :SKYATTACK, :ICYWIND, :TAILWIND, :BATONPASS, :ENCORE,
      :AGILITY, :CRUNCH, :FLAMETHROWER, :SOLARBLADE, :ACROBATICS
    ],

    # Group 13
    [
      :GIGAIMPACT, :SANDSTORM, :PHANTOMFORCE, :SKYATTACK,
      :SKILLSWAP, :MAGNETRISE, :GRAVITY, :RECYCLE, :RETURN,
      :FLY, :IRONHEAD, :FOULPLAY, :KNOCKOFF, :POLTERGEIST,
      :BUGBUZZ, :LASTRESORT, :OUTRAGE, :LOWKICK, :STEELROLLER,
      :POWERGEM, :INFESTATION, :THUNDERBOLT, :SUNNYDAY,
      :SOLARBEAM, :WILLOWISP, :WEATHERBALL, :ICEBEAM,
      :HONECLAWS, :MEGAKICK, :SUCKERPUNCH, :CHARM,
      :EERIEIMPULSE, :GYROBALL, :ROCKSLIDE
    ],

    # Group 14
    [
      :SUPERPOWER, :HEATWAVE, :STEALTHROCK, :FUTURESIGHT,
      :FLIPTURN, :REFLECT, :LIGHTSCREEN, :SMARTSTRIKE,
      :BODYSLAM, :SEEDBOMB, :DRAGONPULSE, :MEGAHORN,
      :SCORCHINGSANDS, :ZENHEADBUTT, :LIQUIDATION, :MUDDYWATER,
      :DEFOG, :DUALWINGBEAT, :BULKUP, :WILDCHARGE, :ARENITEWALL
    ],

    # Group 15
    [
      :DIG, :GRASSYTERRAIN, :ELECTRICTERRAIN, :MISTYTERRAIN,
      :PSYCHICTERRAIN, :SLUDGEWAVE, :SCALD, :SUBSTITUTE,
      :WATERFALL, :UTURN, :DRAGONTAIL, :FLASHCANNON
    ],

    # Group 16 (Karma Files)
    [
      :DRACOMETEOR, :COSMICPOWER, :LEAFBLADE, :TOXICSPIKES,
      :AURASPHERE, :HEAVYSLAM, :HEATCRASH, :GUNKSHOT,
      :POLLENPUFF, :TERRAINPULSE
    ]
  ]

  tutormoveslist = []

  if (KAIZOMOD)
    for i in 0..$Trainer.numbadges
      for currmove in tutormoves[i]
        for j in $cache.moves.keys
          # Kernel.pbMessage(_INTL("Move: {1}", $cache.moves[j].move))

          if $cache.moves[j].move == currmove
            tutormoveslist.append($cache.moves[j].move)
          end
        end
      end
    end
  else

    if !($Trainer.tutorlist)
      $Trainer.tutorlist=[]
    end

    if $Trainer.tutorlist.any?{|i| i.is_a?(Integer) }
      for i in 0...$Trainer.tutorlist.length
        next if !$Trainer.tutorlist[i].is_a?(Integer)
        for j in $cache.moves.keys
          if $cache.moves[j].checkFlag?(:ID) == $Trainer.tutorlist[i]
            $Trainer.tutorlist[i] = $cache.moves[j].move
          end
        end
      end
    end
    $Trainer.tutorlist.each{|i| tutormoveslist.push(i) }

  end

  return tutormoveslist|[] # remove duplicates
end



  ################################################################################
  # Scene class for handling appearance of the screen
  ################################################################################
  class MoveTutorScene
    VISIBLEMOVES = 4
  
    def pbDisplay(msg,brief=false)
      UIHelper.pbDisplay(@sprites["msgwindow"],msg,brief) { pbUpdate }
    end
  
    def pbConfirm(msg)
      UIHelper.pbConfirm(@sprites["msgwindow"],msg) { pbUpdate }
    end
  
  # Update the scene here, this is called once each frame
    def pbUpdate
      pbUpdateSpriteHash(@sprites)
    end
  
    def pbStartScene(moves)
      @moves=moves
      moveCommands=[]
      moves.each{|i| moveCommands.push(getMoveName(i)) }
      # Create sprite hash
      @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
      @viewport.z=99999
      @sprites={}
      addBackgroundPlane(@sprites,"bg","tutorbg",@viewport)
      @sprites["background"]=IconSprite.new(0,0,@viewport)
      @sprites["background"].setBitmap("Graphics/Pictures/reminderSel")
      @sprites["background"].y=78
      @sprites["background"].src_rect=Rect.new(0,72,258,72)
      @sprites["overlay"]=BitmapSprite.new(Graphics.width,Graphics.height,@viewport)
      pbSetSystemFont(@sprites["overlay"].bitmap)
      @sprites["commands"]=Window_CommandPokemon.new(moveCommands,32)
      @sprites["commands"].x=Graphics.width
      @sprites["commands"].height=32*(VISIBLEMOVES+1)
      @sprites["msgwindow"]=Window_AdvancedTextPokemon.new("")
      @sprites["msgwindow"].visible=false
      @sprites["msgwindow"].viewport=@viewport
      pbTMSprites
      @typebitmap=AnimatedBitmap.new(_INTL("Graphics/Pictures/types"))
      pbDrawMoveList
      pbDeactivateWindows(@sprites)
      # Fade in all sprites
      pbFadeInAndShow(@sprites) { pbUpdate }
    end
  
    def pbTMSprites
        xvalues=[300,410,300,410,300,410]
        yvalues=[60,78,140,164,220,244]
        for i in 0...$Trainer.party.length
            if !@sprites["pokemon#{i}"]
                @sprites["pokemon#{i}"]=IconSprite.new(0,0,@viewport)
                @sprites["pokemon#{i}"].bitmap = pbPokemonIconBitmap($Trainer.party[i],$Trainer.party[i].isEgg?)
                @sprites["pokemon#{i}"].src_rect=Rect.new(0,0,64,64)
                @sprites["pokemon#{i}"].x=xvalues[i]
                @sprites["pokemon#{i}"].y=yvalues[i]
                @sprites["pokemon#{i}"].visible=false
            else
                @sprites["pokemon#{i}"].bitmap = pbPokemonIconBitmap($Trainer.party[i],$Trainer.party[i].isEgg?)
                @sprites["pokemon#{i}"].src_rect=Rect.new(0,0,64,64)
            end
            unless @sprites["possiblelearn#{i}"]
                @sprites["possiblelearn#{i}"]=IconSprite.new(0,0,@viewport)
                @sprites["possiblelearn#{i}"].x=xvalues[i]+32
                @sprites["possiblelearn#{i}"].y=yvalues[i]+32
                @sprites["possiblelearn#{i}"].visible=false
            end
        end
    end

    def pbDrawMoveList
      overlay=@sprites["overlay"].bitmap
      overlay.clear
      textpos=[]
      imagepos=[]
      type1rect=Rect.new(0,0,64,28)
      type2rect=Rect.new(0,0,64,28)
      textpos=[
         [_INTL("Teach which move?"),16,8,0,Color.new(88,88,80),Color.new(168,184,184)]
      ]
      yPos=82
      for i in 0...VISIBLEMOVES
        moveobject=@moves[@sprites["commands"].top_item+i]
        if moveobject
          movedata=$cache.moves[moveobject]
          if movedata
            typeimage = AnimatedBitmap.new(sprintf("Graphics/Icons/type%s",movedata.type))
            overlay.blt(12,yPos+2,typeimage.bitmap,type1rect)
            textpos.push([getMoveName(moveobject),80,yPos,0, Color.new(248,248,248),Color.new(0,0,0)])
            if movedata.maxpp>0
              textpos.push([_INTL("PP"),112,yPos+32,0, Color.new(64,64,64),Color.new(176,176,176)])
              textpos.push([_ISPRINTF("{1:d}/{2:d}", movedata.maxpp,movedata.maxpp),230,yPos+32,1, Color.new(64,64,64),Color.new(176,176,176)])
            end
          else
            textpos.push(["-",80,yPos,0,Color.new(64,64,64),Color.new(176,176,176)])
            textpos.push(["--",228,yPos+32,1,Color.new(64,64,64),Color.new(176,176,176)])
          end
        end
        yPos+=64
      end
      selmovedata=$cache.moves[@moves[@sprites["commands"].index]]
      if selmovedata
        canlearnmove=PokemonBag.pbPartyCanLearnThisMove?(selmovedata.move)
        for i in 0...$Trainer.party.length
            @sprites["pokemon#{i}"].visible=true
            @sprites["possiblelearn#{i}"].visible=true
            case canlearnmove[i]
            when 0 #unable
                @sprites["possiblelearn#{i}"].setBitmap(sprintf("Graphics/Pictures/Bag/tmnope")) rescue nil
            when 1 #able
                @sprites["possiblelearn#{i}"].setBitmap(sprintf("Graphics/Pictures/Bag/tmcheck")) rescue nil
            when 2 #learned
                @sprites["possiblelearn#{i}"].setBitmap(sprintf("Graphics/Pictures/Bag/tmdash")) rescue nil
            else
                @sprites["possiblelearn#{i}"].setBitmap(nil)
            end
        end
      else
        for i in 0...$Trainer.party.length
            @sprites["pokemon#{i}"].visible=false
            @sprites["possiblelearn#{i}"].visible=false
        end
      end 
      imagepos.push(["Graphics/Pictures/reminderSel", 0,78+(@sprites["commands"].index-@sprites["commands"].top_item)*64, 0,0,258,72])
      pbDrawTextPositions(overlay,textpos) 
      if @sprites["commands"].index<@moves.length-1
        imagepos.push(["Graphics/Pictures/reminderButtons",48,350,0,0,76,32])
      end
      if @sprites["commands"].index>0
        imagepos.push(["Graphics/Pictures/reminderButtons",134,350,76,0,76,32])
      end
      pbDrawImagePositions(overlay,imagepos)
    end
  
  # Processes the scene
    def pbChooseMove
      oldcmd=-1
      pbActivateWindow(@sprites,"commands"){
         loop do
           oldcmd=@sprites["commands"].index
           Graphics.update
           Input.update
           pbUpdate
           if @sprites["commands"].index!=oldcmd
             @sprites["background"].x=0
             @sprites["background"].y=78+(@sprites["commands"].index-@sprites["commands"].top_item)*64
             pbDrawMoveList
           end
           if Input.trigger?(Input::B)
             return 0
           end
           if Input.trigger?(Input::C)
             return @moves[@sprites["commands"].index]
           end
         end
      }
    end
  
  # End the scene here
    def pbEndScene
      if @sprites
        pbFadeOutAndHide(@sprites) { pbUpdate } # Fade out all sprites
        pbDisposeSpriteHash(@sprites) # Dispose all sprites
        @typebitmap.dispose
        @viewport.dispose # Dispose the viewport
      end
    end
  end
  
  
  
  # Screen class for handling game logic
  class MoveTutorScreen
    def initialize(scene)
      @scene = scene
    end
  
    def pbStartScreen
      moves=pbGetTutorableMoves
      # Kernel.pbMessage(_INTL("MoveList: {1}", moves))

      if moves == []
        Kernel.pbMessage(_INTL("You don't have any registered moves."))
        return false
      end
      @scene.pbStartScene(moves)
      loop do
        move=@scene.pbChooseMove
        if !move.is_a?(Symbol)
          if @scene.pbConfirm(
            _INTL("Give up trying to teach a new move?"))
            @scene.pbEndScene
            return false
          end
        else
          if @scene.pbConfirm(_INTL("Teach {1}?",getMoveName(move)))
            pbMoveTutorChoose(move,false,false,true)
          end
        end
      end
    end
  end
  
  
  
  def pbRelearnMoveTutorScreen
    retval=true
    pbFadeOutIn(99999){
       scene=MoveTutorScene.new
       screen=MoveTutorScreen.new(scene)
       retval=screen.pbStartScreen
    }
    return retval
  end
  