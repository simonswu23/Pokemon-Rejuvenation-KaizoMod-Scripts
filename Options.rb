class Window_PokemonOption < Window_DrawableCommand
  attr_reader :mustUpdateOptions
  attr_accessor :options

  def initialize(options,x,y,width,height)
    @options=options
    @nameBaseColor=Color.new(24*8,15*8,0)
    @nameShadowColor=Color.new(31*8,22*8,10*8)
    @selBaseColor=Color.new(31*8,6*8,3*8)
    @selShadowColor=Color.new(31*8,17*8,16*8)
    @optvalues=[]
    @mustUpdateOptions=false
    for i in 0...@options.length
      @optvalues[i]=0
    end
    super(x,y,width,height)
  end

  def [](i)
    return @optvalues[i]
  end

  def []=(i,value)
    @optvalues[i]=value
    refresh
  end

  def itemCount
    return @options.length+1
  end

  def drawItem(index,count,rect)
    rect=drawCursor(index,rect)
    optionname=(index==@options.length) ? _INTL("Cancel") : @options[index].name
    optionwidth=(rect.width*9/20)
    pbDrawShadowText(self.contents,rect.x,rect.y,optionwidth,rect.height,optionname,
       @nameBaseColor,@nameShadowColor)
    self.contents.draw_text(rect.x,rect.y,optionwidth,rect.height,optionname)
    return if index==@options.length
    if @options[index].is_a?(EnumOption)
      if @options[index].values.length>1
        totalwidth=0
        for value in @options[index].values
          totalwidth+=self.contents.text_size(value).width
        end
        spacing=(optionwidth-totalwidth)/(@options[index].values.length-1)
        spacing=0 if spacing<0
        xpos=optionwidth+rect.x
        ivalue=0
        for value in @options[index].values
          pbDrawShadowText(self.contents,xpos,rect.y,optionwidth,rect.height,value,
             (ivalue==self[index]) ? @selBaseColor : self.baseColor,
             (ivalue==self[index]) ? @selShadowColor : self.shadowColor
          )
          self.contents.draw_text(xpos,rect.y,optionwidth,rect.height,value)
          xpos+=self.contents.text_size(value).width
          xpos+=spacing
          ivalue+=1
        end
      else
        pbDrawShadowText(self.contents,rect.x+optionwidth,rect.y,optionwidth,rect.height,
           optionname,self.baseColor,self.shadowColor)
      end
    elsif @options[index].is_a?(NumberOption)
      value=_ISPRINTF("{1:d}",@options[index].optstart+self[index])
      xpos=optionwidth+rect.x
      pbDrawShadowText(self.contents,xpos,rect.y,optionwidth,rect.height,value,
         @selBaseColor,@selShadowColor)
    else
      value=@options[index].values[self[index]]
      xpos=optionwidth+rect.x
      pbDrawShadowText(self.contents,xpos,rect.y,optionwidth,rect.height,value,
         @selBaseColor,@selShadowColor)
      self.contents.draw_text(xpos,rect.y,optionwidth,rect.height,value)
    end
  end

  def update
    dorefresh=false
    oldindex=self.index
    @mustUpdateOptions=false
    super
    dorefresh=self.index!=oldindex
    if self.active && self.index<@options.length
      if Input.repeat?(Input::LEFT)
        self[self.index]=@options[self.index].prev(self[self.index])
        dorefresh=true
        @mustUpdateOptions=true
      elsif Input.repeat?(Input::RIGHT)
        self[self.index]=@options[self.index].next(self[self.index])
        dorefresh=true
        @mustUpdateOptions=true
      elsif Input.repeat?(Input::UP) || Input.repeat?(Input::DOWN)
        @mustUpdateOptions=true
      end
    end
    refresh if dorefresh
  end
end

module PropertyMixin
  def get
    @getProc ? @getProc.call() : nil
  end

  def set(value)
    @setProc.call(value) if @setProc
  end
end

class EnumOption
  include PropertyMixin
  attr_reader :values
  attr_reader :name
  attr_reader :description

  def initialize(name,options,getProc,setProc,description="")            
    @values=options
    @name=name
    @getProc=getProc
    @setProc=setProc
    @description=description
  end

  def next(current)
    index=current+1
    index=@values.length-1 if index>@values.length-1
    return index
  end

  def prev(current)
    index=current-1
    index=0 if index<0
    return index
  end
end

class NumberOption
  include PropertyMixin
  attr_reader :name
  attr_reader :optstart
  attr_reader :description

  def initialize(name,format,optstart,optend,getProc,setProc,description="")
    @name=name
    @format=format
    @optstart=optstart
    @optend=optend
    @getProc=getProc
    @setProc=setProc
    @description=description
  end

  def next(current)
    index=current+@optstart
    index+=1
    if index>@optend
      index=@optstart
    end
    return index-@optstart
  end

  def prev(current)
    index=current+@optstart
    index-=1
    if index<@optstart
      index=@optend
    end
    return index-@optstart
  end
end


def pbSettingToTextSpeed(speed)
  return 2 if speed==0
  return 1 if speed==1
  return -2 if speed==2
  return MessageConfig::TextSpeed if MessageConfig::TextSpeed
  return ((Graphics.frame_rate>40) ? -2 : 1)
end

module MessageConfig
  def self.pbDefaultSystemFrame
    return pbResolveBitmap(TextFrames[$Settings.frame])||""
  end

  def self.pbDefaultSpeechFrame
    return pbResolveBitmap("Graphics/Windowskins/"+SpeechFrames[$Settings.textskin])||""
  end

  def self.pbDefaultSystemFontName
    return MessageConfig.pbTryFonts(VersionStyles[0][0],"Arial Narrow","Arial")
  end

  def self.pbDefaultTextSpeed
    return pbSettingToTextSpeed($Settings.textspeed)
  end

  def pbGetSystemTextSpeed
    return $Settings.textspeed
  end
end

class PokemonOptions
  attr_accessor :textspeed
  attr_accessor :volume
  attr_accessor :sevolume
  attr_accessor :bagsorttype
  attr_accessor :battlescene
  attr_accessor :battlestyle
  attr_accessor :frame
  attr_accessor :textskin
  attr_accessor :font
  attr_accessor :screensize
  attr_accessor :language
  attr_accessor :border
  attr_accessor :backup
  attr_accessor :maxBackup
  attr_accessor :field_effects_highlights
  attr_accessor :remember_commands
  attr_accessor :photosensitive
  attr_accessor :autosave
  attr_accessor :autorunning
  attr_accessor :bike_and_surf_music
  attr_accessor :streamermode
  attr_accessor :unrealTimeDiverge
  attr_accessor :unrealTimeClock
  attr_accessor :unrealTimeTimeScale
  attr_accessor :portable
  attr_accessor :audiotype
  attr_accessor :chooseBabyIncense # Gen 9 Mod - Baby Incense needed or not
  attr_accessor :itemRestoreGen9 # Gen 9 Mod - Restore Item after battle

  def initialize(system=nil)
    @textspeed   = (system != nil ? system.textspeed : 1)   # Text speed (0=slow, 1=mid, 2=fast)
    @volume      = (system != nil ? system.volume : 100.00) # Volume (0 - 100 )
    @sevolume    = (system != nil ? system.sevolume : 100.00) # Volume (0 - 100 )
    @audiotype   = (system != nil ? system.audiotype : 0) # Stereo / Mono audio (0 / 1)
    @bagsorttype = (system != nil ? system.bagsorttype : 0)   # Bag sorting (0=by name, 1=by type)
    @battlescene = (system != nil ? system.battlescene : 0)   # Battle scene (animations) (0=on, 1=off)
    @battlestyle = (system != nil ? system.battlestyle : 1)   # Battle style (0=shift, 1=set)
    @frame       = (system != nil ? system.frame : 0)   # Default window frame (see also TextFrames)
    @textskin    = (system != nil ? system.textskin : 0)   # Speech frame
    @font        = (system != nil ? system.font : 0)   # Font (see also VersionStyles)
    @screensize  = (system != nil ? system.screensize : (DEFAULTSCREENZOOM).floor).to_i # 0=half size, 1=full size, 2=double size
    @border      = (system != nil ? system.border : 0)   # Screen border (0=off, 1=on)
    @language    = (system != nil ? system.language : 0)   # Language (see also LANGUAGES in script PokemonSystem)
    @backup      = (system != nil ? system.backup : 0)   # Backup on/off
    @maxBackup   = (system != nil ? system.maxBackup : 50)   # Backup on/off
    @portable    = 0 #keep save files in with the game or not
    @field_effects_highlights = (system != nil ? system.field_effects_highlights : 0)   #Field effect UI highlights on/off
    @remember_commands        = (system != nil ? system.remember_commands : 0)
    @photosensitive           = (system != nil ? system.photosensitive : 0) # a mode that disables flashes and shakes (0=off, 1 = onn)
    @autorunning              = (system != nil ? system.autorunning : 0) # 0 is on, 1 is off
    @bike_and_surf_music      = (system != nil ? system.bike_and_surf_music : 0) # 0 is off, 1 is on
    @streamermode             = (system != nil ? system.streamermode : 0)
    @unrealTimeDiverge        = (system != nil ? system.unrealTimeDiverge : 0)   # Unreal Time on/off
    @unrealTimeClock          = (system != nil ? system.unrealTimeClock : 2)    # Unreal Time Clock (0=always, 1=pause menu, 2=pokegear only)
    @unrealTimeTimeScale      = (system != nil ? system.unrealTimeTimeScale : 30)   # Unreal Time Timescale (default 30x real time)
    @chooseBabyIncense        = (system != nil ? system.chooseBabyIncense : 0) # Gen 9 Mod - Baby Incense needed or not. (0=Incense, 1=No Incense)
    @itemRestoreGen9          = (system != nil ? system.itemRestoreGen9 : 2) # Gen 9 Mod - Restore Item after battle (0=Off, 1=No Berries (Gen 9), 2=All)
  end
end

class PokemonOptionScene
  OptionList=[
    EnumOption.new(_INTL("Autorunning"),[_INTL("On"),_INTL("Off")],
        proc { $Settings.autorunning },
        proc {|value|  $Settings.autorunning = value }
    ),
    EnumOption.new(_INTL("Text Speed"),[_INTL("Normal"),_INTL("Fast"),_INTL("Max")],
       proc { $Settings.textspeed },
       proc {|value|  
          $Settings.textspeed=value 
          MessageConfig.pbSetTextSpeed(pbSettingToTextSpeed(value)) 
       }
    ),
    NumberOption.new(_INTL("BGM Volume"),_INTL("Type %d"),0,100,
       proc { $Settings.volume },
       proc {|value|  $Settings.volume=value
       if $game_map && $game_system.playing_bgm
        bgm_new_volume = $game_system.playing_bgm
        bgm_new_volume.volume = $Settings.volume
        $game_system.bgm_play_internal(bgm_new_volume, $game_system.bgm_position)
       end
      },
      "Volume of Background Music."
    ),       
    NumberOption.new(_INTL("SE Volume"),_INTL("Type %d"),0,100,
       proc { $Settings.sevolume },
       proc {|value|  $Settings.sevolume=value },
      "Volume of Sound Effects."
    ),
    EnumOption.new(_INTL("Sound"),[_INTL("Stereo"),_INTL("Mono")],
       proc { $Settings.audiotype },
       proc {|value| $Settings.audiotype=value },
       "Audio plays from both or one ear"
    ),
    EnumOption.new(_INTL("Bike and Surf Music"),[_INTL("Off"),_INTL("On")],
       proc { $Settings.bike_and_surf_music },
       proc {|value| $Settings.bike_and_surf_music=value },
       "Enables bike and surf music to play"
    ),
    EnumOption.new(_INTL("Bag Sorting"),[_INTL("By Name"),_INTL("By Type")],
       proc { $Settings.bagsorttype },
       proc {|value| $Settings.bagsorttype=value },
       "How to sort items in the bag."
    ),
    EnumOption.new(_INTL("Battle Scene"),[_INTL("On"),_INTL("Off")],
       proc { $Settings.battlescene },
       proc {|value|  $Settings.battlescene=value },
       "Show animations during battle."
    ),
    EnumOption.new(_INTL("Battle Style"),[_INTL("Shift"),_INTL("Set")],
       proc { $Settings.battlestyle },
       proc {|value|  $Settings.battlestyle=value }
    ),
    EnumOption.new(_INTL("Photosensitivity"),[_INTL("Off"),_INTL("On")],
       proc { $Settings.photosensitive },
       proc {|value|  $Settings.photosensitive=value },
       "Disables battle animations, screen flashes and shakes for photosensitivity."
    ),
    EnumOption.new(_INTL("Streamer mode"),[_INTL("Off"),_INTL("On")],
       proc { $Settings.streamermode },
       proc {|value|  $Settings.streamermode=value },
       "Hides private information for safety and compatibility."
    ),
    EnumOption.new(_INTL("Portable mode"),[_INTL("Off"),_INTL("On")],
       proc { $Settings.portable },
       proc {|value|  $Settings.portable=value
          makePortable},
       "Keeps save data in the game EXE folder."
    ),
    NumberOption.new(_INTL("Speech Frame"),_INTL("Type %d"),1,SpeechFrames.length,
       proc { $Settings.textskin },
       proc {|value|  $Settings.textskin=value;
          MessageConfig.pbSetSpeechFrame(
             "Graphics/Windowskins/"+SpeechFrames[value]) },
       proc { _INTL("Speech frame {1}.",1+$Settings.textskin) }
    ),
    NumberOption.new(_INTL("Menu Frame"),_INTL("Type %d"),1,TextFrames.length,
       proc { $Settings.frame },
       proc {|value|  
          $Settings.frame=value
          MessageConfig.pbSetSystemFrame(TextFrames[value]) 
       },
       proc { _INTL("Menu frame {1}.",1+$Settings.frame) }
    ),
    EnumOption.new(_INTL("Field UI highlights"),[_INTL("On"),_INTL("Off")],
       proc { $Settings.field_effects_highlights},
       proc {|value|  $Settings.field_effects_highlights=value },
       "Shows boxes around move if boosted or decreased by field effect."
    ),
    EnumOption.new(_INTL("Battle Cursor"),[_INTL("Fight"),_INTL("Last Used")],
       proc { $Settings.remember_commands},
       proc {|value|  $Settings.remember_commands=value },
       "Sets default position of cursor in battle."
    ),
    EnumOption.new(_INTL("Backup"),[_INTL("On"),_INTL("Off")],
       proc { $Settings.backup },
       proc {|value|  $Settings.backup=value },
       "Preserves overwritten files on each save for later recovery."
    ),
    NumberOption.new(_INTL("Max Backup Number"),_INTL("Type %d"),1,101,
       proc { $Settings.maxBackup==999_999 ? 100 : $Settings.maxBackup },
       proc {|value| value == 100 ? $Settings.maxBackup=999_999 : $Settings.maxBackup=value }, #+1 
      "The maximum number of backup save files to keep. (101 is infinite)"
    ),
    EnumOption.new(_INTL("Screen Size"),[_INTL("S"),_INTL("M"),_INTL("L"),_INTL("XL"),_INTL("Full")],
       proc { $Settings.screensize },
       proc {|value|
          oldvalue=$Settings.screensize
          $Settings.screensize=value
          if value!=oldvalue
            pbSetResizeFactor($Settings.screensize)
          end
       }
    ),    
    EnumOption.new(_INTL("Screen Border"),[_INTL("Off"),_INTL("On")],
       proc { $Settings.border },
       proc {|value|
          oldvalue=$Settings.border
          $Settings.border=value
          if value!=oldvalue
            pbSetResizeFactor($Settings.screensize)
          end
       }
    )]
    OptionList.pop() if Desolation
  def pbUpdate
    pbUpdateSpriteHash(@sprites)
  end

  def pbStartScene
    @sprites={}
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @sprites["title"]=Window_UnformattedTextPokemon.newWithSize(
       _INTL("Options"),0,0,Graphics.width,64,@viewport)
    @sprites["textbox"]=Kernel.pbCreateMessageWindow
    @sprites["textbox"].letterbyletter=false
    #@sprites["textbox"].text=_INTL("Speech frame {1}.",1+$Settings.textskin)
    # These are the different options in the game.  To add an option, define a
    # setter and a getter for that option.  To delete an option, comment it out
    # or delete it.  The game's options may be placed in any order.
    # Gen 9 Mod - Baby Incense needed or not. Start
    utOpt1Gen9 = EnumOption.new(_INTL("Incense/Not"),[_INTL("Incense"),_INTL("NoIncense")],
      proc { $Settings.chooseBabyIncense},
      proc {|value|  $Settings.chooseBabyIncense=value },
      "Babies require incense or not."
    )
    # Gen 9 Mod - Baby Incense needed or not. End
    # Gen 9 Mod - Restore items after battle. Start
    utOpt2Gen9 = EnumOption.new(_INTL("Item Restore Gen 9"),[_INTL("Off"),_INTL("No Berries"),_INTL("All")],
      proc { $Settings.itemRestoreGen9},
      proc {|value|  $Settings.itemRestoreGen9=value },
      "Choses if the items will be restored after battle. Gen 9 is: No Berries."
    )
    # Gen 9 Mod - Restore items after battle. End
    if $game_switches && $game_switches[:Unreal_Time]
      utOpt1 = EnumOption.new(_INTL("Unreal Time"),[_INTL("Off"),_INTL("On")],
        proc { $Settings.unrealTimeDiverge},
        proc {|value|  $Settings.unrealTimeDiverge=value },
        "Uses in-game time instead of computer clock."
      )
      utOpt2 = EnumOption.new(_INTL("Show Clock"),[_INTL("Always"),_INTL("Menu"),_INTL("Gear")],
        proc { $Settings.unrealTimeClock},
        proc {|value|  $Settings.unrealTimeClock=value },
        "Shows an in-game clock that displays the current time."
      )
      utOpt3 = NumberOption.new(_INTL("Unreal Time Scale"),_INTL("Type %d"),1,60,
        proc { $Settings.unrealTimeTimeScale-1 },
        proc {|value|  $Settings.unrealTimeTimeScale=value+1 },
        "Sets the rate at which unreal time passes."
      )
      # Gen 9 Mod - Extra options on Options menu.
      unless OptionList.any? {|opt| opt.name == "Unreal Time" }
        OptionList.push(utOpt1)
        OptionList.push(utOpt2)
        OptionList.push(utOpt3)
        OptionList.push(utOpt1Gen9)
        OptionList.push(utOpt2Gen9)
      end
    else
      unless OptionList.any? {|opt| opt.name == "Gen 9 Mod Options" }
        OptionList.push(utOpt1Gen9)
        OptionList.push(utOpt2Gen9)
      end
    end
    # Gen 9 Mod - Extra options on Options menu. End
    @sprites["option"]=Window_PokemonOption.new(OptionList,0,
       @sprites["title"].height,Graphics.width,
       Graphics.height-@sprites["title"].height-@sprites["textbox"].height)
    @sprites["option"].viewport=@viewport
    @sprites["option"].visible=true
    # Get the values of each option
    for i in 0...OptionList.length
      @sprites["option"][i]=(OptionList[i].get || 0)
    end
    pbDeactivateWindows(@sprites)
    pbFadeInAndShow(@sprites) { pbUpdate }
  end

  def pbOptions
    pbActivateWindow(@sprites,"option"){
       loop do
         Graphics.update
         Input.update
         pbUpdate
         if @sprites["option"].mustUpdateOptions
           # Set the values of each option
           for i in 0...OptionList.length
             OptionList[i].set(@sprites["option"][i])
           end
           @sprites["textbox"].setSkin(MessageConfig.pbGetSpeechFrame())
           @sprites["textbox"].width=@sprites["textbox"].width  # Necessary evil
           pbSetSystemFont(@sprites["textbox"].contents)
           if @sprites["option"].options[@sprites["option"].index].description.is_a?(Proc)
            @sprites["textbox"].text=@sprites["option"].options[@sprites["option"].index].description.call
           else
            @sprites["textbox"].text=@sprites["option"].options[@sprites["option"].index].description
           end
         end
         if Input.trigger?(Input::B)
          saveClientData
           break
         end
         if Input.trigger?(Input::C) && @sprites["option"].index==OptionList.length
           break
         end
       end
    }
  end

  def pbEndScene
    pbFadeOutAndHide(@sprites) { pbUpdate }
    # Set the values of each option
    for i in 0...OptionList.length
      OptionList[i].set(@sprites["option"][i])
    end
    Kernel.pbDisposeMessageWindow(@sprites["textbox"])
    pbDisposeSpriteHash(@sprites)
    pbRefreshSceneMap
    @viewport.dispose
  end
end

$ResizeFactor=1.0
$ResizeFactorMul=100
$ResizeOffsetX=0 if !defined?($ResizeOffsetX)
$ResizeOffsetY=0 if !defined?($ResizeOffsetY)
$ResizeFactorSet=false if !defined?($ResizeFactorSet)
$HaveResizeBorder = false if !defined?($HaveResizeBorder)

def pbSetResizeFactor(factor)
  begin
    if factor < 0 || factor == 4
      setScreenBorder
      Graphics.resize_screen(DEFAULTSCREENWIDTH + 2*$ResizeOffsetX,DEFAULTSCREENHEIGHT+2*$ResizeOffsetY)
      setScreenBorderName("border")
      Graphics.fullscreen = true if !Graphics.fullscreen
      resizeSpritesAndViewports
    else
      setScreenBorder
      Graphics.resize_screen(DEFAULTSCREENWIDTH + 2*$ResizeOffsetX,DEFAULTSCREENHEIGHT+2*$ResizeOffsetY)
      Graphics.center
      setScreenBorderName("border")
      resizeSpritesAndViewports
      Graphics.fullscreen = false if Graphics.fullscreen
      Graphics.scale = [0.5,1,1.5,2.0][factor]
      Graphics.center
    end
  rescue
    factor = 2
    Graphics.fullscreen = false if Graphics.fullscreen
    Graphics.scale = [0.5,1,1.5,2.0][factor]
    Graphics.center
  end
end

def resizeSpritesAndViewports
  # Resize every sprite and viewport
  ObjectSpace.each_object(Sprite){|o|
    next if o.disposed?
    o.x=o.x
    o.y=o.y
    o.ox=o.ox
    o.oy=o.oy
    o.zoom_x=o.zoom_x
    o.zoom_y=o.zoom_y
  }
  ObjectSpace.each_object(Viewport){|o|
    next if o.disposed?
    begin
      o.rect=o.rect
      o.ox=o.ox
      o.oy=o.oy
    rescue RGSSError
    end
  }
end

def setScreenBorder
  $ResizeBorder=ScreenBorder.new if !$ResizeBorder || $ResizeBorder.sprite.disposed?
  $ResizeBorder.refresh
  border=$Settings.border
  $ResizeOffsetX=[0,BORDERWIDTH][border]
  $ResizeOffsetY=[0,BORDERHEIGHT][border]
end

def setScreenBorderName(border)
  $ResizeBorder=ScreenBorder.new
  $HaveResizeBorder=true
  $ResizeBorder.bordername=border
end

class ScreenBorder
  attr_accessor :sprite
  def initialize
    initializeInternal
    refresh
  end

  def initializeInternal
    @maximumZ=500000
    @bordername=""
    @sprite=IconSprite.new(0,0) rescue Sprite.new
    @defaultwidth=640
    @defaultheight=480
    @defaultbitmap=Bitmap.new(@defaultwidth,@defaultheight)
  end

  def dispose
    @borderbitmap.dispose if @borderbitmap
    @defaultbitmap.dispose
    @sprite.dispose
  end

  def adjustZ(z)
    if z>=@maximumZ
      @maximumZ=z+1
      @sprite.z=@maximumZ
    end
  end

  def bordername=(value)
    @bordername=value
    refresh
  end

  def refresh
    @sprite.z=@maximumZ
    @sprite.x=-BORDERWIDTH
    @sprite.y=-BORDERHEIGHT
    @sprite.visible=($Settings && $Settings.border==1)
    @sprite.bitmap=nil
    if @sprite.visible
      if @bordername!=nil && @bordername!=""
        setSpriteBitmap("Graphics/Pictures/"+@bordername)
      else
        setSpriteBitmap(nil)
        @sprite.bitmap=@defaultbitmap
      end
    end
    @defaultbitmap.clear
    @defaultbitmap.fill_rect(0,0,@defaultwidth,$ResizeOffsetY,Color.new(0,0,0))
    @defaultbitmap.fill_rect(0,$ResizeOffsetY,
       $ResizeOffsetX,@defaultheight-$ResizeOffsetY,Color.new(0,0,0))
    @defaultbitmap.fill_rect(@defaultwidth-$ResizeOffsetX,$ResizeOffsetY,
       $ResizeOffsetX,@defaultheight-$ResizeOffsetY,Color.new(0,0,0))
    @defaultbitmap.fill_rect($ResizeOffsetX,@defaultheight-$ResizeOffsetY,
       @defaultwidth-$ResizeOffsetX*2,$ResizeOffsetY,Color.new(0,0,0))
  end

  private

  def setSpriteBitmap(x)
    if (@sprite.is_a?(IconSprite) rescue false)
      @sprite.setBitmap(x)
    else
      @sprite.bitmap=x ? RPG::Cache.load_bitmap("",x) : nil
    end
  end
end

class PokemonOption
  def initialize(scene)
    @scene=scene
  end

  def pbStartScreen
    @scene.pbStartScene
    @scene.pbOptions
    @scene.pbEndScene
  end
end

###### MOD Gen 9 - Other Options Menu ######
module OtherOptionsPCList
  @@pclist=[]

  def self.registerOption(pc)
    @@pclist.push(pc)
  end

  def self.getCommandList()
    commands=[]
    for pc in @@pclist
      if pc.shouldShow?
        commands.push(pc.name)
      end
    end
    commands.push(_INTL("Go Back"))
    return commands
  end

  def self.callCommand(cmd)
    if cmd<0 || cmd>=@@pclist.length
      return false
    end
    i=0
    for pc in @@pclist
      if pc.shouldShow?
        if i==cmd
           pc.access()
           return true
        end
        i+=1
      end
    end
    return false
  end
end

###### MOD Gen 9 - Other Options Menu ######
class OtherOptions_PC_Menu
  def shouldShow?
    return true
  end

  def name
    return _INTL("Other Options")
  end

  def access
    loop do
      commands=OtherOptionsPCList.getCommandList()
      command=Kernel.pbMessage(_INTL("Choose the option."),
         commands,commands.length)
      if !OtherOptionsPCList.callCommand(command)
        break
      end
    end
  end
end

PokemonPCList.registerPC(OtherOptions_PC_Menu.new)
###### MOD Gen 9 - Other Options Menu ######

###### MOD Gen 9 - Other Options Menu ######
###### MOD Gen 9 - Other Options Menu - Hail or Snow ######
###### MOD ######
class HailOrSnowPC
  def shouldShow?
    return true
  end

  def name
    return _INTL("Choose Hail, Snow or Both")
  end

  def access
    choice=Kernel.pbMessage(
      _INTL('How would you like your hail/snowy weather? You will need to close and open the game for the changes to apply for in-battle messages & various texts to take effect. Currently: ' + HAILSNOWMOD + '.'),
      [
        _INTL('Hail'),
        _INTL('Snow'),
        _INTL('Both')
      ],
      3
    )
    hailOrSnow_Hail if choice == 0
    hailOrSnow_Snow if choice == 1
    hailOrSnow_Both if choice == 2
  end
end

OtherOptionsPCList.registerOption(HailOrSnowPC.new)


def hailOrSnow_Hail
  if HAILSNOWMOD == "Hail"
    Kernel.pbMessage(_INTL("You already have it set as " + HAILSNOWLOWMOD + "."))
  else
    if Kernel.pbConfirmMessage(_INTL("Vanilla Rejuvenation - Pre Generation 9 Hail. Damage to non-ice types each turn. Change?"))
      if Kernel.pbConfirmMessage(_INTL("Game will close after doing this. After opening it will compile and close again. Continue?"))
        if File.exist?("Data/Mods/HailOrSnowChoose.rb")
          File.delete("Data/Mods/HailOrSnowChoose.rb")
        end
        modfolder = "Data/Mods/"
        Dir.mkdir(modfolder) unless (File.exists?(modfolder))
        File.open("Data/Mods/HailOrSnowChoose.rb", "w"){|f| f.write('HAILSNOWMOD = "Hail"' + "\n")}
        File.open("Data/Mods/HailOrSnowChoose.rb", "a"){|f| f.write('HAILSNOWLOWMOD = "hail"' + "\n")}
        File.open("Data/Mods/HailOrSnowChoose.rb", "a"){|f| f.write('HAILSNOWNAMEMOD = "Hail"' + "\n")}
        File.open("Data/Mods/HailOrSnowChoose.rb", "a"){|f| f.write('HAILSNOWCOMPILED = false' + "\n")}
        scene=PokemonSaveScene.new
        screen=PokemonSave.new(scene)
        if screen.pbSaveScreen
          $scene=nil
          exit
        end
        $scene=nil
        exit
      end
    end
  end
end


def hailOrSnow_Snow
  if HAILSNOWMOD == "Snow"
    Kernel.pbMessage(_INTL("You already have it set as " + HAILSNOWLOWMOD + "."))
  else
    if Kernel.pbConfirmMessage(_INTL("Post Generation 9 Snowscape. Boosts defense for Ice-Types. Change?"))
      if Kernel.pbConfirmMessage(_INTL("Game will close after doing this. After opening it will compile and close again. Continue?"))
        if File.exist?("Data/Mods/HailOrSnowChoose.rb")
          File.delete("Data/Mods/HailOrSnowChoose.rb")
        end
        modfolder = "Data/Mods/"
        Dir.mkdir(modfolder) unless (File.exists?(modfolder))
        File.open("Data/Mods/HailOrSnowChoose.rb", "w"){|f| f.write('HAILSNOWMOD = "Snow"' + "\n")}
        File.open("Data/Mods/HailOrSnowChoose.rb", "a"){|f| f.write('HAILSNOWLOWMOD = "snow"' + "\n")}
        File.open("Data/Mods/HailOrSnowChoose.rb", "a"){|f| f.write('HAILSNOWNAMEMOD = "Snowscape"' + "\n")}
        File.open("Data/Mods/HailOrSnowChoose.rb", "a"){|f| f.write('HAILSNOWCOMPILED = false' + "\n")}
        scene=PokemonSaveScene.new
        screen=PokemonSave.new(scene)
        if screen.pbSaveScreen
          $scene=nil
          exit
        end
        $scene=nil
        exit
      end
    end
  end
end

def hailOrSnow_Both
  if HAILSNOWMOD == "Hail and snow"
    Kernel.pbMessage(_INTL("You already have it set as " + HAILSNOWLOWMOD + "."))
  else
    if Kernel.pbConfirmMessage(_INTL("Both Pre Gen 9 Hail and Post Gen 9 Snow together. Damage each turn to non-ice types. Ice-Types get defense boost. Change?"))
      if Kernel.pbConfirmMessage(_INTL("Game will close after doing this. After opening it will compile and close again. Continue?"))
        if File.exist?("Data/Mods/HailOrSnowChoose.rb")
          File.delete("Data/Mods/HailOrSnowChoose.rb")
        end
        modfolder = "Data/Mods/"
        Dir.mkdir(modfolder) unless (File.exists?(modfolder))
        File.open("Data/Mods/HailOrSnowChoose.rb", "w"){|f| f.write('HAILSNOWMOD = "Hail and snow"' + "\n")}
        File.open("Data/Mods/HailOrSnowChoose.rb", "a"){|f| f.write('HAILSNOWLOWMOD = "hail and snow"' + "\n")}
        File.open("Data/Mods/HailOrSnowChoose.rb", "a"){|f| f.write('HAILSNOWNAMEMOD = "Hailscape"' + "\n")}
        File.open("Data/Mods/HailOrSnowChoose.rb", "a"){|f| f.write('HAILSNOWCOMPILED = false' + "\n")}
        scene=PokemonSaveScene.new
        screen=PokemonSave.new(scene)
        if screen.pbSaveScreen
          $scene=nil
          exit
        end
        $scene=nil
        exit
      end
    end
  end
end


Events.onSpritesetCreate+=proc{
  if HAILSNOWCOMPILED == false || (GEN9MODVERSIONHAILSNOW != GEN9MODVERSION && HAILSNOWMOD != "Hail")
    compileMoves
    compileItems
    compileAbilities
    compileBosses
    compileFields
    File.open("Data/Mods/HailOrSnowChoose.rb", "a"){|f| f.write('HAILSNOWCOMPILED = true' + "\n")}
    File.open("Data/Mods/HailOrSnowChoose.rb", "a"){|f| f.write('GEN9MODVERSIONHAILSNOW = "' + GEN9MODVERSION + '"' "\n")}
    exit
  end
}
###### MOD Gen 9 - Other Options Menu - Hail Or Snow ######