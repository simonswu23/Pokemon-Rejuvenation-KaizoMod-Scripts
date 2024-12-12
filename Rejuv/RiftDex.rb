# Pulse Dex class. Based on xLed's Jukebox Scene class. 
class RiftDexScene
  #-----------------------------------------------------------------------------
  # * Object Initialization
  #     menu_index : command cursor's initial position
  #-----------------------------------------------------------------------------
  def initialize(menu_index = 0)
    @menu_index = menu_index
  end
  #-----------------------------------------------------------------------------
  # * Main Processing
  #-----------------------------------------------------------------------------
  def main
    fadein = true
    # Makes the text window
    @sprites={}
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @sprites["background"] = IconSprite.new(0,0)
    @sprites["background"].setBitmap("Graphics/Pictures/RiftDex/background")
    @sprites["background"].z=255
    @choices=[]
    for key in RIFTDATA.keys
      @choices.push($game_switches[key] ? RIFTDATA[key][:name] : "???")
    end
    @choices.push("Back")
    @sprites["header"]=Window_UnformattedTextPokemon.newWithSize(_INTL("Rift Dex"),
       2,-18,128,64,@viewport)
    @sprites["header"].baseColor=Color.new(248,248,248)
    @sprites["header"].shadowColor=Color.new(0,0,0)
    @sprites["header"].windowskin=nil
    @sprites["command_window"] = Window_CommandPokemonWhiteArrow.new(@choices,324)
    @sprites["command_window"].windowskin=nil
    @sprites["command_window"].baseColor=Color.new(248,248,248)
    @sprites["command_window"].shadowColor=Color.new(0,0,0)
    @sprites["command_window"].index = @menu_index
    @sprites["command_window"].height = 282
    @sprites["command_window"].width = 324
    @sprites["command_window"].x = 94
    @sprites["command_window"].y = 46
    @sprites["command_window"].z = 256    
#   @button=AnimatedBitmap.new("Graphics/Pictures/RiftDex/pokegearButton")
#   for i in 0...@choices.length
#     x=94
#     y=92 - (@choices.length*24) + (i*48)
#     @sprites["button#{i}"]=PokegearButton.new(x,y,@choices[i],i,@viewport)
#     @sprites["button#{i}"].selected=(i==@sprites["command_window"].index)
#     @sprites["button#{i}"].update
#   end
    # Execute transition
    Graphics.transition
    # Main loop
    loop do
      # Update game screen
      Graphics.update
      # Update input information
      Input.update
      # Frame update
      update
      # Abort loop if screen is changed
      if $scene != self
        break
      end
    end
    # Prepares for transition
    Graphics.freeze
    # Disposes the windows
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
  #-----------------------------------------------------------------------------
  # * Frame Update
  #-----------------------------------------------------------------------------  #-----------------------------------------------------------------------------
  def update
#    for i in 0...@sprites["command_window"].commands.length
#      sprite=@sprites["button#{i}"]
#      sprite.selected=(i==@sprites["command_window"].index) ? true : false
#    end
    pbUpdateSpriteHash(@sprites)
    #update command window and the info if it's active
    if @sprites["command_window"].active
      update_command
      return
    end
  end
    
  #-----------------------------------------------------------------------------
  # * Command controls
  #-----------------------------------------------------------------------------
  def update_command
    # If B button was pressed
    if Input.trigger?(Input::B)
      # Switch to map screen
      $scene = Scene_Pokegear.new
      return
    end
    # If C button was pressed
    if Input.trigger?(Input::C)
        index = @sprites["command_window"].index
        # Branch by command window cursor position
        if index == @choices.length - 1  
            # Switch to map screen
            $scene = Scene_Pokegear.new
            return
        else
            rift = RIFTDATA.keys[index]
            $scene = RiftDexInfoScene.new(rift,index) if $game_switches[rift] 
        end
        return
    end
  end

  
end
#-----------------------------------------------------------------------------
# * Determines which Rifts the trainer has data for
#-----------------------------------------------------------------------------
RIFTDATA = {
  :CodeDrifio => {
    :name => "Code: Drifio",
    :desc => "While suspended in air with its vine-like appendages, it is quite fast. It moves its vines to push and pull its body away from enemy attacks. When this being attacks, it moves similar to a yo-yo. It can pull off\ntricks as well. If it loses enough HP, it will\nlet go of the walls around it and turn itself into a wheel. In this form it becomes faster and reckless. It's unstoppable.",
    :blurb => "In its dormant state, it\nsuspends itself in the air;\nwaiting for its prey. It is quite agile and can stretch its vines to swiftly change position. Its movements are similar to that\nof a yo-yo.",
    :species => :FERROTHORN,
    :form => "Suspended Rift Form",
  },
  :CodeFeris => {
    :name => "Code: Feris",
    :desc => "Not much is known about this ominous being. Its body swings around like a\nMerry-go-round, but the orb located in the center is completely stationary. When it moves it creates a noise that is almost identical to wind chimes. This being has somewhat of a playful, but sad nature. It looks down at the ground occasionally and creates small and soft noises.",
    :blurb => "A being of pure fire and\nspectral energy. No one knows\nwhy this rift was created. Not even Zetta himself. It holds extreme regret over not being able to protect its trainer.",
    :species => :CHANDELURE,
    :form => "Rift Form",
  },
  :CodeEvo => {
    :name => "Code: Evo",
    :desc => "Gyarados, under the name Code: Evo is actually not a Gyarados at all, but a tiny school of Magikarp taken from the lake in Goldenwood Forest. It takes this form as\nit was not able to do it in their original lifetime. Despite its size, it's one of the weakest Rift Forms in existence. It is the grand example of size not meaning\neverything.",
    :blurb => "This being was created by Xen Admin Zetta, by draining the\nlife force of all Magikarp living in Goldenwood Forest. It lives\noff the regret of never\nevolving on its own.",
    :species => :GYARADOS,
    :form => "Rift Form",
  },
  :CodeMaterna => {
    :name => "Code: Materna",
    :desc => "It is unknown where Galvantula was from natively, as they are quite uncommon in the Aevium Region. One thing we do know is that\nit was the mother of many Joltik. When it\nwas forcibly transported into Amethyst\nCave, it was fueled with rage. It was killed before it could gather its children and\ntake them to safety. Whether they\nsurvived or not is unknown.",
    :blurb => "Fueled off rage caused by the\ngirl who sealed its fate, Galvantula's burning passion\nto protect its young lives on. Harming its children will anger\nit greatly.",
    :species => :GALVANTULA,
    :form => "Rift Form",
  },
  :CodeStatia => {
    :name => "Code: Statia",
    :desc => "Volcanion was found deep within the depths\nof Draconia's Den in the Badlands by Xen\nAdmin Madelis. Madelis was originally after\nits mother, but it fell in battle. She had no choice but to take its infant. Volcanion\nsat in anger as it churned the insides of Carotos until its muddy and damp nature\nwas no more. Leaving it craggy and melted.",
    :blurb => "Though it's quite large, it's actually an infant. Taken from\nits mother, it is filled with the sadness of never being able to see her again. It is completely\nand utterly stationary.",
    :species => :VOLCANION,
    :form => "Rift Form",
  },
  :CodeSarpa => {
    :name => "Code: Sarpa",
    :desc => "Mischievous, but has a strong sense of\nduty. Chosen by the Cursed Root to become\nTyluric Temple's protector, it embraces its role and staves off those with bad intentions... In this case, Flora. A theory about its dancing movements is that it\nmoves to the collective heartbeat of the Temple's inhabitants, but it's unknown if\nthis is true.",
    :blurb => "It acts as if it doesn't care about its change in form and\nthe new lack of eyes. It moves rythmically and bobs its head\nas if it were listening to music.",
    :species => :CARNIVINE,
    :form => "Rift Form",
  },
  :CodeCorroso => {
    :name => "Code: Corroso",
    :desc => "After it protected Melia, it fought Zetta\nand Code: Evo by itself. It was a close fight, but Zetta wouldn't have any of it. It was transformed into a Rift and cast into the ocean, where it swam alone for months. Its only motivation to keep on was to find out\nif Melia survived Zetta's attack. It wanted\nto make things right after it attacked\nMelia in the sewers.",
    :blurb => "Created as punishment by\nZetta for its interference, Garbodor roamed the land in search of its creator, Melia, to ensure that its efforts were valued and not in vain.",
    :species => :GARBODOR,
    :form => "Rift Form",
  },
  :CodeBella => {
    :name => "Code: Bella",
    :desc => "Taken hold by an ancient Garufan curse, Aelita became a beast like no other. With\nher newfound power, Aelita becomes more powerful the more she's knocked down. Perhaps this is reflective of her stubborn nature? Is her motivation fueled off\ndesires locked away deep down inside? Regardless, she must be saved from herself\nor she will live in regret forever.",
    :blurb => "The incarnation of the curse placed on Aelita and the\nburden that Vivian and Taelia shared. She won't stop until\nher perfect world is complete.\nA world without anyone.",
    :species => :REGIROCK,
    :form => "Rift Form",
  },
  :CodeAngelus => {
    :name => "Code: Angelus",
    :desc => "",
    :blurb => "<fs=24>Born from the power of Master Indriad, Gardevoir serves his order with no\nhesitation. Having her DNA morph with\nGallade, Gardevoir obtained massive power\nthat even she cannot control. With her\nability, Execution, she can lay waste to\nweakened enemies and become victorious.</fs>",
    :species => :GARDEVOIR,
    :form => "Angel of Death",
  },
  :CodeGarna => {
    :name => "Code: Garna",
    :desc => "Gloria was found inside a Pokeball deep underground. One can only assume that it\nwas owned by someone before the Calamity. Flora regrettably modified Gloria with Rift Matter, forcing Gloria to obtain the ability Accumulation. With this ability, Gloria\nalways has three stacks of Stockpile. The sand from its body seem spew out endlessly, creating a never ending sandstorm.",
    :blurb => "Long thought to be lost to the calamity, this rift has bided\nits time within the depths of\nZone Zero. Flora regrettably\nused its power to ward people\naway from Zone Zero.",
    :species => :HIPPOWDON,
    :form => "Rift Form",
  },
  :CodeRembrence => {
    :name => "Code: Rembrence",
    :desc => "Dufaux's electric currents allows it to\nmess with time. Because of this temporal shift, it will send attacks into the future. Celesia's doll and the essence of her\nRotom, Light, have manifested together\ninto this putrid beast. Dufaux's only motivation is revenge, and revenge, it will\nget.",
    :blurb => "The lost soul of Narcissa's forgotten dead sister,\nCelesia, rose from her untimely grave during the Calamity. Now\nshe roams the earth in order to get revenge on the family that forgot her.",
    :species => :FROSLASS,
    :form => "Rift Form",
  },
  :Code1 => {
    :name => "???",
    :desc => "",
    :blurb => "",
    :species => :NOIVERN,
    :form => "Rift Form",
  },
  :Code2 => {
    :name => "???",
    :desc => "",
    :blurb => "",
    :species => :MAGNEZONE,
    :form => "Rift Form",
  },
}

# Class for information screen

class RiftDexInfoScene
  attr_accessor :index
  attr_accessor :rift
  #CONSTANTS
    STATBARLEFT = 363
    STATBARTOP = 138
    STATBARHEIGHT = 14
    STATBAROFFSET = 38
    STATBARWIDTH = 127

    TYPEBOX = [20,88]

    ABILY = 70
  #
  
  def initialize(rift, index)
    @rift           = rift
    @index          = index
  end
  
  def createRiftPage
    riftobj = RIFTDATA[@rift]
    @species = $cache.pkmn[riftobj[:species]]
    form = riftobj[:form]
    @sprites["overlay"]=BitmapSprite.new(Graphics.width,Graphics.height,@viewport)
    pbSetSystemFont(@sprites["overlay"].bitmap)
    @sprites["overlay"].x=0
    @sprites["overlay"].y=0
    @sprites["overlay"].visible=true
    @sprites["overlay"].bitmap.clear
    #@sprites["mon"] = IconSprite.new(0,0,@viewport)
    stats = @species.formData.dig(form,:BaseStats)
    stats = @species.BaseStats if !stats
    max = stats.max
    for i in 0..5
      width = ((stats[i] / max.to_f) * STATBARWIDTH).floor
      statbitmap = BitmapWrapper.new(STATBARWIDTH,STATBARHEIGHT)
      statbitmap.fill_rect(statbitmap.rect,Color.new(59,59,59))
      color = Color.new(0,220,30)
      color = Color.new(220,160,0) if stats[i] < 102
      color = Color.new(190,10,10) if stats[i] < 51
      color = Color.new(150,0,110) if stats[i] == max
      statrect = statbitmap.rect
      statrect.width = width
      statbitmap.fill_rect(statrect,color)
      @sprites["overlay"].bitmap.blt(STATBARLEFT,STATBARTOP + STATBAROFFSET * i,statbitmap,statbitmap.rect)
    end

    type1 = @species.formData.dig(form, :Type1)
    type1 = @species.Type1 if !type1
    type2 = @species.formData.dig(form, :Type2)
    type2 = @species.Type2 if !type2
    type2 = :QMARKS if @rift == :CodeFeris
    type1bitmap = AnimatedBitmap.new("Graphics/Icons/type#{type1.to_s}")
    @sprites["overlay"].bitmap.blt(20,88,type1bitmap.bitmap,Rect.new(0,0,64,28))
    type1bitmap.dispose

    if type2 != nil
      type2bitmap = AnimatedBitmap.new("Graphics/Icons/type#{type2.to_s}")
      @sprites["overlay"].bitmap.blt(88,88,type2bitmap.bitmap,Rect.new(0,0,64,28))
      type2bitmap.dispose
    end

    abil = @species.formData.dig(form, :Abilities)[0]
    if @sprites["abil"]
        @sprites["abil"].setText("")
    end
    @sprites["abil"] = RiftNoteWindow.new("Ability - #{getAbilityName(abil)}",0)
    @sprites["abil"].windowskin=nil
    @sprites["abil"].baseColor=Color.new(248,248,248)
    @sprites["abil"].shadowColor=Color.new(0,0,0)
    @sprites["abil"].setHW_XYZ(80, 500, TYPEBOX[0] + 64 + 8 + 49 + 16, ABILY, 256)

    if @sprites["desc"]
        @sprites["desc"].setText("")
    end
    blurb = riftobj[:blurb]
    blurb = "<fs=32>" + blurb + "</fs>" if blurb[0]!="<"
    @sprites["desc"] = RiftNoteWindow.new(blurb,0)
    @sprites["desc"].windowskin=nil
    @sprites["desc"].baseColor=Color.new(248,248,248)
    @sprites["desc"].shadowColor=Color.new(0,0,0)
    @sprites["desc"].setHW_XYZ(280, 320, 8, 114, 256)
  end

  def main
    fadein = true
    # Makes the text window
    @sprites={}
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @sprites["background"] = IconSprite.new(0,0)
    @sprites["background"].setBitmap("Graphics/Pictures/RiftDex/#{@rift.to_s}")
    @sprites["background"].z=254
    createRiftPage
    # Execute transition
    Graphics.transition
    # Main loop
    loop do
      # Update game screen
      Graphics.update
      # Update input information
      Input.update
      # Frame update
      update
      # Abort loop if screen is changed
      if $scene != self
        # Prepares for transition
        Graphics.freeze
        # Disposes the windows
        pbDisposeSpriteHash(@sprites)
        @viewport.dispose
        break
      end
    end
  end
  
  def update
    pbUpdateSpriteHash(@sprites)
    update_command
  end  

  def update_command
    # If B button was pressed
    if Input.trigger?(Input::RIGHT) || Input.trigger?(Input::LEFT)
        return if !$game_switches[:RiftNotes]
        $scene = RiftDexNotesScene.new(@rift, @index)
        return
    end

    if Input.trigger?(Input::DOWN)
        @index += 1
        if @index > RIFTDATA.length - 1
            @index = 0
        end
        while !$game_switches[RIFTDATA.keys[@index]]
            @index += 1
            if @index > RIFTDATA.length - 1
                @index = 0
            end
        end
        @rift = RIFTDATA.keys[@index]
        @sprites["background"].setBitmap("Graphics/Pictures/RiftDex/#{@rift.to_s}")
        createRiftPage
    end

    if Input.trigger?(Input::UP)
        @index -= 1
        if @index < 0
            @index = RIFTDATA.length - 1
        end
        while !$game_switches[RIFTDATA.keys[@index]]
            @index -= 1
            if @index < 0
                @index = RIFTDATA.length - 1
            end
        end
        @rift = RIFTDATA.keys[@index]
        @sprites["background"].setBitmap("Graphics/Pictures/RiftDex/#{@rift.to_s}")
        createRiftPage
    end

    if Input.trigger?(Input::B)
      # Switch to map screen
      $scene = RiftDexScene.new(@index)
      return
    end  
  end
  
end

class RiftDexNotesScene
  attr_accessor :index
  attr_accessor :rift
  
  def initialize(rift, index)
    @rift           = rift
    @index          = index
  end
  
  def main
    fadein = true
    # Makes the text window
    @sprites={}
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @rift = RIFTDATA.keys[@index]
    @sprites["background"] = IconSprite.new(0,0)
    @sprites["background"].setBitmap("Graphics/Pictures/RiftDex/riftnotesbackground")
    @sprites["background"].setBitmap("Graphics/Pictures/RiftDex/#{@rift.to_s}Notes") if @rift == :CodeAngelus
    @sprites["background"].z=254
    @sprites["command_window"] = RiftNoteWindow.new(RIFTDATA[@rift][:desc],0)
    @sprites["command_window"].windowskin=nil
    @sprites["command_window"].baseColor=Color.new(248,248,248)
    @sprites["command_window"].shadowColor=Color.new(0,0,0)
    @sprites["command_window"].setHW_XYZ(320, 462, 24, 33, 256)
    # Execute transition
    Graphics.transition
    # Main loop
    loop do
      # Update game screen
      Graphics.update
      # Update input information
      Input.update
      # Frame update
      update
      # Abort loop if screen is changed
      if $scene != self
        # Prepares for transition
        Graphics.freeze
        # Disposes the windows
        pbDisposeSpriteHash(@sprites)
        @viewport.dispose
        break
      end
    end
  end
  
  def update
    pbUpdateSpriteHash(@sprites)
    update_command
  end  

  def update_command
    if Input.trigger?(Input::RIGHT) || Input.trigger?(Input::LEFT)
        $scene = RiftDexInfoScene.new(@rift, @index)
        return
    end

    if Input.trigger?(Input::DOWN)
        @index += 1
        if @index > RIFTDATA.length - 1
            @index = 0
        end
        while !$game_switches[RIFTDATA.keys[@index]]
            @index += 1
            if @index > RIFTDATA.length - 1
                @index = 0
            end
        end
        @rift = RIFTDATA.keys[@index]
        if @rift == :CodeAngelus
            @sprites["background"].setBitmap("Graphics/Pictures/RiftDex/#{@rift.to_s}Notes")
        else
            @sprites["background"].setBitmap("Graphics/Pictures/RiftDex/riftnotesbackground")
        end
        @sprites["command_window"].setText(RIFTDATA[@rift][:desc])
    end

    if Input.trigger?(Input::UP)
        @index -= 1
        if @index < 0
            @index = RIFTDATA.length - 1
        end
        while !$game_switches[RIFTDATA.keys[@index]]
            @index -= 1
            if @index < 0
                @index = RIFTDATA.length - 1
            end
        end
        @rift = RIFTDATA.keys[@index]
        if @rift == :CodeAngelus
            @sprites["background"].setBitmap("Graphics/Pictures/RiftDex/#{@rift.to_s}Notes")
        else
            @sprites["background"].setBitmap("Graphics/Pictures/RiftDex/riftnotesbackground")
        end
        @sprites["command_window"].setText(RIFTDATA[@rift][:desc])
    end

    if Input.trigger?(Input::B)
      # Switch to map screen
      $scene = RiftDexScene.new(@index)
      return
    end  
  end
end


class RiftNoteWindow < Window_AdvancedCommandPokemon
  attr_accessor :text
  attr_accessor :linespacing

  def initialize(text,width,linespacing = 32)
    @text=text
    @linespacing = 32
    super([text],width)
  end

  def setText(text)
    @text = text
    refresh
  end

  def drawItem
    pbSetSystemFont(self.contents)
      chars=getFormattedText(self.contents,0,0,self.width,self.height,@text,@linespacing)
      drawFormattedChars(self.contents,chars)
  end

  def refresh
    dwidth=self.width
    dheight=self.height
    self.contents=pbDoEnsureBitmap(self.contents,dwidth,dheight)
    self.contents.clear
    drawItem
  end
end