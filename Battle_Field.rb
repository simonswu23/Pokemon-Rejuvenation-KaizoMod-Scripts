class PokeBattle_Field
  attr_accessor :effect               #field effect ID
  attr_accessor :data                 #associated field information
  attr_accessor :layer                #order of fields, stacked up from base
  attr_accessor :counter              #counter for certain field triggers
  attr_accessor :counter2             #counter for certain field triggers
  attr_accessor :counter3             #counter for certain field triggers
  attr_accessor :counter4             #counter for certain field triggers
  attr_accessor :pledge               #whether a pledge move has been used
  attr_accessor :conversion           #whether conversion has been used
  attr_accessor :duration             #number of turns remaining on a temporary field
  attr_accessor :duration_condition   #condition to still keep remaining on a temporary field
  attr_accessor :permanent_condition  #condition to change a temp field into a permanent field
  attr_accessor :overlay              #layer index of the temporary field
  attr_accessor :roll
  attr_accessor :old_counter          #old counter value that shouldn't be overwritten when field returns

  def initialize
    @pledge = nil
    @conversion = nil
    @counter = 0
    # chances are no one except rejuv cave field is ever
    # going to use more than 1 of these but here they are anyway - Fal
    @counter2 = 0
    @counter3 = 0
    @counter4 = 0
    @duration = 0
    @duration_condition = nil
    @permanent_condition = nil
    @roll = 0
    @overlay = nil

    basefield = $cache.mapdata[$game_map.map_id].BattleBack
    basefield = $game_variables[:Forced_BaseField] if $game_variables[:Forced_BaseField] != 0
    # Base field is no field
    @layer = []
    @layer[0] = fieldSymFromGraphic(basefield)
    @layer[0] = :WATERSURFACE if $PokemonGlobal.surfing
    # @layer[0] = :??? if $PokemonGlobal.lavasurfing
    @layer[0] = :MURKWATERSURFACE if $game_map.terrain_tag($game_player.x, $game_player.y) == PBTerrain::PokePuddle # Murkwater
    # Field Effect override from variable
    if !$game_variables[:Forced_Field_Effect].nil? && $game_variables[:Forced_Field_Effect] != 0
      @layer.push($game_variables[:Forced_Field_Effect])
    end

    if Reborn
      # Password forced / random fields
      fields = randomFields()
      if fields != []
        @layer = [fields.sample]
      end
    end

    @effect = @layer[-1]
    setData
  end

  def setData
    @data = $cache.FEData[@effect]
  end

  def isFieldEffect?
    return false if @effect == :INDOOR || @effect == :INDOORA || @effect == :INDOORB || @effect == :INDOORC || (!Rejuv && (@effect == :CITY || @effect == :CITYNEW))

    return true
  end

  def backup
    return @layer[-2] if @layer[-2]

    return :INDOOR
  end

  def resetFieldVars(newfield = nil, oldfield = nil)
    @pledge = nil
    @conversion = nil
    @counter = 0
    @counter2 = 0
    @counter3 = 0
    @counter4 = 0
  end

  def getRoll(update_roll: true, maximize_roll: false)
    case @effect
      when :CRYSTALCAVERN then choices = PBStuff::CCROLLS
      when :SHORTCIRCUIT then choices = PBStuff::SHORTCIRCUITROLLS
    end
    result = choices[@roll]
    @roll = (@roll + 1) % choices.length if update_roll
    result = choices.max if @effect == :SHORTCIRCUIT && maximize_roll
    return result
  end

  def checkPermCondition(battle)
    return if !@permanent_condition
    return if !@permanent_condition.call(battle)

    @duration = 0
    @overlay = nil
    @permanent_condition = nil
    @duration_condition = nil
  end

  # FEData hash helpers
  def moveData(movesymbol)
    return @data.fieldmovedata[movesymbol]
  end

  def typeData(type)
    return @data.fieldtypedata[type]
  end

  def fieldChangeData
    return @data.fieldchangeconditions
  end

  def introMessage
    if isFieldEffect?
      return @data.message
    else
      return false
    end
  end

  def statusMoves
    return @data.statusMods
  end

  def seeds
    return @data.seeddata
  end

  def mimicry
    return @data.mimicry
  end

  def backdrop
    # return "Glitch2" if Reborn && @effect == :GLITCH && $game_map.map_id == 898  # for anna specifically
    # return "ForestVisinite" if Desolation && @effect == :ELECTERRAIN && $game_map.map_id == 470 && $game_switches[779]  # for Visinite Range
    # return "Visinite" if Desolation && @effect == :ELECTERRAIN && $game_map.map_id == 470 && $game_switches[778]  # for Visinite Range Wald
    map_bg = $cache.mapdata[$game_map.map_id].BattleBack
    map_bg = $game_variables[:Forced_BaseField] if $game_variables[:Forced_BaseField] != 0
    related_fe = fieldSymFromGraphic(map_bg)
    if !($game_variables[:AltFieldGraphic].nil? || $game_variables[:AltFieldGraphic] == 0)
      alt_bg = $game_variables[:AltFieldGraphic] # temporary alternate field graphics
      alt_fe = fieldSymFromGraphic(alt_bg)
      return alt_bg if @effect == alt_fe && !alt_bg.nil?
    end
    return map_bg if @effect == related_fe && !map_bg.nil? # alternate field graphics
    return @data.graphic[0] if @effect
    return $cache.FEData[:INDOOR].graphic[0] if map_bg.nil?

    return $cache.mapdata[$game_map.map_id].BattleBack
  end

  def naturePower
    return @data.naturePower if @data.naturePower

    return :TRIATTACK
  end

  def secretPowerAnim
    return @data.secretPower if @data.secretPower

    return :TRIATTACK
  end

  def checkPledge(moveid)
    return @pledge && @pledge != moveid
  end

  def self.getFieldName(field)
    return "No Field" if field == :INDOOR
    return $cache.FEData[field].name if $cache.FEData[field].name

    return ""
  end
end

class PokeBattle_FieldOnline < PokeBattle_Field
  def initialize(field)
    @pledge = nil
    @conversion = nil
    @counter = 0
    @duration = 0
    @roll = 0
    @overlay = nil
    # Base field is no field
    @layer = []
    @layer[0] = field
    # Field Effect override from variable
    if $feonline
      @layer.push($feonline)
    end
    @effect = @layer[-1]
    setData
  end

  def backdrop
    return @data.graphic[0] if @effect

    return $cache.FEData[:INDOOR].graphic[0]
  end

  def self.getFieldName(field)
    return "no field" if field == :INDOOR
    return $cache.FEData[field].name if $cache.FEData[field].name

    return ""
  end
end

class PokeBattle_Battle
  def noWeather
    if @weather != 0 && !pbCheckGlobalAbility(:TEMPEST)
      if @field.effect == :NEWWORLD
        pbDisplay(_INTL("The weather disappeared into space!"))
        @weather = 0
        @weatherduration = 0
      elsif @field.effect == :UNDERWATER
        pbDisplay(_INTL("You're too deep to notice the weather!"))
        @weather = 0
        @weatherduration = 0
      elsif @field.effect == :DIMENSIONAL && @weather != :SHADOWSKY && @weather != :STRONGWINDS && @weatherbackup != @weather
        case @weather
          when :SUNNYDAY then pbDisplay(_INTL("The sunlight cannot pierce the darkness!"))
          when :RAINDANCE then pbDisplay(_INTL("The dark dimension swallowed the rain!"))
          when :SANDSTORM, :SSANDSTREAM then pbDisplay(_INTL("The dark dimension swallowed the sand!"))
          # Gen 9 Mod - Hail/Snow/Both
          when :HAIL then pbDisplay(_INTL("The dark dimension swallowed the " + HAILSNOWLOWMOD + "!"))
        end
        @weather = 0
        @weatherduration = 0
        persistentWeather
      elsif @weather == :HAIL && (@field.effect == :SUPERHEATED || @field.effect == :VOLCANIC || @field.effect == :VOLCANICTOP || @field.effect == :INFERNAL || (@field.effect == :DRAGONSDEN && Rejuv))
        # Gen 9 Mod - Hail/Snow/Both
        pbDisplay(_INTL("The " + HAILSNOWLOWMOD + " melted away!"))
        @weather = 0
        @weatherduration = 0
        persistentWeather
      elsif @weather == :RAINDANCE && @field.effect == :INFERNAL
        pbDisplay(_INTL("The rain evaporated!"))
        @weather = 0
        @weatherduration = 0
        persistentWeather
      else
        persistentWeather
      end
    end
    # Gen 9 Mod - Added Protosynthesis
    protosynthesisCheck
  end

  def persistentWeather
    ### Fali - modification so weatherless fields remain so
    return if !Rejuv
    return if @field.effect == :NEWWORLD || @field.effect == :UNDERWATER
    return if @weather != 0
    return if @weatherbackup == 0
    return if @weatherbackup != :SHADOWSKY && @weatherbackup != :STRONGWINDS && @field.effect == :DIMENSIONAL
    return if @weatherbackup == :RAINDANCE && @field.effect == :INFERNAL
    return if @weatherbackup == :HAIL && (@field.effect == :SUPERHEATED || @field.effect == :VOLCANIC || @field.effect == :VOLCANICTOP || @field.effect == :INFERNAL || (@field.effect == :DRAGONSDEN && Rejuv))

    #### DemICE - persistentweather - START
    pbCommonAnimation(@weatherbackupanim, nil, nil)
    @weather = @weatherbackup
    @weatherduration = -1
    pbDisplay(_INTL("The initial weather took over again!"))
    #### DemICE
  end

  def setField(fieldeffect, temp = 0, add_on: false, growth: false)
    return if @field.effect == fieldeffect

    if Rejuv && [:ELECTERRAIN, :GRASSY, :MISTY, :PSYTERRAIN].include?(fieldeffect) && temp > 0 && (@field.effect != :INDOOR || KAIZOMOD)
      @state.effects[fieldeffect] = temp
      quarkdriveCheck

      # overrides all other terrains
      for terrain in [:ELECTERRAIN,:GRASSY,:MISTY,:PSYTERRAIN]
        if (terrain != fieldeffect && !KAIZOMOD)
          @state.effects[terrain] = 0
        end
      end
      return
    end

    animfieldref = @field.effect
    @field.effect = fieldeffect
    @field.checkPermCondition(self)
    if temp > 0
      @field.overlay = @field.layer.length if !@field.overlay
      @field.duration = temp
    end
    # Setting the new Field
    oldfield = @field.effect
    oldfield = @field.layer.pop if temp <= 0 && !add_on
    @field.layer.push(fieldeffect)

    # Animation
    case fieldeffect
      when :RAINBOW
        if animfieldref != :RAINBOW
          @battle.pbCommonAnimation("RainbowT")
        else
          @battle.pbCommonAnimation("RainbowE")
        end
      when :GLITCH
        if animfieldref != :GLITCH
          @battle.pbCommonAnimation("GlitchT")
        else
          @battle.pbCommonAnimation("GlitchE")
        end
    end

    # Changes
    @field.resetFieldVars(@field.effect, oldfield)
    @field.setData
    pbChangeBGSprite
    @state.effects[:Gravity] = -1 if fieldeffect == :DEEPEARTH
    @state.effects[:Gravity] = 0 if oldfield == :DEEPEARTH && @state.effects[:Gravity] == -1
    for i in priority
      next if i.isFainted?
      i.pbAbilitiesOnField(true) if !growth
    end
    quarkdriveCheck
    seedCheck
    noWeather
    persistentWeather # recheck if no current Weather and previous field disallowed the persistent weather effect
  end

  def canChangeFE?(newfield = [])
    newfield = [newfield] if newfield && !newfield.is_a?(Array)
    return !([:UNDERWATER, :NEWWORLD] + newfield).include?(@field.effect)
  end

  def breakField
    oldfield = @field.layer.pop
    @field.effect = @field.layer[-1] || :INDOOR
    @field.resetFieldVars(@field.effect, oldfield)
    @field.setData
    pbChangeBGSprite
    @state.effects[:Gravity] = 0 if oldfield == :DEEPEARTH && @state.effects[:Gravity] == -1
    for i in priority
      next if i.isFainted?

      i.pbAbilitiesOnField(true)
    end
    quarkdriveCheck
    seedCheck
    noWeather
    persistentWeather # recheck if no current Weather and previous field disallowed the persistent weather effect
  end

  def endTempField
    return if !@field.overlay

    oldfield = nil
    while @field.layer.length > @field.overlay
      oldfield = @field.layer.pop
    end
    @field.layer[-1] = :FLOWERGARDEN1 if Reborn && [:FLOWERGARDEN2, :FLOWERGARDEN3, :FLOWERGARDEN4, :FLOWERGARDEN5].include?(@field.layer[-1])
    @field.overlay = nil

    @field.effect = @field.layer[-1] || :INDOOR
    @field.resetFieldVars(@field.effect, oldfield)
    @field.permanent_condition = nil
    @field.duration_condition = nil
    @field.setData
    pbChangeBGSprite
    for i in priority
      next if i.isFainted?

      i.pbAbilitiesOnField(true)
    end
    quarkdriveCheck
    seedCheck
    noWeather
  end

  # i don't think we need this but keeping it just in case
  # def getNoField #for when the base graphic isn't blank
  #   return :INDOOR
  #   basefieldbg = $game_map ? $cache.mapdata[$game_map.map_id].BattleBack : ""
  #   basefield = fieldSymFromGraphic(basefieldbg)
  #   basefield = :INDOOR if basefield.nil? || $cache.FEData[basefield].nil?
  #   return basefield
  # end

  def canSetWeather?
    return !(@field.effect == :NEWWORLD || @field.effect == :UNDERWATER)
  end

  def setPledge(moveid, fielduration = 4)
    @field.pledge = moveid if @field.pledge == nil
    return if @field.pledge == moveid

    pledgepair = [moveid, @field.pledge]
    setField(:SWAMP, fielduration) if !pledgepair.include?(:FIREPLEDGE)
    setField(:RAINBOW, fielduration) if !pledgepair.include?(:GRASSPLEDGE)
    setField(:BURNING, fielduration) if !pledgepair.include?(:WATERPLEDGE)
    @field.pledge = nil
  end

  def fieldeffect
    return @field.effect
  end

  def FE
    return @field.effect
  end

  def fieldEffectAfterMove(basemove, user)
    # FIELD TRANSFORMATIONS
    # sorry cass this seems to be the right timing here but i'm so sorry to do this to your beautiful code
    @battle.growField("The wide area attack", user) if @battle.ProgressiveFieldCheck(PBFields::CONCERT) && user.midwayThroughMove
    fieldmove = @field.moveData(basemove.move)
    type = basemove.type
    fieldtype = @field.typeData(type)
    return if !fieldmove && (!fieldtype || !fieldtype[:typeeffect])

    if fieldtype && fieldtype[:typeeffect]
      if !fieldtype[:condition]
        eval(fieldtype[:typeeffect])
      else
        eval(fieldtype[:typeeffect]) if basemove.runCondition(fieldtype[:condition], user)
      end
    end
    if fieldmove && fieldmove[:moveeffect]
      eval(fieldmove[:moveeffect])
      fieldcounterMessages(basemove)
    end
    return if !fieldmove || !fieldmove[:fieldchange]

    change_conditions = @battle.field.fieldChangeData
    if change_conditions[fieldmove[:fieldchange]]
      return if !basemove.runCondition(change_conditions[fieldmove[:fieldchange]], user)
    end
    pbDisplay(_INTL(@field.data.changemessagelist[fieldmove[:changetext] - 1])) if fieldmove[:changetext]
    eval(fieldmove[:changeeffect]) if fieldmove[:changeeffect]
    newfield = fieldmove[:fieldchange]
    newfield = :INDOOR if Rejuv && @field.effect == :ICY && [:WATERSURFACE, :MURKWATERSURFACE, :CAVE].include?(@battle.field.backup)
    if ProgressiveFieldCheck(PBFields::FLOWERGARDEN, 1, 3) && user.ability == :RIPEN &&
       (PBFields::FLOWERGARDEN.index(@field.effect) < PBFields::FLOWERGARDEN.index(newfield))
      newfieldmove = ($cache.FEData[newfield]).moveData(basemove.move)
      newfield = newfieldmove[:fieldchange]
    end
    dont_change_backup = fieldmove[:dontchangebackup]
    if newfield == :INDOOR
      breakField
    elsif ProgressiveFieldCheck("All") && (PBFields::CONCERT.include?(newfield) || PBFields::FLOWERGARDEN.include?(newfield) || PBFields::DARKNESS.include?(newfield))
      setField(newfield, add_on: dont_change_backup, growth: true)
    else
      setField(newfield, add_on: dont_change_backup)
    end
  end

  # Specific Field Functions
  def fieldcounterMessages(basemove)
    case @field.effect
      when :MISTY
        pbDisplay(_INTL("Poison spread through the mist!")) if @field.counter == 1
      when :GRASSY, :FOREST
        pbDisplay(_INTL("The ground became waterlogged...")) if (@field.counter > 0 && @field.counter < 3 && Rejuv)
      when :ICY
        pbDisplay(_INTL("Parts of the ice melted!")) if @field.counter == 1 && (basemove.move == :SCALD || basemove.move == :STEAMERUPTION)
      when :WATERSURFACE, :UNDERWATER
        pbDisplay(_INTL("Poison spread through the water!")) if @field.counter == 1
      when :DRAGONSDEN
        pbDisplay(_INTL("The lava began to harden!")) if @field.counter == 1
      when :CAVE
        if basemove.move == :DRAGONPULSE
          pbDisplay(_INTL("Draconic energy seeps in...")) if @field.counter2 == 1
        elsif basemove.move == :GRAVITY
          pbDisplay(_INTL("Intense gravity is pulling from deep below...")) if @field.counter4 == 1
        elsif [:FEVERPITCH, :MAGMADRIFT, :ERUPTION, :LAVAPLUME, :HEATWAVE, :OVERHEAT, :FUSIONFLARE].include?(basemove.move)
          pbDisplay(_INTL("The cave is heating up...")) if @field.counter3 == 1
        end
      when :CRYSTALCAVERN
        pbDisplay(_INTL("The crystals are starting to crack...")) if @field.counter == 1
      when :FROZENDIMENSION
        pbDisplay(_INTL("A frightening chill goes down your spine...")) if @field.counter == 1
    end
  end

  # Corrosive Mist & Corrupted Cave
  def mistExplosion(basemove, user)
    if !pbCheckGlobalAbility(:DAMP)
      if @field.effect == :CORROSIVEMIST
        pbDisplay(_INTL("The toxic mist combusted!"))
      elsif @field.effect == :CORRUPTED
        pbDisplay(_INTL("The cave's corruption combusted!"))
      end
      for i in @battlers
        # rewriting this for sanity purposes. "next if" implies combustdamage == 0
        combustdamage = i.totalhp
        combustdamage = i.totalhp / 2 if @field.effect == :CORRUPTED
        for j in PBStuff::INVULEFFECTS
          combustdamage = 0 if i.effects[j] == true
        end
        next if combustdamage == 0
        next if PBStuff::TWOTURNMOVE.include?(i.effects[:TwoTurnAttack])
        next if i.ability == :FLASHFIRE
        next if i.pbOwnSide.effects[:WideGuard]
        next if i.pbOwnSide.effects[:MatBlock]
        next if i.pbOwnSide.effects[:QuickGuard] && basemove.priorityCheck(user) > 0
        next if i.effects[:Protect]
        next if i.effects[:SkyDrop]
        next if i.effects[:Commander] # Gen 9 Mod - Added Commander immunity when inside Dondozo's mouth.

        combustdamage -= 1 if (i.effects[:Endure] || i.ability == :STURDY) && @field.effect == :CORROSIVEMIST
        i.pbReduceHP(combustdamage) if combustdamage != 0
        i.pbFaint if i.isFainted?
      end
      return true
    else
      pbDisplay(_INTL("A Pokémon's Damp ability prevented a complete explosion!"))
      return false
    end
  end

  # Cave
  def caveCollapse(basemove, user)
    if @field.counter == 0
      pbDisplay(_INTL("Bits of rock fell from the crumbling ceiling!"))
      @field.counter += 1
    elsif @field.counter > 0
      @field.counter = 0
      pbDisplay(_INTL("The quake collapsed the ceiling!"))
      $game_variables[:Cave_Collapse] = 1
      for i in @battlers
        # rewriting this for sanity purposes. "next if" implies quakedrop == 0
        quakedrop = i.totalhp
        for j in PBStuff::INVULEFFECTS
          quakedrop = 0 if i.effects[j] == true
        end
        next if quakedrop == 0
        next if i.ability == :BULLETPROOF || i.ability == :ROCKHEAD || i.ability == :STALWART
        next if PBStuff::TWOTURNMOVE.include?(i.effects[:TwoTurnAttack])
        next if i.pbOwnSide.effects[:WideGuard]
        next if i.pbOwnSide.effects[:MatBlock]
        next if i.pbOwnSide.effects[:QuickGuard] && basemove.priorityCheck(user) > 0
        next if i.effects[:Protect]
        next if i.effects[:SkyDrop]
        next if i.effects[:Commander] # Gen 9 Mod - Added Commander immunity to when inside Dondozo's mouth.

        quakedrop -= 1 if i.effects[:Endure] || i.ability == :STURDY
        quakedrop /= 2 if i.ability == :SHELLARMOR || i.ability == :BATTLEARMOR
        quakedrop /= 3 if i.ability == :PRISMARMOR || i.ability == :SOLIDROCK
        i.pbReduceHP(quakedrop) if quakedrop != 0
        i.pbFaint if i.isFainted?
      end
    end
    return false
  end

  def mirrorShatter(basemove, user)
    for i in @battlers
      # rewriting this for sanity purposes. "next if" implies shatter == 0
      shatter = i.totalhp / 2
      for j in PBStuff::INVULEFFECTS
        shatter = 0 if i.effects[j] == true
      end
      next if shatter == 0
      next if PBStuff::TWOTURNMOVE.include?(i.effects[:TwoTurnAttack])
      next if i.ability == :SHELLARMOR || i.ability == :BATTLEARMOR
      next if i.pbOwnSide.effects[:WideGuard]
      next if i.pbOwnSide.effects[:MatBlock]
      next if i.pbOwnSide.effects[:QuickGuard] && basemove.priorityCheck(user) > 0
      next if i.effects[:Protect]
      next if i.effects[:SkyDrop]
      next if i.effects[:Commander] # Gen 9 Mod - Added Commander immunity when inside Dondozo's mouth.

      i.pbReduceHP(shatter) if shatter != 0
      i.pbFaint if i.isFainted?
    end
    return true
  end

  # Underwater
  def waterPollution
    @battle.pbDisplay(_INTL("The water was polluted!"))
    for i in 0...4
      toxicdrown = @battle.battlers[i].totalhp
      next if toxicdrown == 0

      toxicdrown = 0 if PBStuff::TWOTURNMOVE.include?(@battle.battlers[i].effects[:TwoTurnAttack])
      toxicdrown = 0 if @battle.battlers[i].hasType?(:POISON)
      toxicdrown = 0 if @battle.battlers[i].hasType?(:STEEL)
      @battle.battlers[i].pbReduceHP(toxicdrown) if toxicdrown != 0
      @battle.battlers[i].pbFaint if @battle.battlers[i].isFainted?
      @battle.field.counter = 0
    end
  end

  # Icy Field
  def iceSpikes
    if !(@battle.field.backup == :WATERSURFACE || @battle.field.backup == :MURKWATERSURFACE)
      spikevar = false
      if @battle.battlers[0].pbOwnSide.effects[:Spikes] < 3
        @battle.battlers[0].pbOwnSide.effects[:Spikes] += 1
        spikevar = true
      end
      if @battle.battlers[1].pbOwnSide.effects[:Spikes] < 3
        @battle.battlers[1].pbOwnSide.effects[:Spikes] += 1
        spikevar = true
      end
      if spikevar
        @battle.pbDisplay(_INTL("The quake broke up the ice into spiky pieces!"))
      end
    end
  end

  def concertNoise
    noisedamage = false
    for i in @battlers
      if i.status == :SLEEP || i.ability == :COMATOSE
        i.status = nil if i.status == :SLEEP
        i.ability = nil if i.ability == :COMATOSE
        i.pbReduceHP(i.totalhp / 4)
        i.pbFaint if i.isFainted?
        noisedamage = true
      end
    end
    if noisedamage
      @battle.pbDisplay(_INTL("The Concert's noise could wake up even the dead!"))
    end
  end

  # Superheated, Volcanic Top, Ashen Beach
  def fieldAccuracyDrop
    @battle.pbDisplay(_INTL("Steam shot up from the field!")) if @field.effect == :SUPERHEATED || @field.effect == :VOLCANICTOP
    @battle.pbDisplay(_INTL("The attack stirred up the ash on the ground!")) if @field.effect == :ASHENBEACH
    for i in 0...4
      canthit = PBStuff::TWOTURNMOVE.include?(@battle.battlers[i].effects[:TwoTurnAttack])
      canthit = true if @battle.battlers[i].effects[:SkyDrop]
      @battle.battlers[i].pbReduceStat(PBStats::ACCURACY, 1, abilitymessage: false) if !canthit
    end
  end

  # Volcanic Top
  def eruptionChecker
    @battle.pbDisplay(_INTL("The volcano is going to erupt!")) if !@battle.eruption
    @battle.eruption = true
  end

  # Flower Garden
  def growField(text, user)
    newfield = nil
    if @battle.ProgressiveFieldCheck(PBFields::FLOWERGARDEN, 1, 4)
      stagejump = 1
      stagejump = 2 if user.ability == :RIPEN
      newindex = PBFields::FLOWERGARDEN.index(@battle.FE) + stagejump
      newindex = 4 if newindex > 4
      newfield = PBFields::FLOWERGARDEN[newindex]
    elsif @battle.ProgressiveFieldCheck(PBFields::CONCERT, 1, 3)
      newindex = (PBFields::CONCERT.index(@battle.FE)) + 1
      @battle.concertNoise if newindex > 2
      newfield = PBFields::CONCERT[newindex]
    elsif @battle.ProgressiveFieldCheck(PBFields::DARKNESS, 1, 2)
      newindex = (PBFields::DARKNESS.index(@battle.FE)) + 1
      newfield = PBFields::DARKNESS[newindex]
    end
    return if newfield.nil?

    setField(newfield, add_on: false, growth: true)
    pbDisplay(_INTL("{1} grew the garden!", text)) if @battle.ProgressiveFieldCheck(PBFields::FLOWERGARDEN)
    pbDisplay(_INTL("{1} is getting the crowd hyped!", text)) if @battle.ProgressiveFieldCheck(PBFields::CONCERT)
    pbDisplay(_INTL("{1}", text)) if @battle.ProgressiveFieldCheck(PBFields::DARKNESS)
  end

  def reduceField
    newfield = nil
    if @battle.ProgressiveFieldCheck(PBFields::FLOWERGARDEN, 2, 5)
      newindex = (PBFields::FLOWERGARDEN.index(@battle.FE)) - 1
      newfield = PBFields::FLOWERGARDEN[newindex]
    elsif @battle.ProgressiveFieldCheck(PBFields::CONCERT, 2, 4)
      newindex = (PBFields::CONCERT.index(@battle.FE)) - 1
      newfield = PBFields::CONCERT[newindex]
    elsif @battle.ProgressiveFieldCheck(PBFields::DARKNESS, 2, 3)
      newindex = (PBFields::DARKNESS.index(@battle.FE)) - 1
      newfield = PBFields::DARKNESS[newindex]
    end
    return if newfield.nil?

    setField(newfield, add_on: false, growth: true)
    pbDisplay(_INTL("The garden was cut down!")) if @battle.ProgressiveFieldCheck(PBFields::FLOWERGARDEN)
    pbDisplay(_INTL("The crowd is booing!")) if @battle.ProgressiveFieldCheck(PBFields::CONCERT)
    pbDisplay(_INTL("The shadows retreat!")) if @battle.ProgressiveFieldCheck(PBFields::DARKNESS)
  end

  # checks whether specific stages of a field with multiple stages is in effect (mainly Flowergarden)
  def ProgressiveFieldCheck(field, startstage = 1, endstage = nil)
    if field == "All"
      return true if ProgressiveFieldCheck(PBFields::FLOWERGARDEN)

      if Rejuv
        return true if ProgressiveFieldCheck(PBFields::CONCERT)
      end
      if Desolation
        return true if ProgressiveFieldCheck(PBFields::DARKNESS)
      end
      return false
    end
    endstage = field.length if endstage.nil?
    for i in startstage - 1...endstage
      return true if @battle.FE == field[i]
    end
    return false
  end

  def getRandomType(except = [])
    except = [except] if except && !except.is_a?(Array)
    types = []
    for j in $cache.types.keys
      types.push(j) if j != :QMARKS && j != :SHADOW && !except.include?(j)
    end
    rnd = @battle.pbRandom(types.length)
    type = types[rnd]
    return type
  end

  def NWTypeRoll(mon)
    roll = 9
    roll = @battle.pbRandom(pulseArceusTypes) while roll == 9 # exclude qmarks
    roll += pulseArceusTypes if (mon.species == :ARCEUS && $game_switches[:Pulse_Arceus] && mon.pokemon.trainerID == 00000) # || ($DEBUG && $INTERNAL)
    if mon.form != roll
      backupspecies = mon.pokemon.species
      mon.form = roll
      abil = getAbilityName(mon.ability)
      pbDisplay(_INTL("{1}'s {2} activated!", mon.pbThis, abil))
      pbCommonAnimation("TypeRoll", mon, nil)
      mon.form = mon.pokemon.form
      mon.pokemon.species = mon.species if mon.effects[:Transform]
      mon.pbUpdate(true)
      @scene.pbChangePokemon(mon, mon.pokemon)
      mon.pokemon.species = backupspecies
      pbDisplay(_INTL("{1} rolled the {2} type!", mon.pbThis, mon.type1.capitalize))
    end
  end

  #friendly helpful function to avoid calling triple-nested arrays in the code
  #gosh whose idea was that
  def fieldeffectchecker(parameter,section) #find [thing] in [place]
    if FIELDEFFECTS[@field.effect][section]
      for object in FIELDEFFECTS[@field.effect][section].keys
        for i in FIELDEFFECTS[@field.effect][section][object]
          return object if parameter == i
        end
      end
    end
    return nil
  end
end

class PokeBattle_Move
  def runCondition(code, attacker)
    return eval(code)
  end

  def typeFieldMessage(type)
    fieldtype = @battle.field.typeData(type)
    return nil if !fieldtype || !fieldtype[:multtext]

    return @battle.field.data.typemessagelist[fieldtype[:multtext] - 1]
  end

  def typeFieldBoost(type, attacker = nil, opponent = nil) # returns multiplier value of field boost
    fieldtype = @battle.field.typeData(type)
    return 1 if !fieldtype || !fieldtype[:mult]
    return 1 if fieldtype[:mult] && @battle.field.effect == :STARLIGHT && !(@battle.pbWeather == 0 || @battle.pbWeather == :STRONGWINDS) # starlight arena

    if fieldtype[:condition] && attacker && opponent
      return 1 if !eval(fieldtype[:condition])
    end
    if $game_variables[:DifficultyModes] == 1 && !$game_switches[:FieldFrenzy]
      mult = 0
      mult = ((fieldtype[:mult] - 1.0) / 2.0) + 1.0 unless fieldtype[:mult] == 0
      return mult
    elsif $game_variables[:DifficultyModes] != 1 && $game_switches[:FieldFrenzy]
      mult = 0
      if fieldtype[:mult] != 0
        mult = ((fieldtype[:mult] - 1.0) * 2.0) + 1.0 if fieldtype[:mult] > 1
        mult = fieldtype[:mult] / 2.0 if fieldtype[:mult] < 1
      end
      return mult
    else
      return fieldtype[:mult]
    end
  end

  def moveFieldMessage
    fieldmove = @battle.field.moveData(@move)
    return nil if !fieldmove || !fieldmove[:multtext]

    return @battle.field.data.movemessagelist[fieldmove[:multtext] - 1]
  end

  def moveFieldBoost
    fieldmove = @battle.field.moveData(@move)
    return 1 if !fieldmove || !fieldmove[:mult]
    return 1 if fieldmove[:mult] && @battle.field.effect == :STARLIGHT && !(@battle.pbWeather == 0 || @battle.pbWeather == :STRONGWINDS) # starlight arena

    if $game_variables[:DifficultyModes] == 1 && !$game_switches[:FieldFrenzy]
      mult = 0
      mult = ((fieldmove[:mult] - 1.0) / 2.0) + 1.0 unless fieldmove[:mult] == 0
      return mult
    elsif $game_variables[:DifficultyModes] != 1 && $game_switches[:FieldFrenzy]
      mult = 0
      if fieldmove[:mult] != 0
        mult = ((fieldmove[:mult] - 1.0) * 2.0) + 1.0 if fieldmove[:mult] > 1
        mult = fieldmove[:mult] / 2.0 if fieldmove[:mult] < 1
      end
      return mult
    else
      return fieldmove[:mult]
    end
  end

  def changeFieldMessage
    fieldmove = @battle.field.moveData(@move)
    return nil if !fieldmove || !fieldmove[:changetext]

    return @battle.field.data.changemessagelist[fieldmove[:changetext] - 1]
  end

  def checkFieldChange(attacker, opponent)
    fieldmove = @battle.field.moveData(@move)
    return nil if !fieldmove || !fieldmove[:fieldchange]

    if fieldmove[:condition]
      return nil if !eval(fieldmove[:condition])
    end
    return fieldmove[:fieldchange]
  end

  def typeOverlayMessage(type, overlay)
    return nil if !Rejuv

    overlaytype = $cache.FEData[overlay].overlaytypedata[type]
    return nil if !overlaytype || !overlaytype[:multtext]

    return $cache.FEData[overlay].overlaytypemessagelist[overlaytype[:multtext] - 1]
  end

  def typeOverlayBoost(type, attacker = nil, opponent = nil) # returns multiplier value of overlay boost
    return 1 if !Rejuv

    overlayBoost = 1
    booster = nil
    for terrain in [:ELECTERRAIN, :GRASSY, :MISTY, :PSYTERRAIN]
      next if @battle.state.effects[terrain] == 0

      overlaytype = $cache.FEData[terrain].overlaytypedata[type]
      next if !overlaytype || !overlaytype[:mult]

      if overlaytype[:condition] && attacker && opponent
        next if !eval(overlaytype[:condition])
      end
      if $game_variables[:DifficultyModes] == 1 && !$game_switches[:FieldFrenzy]
        mult = ((overlaytype[:mult] - 1.0) / 2.0) + 1.0
      elsif $game_variables[:DifficultyModes] != 1 && $game_switches[:FieldFrenzy]
        mult = ((overlaytype[:mult] - 1.0) * 2.0) + 1.0 if overlaytype[:mult] > 1
        mult = overlaytype[:mult] / 2.0 if overlaytype[:mult] < 1
      else
        mult = overlaytype[:mult]
      end
      if mult && mult > overlayBoost
        overlayBoost = mult
        booster = terrain
      end
    end
    return overlayBoost, booster
  end

  def moveOverlayMessage(overlay)
    return nil if !Rejuv

    overlaymove = $cache.FEData[overlay].overlaymovedata[@move]
    return nil if !overlaymove || !overlaymove[:multtext]

    return $cache.FEData[overlay].overlaymovemessagelist[overlaymove[:multtext] - 1]
  end

  def moveOverlayBoost(overlay)
    return 1 if !Rejuv

    overlaymove = $cache.FEData[overlay].overlaymovedata[@move]
    return 1 if !overlaymove || !overlaymove[:mult]

    if $game_variables[:DifficultyModes] == 1 && !$game_switches[:FieldFrenzy]
      mult = ((overlaymove[:mult] - 1.0) / 2.0) + 1.0
      return mult
    elsif $game_variables[:DifficultyModes] != 1 && $game_switches[:FieldFrenzy]
      mult = ((overlaymove[:mult] - 1.0) * 2.0) + 1.0 if overlaymove[:mult] > 1
      mult = overlaymove[:mult] / 2.0 if overlaymove[:mult] < 1
      return mult
    else
      return overlaymove[:mult]
    end
  end

  def fieldDefenseBoost(type, target)
    defmult = 1
    case @battle.FE
      when :MISTY
        defmult *= 1.5 if pbHitsSpecialStat?(type) && target.hasType?(:FAIRY)
      when :DARKCRYSTALCAVERN
        defmult *= 1.5 if target.hasType?(:DARK) || target.hasType?(:GHOST)
        defmult *= 1.33 if target.ability == :PRISMARMOR
      when :RAINBOW
        defmult *= 1.33 if target.ability == :PRISMARMOR
      when :DRAGONSDEN
        defmult *= 1.3 if target.hasType?(:DRAGON)
      when :NEWWORLD
        defmult *= 0.9 if target.isAirborne?
      when :SNOWYMOUNTAIN
        defmult *= 1.5 if pbHitsPhysicalStat?(type) && target.hasType?(:ICE) && @battle.pbWeather == :HAIL
      when :ICY
        defmult *= 1.5 if pbHitsPhysicalStat?(type) && target.hasType?(:ICE) && @battle.pbWeather == :HAIL
      when :DESERT
        defmult *= 1.5 if pbHitsSpecialStat?(type) && target.hasType?(:GROUND)
      when :CRYSTALCAVERN
        defmult *= 1.33 if target.ability == :PRISMARMOR
      when :DIMENSIONAL
        defmult *= 1.5 if target.hasType?(:GHOST)
      when :FROZENDIMENSION
        defmult *= 1.2 if target.hasType?(:GHOST) || target.hasType?(:ICE)
        defmult *= 0.8 if target.hasType?(:FIRE)
      when :DARKNESS2
        defmult *= 1.1 if target.hasType?(:DARK) || target.hasType?(:GHOST)
      when :DARKNESS3
        defmult *= 1.20 if target.hasType?(:DARK) || target.hasType?(:GHOST)
    end
    return defmult
  end
end

class PokeBattle_Battler
  def burningFieldPassiveDamage?
    return false if hasType?(:FIRE) || @effects[:AquaRing]
    return false if [:FLAREBOOST, :MAGMAARMOR, :FLAMEBODY, :FLASHFIRE].include?(@ability)
    return false if [:WATERVEIL, :MAGICGUARD, :HEATPROOF, :WATERBUBBLE].include?(@ability)
    return false if $cache.moves[@effects[:TwoTurnAttack]] && [0xCA, 0xCB].include?($cache.moves[@effects[:TwoTurnAttack]].function) # Dig, Dive

    if self.isbossmon
      return false if self.immunities[:fieldEffectDamage].include?(@battle.FE)
    end
    return true
  end

  def underwaterFieldPassiveDamamge?
    return false if hasType?(:WATER)
    return false if @ability == :SWIFTSWIM || @ability == :MAGICGUARD
    return false if PBTypes.twoTypeEff(:WATER, @type1, @type2) <= 4

    if self.isbossmon
      return false if self.immunities[:fieldEffectDamage].include?(@battle.FE)
    end
    return true
  end

  def murkyWaterSurfacePassiveDamage?
    return false if hasType?(:STEEL) || hasType?(:POISON)
    return false if [:POISONHEAL, :MAGICGUARD, :WONDERGUARD, :TOXICBOOST, :IMMUNITY, :PASTELVEIL].include?(@ability)
    return false if Rejuv && @ability == :SURGESURFER
    return false if self.crested == :ZANGOOSE

    if self.isbossmon
      return false if self.immunities[:fieldEffectDamage].include?(@battle.FE)
    end
    return true
  end
end

def pulseArceusTypes
  return 19
end

