#Suplemtary Script that edits and adds to classes in Battle_Scene

class FightMenuButtons < BitmapSprite
  def pbFieldNotesBattle(move)
    return 0 if $Settings.field_effects_highlights==1
    return 0 if !move.battle.field.isFieldEffect?
    battle = move.battle
    return 1 if battle.field.statusMoves && battle.field.statusMoves.include?(move.move)
    typeBoost = 1; moveBoost=1
    attacker = battle.battlers.find { |battler| battler.moves.include?(move) || (battler.zmoves && battler.zmoves.include?(move)) }
    opponent = attacker.pbOppositeOpposing
    movetype = move.pbType(attacker)
    if move.basedamage > 0 && !((0x6A..0x73).include?(move.function) || [0xD4,0xE1].include?(move.function))
      typeBoost = move.typeFieldBoost(movetype,attacker,opponent)
      moveBoost = move.moveFieldBoost
      moveBoost = 1.5 if move.isSoundBased? && move.basedamage > 0 && [:CAVE,:BIGTOP,:CONCERT1,:CONCERT2,:CONCERT3,:CONCERT4].include?(battle.FE)
    end
    moveBoost = 1.5 if move.move == :SONICBOOM && battle.FE == :RAINBOW
    # Failing moves
    case battle.FE
    when :UNDERWATER
      moveBoost = 0 if [:ELECTRICTERRAIN, :GRASSYTERRAIN, :MISTYTERRAIN, :PSYCHICTERRAIN, :MIST].include?(move.move)
      moveBoost = 0 if [:RAINDANCE, :SUNNYDAY, :HAIL, :SANDSTORM].include?(move.move)
    when :NEWWORLD
      moveBoost = 0 if [:ELECTRICTERRAIN, :GRASSYTERRAIN, :MISTYTERRAIN, :PSYCHICTERRAIN, :MIST].include?(move.move)
      moveBoost = 0 if [:RAINDANCE, :SUNNYDAY, :HAIL, :SANDSTORM].include?(move.move)
    when :ELECTERRAIN
      moveBoost = 0 if move.move == :FOCUSPUNCH
    when :CAVE
      moveBoost = 0 if move.move == :SKYDROP
    end
    totalboost = typeBoost*moveBoost
    if totalboost > 1
      return 1
    elsif totalboost < 1
      return 2
    end

    return 0
  end
end

class PokeballPlayerSendOutAnimation
  #  Ball curve: 8,52; 22,44; 52, 96
  #  Player: Color.new(16*8,23*8,30*8)
    SPRITESTEPS=10
    STARTZOOM=0.125
  
    def initialize(sprite,spritehash,pkmn,doublebattle,illusionpoke,battle)
      @disposed=false
      @PokemonBattlerSprite=sprite
      @pkmn=pkmn
      @PokemonBattlerSprite.visible=false
      @PokemonBattlerSprite.tone=Tone.new(248,248,248,248)
      @spritehash=spritehash
      playerpos = battle.sosbattle==3 ? [PBScene::PLAYERBATTLER_X,PBScene::PLAYERBATTLER_Y] : [PBScene::PLAYERBATTLERD1_X,PBScene::PLAYERBATTLERD1_Y]
      if doublebattle
        @spritex=playerpos[0] if pkmn.index==0
        @spritex=PBScene::PLAYERBATTLERD2_X if pkmn.index==2
      else
        @spritex=PBScene::PLAYERBATTLER_X
      end
      @spritey=0
      @illusionpoke = illusionpoke
      if illusionpoke != nil
        @endspritey=adjustBattleSpriteY(sprite,illusionpoke.species,illusionpoke.form,pkmn.index)
      else
        @endspritey=adjustBattleSpriteY(sprite,pkmn.species,pkmn.form,pkmn.index)
      end
      if doublebattle
        @spritey+=playerpos[1] if pkmn.index==0
        @spritey+=PBScene::PLAYERBATTLERD2_Y if pkmn.index==2
        @endspritey+=playerpos[1] if pkmn.index==0
        @endspritey+=PBScene::PLAYERBATTLERD2_Y if pkmn.index==2
      else
        @spritey+=PBScene::PLAYERBATTLER_Y
        @endspritey+=PBScene::PLAYERBATTLER_Y
      end
      @animdone=false
      @frame=0
    end
end

class PokemonDataBox < SpriteWrapper
  attr_accessor   :doublebattle
  def initialize(battler,doublebattle,viewport=nil,battle)
    super(viewport)
    @explevel=0
    @battler=battler
    @battle = battle
    @selected=0
    @frame=0
    @showhp=false
    @showexp=false
    @appearing=false
    @animatingHP=false
    @animatingScale=0 # add this line
    @starthp=0
    @currenthp=0
    @endhp=0
    @expflash=0
    @doublebattle=doublebattle
    if (@battler.index&1)==0 # if player's Pokémon
      @spritebaseX=34
    else
      @spritebaseX=16
    end
    @spritebaseY=0
    if doublebattle
      case @battler.index
        when 0
          @databox=AnimatedBitmap.new("Graphics/Pictures/Battle/battlePlayerBoxD")
          @spriteX=PBScene::PLAYERBOXD1_X
          @spriteY=PBScene::PLAYERBOXD1_Y
        when 1 
          if @battler.issossmon
            @databox=AnimatedBitmap.new("Graphics/Pictures/Battle/boss_bar_sos")
            @spriteX=PBScene::FOEBOXD1_X-12
            @spriteY=PBScene::FOEBOXD1_Y-23
          else
            @databox=AnimatedBitmap.new("Graphics/Pictures/Battle/battleFoeBoxD")
            @spriteX=PBScene::FOEBOXD1_X
            @spriteY=PBScene::FOEBOXD1_Y
          end
        when 2 
          @databox=AnimatedBitmap.new("Graphics/Pictures/Battle/battlePlayerBoxD")
          @spriteX=PBScene::PLAYERBOXD2_X
          @spriteY=PBScene::PLAYERBOXD2_Y
        when 3 
          if @battler.issossmon
            @databox=AnimatedBitmap.new("Graphics/Pictures/Battle/boss_bar_sos")
            @spriteX=PBScene::FOEBOXD2_X+8
            @spriteY= PBScene::FOEBOXD2_Y+23
          else
            @databox=AnimatedBitmap.new("Graphics/Pictures/Battle/battleFoeBoxD")
            @spriteX=PBScene::FOEBOXD2_X+4
            @spriteY=PBScene::FOEBOXD2_Y 
          end
      end
    else
      case @battler.index
        when 0
          @databox=AnimatedBitmap.new("Graphics/Pictures/Battle/battlePlayerBoxS")
          @spriteX=PBScene::PLAYERBOX_X
          @spriteY=PBScene::PLAYERBOX_Y
          @showhp=true
          @showexp=true
        when 1 
          @databox=AnimatedBitmap.new("Graphics/Pictures/Battle/battleFoeBoxS")
          @spriteX=PBScene::FOEBOX_X+4
          @spriteY=PBScene::FOEBOX_Y
      end
    end
    @contents=BitmapWrapper.new(@databox.width,@databox.height)
    self.bitmap=@contents
    self.visible=false
    self.z=50
    refreshExpLevel
    refresh
  end

  #### StatBoosts - START
  def aGetStage(i)
    if i == 3
      return -6 if @battler.pbOpposingSide.effects[:LuckyChant] > 0
      return 6 if @battler.effects[:LaserFocus]
      return @battler.effects[:FocusEnergy]
    else
      case i
        when 0
          stat = PBStats::SPATK
        when 1
          stat = PBStats::SPDEF
        when 2
          stat = PBStats::SPEED
        when 4
          stat = PBStats::ATTACK
        when 5
          stat = PBStats::DEFENSE
        when 6
          stat = PBStats::EVASION
        when 7
          stat = PBStats::ACCURACY
      end
      
      return @battler.stages[stat]
    end
  end
  
  def aShowStatBoosts
    #Init
    bIsFoe = ((@battler.index == 1) || (@battler.index == 3))
    
    if defined?(@aStatBoostsG) && defined?(@aStatBoostsN) && defined?(@aStatBoostsL)
      #Build bitmap
      aBitmap = Bitmap.new(83, 50)
      
      for i in 0...8
        iStage = aGetStage(i)
        
        if bIsFoe
          iOffsetX = 2
        else
          iOffsetX = 0
        end
        
        if i < 4
          iCol = 21+iOffsetX
          iRow = i
        else
          iCol = 31+iOffsetX
          iRow = i-4
        end
        
        if iStage == 0
          aBitmap.blt(0, 0, @aStatBoostsN[i], aBitmap.rect)
        elsif iStage > 0
          iNum = iStage-1
          aBitmap.blt(0, 0, @aStatBoostsG[i], aBitmap.rect)
          aBitmap.blt(iCol, 4+12*iRow, @aStatBoostsNumG[iNum], @aStatBoostsNumG[iNum].rect)
        elsif iStage < 0
          iNum = -iStage-1
          aBitmap.blt(0, 0, @aStatBoostsL[i], aBitmap.rect)
          aBitmap.blt(iCol, 4+12*iRow, @aStatBoostsNumL[iNum], @aStatBoostsNumL[iNum].rect)
        end
      end
      
      #Draw tab
      if self.bitmap.width == 260
        if !bIsFoe && false
          #Adding to the left is more difficult
          aTemp = Bitmap.new(@databox.bitmap.width+56-@spritebaseX, @databox.bitmap.height)
          iDiff = aTemp.width-@databox.bitmap.width
          
          @spritebaseX = @spritebaseX+iDiff
          @spriteX = @spriteX-iDiff
          aTemp.blt(iDiff, 0, @databox.bitmap, @databox.bitmap.rect)
          
          @databox.aSetBitmap(aTemp)
        end
        
        aTemp = Bitmap.new(@spritebaseX+228+56, self.bitmap.height)
        aTemp.blt(0, 0, self.bitmap, self.bitmap.rect)
        
        self.bitmap = aTemp
      else
        if bIsFoe
          self.bitmap.blt(@spritebaseX+228, 0, aBitmap, aBitmap.rect)
        else
          self.bitmap.blt(@spritebaseX-56, 0, aBitmap, aBitmap.rect)
        end
      end
    else
      if (!bIsFoe) && (@databox.bitmap.width == 260)
        #Adding to the left is more difficult
        aTemp = Bitmap.new(@databox.bitmap.width+56-@spritebaseX, @databox.bitmap.height, -1)
        iDiff = aTemp.width-@databox.bitmap.width
        
        @spritebaseX = @spritebaseX+iDiff
        @spriteX = @spriteX-iDiff
        aTemp.blt(iDiff, 0, @databox.bitmap, @databox.bitmap.rect)
        
        @databox.aSetBitmap(aTemp)
      end
      
      aInitStatsTab(bIsFoe)
    end
  end
  
  def aInitStatsTab(bIsFoe)
    aBitmap = AnimatedBitmap.new(_INTL("Graphics/Pictures/Battle/ShowStatBoosts"))
    
    #Constants
    iWidth_Full = 56
    iHeight_Full = 50
    
    iLeft1 = 0
    iLeft2P = 27
    iLeft2F = 29
    
    iRow_Dist = 12
    iRow_Height = 14
    
    iCol_WidthL = 31
    iCol_WidthR = 27
    iCol_WidthP = 29
    
    iBorder = 2
    
    iLeft_NF1 = 0
    iLeft_LF1 = iWidth_Full+iLeft_NF1
    iLeft_GF1 = iWidth_Full+iLeft_LF1
    iLeft_NF2 = iLeft_NF1+iCol_WidthL-iBorder
    iLeft_LF2 = iWidth_Full+iLeft_NF2
    iLeft_GF2 = iWidth_Full+iLeft_LF2
    
    iLeft_NP1 = 2
    iLeft_LP1 = iWidth_Full+iLeft_NP1
    iLeft_GP1 = iWidth_Full+iLeft_LP1
    iLeft_NP2 = iLeft_NP1+iCol_WidthP-iBorder
    iLeft_LP2 = iWidth_Full+iLeft_NP2
    iLeft_GP2 = iWidth_Full+iLeft_LP2
    
    #Get bitmaps
    @aStatBoostsG = [] #Greater
    @aStatBoostsN = [] #None
    @aStatBoostsL = [] #Lower
    for i in 0...8
      @aStatBoostsG[i] = Bitmap.new(iWidth_Full, iHeight_Full)
      @aStatBoostsN[i] = Bitmap.new(iWidth_Full, iHeight_Full)
      @aStatBoostsL[i] = Bitmap.new(iWidth_Full, iHeight_Full)
    end
    
    @aStatBoostsNumG = []
    @aStatBoostsNumL = []
    
    for i in 0...4
      i2 = 4+i #Right half of the tab
      
      iHL = i*12
      iHL2 = iHL+iHeight_Full
      
      if bIsFoe
        aRect = Rect.new(iLeft_GF1, iHL, iCol_WidthL, iRow_Height)
        @aStatBoostsG[i].blt(iLeft1, iHL, aBitmap.bitmap, aRect)
        
        aRect = Rect.new(iLeft_NF1, iHL, iCol_WidthL, iRow_Height)
        @aStatBoostsN[i].blt(iLeft1, iHL, aBitmap.bitmap, aRect)
        
        aRect = Rect.new(iLeft_LF1 , iHL, iCol_WidthL, iRow_Height)
        @aStatBoostsL[i].blt(iLeft1, iHL, aBitmap.bitmap, aRect)
        
        aRect = Rect.new(iLeft_GF2, iHL, iCol_WidthR, iRow_Height)
        @aStatBoostsG[i2].blt(iLeft2F, iHL, aBitmap.bitmap, aRect)
        
        aRect = Rect.new(iLeft_NF2, iHL, iCol_WidthR, iRow_Height)
        @aStatBoostsN[i2].blt(iLeft2F, iHL, aBitmap.bitmap, aRect)
        
        aRect = Rect.new(iLeft_LF2, iHL, iCol_WidthR, iRow_Height)
        @aStatBoostsL[i2].blt(iLeft2F, iHL, aBitmap.bitmap, aRect)
      else
        aRect = Rect.new(iLeft_GP1, iHL2, iCol_WidthP, iRow_Height)
        @aStatBoostsG[i].blt(iLeft1, iHL, aBitmap.bitmap, aRect)
        
        aRect = Rect.new(iLeft_NP1, iHL2, iCol_WidthP, iRow_Height)
        @aStatBoostsN[i].blt(iLeft1, iHL, aBitmap.bitmap, aRect)
        
        aRect = Rect.new(iLeft_LP1, iHL2, iCol_WidthP, iRow_Height)
        @aStatBoostsL[i].blt(iLeft1, iHL, aBitmap.bitmap, aRect)
        
        aRect = Rect.new(iLeft_GP2, iHL2, iCol_WidthP, iRow_Height)
        @aStatBoostsG[i2].blt(iLeft2P, iHL, aBitmap.bitmap, aRect)
        
        aRect = Rect.new(iLeft_NP2, iHL2, iCol_WidthP, iRow_Height)
        @aStatBoostsN[i2].blt(iLeft2P, iHL, aBitmap.bitmap, aRect)
        
        aRect = Rect.new(iLeft_LP2, iHL2, iCol_WidthP, iRow_Height)
        @aStatBoostsL[i2].blt(iLeft2P, iHL, aBitmap.bitmap, aRect)
      end
    end
    for i in 0...6
      @aStatBoostsNumG[i] = Bitmap.new(4, 6)
      aRect = Rect.new(172, 1+(i*7), 4, 6)
      @aStatBoostsNumG[i].blt(0, 0, aBitmap.bitmap, aRect)
      
      @aStatBoostsNumL[i] = Bitmap.new(4, 6)
      aRect = Rect.new(168, 1+(i*7), 4, 6)
      @aStatBoostsNumL[i].blt(0, 0, aBitmap.bitmap, aRect)
    end
  end
  #### StatBoosts - END
  
  def battlerStatus(battler)
    case battler.status
      when :SLEEP  
        return "SLP"  
      when :FROZEN 
        return "FRZ"  
      when :BURN 
        return "BRN"  
      when :POISON 
        return "PSN"  
      when :PARALYSIS  
        return "PAR" 
      when :PETRIFIED
        return "PTR"
    end 
    return "" 
  end 

  def refresh
    self.bitmap.clear
    return if !@battler.pokemon
    bIsFoe = ((@battler.index == 1) || (@battler.index == 3))
    filename = @battler.issossmon && (battler.index != 2) ? "Graphics/Pictures/Battle/" : "Graphics/Pictures/Battle/battle" 
    if @doublebattle  
      case @battler.index % 2 
        when 0  
          if @battler.issossmon
            filename += "PlayerBoxSOS"  
          else
            filename += "PlayerBoxD"  
          end
        when 1  
          if @battler.issossmon
            filename += "boss_bar_sos" 
          else
            filename += "FoeBoxD"  
          end
      end       
    else  
      case @battler.index 
        when 0  
          filename += "PlayerBoxS"  
        when 1  
          filename += "FoeBoxS" 
      end 
    end
    filename += battlerStatus(@battler) if !@battler.issossmon || (@battler.issossmon && @battler.index==2)
    @databox=AnimatedBitmap.new(filename)

    self.bitmap.blt(0,0,@databox.bitmap,Rect.new(0,0,@databox.width,@databox.height))
    if @doublebattle  
      if !@battler.issossmon || (battler.issossmon && battler.index == 2)
        @hpbar = AnimatedBitmap.new("Graphics/Pictures/Battle/hpbardoubles")
      else
        @hpbar = AnimatedBitmap.new("Graphics/Pictures/Battle/hpbarsos")
      end
      hpbarconstant=PBScene::HPGAUGEHEIGHTD
    else
      @hpbar = AnimatedBitmap.new("Graphics/Pictures/Battle/hpbar")
      hpbarconstant=PBScene::HPGAUGEHEIGHTS
    end
    base=PBScene::BOXBASE
    shadow=PBScene::BOXSHADOW
    headerY = 18
    sbX = @spritebaseX 
    if bIsFoe
      headerY += 4
      sbX -= 12
    end
    if @doublebattle
      headerY -= 12
      sbX += 6

      if bIsFoe
        headerY -= 4
        sbX += 2
      end
    end

    # Pokemon Name
    pokename=@battler.name
    if @battler.issossmon && !(@battler.index == 2)
      pbSetSmallFont(self.bitmap)
      nameposition=sbX+4
    else
      pbSetSystemFont(self.bitmap)
      nameposition=sbX+8
    end

    textpos=[
       [pokename,nameposition,headerY,false,base,shadow]
    ]
    if !@battler.issossmon  || (@battler.issossmon && @battler.index == 2)
      genderX=self.bitmap.text_size(pokename).width
      genderX+=sbX+14
      if genderX > 165 && !@doublebattle && (@battler.index&1)==1 #opposing pokemon
        genderX = 224
      end
      gendertarget = @battler.effects[:Illusion] ? @battler.effects[:Illusion] : @battler
      if gendertarget.gender==0 # Male
        textpos.push([_INTL("♂"),genderX,headerY,false,Color.new(48,96,216),shadow])
      elsif gendertarget.gender==1 # Female
        textpos.push([_INTL("♀"),genderX,headerY,false,Color.new(248,88,40),shadow])
      end
    end
    pbDrawTextPositions(self.bitmap,textpos)
    pbSetSmallFont(self.bitmap)
    # Level
    hpShiftX = 202
    if bIsFoe
      hpShiftX -= 4
    end
    textpos=[[_INTL("Lv{1}",$game_switches[1306] && (@battler.index%2)==1 ? "???" : @battler.level),sbX+hpShiftX,headerY+8,true,base,shadow]]
    textpos=[] if @battler.issossmon
    # HP Numbers
    if @showhp
      hpstring=_ISPRINTF("{1: 2d}/{2: 2d}",self.hp,@battler.totalhp)
      textpos.push([hpstring,sbX+202,78,true,base,shadow])
    end
    pbDrawTextPositions(self.bitmap,textpos)
    # Shiny
    imagepos=[]
    if (@battler.pokemon.isShiny? && @battler.effects[:Illusion].nil?) || (!@battler.effects[:Illusion].nil? && @battler.effects[:Illusion].pokemon.isShiny?)
      shinyX=202
      shinyX=-16 if (@battler.index&1)==0 # If player's Pokémon
      shinyY=24
      shinyY=12 if @doublebattle
      if (@battler.index&1)==1 && !@doublebattle
        shinyY+=4
      end
      imagepos.push(["Graphics/Pictures/shiny.png",sbX+shinyX,shinyY,0,0,-1,-2])
    end
    # Mega
    megaY=52
    megaY-=4 if (@battler.index&1)==0 # If player's Pokémon
    megaY=32 if @doublebattle
    megaX=215
    megaX=-27 if (@battler.index&1)==0 # If player's Pokémon
    if !@battler.issossmon || (@battler.issossmon && @battler.index == 2)
      if @battler.isMega? && @battler.hasMega?
        imagepos.push(["Graphics/Pictures/Battle/battleMegaEvoBox.png",sbX+megaX,megaY,0,0,-1,-1])
      elsif @battler.isUltra? # Maybe temporary until new icon
        imagepos.push(["Graphics/Pictures/Battle/battleMegaEvoBox.png",sbX+megaX,megaY,0,0,-1,-1])
      elsif @battler.isGiga? && @battler.hasGiga?
        imagepos.push(["Graphics/Pictures/Battle/battleMegaEvoBox.png",sbX+megaX,megaY,0,0,-1,-1])
      end
      # Crest
      illusion = !@battler.effects[:Illusion].nil?
      if @battler.hasCrest?(illusion) || (@battler.crested && !illusion)
        imagepos.push(["Graphics/Pictures/Battle/battleCrest.png",sbX+megaX,megaY,0,0,-1,-1])
      end
      # Owned
      if @battler.owned && (@battler.index&1)==1 
        if @doublebattle  
          imagepos.push(["Graphics/Pictures/Battle/battleBoxOwned.png",sbX-12,4,0,0,-1,-1]) if (@battler.index)==3
          imagepos.push(["Graphics/Pictures/Battle/battleBoxOwned.png",sbX-18,4,0,0,-1,-1]) if (@battler.index)==1
        else  
          imagepos.push(["Graphics/Pictures/Battle/battleBoxOwned.png",sbX-12,20,0,0,-1,-1])  
        end 
      end
    end
    pbDrawImagePositions(self.bitmap,imagepos)
    hpGaugeSize=PBScene::HPGAUGESIZE
    hpgauge=@battler.totalhp==0 ? 0 : (self.hp*hpGaugeSize/@battler.totalhp)
    hpgauge=2 if hpgauge==0 && self.hp>0
    hpzone=0
    hpzone=1 if self.hp<=(@battler.totalhp/2.0).floor
    hpzone=2 if self.hp<=(@battler.totalhp/4.0).floor
    hpcolors=[
      PBScene::HPGREENDARK,
      PBScene::HPGREEN,
      PBScene::HPYELLOWDARK,
      PBScene::HPYELLOW,
      PBScene::HPREDDARK,
      PBScene::HPRED
    ]
    # fill with black (shows what the HP used to be)
    hpGaugeX=PBScene::HPGAUGE_X
    hpGaugeY=PBScene::HPGAUGE_Y
    if @battler.issossmon && !(@battler.index == 2)
      hpGaugeY=PBScene::HPGAUGE_Y-10
      hpGaugeX=PBScene::HPGAUGE_X-16
    end
    hpGaugeLowerY = 14
    hpThiccness = 16
    if bIsFoe
      hpGaugeX += 8
      hpGaugeY += 4
    end
    if @doublebattle
      hpGaugeY -= 12
      hpGaugeLowerY = 10
      hpThiccness = 12

      if bIsFoe
        hpGaugeY -= 4
      end
    end
    self.bitmap.blt(sbX+hpGaugeX,hpGaugeY,@hpbar.bitmap,Rect.new(0,(hpzone)*hpbarconstant,hpgauge,hpbarconstant))

    # self.bitmap.fill_rect(sbX+hpGaugeX,hpGaugeY,hpgauge,hpThiccness,hpcolors[hpzone*2+1])
    # self.bitmap.fill_rect(sbX+hpGaugeX,hpGaugeY,hpgauge,2,hpcolors[hpzone*2])
    # self.bitmap.fill_rect(sbX+hpGaugeX,hpGaugeY+hpGaugeLowerY,hpgauge,2,hpcolors[hpzone*2])
    # Status
    if !@battler.status.nil?
      imagepos=[]
      doubles = "D"
      if @doublebattle
        if bIsFoe
          if @battler.issossmon && !(@battler.index == 2)
            imagepos.push([sprintf("Graphics/Pictures/Battle/battleStatuses"+ doubles + "%s",@battler.status),@spritebaseX-6,@spritebaseY+26,0,0,64,28])
          else
            imagepos.push([sprintf("Graphics/Pictures/Battle/battleStatuses"+ doubles + "%s",@battler.status),@spritebaseX+8,@spritebaseY+36,0,0,64,28])
          end
        else
          imagepos.push([sprintf("Graphics/Pictures/Battle/battleStatuses"+ doubles + "%s",@battler.status),@spritebaseX+10,@spritebaseY+36,0,0,64,28])
        end
      elsif bIsFoe
        imagepos.push([sprintf("Graphics/Pictures/Battle/battleStatuses%s",@battler.status),@spritebaseX,@spritebaseY+54,0,0,64,28])
      else
        imagepos.push([sprintf("Graphics/Pictures/Battle/battleStatuses%s",@battler.status),@spritebaseX+4,@spritebaseY+50,0,0,64,28])
      end
      pbDrawImagePositions(self.bitmap,imagepos)
    end
    if @showexp
      # fill with EXP color
      expGaugeX=PBScene::EXPGAUGE_X
      expGaugeY=PBScene::EXPGAUGE_Y
      self.bitmap.fill_rect(sbX+expGaugeX,expGaugeY,self.exp,2,
         PBScene::EXPCOLORSHADOW)
      self.bitmap.fill_rect(sbX+expGaugeX,expGaugeY+2,self.exp,4,
         PBScene::EXPCOLORBASE)
    end
    
    #### - StatBoosts - START
    aTypeBattleIcons if defined?(aTypeBattleIcons) && $DEV
    aShowStatBoosts if $DEV
    #### - StatBoosts - END
  end
end

# Shows the enemy trainer(s)'s Pokémon being thrown out.  It appears at coords
# (@spritex,@spritey), and moves in y to @endspritey where it stays for the rest
# of the battle, i.e. the latter is the more important value.
# Doesn't show the ball itself being thrown.
class PokeballSendOutAnimation

  def initialize(sprite,spritehash,pkmn,doublebattle,illusionpoke)
    @disposed=false
    @ballused=pkmn.pokemon ? pkmn.pokemon.ballused : :POKEBALL
    @PokemonBattlerSprite=sprite
    @PokemonBattlerSprite.visible=false
    @PokemonBattlerSprite.tone=Tone.new(248,248,248,248)
    @pokeballsprite=IconSprite.new(0,0,sprite.viewport)
    @pokeballsprite.setBitmap(sprintf("Graphics/Pictures/Battle/%s",@ballused))
    if doublebattle && pkmn.battle.party2.length!=1
      @spritex=PBScene::FOEBATTLERD1_X if pkmn.index==1 
      @spritex=PBScene::FOEBATTLERD2_X if pkmn.index==3
    else
      @spritex=PBScene::FOEBATTLER_X 
    end
    @spritey=0
    @illusionpoke = illusionpoke
    if illusionpoke != nil
      @endspritey=adjustBattleSpriteY(sprite,illusionpoke.species,illusionpoke.form,pkmn.index)
    else
      @endspritey=adjustBattleSpriteY(sprite,pkmn.species,pkmn.form,pkmn.index)
    end
    if doublebattle && pkmn.battle.party2.length!=1
      @spritey=PBScene::FOEBATTLERD1_Y if pkmn.index==1
      @spritey=PBScene::FOEBATTLERD2_Y if pkmn.index==3
      @endspritey+=PBScene::FOEBATTLERD1_Y if pkmn.index==1
      @endspritey+=PBScene::FOEBATTLERD2_Y if pkmn.index==3
    else
      @spritey=PBScene::FOEBATTLER_Y
      @endspritey+=PBScene::FOEBATTLER_Y
    end
    @spritehash=spritehash
    @pokeballsprite.x=@spritex-@pokeballsprite.bitmap.width/2
    @pokeballsprite.y=@spritey-@pokeballsprite.bitmap.height/2-4
    @pokeballsprite.z=@PokemonBattlerSprite.z+1
    @pkmn=pkmn
    @shadowX=@spritex
    @shadowY=@spritey
    if @spritehash["shadow#{@pkmn.index}"] && @spritehash["shadow#{@pkmn.index}"].bitmap!=nil
      @shadowX-=@spritehash["shadow#{@pkmn.index}"].bitmap.width/2
      @shadowY-=@spritehash["shadow#{@pkmn.index}"].bitmap.height/2
    end
    if illusionpoke != nil #ILLUSION
      @shadowVisible=showShadow?(illusionpoke.species,illusionpoke.form)
    else
      @shadowVisible=showShadow?(pkmn.species,pkmn.form)
    end #ILLUSION
    @stepspritey=(@spritey-@endspritey)
    @zoomstep=(1.0-STARTZOOM)/SPRITESTEPS
    @animdone=false
    @frame=0
  end
end

class PokeBattle_DebugSceneNoLogging
  def pbFakeOutFainted(pkmn)
  end
end

class PokeBattle_DebugScene
  def pbFakeOutFainted(pkmn)
  end
end
class PokeBattle_DebugSceneNoGraphics
  # This method is called whenever a Pokémon faints
  def pbFakeOutFainted(pkmn)
  end
end

####################################################

class PokeBattle_Scene
  
  def pbInputUpdate
    Input.update
  end

    # This method is called whenever a Pokémon faints.
    def pbFakeOutFainted(pkmn)
      frames=pbCryFrameLength(pkmn.pokemon)
      pbPlayCry(pkmn.pokemon)
      frames.times do
        pbGraphicsUpdate
        pbInputUpdate
      end
      @sprites["shadow#{pkmn.index}"].visible=false 
      pkmnsprite=@sprites["pokemon#{pkmn.index}"]
      ycoord=0
      if @battle.doublebattle
        ycoord=PBScene::PLAYERBATTLERD1_Y if pkmn.index==0
        ycoord=PBScene::FOEBATTLERD1_Y if pkmn.index==1
        ycoord=PBScene::PLAYERBATTLERD2_Y if pkmn.index==2
        ycoord=PBScene::FOEBATTLERD2_Y if pkmn.index==3
      else
        if @battle.pbIsOpposing?(pkmn.index)
          ycoord=PBScene::FOEBATTLER_Y
        else
          ycoord=PBScene::PLAYERBATTLER_Y
        end
      end
      pbSEPlay("faint")
      heightsave=pkmnsprite.src_rect.height
      loop do
        pkmnsprite.y+=8
        if pkmnsprite.y-pkmnsprite.oy+pkmnsprite.src_rect.height>=ycoord
          pkmnsprite.src_rect.height=ycoord-pkmnsprite.y+pkmnsprite.oy
        end
        pbGraphicsUpdate
        pbInputUpdate
        break if pkmnsprite.y>=ycoord
      end
      pkmnsprite.visible=false
      pkmn.form=2
      pbChangePokemon(pkmn,pkmn.pokemon)
      loop do
        pkmnsprite.y-=4
        if pkmnsprite.y+pkmnsprite.oy+pkmnsprite.src_rect.height<=ycoord
          pkmnsprite.src_rect.height=ycoord-pkmnsprite.y+pkmnsprite.oy
        end
        pbGraphicsUpdate
        pbInputUpdate
        break if pkmnsprite.src_rect.height>=(heightsave-20)
      end
      frames=pbCryFrameLength(pkmn.pokemon)
      pbPlayCry(pkmn.pokemon)
      pkmnsprite.visible=true
    end

  # to update databox shield display every hit
  def pbUpdateShield(shield, index)
    return false if !@battle.battlers[index]
    @battle.battlers[index].pokemon.shieldCount = shield
    @sprites["battlebox#{index}"].shieldCount = shield
    @sprites["battlebox#{index}"].refresh
    if @battle.battlers[index].lastAttacker
      opponentindex = @battle.battlers[index].lastAttacker
    else
      opponentindex = @battle.battlers[index].pbOppositeOpposing.index
    end
    @battle.battlers[index].shieldsBrokenThisTurn[opponentindex] += 1
    if @battle.battlers[index].capturable
      if @battle.battlers[index].shieldCount==0
        @battle.pbDisplayPaused(_INTL("{1}'s guard is low! Try capturing it!", @battle.battlers[index].pbThis))
      end
    end
  end

  # to update @battle.shieldCount in case mon enters as rift form
  # no shield due to transformation
  def pbUpdateBattleShield(index)
    @battle.shieldCount = @sprites["battlebox#{index}"].shieldCount
  end
  
  def pbBackdrop
    backdrop = @battle.field.backdrop
    # Choose bases
    environ=@battle.environment
    base = ""
    if environ==:Grass || environ==:TallGrass
      base= "Grass"
    elsif environ==:Sand
      base= "Sand"
    elsif $PokemonGlobal.surfing
      base= "Water"
    elsif $PokemonGlobal.lavasurfing
      base= "Volcano"
    end
    base= "" if !pbResolveBitmap(sprintf("Graphics/Battlebacks/playerbase"+backdrop+base))
    # Choose time of day
    time= ""
    timenow=pbGetTimeNow
    if PBDayNight.isNight?(timenow)
      time= "Night"
    elsif PBDayNight.isEvening?(timenow)
      time= "Eve"
    end
    time= "" if !pbResolveBitmap(sprintf("Graphics/Battlebacks/battlebg"+backdrop+time))
    battlebg= "Graphics/Battlebacks/battlebg"+backdrop+time
    enemybase= "Graphics/Battlebacks/enemybase"+backdrop+base+time
    playerbase= "Graphics/Battlebacks/playerbase"+backdrop+base+time
    enemybase= "Graphics/Battlebacks/enemybaseDummy" if !pbResolveBitmap(sprintf(enemybase))
    playerbase= "Graphics/Battlebacks/playerbaseDummy" if !pbResolveBitmap(sprintf(playerbase))
    pbAddPlane("battlebg",battlebg,@viewport)
    pbAddSprite("playerbase",
       PBScene::PLAYERBASEX,
       PBScene::PLAYERBASEY,playerbase,@viewport)
    @sprites["playerbase"].x-=@sprites["playerbase"].bitmap.width/2 if @sprites["playerbase"].bitmap!=nil
    @sprites["playerbase"].y-=@sprites["playerbase"].bitmap.height if @sprites["playerbase"].bitmap!=nil
    pbAddSprite("enemybase",
       PBScene::FOEBASEX,
       PBScene::FOEBASEY,enemybase,@viewport)
    @sprites["enemybase"].x-=@sprites["enemybase"].bitmap.width/2 if @sprites["enemybase"].bitmap!=nil
    @sprites["enemybase"].y-=@sprites["enemybase"].bitmap.height/2 if @sprites["enemybase"].bitmap!=nil
    @sprites["battlebg"].z=0
    @sprites["playerbase"].z=2
    @sprites["enemybase"].z=1
  end

  def createPokemonDataBox(battler, doublebattle, viewport,battle)
    if battle.pbIsEnemy(battler.index)
      if battler.isbossmon 
        return BossPokemonDataBox.new(battler, doublebattle, viewport,battler.index,battle)
      end
    end
    return PokemonDataBox.new(battler, doublebattle, viewport, battle)
  end

  def pbStartBattle(battle)
    # Called whenever the battle begins
    @battle=battle
    @lastcmd=[0,0,0,0]
    @lastmove=[0,0,0,0]
    @showingplayer=true
    @showingenemy=true
    @sprites.clear
    @viewport=Viewport.new(0,Graphics.height/2,Graphics.width,0)
    @viewport.z=99999
    @traineryoffset=(Graphics.height-320) # Adjust player's side for screen size
    @foeyoffset=(@traineryoffset*3/4).floor  # Adjust foe's side for screen size
    pbBackdrop
    pbAddSprite("partybarfoe",
       PBScene::FOEPARTYBAR_X,
       PBScene::FOEPARTYBAR_Y,
       "Graphics/Pictures/Battle/battleLineup",@viewport)
    pbAddSprite("partybarplayer",
       PBScene::PLAYERPARTYBAR_X,
       PBScene::PLAYERPARTYBAR_Y,
       "Graphics/Pictures/Battle/battleLineup",@viewport)
    @sprites["partybarfoe"].x-=@sprites["partybarfoe"].bitmap.width
    @sprites["partybarplayer"].mirror=true
    @sprites["partybarfoe"].z=40
    @sprites["partybarplayer"].z=40
    @sprites["partybarfoe"].visible=false
    @sprites["partybarplayer"].visible=false
    if @battle.player.is_a?(Array)
      trainerfile=pbPlayerSpriteBackFile(@battle.player[0].trainertype)
      pbAddSprite("player",
           PBScene::PLAYERTRAINERD1_X,
           PBScene::PLAYERTRAINERD1_Y,trainerfile,@viewport)
      trainerfile=pbTrainerSpriteBackFile(@battle.player[1].trainertype)
      pbAddSprite("playerB",
           PBScene::PLAYERTRAINERD2_X,
           PBScene::PLAYERTRAINERD2_Y,trainerfile,@viewport)
      if @sprites["player"].bitmap
        if @sprites["player"].bitmap.width>@sprites["player"].bitmap.height
          @sprites["player"].src_rect.x=0
          @sprites["player"].src_rect.width=@sprites["player"].bitmap.width/5
        end
        @sprites["player"].x-=(@sprites["player"].src_rect.width/2)
        @sprites["player"].y-=@sprites["player"].bitmap.height
        @sprites["player"].z=30
      end
      if @sprites["playerB"].bitmap
        if @sprites["playerB"].bitmap.width>@sprites["playerB"].bitmap.height
          @sprites["playerB"].src_rect.x=0
          @sprites["playerB"].src_rect.width=@sprites["playerB"].bitmap.width/5
        end
        @sprites["playerB"].x-=(@sprites["playerB"].src_rect.width/2)
        @sprites["playerB"].y-=@sprites["playerB"].bitmap.height
        @sprites["playerB"].z=31
      end
    else
      trainerfile=pbPlayerSpriteBackFile(@battle.player.trainertype)
      pbAddSprite("player",
           PBScene::PLAYERTRAINER_X,
           PBScene::PLAYERTRAINER_Y,trainerfile,@viewport)
      if @sprites["player"].bitmap
        if @sprites["player"].bitmap.width>@sprites["player"].bitmap.height
          @sprites["player"].src_rect.x=0
          @sprites["player"].src_rect.width=@sprites["player"].bitmap.width/5
        end
        @sprites["player"].x-=(@sprites["player"].src_rect.width/2)
        @sprites["player"].y-=@sprites["player"].bitmap.height
        @sprites["player"].z=30
      end
    end
    if @battle.opponent
      if @battle.opponent.is_a?(Array)
        trainerfile=pbTrainerSpriteFile(@battle.opponent[1].trainertype,@battle.opponent[1].outfit)
        pbAddSprite("trainer2",
           PBScene::FOETRAINERD2_X,
           PBScene::FOETRAINERD2_Y,trainerfile,@viewport)
        trainerfile=pbTrainerSpriteFile(@battle.opponent[0].trainertype,@battle.opponent[0].outfit)
        pbAddSprite("trainer",
           PBScene::FOETRAINERD1_X,
           PBScene::FOETRAINERD1_Y,trainerfile,@viewport)
      else
        trainerfile=pbTrainerSpriteFile(@battle.opponent.trainertype,@battle.opponent.outfit)
        pbAddSprite("trainer",
           PBScene::FOETRAINER_X,
           PBScene::FOETRAINER_Y,trainerfile,@viewport)
      end
    else
      trainerfile="Graphics/Characters/trfront"
      pbAddSprite("trainer",
           PBScene::FOETRAINER_X,
           PBScene::FOETRAINER_Y,trainerfile,@viewport)
    end
    if @sprites["trainer"].bitmap
      @sprites["trainer"].x-=(@sprites["trainer"].bitmap.width/2)
      @sprites["trainer"].y-=@sprites["trainer"].bitmap.height
      @sprites["trainer"].z=8
    end
    if @sprites["trainer2"] && @sprites["trainer2"].bitmap
      @sprites["trainer2"].x-=(@sprites["trainer2"].bitmap.width/2)
      @sprites["trainer2"].y-=@sprites["trainer2"].bitmap.height
      @sprites["trainer2"].z=7
    end
    @sprites["shadow0"]=IconSprite.new(0,0,@viewport)
    @sprites["shadow0"].z=3
    pbAddSprite("shadow1",0,0,"Graphics/Pictures/Battle/battleShadow",@viewport)
    @sprites["shadow1"].z=3
    @sprites["shadow1"].visible=false
    @sprites["pokemon0"]=PokemonBattlerSprite.new(battle.doublebattle,0,@viewport)
    @sprites["pokemon0"].z=21
    @sprites["pokemon1"]=PokemonBattlerSprite.new(battle.doublebattle,1,@viewport)
    @sprites["pokemon1"].z=16
    if battle.doublebattle
      @sprites["shadow2"]=IconSprite.new(0,0,@viewport)
      @sprites["shadow2"].z=3
      pbAddSprite("shadow3",0,0,"Graphics/Pictures/Battle/battleShadow",@viewport)
      @sprites["shadow3"].z=3
      @sprites["shadow3"].visible=false
      @sprites["pokemon2"]=PokemonBattlerSprite.new(battle.doublebattle,2,@viewport)
      @sprites["pokemon2"].z=26 # Editing to see
      @sprites["pokemon3"]=PokemonBattlerSprite.new(battle.doublebattle,3,@viewport)
      @sprites["pokemon3"].z=11
    end
    @sprites["battlebox0"]=createPokemonDataBox(battle.battlers[0],battle.doublebattle,@viewport,battle)
    @sprites["battlebox1"]=createPokemonDataBox(battle.battlers[1],battle.doublebattle,@viewport,battle)
    if battle.doublebattle
      @sprites["battlebox2"]=createPokemonDataBox(battle.battlers[2],battle.doublebattle,@viewport,battle)
      @sprites["battlebox3"]=createPokemonDataBox(battle.battlers[3],battle.doublebattle,@viewport,battle)
    end
    pbAddSprite("messagebox",0,Graphics.height-96,"Graphics/Pictures/Battle/battleMessage",@viewport)
    @sprites["messagebox"].z=90
    @sprites["helpwindow"]=Window_UnformattedTextPokemon.newWithSize("",0,0,32,32,@viewport)
    @sprites["helpwindow"].visible=false
    @sprites["helpwindow"].z=90
    @sprites["messagewindow"]=Window_AdvancedTextPokemon.new("")
    @sprites["messagewindow"].letterbyletter=true
    @sprites["messagewindow"].viewport=@viewport
    @sprites["messagewindow"].z=100
    @sprites["commandwindow"]=CommandMenuDisplay.new(@viewport)
    @sprites["commandwindow"].z=100
    @sprites["fightwindow"]=FightMenuDisplay.new(nil,@viewport)
    @sprites["fightwindow"].z=100
    pbShowWindow(MESSAGEBOX)
    pbSetMessageMode(false)
    trainersprite1=@sprites["trainer"]
    trainersprite2=@sprites["trainer2"]
    if !@battle.opponent
      @sprites["trainer"].visible=false
      if @battle.party2.length>=1
        if @battle.party2.length==1
          species=@battle.party2[0].species
          form=@battle.party2[0].form
          @sprites["pokemon1"].setPokemonBitmap(@battle.party2[0],false)
          @sprites["pokemon1"].tone=Tone.new(-128,-128,-128,-128)
          @sprites["pokemon1"].x=PBScene::FOEBATTLER_X
          @sprites["pokemon1"].x-=@sprites["pokemon1"].width/2
          @sprites["pokemon1"].y=PBScene::FOEBATTLER_Y
          @sprites["pokemon1"].y+=adjustBattleSpriteY(@sprites["pokemon1"],species,form,1)
          @sprites["pokemon1"].visible=true
          @sprites["shadow1"].x=PBScene::FOEBATTLER_X
          @sprites["shadow1"].y=PBScene::FOEBATTLER_Y
          @sprites["shadow1"].x-=@sprites["shadow1"].bitmap.width/2 if @sprites["shadow1"].bitmap!=nil
          @sprites["shadow1"].y-=@sprites["shadow1"].bitmap.height/2 if @sprites["shadow1"].bitmap!=nil
          @sprites["shadow1"].visible=showShadow?(species,form)
          trainersprite1=@sprites["pokemon1"]
        elsif @battle.party2.length==2
          species=@battle.party2[0].species
          form=@battle.party2[0].form
          @sprites["pokemon1"].setPokemonBitmap(@battle.party2[0],false)
          @sprites["pokemon1"].tone=Tone.new(-128,-128,-128,-128)
          @sprites["pokemon1"].x=PBScene::FOEBATTLERD1_X
          @sprites["pokemon1"].x-=@sprites["pokemon1"].width/2  
          @sprites["pokemon1"].y=PBScene::FOEBATTLERD1_Y
          @sprites["pokemon1"].y+=adjustBattleSpriteY(@sprites["pokemon1"],species,form,1)
          @sprites["pokemon1"].visible=true
          @sprites["shadow1"].x=PBScene::FOEBATTLERD1_X
          @sprites["shadow1"].y=PBScene::FOEBATTLERD1_Y
          @sprites["shadow1"].x-=@sprites["shadow1"].bitmap.width/2 if @sprites["shadow1"].bitmap!=nil
          @sprites["shadow1"].y-=@sprites["shadow1"].bitmap.height/2 if @sprites["shadow1"].bitmap!=nil
          @sprites["shadow1"].visible=showShadow?(species,form)
          trainersprite1=@sprites["pokemon1"]
          species=@battle.party2[1].species
          form=@battle.party2[1].form
          @sprites["pokemon3"].setPokemonBitmap(@battle.party2[1],false)
          @sprites["pokemon3"].tone=Tone.new(-128,-128,-128,-128)
          @sprites["pokemon3"].x=PBScene::FOEBATTLERD2_X
          @sprites["pokemon3"].x-=@sprites["pokemon3"].width/2 
          @sprites["pokemon3"].y=PBScene::FOEBATTLERD2_Y
          @sprites["pokemon3"].y+=adjustBattleSpriteY(@sprites["pokemon3"],species,form,3)
          @sprites["pokemon3"].visible=true
          @sprites["shadow3"].x=PBScene::FOEBATTLERD2_X
          @sprites["shadow3"].y=PBScene::FOEBATTLERD2_Y
          @sprites["shadow3"].x-=@sprites["shadow3"].bitmap.width/2 if @sprites["shadow3"].bitmap!=nil
          @sprites["shadow3"].y-=@sprites["shadow3"].bitmap.height/2 if @sprites["shadow3"].bitmap!=nil
          @sprites["shadow3"].visible=showShadow?(species,form)
          trainersprite2=@sprites["pokemon3"]
        end
      end
    end
    #################
    # Move trainers/bases/etc. off-screen
    oldx=[]
    oldx[0]=@sprites["playerbase"].x; @sprites["playerbase"].x+=Graphics.width
    oldx[1]=@sprites["player"].x; @sprites["player"].x+=Graphics.width
    if @sprites["playerB"]
      oldx[2]=@sprites["playerB"].x; @sprites["playerB"].x+=Graphics.width
    end
    oldx[3]=@sprites["enemybase"].x; @sprites["enemybase"].x-=Graphics.width
    oldx[4]=trainersprite1.x; trainersprite1.x-=Graphics.width
    if trainersprite2
      oldx[5]=trainersprite2.x; trainersprite2.x-=Graphics.width
    end
    oldx[6]=@sprites["shadow1"].x; @sprites["shadow1"].x-=Graphics.width
    if @sprites["shadow3"]
      oldx[7]=@sprites["shadow3"].x; @sprites["shadow3"].x-=Graphics.width
    end
    @sprites["partybarfoe"].x-=PBScene::FOEPARTYBAR_X
    @sprites["partybarplayer"].x+=Graphics.width-PBScene::PLAYERPARTYBAR_X
    #################
    appearspeed=12
    (1+Graphics.width/appearspeed).times do
      tobreak=true
      if @viewport.rect.y>0
        @viewport.rect.y-=appearspeed/2
        @viewport.rect.y=0 if @viewport.rect.y<0
        @viewport.rect.height+=appearspeed
        @viewport.rect.height=Graphics.height if @viewport.rect.height>Graphics.height
        tobreak=false
      end
      if !tobreak
        for i in @sprites
          i[1].ox=@viewport.rect.x
          i[1].oy=@viewport.rect.y
        end
      end
      if @sprites["playerbase"].x>oldx[0]
        @sprites["playerbase"].x-=appearspeed; tobreak=false
        @sprites["playerbase"].x=oldx[0] if @sprites["playerbase"].x<oldx[0]
      end
      if @sprites["player"].x>oldx[1]
        @sprites["player"].x-=appearspeed; tobreak=false
        @sprites["player"].x=oldx[1] if @sprites["player"].x<oldx[1]
      end
      if @sprites["playerB"] && @sprites["playerB"].x>oldx[2]
        @sprites["playerB"].x-=appearspeed; tobreak=false
        @sprites["playerB"].x=oldx[2] if @sprites["playerB"].x<oldx[2]
      end
      if @sprites["enemybase"].x<oldx[3]
        @sprites["enemybase"].x+=appearspeed; tobreak=false
        @sprites["enemybase"].x=oldx[3] if @sprites["enemybase"].x>oldx[3]
      end
      if trainersprite1.x<oldx[4]
        trainersprite1.x+=appearspeed; tobreak=false
        trainersprite1.x=oldx[4] if trainersprite1.x>oldx[4]
      end
      if trainersprite2 && trainersprite2.x<oldx[5]
        trainersprite2.x+=appearspeed; tobreak=false
        trainersprite2.x=oldx[5] if trainersprite2.x>oldx[5]
      end
      if @sprites["shadow1"].x<oldx[6]
        @sprites["shadow1"].x+=appearspeed; tobreak=false
        @sprites["shadow1"].x=oldx[6] if @sprites["shadow1"].x>oldx[6]
      end
      if @sprites["shadow3"] && @sprites["shadow3"].x<oldx[7]
        @sprites["shadow3"].x+=appearspeed; tobreak=false
        @sprites["shadow3"].x=oldx[7] if @sprites["shadow3"].x>oldx[7]
      end
      pbGraphicsUpdate
      Input.update
      break if tobreak
    end
    # Play cry for wild Pokémon
    if !@battle.opponent
      if !@battle.doublebattle
        pbPlayCry(@battle.party2[0])
      else
        pbPlayCry(@battle.party2[0])
        pbPlayCry(@battle.party2[1])      
      end      
    end
    if @battle.opponent
      @enablePartyAnim=true
      @partyAnimPhase=0
      @sprites["partybarfoe"].visible=true
      @sprites["partybarplayer"].visible=true
    else
      @sprites["battlebox1"].appear
      @sprites["battlebox3"].appear if @battle.party2.length==2 
      appearing=true
      begin
        pbGraphicsUpdate
        Input.update
        @sprites["battlebox1"].update
        @sprites["pokemon1"].tone.red+=8 if @sprites["pokemon1"].tone.red<0
        @sprites["pokemon1"].tone.blue+=8 if @sprites["pokemon1"].tone.blue<0
        @sprites["pokemon1"].tone.green+=8 if @sprites["pokemon1"].tone.green<0
        @sprites["pokemon1"].tone.gray+=8 if @sprites["pokemon1"].tone.gray<0
        appearing=@sprites["battlebox1"].appearing
        if @battle.party2.length==2 
          @sprites["battlebox3"].update
          @sprites["pokemon3"].tone.red+=8 if @sprites["pokemon3"].tone.red<0
          @sprites["pokemon3"].tone.blue+=8 if @sprites["pokemon3"].tone.blue<0
          @sprites["pokemon3"].tone.green+=8 if @sprites["pokemon3"].tone.green<0
          @sprites["pokemon3"].tone.gray+=8 if @sprites["pokemon3"].tone.gray<0
          appearing=(appearing || @sprites["battlebox3"].appearing)
        end
      end while appearing
      # Show shiny animation for wild Pokémon
      if @battle.party2[0].isShiny? && @battle.battlescene
        pbCommonAnimation("Shiny",@battle.battlers[1],nil)
      end
      if @battle.party2.length==2
        if @battle.party2[1].isShiny? && @battle.battlescene
          pbCommonAnimation("Shiny",@battle.battlers[3],nil)
        end
      end
    end
  end

  def adjustBattlerPositionsBossFight(battle)
    for i in 0..3
      if @sprites["battlebox#{i}"]
        @sprites["battlebox#{i}"].doublebattle = (battle.sosbattle) > 3 ? true : false
        if i == 0
          @sprites["battlebox#{i}"].x =  PBScene::PLAYERBOXD1_X
          @sprites["battlebox#{i}"].y = PBScene::PLAYERBOXD1_Y
        end
      end
    end
  end

  def pbIntroBoss(battle,sosmonindex=nil)
    # Called whenever the battle begins
    @battle=battle
    @lastcmd=[0,0,0,0]
    @lastmove=[0,0,0,0]
    if @battle.opponent
      if @battle.opponent.is_a?(Array)
        trainerfile=pbTrainerSpriteFile(@battle.opponent[1].trainertype,@battle.opponent[1].outfit)
        pbAddSprite("trainer2",
           PBScene::FOETRAINERD2_X,
           PBScene::FOETRAINERD2_Y,trainerfile,@viewport)
        trainerfile=pbTrainerSpriteFile(@battle.opponent[0].trainertype,@battle.opponent[0].outfit)
        pbAddSprite("trainer",
           PBScene::FOETRAINERD1_X,
           PBScene::FOETRAINERD1_Y,trainerfile,@viewport)
        @sprites["trainer2"].visible=false
      else
        trainerfile=pbTrainerSpriteFile(@battle.opponent.trainertype,@battle.opponent.outfit)
        pbAddSprite("trainer",
           PBScene::FOETRAINER_X,
           PBScene::FOETRAINER_Y,trainerfile,@viewport)
      end
      @sprites["trainer"].visible=false

    else
      trainerfile="Graphics/Characters/trfront"
      pbAddSprite("trainer",
           PBScene::FOETRAINER_X,
           PBScene::FOETRAINER_Y,trainerfile,@viewport)
      @sprites["trainer"].visible=false
    end
    pbAddSprite("shadow3",0,0,"Graphics/Pictures/Battle/battleShadow",@viewport)
    for i in @battle.battlers
      battler = i if i.isbossmon
    end
    battlerIndex= battler.index
    sosIndex = sosmonindex
    # @sprites["shadow3"].z=3
    @sprites["shadow3"].visible=false
    species=@battle.party2[0].species
    form=@battle.party2[0].form
    bossposition = battlerIndex==1 ? [PBScene::FOEBATTLERD1_X,PBScene::FOEBATTLERD1_Y] : [PBScene::FOEBATTLERD2_X,PBScene::FOEBATTLERD2_Y]
    if sosIndex != 2
      sosposition = sosIndex == 1 ? [PBScene::FOEBATTLERD1_X,PBScene::FOEBATTLERD1_Y] : [PBScene::FOEBATTLERD2_X,PBScene::FOEBATTLERD2_Y]
    else
      sosposition = [PBScene::PLAYERBATTLERD2_X,PBScene::PLAYERBATTLERD2_Y] 
    end
    @sprites["pokemon"+battlerIndex.to_s].x=bossposition[0]
    @sprites["pokemon"+battlerIndex.to_s].x-=@sprites["pokemon"+battlerIndex.to_s].width/2 
    @sprites["pokemon"+battlerIndex.to_s].y=bossposition[1]
    @sprites["pokemon"+battlerIndex.to_s].y+=adjustBattleSpriteY(@sprites["pokemon"+battlerIndex.to_s],species,form,battlerIndex)
    @sprites["shadow"+battlerIndex.to_s].x=bossposition[0]
    @sprites["shadow"+battlerIndex.to_s].y=bossposition[1]
    @sprites["shadow"+battlerIndex.to_s].x-=@sprites["shadow"+battlerIndex.to_s].bitmap.width/2 if @sprites["shadow"+battlerIndex.to_s].bitmap!=nil
    @sprites["shadow"+battlerIndex.to_s].y-=@sprites["shadow"+battlerIndex.to_s].bitmap.height/2 if @sprites["shadow"+battlerIndex.to_s].bitmap!=nil
    @sprites["shadow"+battlerIndex.to_s].visible=showShadow?(species,form)
    if @battle.party2.length>=1
        species=@battle.party2[-1].species
        form=@battle.party2[-1].form
        # another line to account for me running absolute BS for one battle; double check that the battler on the battler box is actually the battler on that index
        @sprites["battlebox"+sosIndex.to_s].dispose if @sprites["battlebox"+sosIndex.to_s] && @sprites["battlebox"+sosIndex.to_s].battler != battle.battlers[sosIndex]
        @sprites["battlebox"+sosIndex.to_s]=createPokemonDataBox(battle.battlers[sosIndex],battle.doublebattle,@viewport,battle) if !@sprites["battlebox"+sosIndex.to_s] || @sprites["battlebox"+sosIndex.to_s].disposed?
        @sprites["pokemon"+sosIndex.to_s]=PokemonBattlerSprite.new(battle.doublebattle,sosIndex,@viewport) if !@sprites["pokemon"+sosIndex.to_s]
        if sosIndex == 2
          @sprites["pokemon"+sosIndex.to_s].setPokemonBitmap(@battle.party2[-1],true)
        else
          @sprites["pokemon"+sosIndex.to_s].setPokemonBitmap(@battle.party2[-1],false)
        end
        @sprites["pokemon"+sosIndex.to_s].tone=Tone.new(-128,-128,-128,-128)
        @sprites["pokemon"+sosIndex.to_s].x=sosposition[0]
        @sprites["pokemon"+sosIndex.to_s].x-=@sprites["pokemon"+sosIndex.to_s].width/2 
        @sprites["pokemon"+sosIndex.to_s].y=sosposition[1]
        @sprites["pokemon"+sosIndex.to_s].y+=adjustBattleSpriteY(@sprites["pokemon"+sosIndex.to_s],species,form,sosIndex)
        case sosIndex
        when 1
          @sprites["pokemon"+sosIndex.to_s].z=16 
        when 2
          @sprites["pokemon"+sosIndex.to_s].z=26 
        when 3
          @sprites["pokemon"+sosIndex.to_s].z=11
        end
        @sprites["pokemon"+sosIndex.to_s].visible=true
        if sosIndex == 2
          @sprites["shadow"+sosIndex.to_s]=IconSprite.new(0,0,@viewport) if !@sprites["shadow"+sosIndex.to_s]
        end
        @sprites["shadow"+sosIndex.to_s].x=sosposition[0]
        @sprites["shadow"+sosIndex.to_s].y=sosposition[1]
        @sprites["shadow"+sosIndex.to_s].x-=@sprites["shadow"+sosIndex.to_s].bitmap.width/2 if @sprites["shadow"+sosIndex.to_s].bitmap!=nil
        @sprites["shadow"+sosIndex.to_s].y-=@sprites["shadow"+sosIndex.to_s].bitmap.height/2 if @sprites["shadow"+sosIndex.to_s].bitmap!=nil
        @sprites["shadow"+sosIndex.to_s].visible=showShadow?(species,form)
        trainersprite2=@sprites["pokemon"+sosIndex.to_s]
    end
    #################
    appearspeed=12
    (1+Graphics.width/appearspeed).times do
      tobreak=true
      if @viewport.rect.y>0
        @viewport.rect.y-=appearspeed/2
        @viewport.rect.y=0 if @viewport.rect.y<0
        @viewport.rect.height+=appearspeed
        @viewport.rect.height=Graphics.height if @viewport.rect.height>Graphics.height
        tobreak=false
      end
      if !tobreak
        for i in @sprites
          next if i[1].nil?
          i[1].ox=@viewport.rect.x
          i[1].oy=@viewport.rect.y
        end
      end
      pbGraphicsUpdate
      Input.update
      break if tobreak
    end
    # Play cry for wild Pokémon
    pbPlayCry(@battle.party2[-1])          
      @sprites["battlebox"+sosIndex.to_s].appear if @battle.party2.length>=2 
      appearing=true
      begin
        pbGraphicsUpdate
        Input.update
        @sprites["battlebox"+sosIndex.to_s].update
        @sprites["pokemon"+sosIndex.to_s].tone.red+=8 if @sprites["pokemon"+sosIndex.to_s].tone.red<0
        @sprites["pokemon"+sosIndex.to_s].tone.blue+=8 if @sprites["pokemon"+sosIndex.to_s].tone.blue<0
        @sprites["pokemon"+sosIndex.to_s].tone.green+=8 if @sprites["pokemon"+sosIndex.to_s].tone.green<0
        @sprites["pokemon"+sosIndex.to_s].tone.gray+=8 if @sprites["pokemon"+sosIndex.to_s].tone.gray<0
        appearing=(@sprites["battlebox"+sosIndex.to_s].appearing)
      end while appearing
      # Show shiny animation for wild Pokémon
      if @battle.party2[-1].isShiny? && @battle.battlescene
        pbCommonAnimation("Shiny",@battle.battlers[3],nil)
      end
  end

  def pbEndBattle(result)
    pbShowWindow(BLANK)
    # Fade out all sprites
    pbBGMFade(1.0) if $game_switches[1404] == false #don't stop the music switch
    pbFadeOutAndHide(@sprites)
    pbDisposeSprites
  end

  def pbTrainerSendOut(battlerindex,pkmn)
    @briefmessage=false
    fadeanim=nil
    while inPartyAnimation?; end
    if @showingenemy
      fadeanim=TrainerFadeAnimation.new(@sprites)
    end
    frame=0    
    @sprites["pokemon#{battlerindex}"].setPokemonBitmap(pkmn,false)
    if @battle.battlers[battlerindex].effects[:Illusion] != nil #Illusion
      @sprites["pokemon#{battlerindex}"].setPokemonBitmap(
      @battle.battlers[battlerindex].effects[:Illusion].pokemon, false)
    end
    sendout=PokeballSendOutAnimation.new(@sprites["pokemon#{battlerindex}"],
       @sprites,@battle.battlers[battlerindex],@battle.doublebattle,
       @battle.battlers[battlerindex].effects[:Illusion]) #Illusion
       @sprites["pokemon#{battlerindex}"].opacity = 255
    @sprites["battlebox#{battlerindex}"].visible=false
    pbDisposeSprite(@sprites,["battlebox#{battlerindex}"])
    @sprites["battlebox#{battlerindex}"]=createPokemonDataBox(@battle.battlers[battlerindex],@battle.doublebattle,@viewport,@battle)
    loop do
      pbGraphicsUpdate
      Input.update
      fadeanim.update if fadeanim
      frame+=1    
      if frame==1
        @sprites["battlebox#{battlerindex}"].appear
      end
      if frame>=10
        sendout.update
      end
      @sprites["battlebox#{battlerindex}"].update
      break if (!fadeanim || fadeanim.animdone?) && sendout.animdone? &&
       !@sprites["battlebox#{battlerindex}"].appearing
      end 
    if @battle.battlescene && ((@battle.battlers[battlerindex].pokemon.isShiny? && 
      @battle.battlers[battlerindex].effects[:Illusion].nil?) || 
       (@battle.battlers[battlerindex].effects[:Illusion] != nil && 
       @battle.battlers[battlerindex].effects[:Illusion].pokemon.isShiny?))
      pbCommonAnimation("Shiny",@battle.battlers[battlerindex],nil)
    end
    sendout.dispose
    if @showingenemy
      @showingenemy=false
      pbDisposeSprite(@sprites,"trainer")
      pbDisposeSprite(@sprites,"partybarfoe")
      for i in 0...6
        pbDisposeSprite(@sprites,"enemy#{i}")
      end
    end
    pbRefresh
  end

  # This method is called whenever a Pokémon faints.
  def pbFaintedSpacea(pkmn)
    #frames=pbCryFrameLength(pkmn.pokemon)
    pbPlayCry(pkmn.pokemon)
    #frames.times do
    #  pbGraphicsUpdate
    #  Input.update
    #end
    @sprites["shadow#{pkmn.index}"].visible=false
    pkmnsprite=@sprites["pokemon#{pkmn.index}"]
    ycoord=0
    if @battle.doublebattle
      ycoord=PBScene::PLAYERBATTLERD1_Y if pkmn.index==0
      ycoord=PBScene::FOEBATTLERD1_Y if pkmn.index==1
      ycoord=PBScene::PLAYERBATTLERD2_Y if pkmn.index==2
      ycoord=PBScene::FOEBATTLERD2_Y if pkmn.index==3
    else
      if @battle.pbIsOpposing?(pkmn.index)
        ycoord=PBScene::FOEBATTLER_Y
      else
        ycoord=PBScene::PLAYERBATTLER_Y
      end
    end
    @battle.pbIsOpposing?(pkmn.index) ? pbSEPlay("faint") : pbSEPlay("faint_L")
    heightsave=pkmnsprite.src_rect.height
    loop do
      pkmnsprite.y+=8
      if pkmnsprite.y-pkmnsprite.oy+pkmnsprite.src_rect.height>=ycoord
        pkmnsprite.src_rect.height=ycoord-pkmnsprite.y+pkmnsprite.oy
      end
      pbGraphicsUpdate
      Input.update
      break if pkmnsprite.y>=ycoord
    end
    pkmnsprite.visible=false
    pkmnsprite.src_rect.height=heightsave
    8.times do
      @sprites["battlebox#{pkmn.index}"].opacity-=32
      pbGraphicsUpdate
      Input.update
    end
    @sprites["battlebox#{pkmn.index}"].visible=false
    pkmn.pbResetForm
  end

  def pbCommandMenuEx(index,texts,mode=0)      # Mode: 0 - regular battle
    pbShowWindow(COMMANDBOX)                   #       1 - Shadow Pokémon battle
    cw=@sprites["commandwindow"]               #       2 - Safari Zone
    cw.setTexts(texts)                         #       3 - Bug Catching Contest
    cw.index=0 if @lastcmd[index]==2
    cw.mode=mode
    pbSelectBattler(index)
    pbRefresh
    update_menu=true
    loop do
      pbGraphicsUpdate
      Input.update
      pbFrameUpdate(cw,update_menu)
      update_menu=false
      # Update selected command
      if Input.trigger?(Input::LEFT) && (cw.index&1)==1
        pbPlayCursorSE()
        cw.index-=1
        update_menu=true
      elsif Input.trigger?(Input::RIGHT) &&  (cw.index&1)==0
        pbPlayCursorSE()
        cw.index+=1
        update_menu=true
      elsif Input.trigger?(Input::UP) &&  (cw.index&2)==2
        pbPlayCursorSE()
        cw.index-=2
        update_menu=true
      elsif Input.trigger?(Input::DOWN) &&  (cw.index&2)==0
        pbPlayCursorSE()
        cw.index+=2
        update_menu=true
      elsif Input.trigger?(Input::Y)  #Show Battle Stats feature made by DemICE
        statstarget=pbStatInfo(index)
        return -1 if statstarget==-1      
        if !pbInSafari?
          pbShowBattleStats(statstarget)
        end
      end
      if Input.trigger?(Input::C)   # Confirm choice
        pbPlayDecisionSE()
        ret=cw.index
        @lastcmd[index]=ret
        cw.index=0 if $Settings.remember_commands==0
        return ret
      elsif Input.trigger?(Input::B) && index==2 #&& @lastcmd[0]!=2 # Cancel #Commented out for cancelling switches in doubles
        pbPlayDecisionSE()
        return -1
      end
    end 
  end

# Use this method to display the list of moves for a Pokémon
def pbFightMenu(index)
  pbShowWindow(FIGHTBOX)
  cw = @sprites["fightwindow"]
  battler=@battle.battlers[index]
  cw.battler=battler
  lastIndex=@lastmove[index]
  if battler.moves[lastIndex]
    cw.setIndex(lastIndex)
  else
    cw.setIndex(0)
  end
  cw.megaButton=0 unless @battle.megaEvolution[(@battle.pbIsOpposing?(index)) ? 1 : 0][@battle.pbGetOwnerIndex(index)] == index && @battle.battlers[index].hasMega?
  cw.megaButton=1 if @battle.pbCanMegaEvolve?(index) && !@battle.pbCanZMove?(index)
  cw.ultraButton=0
  cw.ultraButton=1 if @battle.pbCanUltraBurst?(index)
  # cw.gigaButton=0   #@SWu might need to update to be consistent with mega evo code above (assuming it's for double battles)
  cw.zButton=0
  cw.zButton=1 if @battle.pbCanZMove?(index) && !battler.isMega? && !battler.isGiga?
  pbSelectBattler(index)
  pbRefresh
  update_menu = true
  loop do
      Graphics.update
      Input.update
      pbFrameUpdate(cw,update_menu)
      update_menu = false
    # Update selected command
    if Input.trigger?(Input::LEFT) && (cw.index&1)==1
      pbPlayCursorSE() if cw.setIndex(cw.index-1)
        update_menu=true
    elsif Input.trigger?(Input::RIGHT) &&  (cw.index&1)==0
      pbPlayCursorSE() if cw.setIndex(cw.index+1)
        update_menu=true
    elsif Input.trigger?(Input::UP) &&  (cw.index&2)==2
      pbPlayCursorSE() if cw.setIndex(cw.index-2)
        update_menu=true
    elsif Input.trigger?(Input::DOWN) &&  (cw.index&2)==0
      pbPlayCursorSE() if cw.setIndex(cw.index+2)
      update_menu=true
    elsif Input.trigger?(Input::Y)  #Show Battle Stats feature made by DemICE
      statstarget=pbStatInfoF(index)
      return -1 if statstarget==-1          
      pbShowBattleStats(statstarget)
      update_menu=true
    end
    if Input.trigger?(Input::C)   # Confirm choice
      ret=cw.index
      if cw.zButton==2        
        if battler.pbCompatibleZMoveFromMove?(ret,true)
          pbPlayDecisionSE()     
          @lastmove[index]=ret
          return ret
        elsif @battle.pbCanGigaEvolve?(index)
          pbPlayDecisionSE()     
          @lastmove[index]=ret
          return ret
        else
          @battle.pbDisplay(_INTL("{1} is not compatible with {2}!",battler.moves[ret].name,getItemName(battler.item)))
          @lastmove[index]=cw.index     
          return -1
        end
      else
        pbPlayDecisionSE() 
        @lastmove[index]=ret   
        return ret
      end          
    elsif Input.trigger?(Input::X)  
      if (@battle.pbCanMegaEvolve?(index)) && !pbIsZCrystal?(battler.item)
        if cw.megaButton==2
          @battle.pbUnRegisterMegaEvolution(index)
          cw.megaButton=1
          pbPlayCancelSE()
        else
          @battle.pbRegisterMegaEvolution(index)
          cw.megaButton=2
          pbPlayDecisionSE()
        end
      elsif @battle.pbCanGigaEvolve?(index)
        if cw.megaButton==2
          @battle.pbUnRegisterGigaEvolution(index)
          cw.megaButton=1
          pbPlayCancelSE()
        else
          @battle.pbRegisterGigaEvolution(index)
          cw.megaButton=2
          pbPlayDecisionSE()
        end
      end
      if @battle.pbCanUltraBurst?(index)
        if cw.ultraButton==2
          @battle.pbUnRegisterUltraBurst(index)
          cw.ultraButton=1
          pbPlayCancelSE()
        else
          @battle.pbRegisterUltraBurst(index)
          cw.ultraButton=2
          pbPlayDecisionSE()
        end
      end
      if @battle.pbCanZMove?(index) # && !@battle.pbCanGigaEvolve?(index) # Use Z Move
        if cw.zButton==2
          @battle.pbUnRegisterZMove(index)
          cw.zButton=1
          pbPlayCancelSE()
        else
          @battle.pbRegisterZMove(index)
          cw.zButton=2
          pbPlayDecisionSE()
          if (battler.isGiga?)
            @battle.pbUnRegisterZMove(index)
          end
        end
      end        
      update_menu=true
    elsif Input.trigger?(Input::B)   # Cancel fight menu
      @lastmove[index]=cw.index
      pbPlayCancelSE()
      return -1
    end
  end
end

# This method is called when the player wins a Trainer battle.
# This method can change the battle's music for example.
  def pbBossBattleSuccess(bossname=nil)
    if bossname == "Tiempa"
      return
    else
      pbBGMPlay("Victory!")
    end
  end

  def pbTrainerBattleSuccess
    pbBGMPlay(pbGetTrainerVictoryME(@battle.opponent)) if $game_switches[1404] == false
  end

  def pbFindAnimation(move,userIndex,hitnum)
    begin
      noflip=false
      if (userIndex&1)==0   # On player's side
        anim=$cache.move2anim[0].fetch(move.intern)
      else                  # On opposing side
        anim=$cache.move2anim[1].fetch(move.intern) if $cache.move2anim[1].key?(move.intern)
        noflip=true if anim
        anim=$cache.move2anim[0].fetch(move.intern) if !anim
      end
      return [anim+hitnum,noflip] if move == (:BONEMERANG || :THUNDERRAID)
      return [anim,noflip] if anim
      anim=$cache.move2anim[0].fetch(:TACKLE)
        return [anim,false] if anim
    rescue
      return nil
    end
    return nil
  end
end