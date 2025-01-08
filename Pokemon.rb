# This class stores data on each Pokemon.  Refer to $Trainer.party for an array
# of each Pokemon in the Trainer's current party.
class PokeBattle_Pokemon
  # stat information
  attr_reader :totalhp       # Current Total HP
  attr_reader :attack        # Current Attack stat
  attr_reader :defense       # Current Defense stat
  attr_accessor :speed       # Current Speed stat
  attr_reader :spatk         # Current Special Attack stat
  attr_reader :spdef         # Current Special Defense stat
  attr_accessor :iv          # Individual Values
  attr_accessor :ev          # Effort Values
  attr_accessor :species     # Species (National Pokedex number)
  attr_accessor :moves       # Moves (PBMove)
  attr_accessor :zmoves      # Z-Moves (PBMove)
  attr_accessor :hp          # Current HP
  attr_accessor :item        # Held item
  attr_accessor :name        # Nickname
  attr_accessor :exp         # Current experience points
  attr_accessor :level
  attr_accessor :happiness   # Current happiness
  attr_accessor :status      # Status problem (PBStatuses)
  attr_accessor :form
  attr_accessor :ability
  # other data
  attr_accessor :personalID  # Personal ID
  attr_accessor :trainerID   # 32-bit Trainer ID
  attr_accessor :mail        # Mail
  attr_accessor :fused       # The Pokémon fused into this one
  attr_accessor :eggsteps    # Steps to hatch egg, 0 if Pokémon is not an egg
  attr_accessor :firstmoves  # The moves known when this Pokémon was obtained
  attr_accessor :ballused    # Ball used
  attr_accessor :markings    # Markings
  attr_accessor :obtainMode
  attr_accessor :obtainMap   # Map where obtained
  attr_accessor :obtainText  # Replaces the obtain map's name if not nil
  attr_accessor :obtainLevel # Level obtained
  attr_accessor :hatchedMap  # Map where an egg was hatched
  attr_accessor :language    # Language
  attr_accessor :ot          # Original Trainer's name
  # attr_accessor(:ribbons)     # Array of ribbons
  attr_accessor :cool, :beauty, :cute, :smart, :tough, :sheen # Contest stats
  attr_accessor :obedient
  attr_accessor :pokerus # Pokérus strain and infection time
  # modification flags
  attr_accessor :genderflag  # Forces male (0) or female (1)
  attr_accessor :natureflag  # Forces a particular nature
  attr_accessor :shinyflag   # Forces the shininess (true/false)
  attr_accessor :hptype

  # battle info
  attr_accessor :itemRecycle # Consumed held item (used in battle only)
  attr_accessor :itemInitial # Resulting held item (used in battle only)
  attr_accessor :itemReallyInitialHonestlyIMeanItThisTime # Original held item (used in battle only)
  attr_accessor :belch       # If pokemon has used belch this battle (used in battle only)
  attr_accessor :statusCount # Sleep count/Toxic flag
  attr_accessor :piece       # Piece roll given for Chess field
  attr_accessor :landCritical # Galarian Farfetch'd evo method (used in battle only)
  attr_accessor :corrosiveGas # Corrosive Gas Effect (used in battle only)
  attr_accessor :originalAbility # stores original ability for semi permanent ability changes (mega evolution etc.)
  attr_accessor :originalForm # stores startform in battle for semi permanent form changes (Power construct, ultraburst, some mega's)
  attr_accessor :fakeOT
  attr_accessor :relearner
  attr_accessor :megaEvo

  # evolution data
  # Gen 9 Mod - Added evolution methods: LevelWalk, LevelUseMove, EnemyDefeat.
  attr_accessor :defeatedEnemies # number of kills while holding an item (for evolution only)
  attr_accessor :usedMoves # number of times a certain move was used (for evolution check only)
  attr_accessor :levelWalkSteps #number steps while on part
  # Gen 9 Mod - Added transformation check for Palafin.
  attr_accessor :justTransformed #check if the transformation just happened or not

  def initialize(species, level, player = $Trainer, withMoves = true, form = 0)
    @form = form
    if $game_switches[:Just_Budew]
      species = :BUDEW
      @form = 0
    elsif $game_switches[:Just_Vulpix]
      species = :VULPIX
      @form = rand(2)
    end
    @species = species
    @moves = []
    @personalID = (rand(65536) | (rand(65536) << 16))
    @trainerID=player.id
    if $PokemonBag.pbQuantity(:SHINYCHARM) > 0
      rolls = 2 #3 tries with shiny charm aka 3 times as likely
      for i in 0...rolls
        break if self.isShiny?
        @personalID = (rand(65536) | (rand(65536) << 16))
      end
    end
    if $game_variables[:LuckShinies] > 0
      rolls = 4 #5 tries with Luck contract aka 5 times as likely
      for i in 0...rolls
        break if self.isShiny?
        @personalID = (rand(65536) | (rand(65536) << 16))
      end
    end
    initAbility
    if withMoves
      # Generating move list
      movelist=[]
      moveset = formCheck(:Moveset)
      moveset = !moveset.nil? ? moveset : $cache.pkmn[@species].Moveset
      for k in 0...moveset.length

        alevel=moveset[k][0]
        movelist.push(moveset[k][1]) if alevel<=level
      end
      movelist.reverse!
      movelist.uniq!
      # Use the first 4 items in the move list
      movelist = movelist[0,4]
      movelist.reverse!
      for i in 0...4
        next if i>=movelist.length
        @moves[i]=PBMove.new(movelist[i])
      end
    end
    @nature = $cache.natures.keys[@personalID % 25]
    @hp=1
    @totalhp=1
    @ev=[0,0,0,0,0,0]
    @iv=[rand(32),rand(32),rand(32),rand(32),rand(32),rand(32)]
    if $cache.pkmn[species].EggGroups.include?(:Undiscovered) || @species == :MANAPHY #undiscovered group or manaphy
      stat1, stat2, stat3 = [0,1,2,3,4,5].sample(3)
      for i in 0..5
        @iv[i] = 31 if [stat1,stat2,stat3].include?(i)
      end
    end
    #IV overrides
    @iv=[31,31,31,31,31,31] if $game_switches[:Full_IVs] || $game_switches[:Standard_S]
    @iv=[0,0,0,0,0,0] if $game_switches[:Empty_IVs_Password]
    @level = level
    @exp=PBExp.startExperience(level,self.growthrate)
    self.calcStats
    @hp=@totalhp

    #Flavor data
    @ot=player.name
    @language=player.language
    @happiness=$cache.pkmn[species].Happiness
    @name=getMonName(@species)
    timediverge = $Settings.unrealTimeDiverge
    $Settings.unrealTimeDiverge = 0
    time=pbGetTimeNow
    time = Time.unrealTime_oldTimeNew(time.year-40,time.month,time.day,time.hour,time.min,time.sec) if Rejuv && inPast?
    @timeReceived=time.getgm.to_i # Use GMT
    $Settings.unrealTimeDiverge = timediverge
    @eggsteps=0
    @status=nil
    @statusCount=0
    @item=nil
    @mail=nil
    @fused=nil
    @ballused= :POKEBALL
    @obtainMap=$game_map.map_id
    @obtainText=nil
    @obtainLevel=level
    @landcritical=0
    @obtainMode=0   # Met
    @obtainMode=4 if $game_switches[:Fateful_Encounter]
    @hatchedMap=0
    @relearner=[false,0]
    # Gen 9 Mod - Added evolution methods: EnemyDefeat, LevelUseMove, WalkSteps (EnemyDefeat = Kingambit, LevelUseMove = Annihilape, WalkSteps = Rellor, Pawmo, Brambrin)
    @defeatedEnemies=0
    @usedMoves=0
    @levelWalkSteps=0
    # Gen 9 Mod - Added transformation check for Palafin.
    @justTransformed=0
  end

  def formCheck(attribute)
    return nil if @form == 0 && !(cancelledgenders.include?(@species) && self.isFemale?)
    return nil if $cache.pkmn[@species].formData.empty?
    return $cache.pkmn[@species].formData.dig(self.getFormName,attribute)
  end

  #more flavor stuff
  def personalID(checkHiddenID=false)
    return @personalID.to_i if @personalID.is_a?(Numeric) || !checkHiddenID
    return @personalID
  end

  ################################################################################
  # Stat calculations, Pokémon creation
  ################################################################################
  def baseStats
    val = formCheck(:BaseStats)
    val = [70, 70, 70, 90, 70, 100] if @species == :CASTFORM && @item == :CASTCREST && @form == 1
    val = [100, 70, 80, 70, 80, 70] if @species == :CASTFORM && @item == :CASTCREST && @form == 2
    val = [70, 70, 70, 100, 70, 90] if @species == :CASTFORM && @item == :CASTCREST && @form == 3
    return !val.nil? ? val : $cache.pkmn[@species].BaseStats
  end

  def calcHP(base,level,iv,ev)
    return 1 if base==1
    return ((base*2+iv+(ev>>2))*level/100).floor+level+10
  end

  def calcStat(base,level,iv,ev,naturemod)
    naturemod = 1 if naturemod == nil
    return ((((base*2+iv+(ev>>2))*level/100).floor+5)*naturemod).floor
  end

  def calcStats
    @nature = $cache.natures.keys[self.personalID % 25] if @nature.nil?
    stats=[]
    level=self.level
    bs=self.baseStats
    naturemod = {
      $cache.natures[self.nature].incStat => 1.1,
      $cache.natures[self.nature].decStat => 0.9
    }
    for i in 0..5
      base=bs[i]
      if i==0
        stats[i]=calcHP(base,level,@iv[i],@ev[i])
      else
        stats[i]=calcStat(base,level,@iv[i],@ev[i],naturemod.dig(i))
      end
    end
    diff=@totalhp-@hp
    @totalhp=stats[0]
    if @hp>0
      @hp=@totalhp-diff
      @hp=1 if @hp<=0
      @hp=@totalhp if @hp>@totalhp
    end
    @attack=stats[1]
    @defense=stats[2]
    @spatk=stats[3]
    @spdef=stats[4]
    @speed=stats[5]
  end

  ################################################################################
  # Level
  ################################################################################
  def level=(value)
    @level = value.to_i
  end

  def isEgg?
    return @eggsteps>0
  end

  def growthrate
    val = formCheck(:GrowthRate)
    return !val.nil? ? val : $cache.pkmn[@species].GrowthRate
  end

  def baseExp
    val = formCheck(:BaseEXP)
    return !val.nil? ? val : $cache.pkmn[@species].BaseEXP
  end


################################################################################
# Ability
################################################################################
  def abilityIndex
    abillist = getAbilityList
    abil=abillist[self.personalID % (abillist.length)]
    abil = 0 if abil.nil?
    return abil
  end

  def initAbility
    abillist = getAbilityList
    @ability = abillist[self.personalID % (abillist.length)]
  end

  def setAbility(value)
    @ability=value
    @ability = getAbilityList[value] if value.is_a?(Integer)
  end

  def getAbilityList
    abillist = $cache.pkmn[@species].Abilities
    abillist += [$cache.pkmn[@species].flags[:HiddenAbilities]] if $cache.pkmn[@species].checkFlag?(:HiddenAbilities)
    if @form != 0 || (cancelledgenders.include?(@species) && self.isFemale?)
      v = self.formCheck(:Abilities)
      abillist = v.is_a?(Array) ? v :[v] if v!=nil
      abillist += [self.formCheck(:HiddenAbilities)] if v!=nil && self.formCheck(:HiddenAbilities)
    end
    return abillist
  end

################################################################################
# Types
################################################################################
  def hasType?(type)
    return self.type1==type || self.type2==type
  end

  def type1
    if @species == :ARCEUS && @ability == :MULTITYPE
      type = $cache.pkmn[@species].forms[self.form%19].upcase.intern
      type = :QMARKS if type == "???".intern
      return type
    elsif @species == :SILVALLY && @ability == :RKSSYSTEM
      type = $cache.pkmn[@species].forms[self.form].upcase.intern
      type = :QMARKS if type == "???".intern
      return type
    else
      val = formCheck(:Type1)
      return !val.nil? ? val : $cache.pkmn[@species].Type1
    end
  end

  def type2
    #return nil if @species == :SILVALLY || @species == :ARCEUS
    val = formCheck(:Type2)
    check = formCheck(:Type1)
    return (check.nil? && val.nil?) ? $cache.pkmn[@species].Type2 : val
  end

################################################################################
# Moves
################################################################################
  def numMoves
    ret=0
    for i in 0...4
      ret+=1 if !@moves[i].nil?
    end
    return ret
  end

  def knowsMove?(move)
    for i in 0...4
      next if @moves[i].nil?
      return true if @moves[i].move==move
    end
    return false
  end

  def getMoveList
    v = $cache.pkmn[@species].formData.dig(self.getFormName, :Moveset) if @form > 0 || (cancelledgenders.include?(@species) && self.isFemale?)
    v = $cache.pkmn[@species].Moveset if !v || v.nil?
    return v
  end

  def getEggMoveList(relearner=false)
    babyspecies = pbGetBabySpecies(@species,@form)
    preevo = pbGetPreviousForm(@species,form)
    if !$cache.pkmn[babyspecies[0]].EggMoves.nil?
      movelist = $cache.pkmn[babyspecies[0]].EggMoves
      if relearner == true
        if !$cache.pkmn[preevo[0]].EggMoves.nil?
          movelist += $cache.pkmn[preevo[0]].EggMoves
        end
        movelist.uniq!
      end
      if babyspecies[1] != 0
        formname = $cache.pkmn[babyspecies[0]].forms[babyspecies[1]]
        movelist = $cache.pkmn[babyspecies[0]].formData.dig(formname,:EggMoves)
      end
    end
    movelist = [] if movelist.nil?
    return movelist
  end

  def resetMoves
    @moves = []
    moves=self.getMoveList
    movelist=[]
    for i in moves
      if i[0]<=self.level
        movelist.push(i[1])
      end
    end
    movelist|=[] # Remove duplicatesx
    listend=movelist.length-4
    listend=0 if listend<0
    for i in listend...listend+4
      next if i>=movelist.length
      @moves.push(PBMove.new(movelist[i]))
    end
  end

  def pbLearnMove(move)
    if knowsMove?(move)
      @moves.delete(move)
    end
    @moves=@moves.push(PBMove.new(move))
    if @moves.length > 4
      @moves=@moves.drop(1)
    end
    initZmoves(@item,true) if $cache.items[@item] && $cache.items[@item].checkFlag?(:zcrystal)
  end

# Deletes all moves from the Pokémon.
  def pbDeleteAllMoves
    for i in 0...4
      @moves[i]=nil
    end
  end

# Copies currently known moves into a separate array, for Move Relearner.
  def pbRecordFirstMoves
    @firstmoves=[]
    for i in 0...4
      @firstmoves.push(@moves[i].move) if @moves[i]
    end
  end

  def SpeciesCompatible?(move)
    return false if @species.nil?
    exceptionlist = formCheck(:moveexceptions)
    exceptionlist = $cache.pkmn[@species].moveexceptions if exceptionlist.nil?
    return false if exceptionlist.include?(move)
    return true if @species == :MEW
    return true if PBStuff::UNIVERSALTMS.include?(move)
    tmmovelist = formCheck(:compatiblemoves)
    tmmovelist = $cache.pkmn[@species].compatiblemoves if tmmovelist.nil?
    return true if tmmovelist.include?(move)
    movelist = getMoveList
    leveluplist = []
    for pair in movelist
      leveluplist.push pair[1]
    end
    if leveluplist.include?(move)
      #puts "#{@species} with form #{@form} is compatible with #{move} via levelup learnset, please add it to it's 'compatiblemoves' for efficiency!"
      return true
    end
    egglist = getEggMoveList
    if egglist.include?(move)
      #puts "#{@species} with form #{@form} is compatible with #{move} via it's Egg Moves, please add it to it's 'compatiblemoves' for efficiency!"
      return true
    end
    return false
  end

  def initZmoves(crystal,player=false)
    zcrystal_to_type = PBStuff::TYPETOZCRYSTAL.invert
    @zmoves = [nil,nil,nil,nil]
    if crystal == :INTERCEPTZ
      @zmoves[0] = PBMove.new(:UNLEASHEDPOWER)
      @zmoves[1] = PBMove.new(:BLINDINGSPEED)
      @zmoves[2] = $game_switches[:RenegadeRoute] && player ? PBMove.new(:CHTHONICMALADY) : PBMove.new(:ELYSIANSHIELD)
      @zmoves[3] = PBMove.new(:DOMAINSHIFT)
    elsif zcrystal_to_type[crystal]
      for i in 0...@moves.length
        move = @moves[i]
        next if move.type != zcrystal_to_type[crystal]
        @zmoves[i] = move.category == :status ? PBMove.new(move.move) : PBMove.new(PBStuff::CRYSTALTOZMOVE[crystal])
      end
    elsif (PBStuff::MOVETOZCRYSTAL.invert)[crystal]
      case crystal
      when :ALORAICHIUMZ then return if !(@species==:RAICHU && (@form==1))
      when :DECIDIUMZ then return if !(@species==:DECIDUEYE && (@form==0))
      when :INCINIUMZ then return if @species!=:INCINEROAR
      when :PRIMARIUMZ then return if @species!=:PRIMARINA
      when :EEVIUMZ then return if @species!=:EEVEE
      when :PIKANIUMZ then return if @species!=:PIKACHU
      when :SNORLIUMZ then return if @species!=:SNORLAX
      when :MEWNIUMZ then return if @species!=:MEW
      when :TAPUNIUMZ then return if !(@species==:TAPUKOKO || @species==:TAPULELE || @species==:TAPUFINI || @species==:TAPUBULU)
      when :MARSHADIUMZ then return if @species!=:MARSHADOW
      when :KOMMONIUMZ then return if @species!=:KOMMOO
      when :LYCANIUMZ then return if @species!=:LYCANROC
      when :MIMIKIUMZ then return if @species!=:MIMIKYU
      when :SOLGANIUMZ then return if !((@species==:NECROZMA && @form==1) || @species==:SOLGALEO)
      when :LUNALIUMZ then return if !((@species==:NECROZMA && @form==2) || @species==:LUNALA)
      when :ULTRANECROZIUMZ then return if !(@species==:NECROZMA && @form!=0)
      end
      for i in 0...@moves.length
        move = @moves[i]
        next if crystal != PBStuff::MOVETOZCRYSTAL[move.move]
        @zmoves[i] = PBMove.new(PBStuff::CRYSTALTOZMOVE[crystal])
      end
    end
  end

  def updateZMoveIndex(index)
    zcrystal_to_type = PBStuff::TYPETOZCRYSTAL.invert
    if zcrystal_to_type[@item]
      if @moves[index].type != zcrystal_to_type[@item]
        @zmoves[index] = nil
      else
        @zmoves[index] = @moves[index].category == :status ? PBMove.new(@moves[index].move) : PBMove.new(PBStuff::CRYSTALTOZMOVE[@item])
      end
    elsif (PBStuff::MOVETOZCRYSTAL.invert)[@item]
      speciesblock = false
      case @item
      when :ALORAICHIUMZ then speciesblock=true if !(@species==:RAICHU && (@form==1))
      when :DECIDIUMZ then speciesblock=true if !(@species==:DECIDUEYE && (@form==0))
      when :INCINIUMZ then speciesblock=true if @species!=:INCINEROAR
      when :PRIMARIUMZ then speciesblock=true if @species!=:PRIMARINA
      when :EEVIUMZ then speciesblock=true if @species!=:EEVEE
      when :PIKANIUMZ then speciesblock=true if @species!=:PIKACHU
      when :SNORLIUMZ then speciesblock=true if @species!=:SNORLAX
      when :MEWNIUMZ then speciesblock=true if @species!=:MEW
      when :TAPUNIUMZ then speciesblock=true if !(@species==:TAPUKOKO || @species==:TAPULELE || @species==:TAPUFINI || @species==:TAPUBULU)
      when :MARSHADIUMZ then speciesblock=true if @species!=:MARSHADOW
      when :KOMMONIUMZ then speciesblock=true if @species!=:KOMMOO
      when :LYCANIUMZ then speciesblock=true if @species!=:LYCANROC
      when :MIMIKIUMZ then speciesblock=true if @species!=:MIMIKYU
      when :SOLGANIUMZ then speciesblock=true if !((@species==:NECROZMA && @form==1) || @species==:SOLGALEO)
      when :LUNALIUMZ then speciesblock=true if !((@species==:NECROZMA && @form==2) || @species==:LUNALA)
      when :ULTRANECROZIUMZ then speciesblock=true if !(@species==:NECROZMA && @form!=0)
      end
      if (@item != PBStuff::MOVETOZCRYSTAL[@moves[index].move]) || speciesblock
        @zmoves[index] = nil
      else
        @zmoves[index] = PBMove.new(PBStuff::CRYSTALTOZMOVE[@item])
      end
    end
  end

  ################################################################################
  # Nature
  ################################################################################
  def nature
    return @natureflag if @natureflag!=nil
    return @nature
  end

  def setNature(value)
    @natureflag = value
    self.calcStats
  end

  def nature=(value)
    @nature = value
    self.calcStats
  end

  ################################################################################
  # Shininess
  ################################################################################
  def isShiny?
    return @shinyflag if @shinyflag!=nil
    a=self.personalID^@trainerID
    b=a&0xFFFF
    c=(a>>16)&0xFFFF
    d=b^c
    return (d<SHINYPOKEMONCHANCE)
  end

  def makeShiny
    @shinyflag=true
  end

  def makeNotShiny
    @shinyflag=false
  end

  ################################################################################
  # Gender
  ################################################################################
  def gender
    return @genderflag if @genderflag!=nil
    ratio=$cache.pkmn[@species].GenderRatio
    case ratio
      when :Genderless then return 2 # genderless
      when :MaleZero then return 1 # always female
      when :FemZero then return 0 # always male
      when :FemEighth then genderbyte = 31
      when :FemQuarter then genderbyte = 63
      when :FemHalf then genderbyte = 127
      when :MaleQuarter then genderbyte = 191
      when :MaleEighth then genderbyte = 223
    end
    return ((self.personalID&0xFF)<=genderbyte) ? 1 : 0
  end

  def isMale?
    return self.gender==0
  end

  def isFemale?
    return self.gender==1
  end

  def setGender(value)
    value = 0 if value == "Male"
    value = 1 if value == "Female"
    return if !value.is_a?(Integer)
    ratio=$cache.pkmn[@species].GenderRatio
    if ratio != :Genderless && ratio != :MaleZero && ratio != :FemZero
      @genderflag=value
    end
  end

  def makeMale; setGender(0); end
  def makeFemale; setGender(1); end
  def makeGenderless; setGender(2); end

  ################################################################################
  # Pokérus
  ################################################################################
  def givePokerus(strain=0)
    return if self.pokerusStage==2 # Can't re-infect a cured Pokémon
    if strain<=0 || strain>=16
      strain=1+rand(15)
    end
    time=1+(strain%4)
    @pokerus=time
    @pokerus|=strain<<4
  end

  def resetPokerusTime
    return if @pokerus==0
    strain=@pokerus%16
    time=1+(strain%4)
    @pokerus=time
    @pokerus|=strain<<4
  end

  def lowerPokerusCount
    return if self.pokerusStage!=1
    @pokerus-=1
  end

  def pokerusStage
    return 0 if !@pokerus || @pokerus==0        # Not infected
    return 2 if @pokerus>0 && (@pokerus%16)==0  # Cured
    return 1                                    # Infected
  end

################################################################################
# Forms
################################################################################
  def form=(value)
    @form=value
    self.calcStats
    $Trainer.pokedex.setFormSeen(self)
    $Trainer.pokedex.setFormOwned(self) if $Trainer.party.include?(self) || $PokemonStorage.contains?(self)
    if @species == :ROTOM
      formmoves = [:THUNDERSHOCK,:OVERHEAT,:HYDROPUMP,:BLIZZARD,:AIRSLASH,:LEAFSTORM]
      formmoves.each{|move|
         pbDeleteMoveByID(self,move)
      }
      self.pbLearnMove(formmoves[@form])
    end
  end

  def getForm (pkmn)
    if pkmn.species == :GIRATINA
      return pkmn.item == :GRISEOUSORB ? 1 : 0
    end
    if pkmn.species == :ARCEUS && pkmn.ability == :MULTITYPE
      case pkmn.item
        when :FISTPLATE, :FIGHTINIUMZ    then arcform = 1
        when :SKYPLATE, :FLYINIUMZ       then arcform = 2
        when :TOXICPLATE, :POISONIUMZ    then arcform = 3
        when :EARTHPLATE, :GROUNDIUMZ    then arcform = 4
        when :STONEPLATE, :ROCKIUMZ      then arcform = 5
        when :INSECTPLATE, :BUGINIUMZ    then arcform = 6
        when :SPOOKYPLATE, :GHOSTIUMZ    then arcform = 7
        when :IRONPLATE, :STEELIUMZ      then arcform = 8
        when :FLAMEPLATE, :FIRIUMZ       then arcform = 10
        when :SPLASHPLATE, :WATERIUMZ    then arcform = 11
        when :MEADOWPLATE, :GRASSIUMZ    then arcform = 12
        when :ZAPPLATE, :ELECTRIUMZ      then arcform = 13
        when :MINDPLATE, :PSYCHIUMZ      then arcform = 14
        when :ICICLEPLATE, :ICIUMZ       then arcform = 15
        when :DRACOPLATE, :DRAGONIUMZ    then arcform = 16
        when :DREADPLATE, :DARKINIUMZ    then arcform = 17
        when :PIXIEPLATE, :FAIRIUMZ      then arcform = 18
        else arcform = 0
      end
      return 19+arcform if pkmn.form > 18
      return arcform
    end
    if pkmn.species == :GENESECT
      case pkmn.item
        when :SHOCKDRIVE   then return 1
        when :BURNDRIVE    then return 2
        when :CHILLDRIVE   then return 3
        when :DOUSEDRIVE   then return 4
        else return 0
      end
    end
    if pkmn.species == :SILVALLY && pkmn.ability == :RKSSYSTEM
      case pkmn.item
        when :FIGHTINGMEMORY  then return 1
        when :FLYINGMEMORY    then return 2
        when :POISONMEMORY    then return 3
        when :GROUNDMEMORY    then return 4
        when :ROCKMEMORY      then return 5
        when :BUGMEMORY       then return 6
        when :GHOSTMEMORY     then return 7
        when :STEELMEMORY     then return 8
        when :GLITCHMEMORY    then return 9
        when :FIREMEMORY      then return 10
        when :WATERMEMORY     then return 11
        when :GRASSMEMORY     then return 12
        when :ELECTRICMEMORY  then return 13
        when :PSYCHICMEMORY   then return 14
        when :ICEMEMORY       then return 15
        when :DRAGONMEMORY    then return 16
        when :DARKMEMORY      then return 17
        when :FAIRYMEMORY     then return 18
        else return 0
      end
    end
    if pkmn.species == :ZACIAN
      return pkmn.item == :RUSTEDSWORD ? 1 : 0
    end
    if pkmn.species == :ZAMAZENTA
      return pkmn.item == :RUSTEDSHIELD ? 1 : 0
    end
    # Gen 9 Mod - Ogerpon form changes when given coressponding mask.
    if pkmn.species == :OGERPON
      case pkmn.item
        when :WELLSPRINGMASK  then return 1
        when :HEARTHFLAMEMASK then return 2
        when :CORNERSTONEMASK then return 3
        else return 0
      end
    end
    # Gen 9 Mod - Outside of battle, Terapagos should always be in it's normal form.
    if pkmn.species == :TERAPAGOS
      # Ugly, but the only way I've found to make Terapagos' ability reset to Tera Shift when it leaves battle.
      # Hopefully this is the last of the code I have to write for this annoying (adorable) little shit.
      pkmn.ability=:TERASHIFT
      return 0
    end
    return pkmn.form
  end

  def getFormName
		formnames = $cache.pkmn[@species].forms
		return if formnames.empty?
    return "Female" if (cancelledgenders.include?(@species) && self.isFemale?)
		return formnames[@form]
	end

  def hasMegaForm?
    #check for forms
    v = $cache.pkmn[@species].formData.dig(:MegaForm)
    v = $cache.pkmn[@species].formData.dig(:PulseForm) if (Reborn && !v)
    #v = $cache.pkmn[@species].formData.dig(:RiftForm) if (Rejuv && !v)
    # Gen 9 Mod - Ogerpon and Terapagos' Mega/Tera is handled differently, we need this to be true.
    return true if @species==:OGERPON
    return true if @species==:TERAPAGOS
    return false if !v
    # check if current species form *can* Mega
    if !self.isMega? # don't do this check if you are already a Mega
      k = $cache.pkmn[@species].formData.dig(:DefaultForm)
      if k.is_a?(Array)
        return false if !k.include?(@form)
      else
        return false if k != @form
      end
    end
    #check if conditions are met
    if @species==:RAYQUAZA && !pbIsZCrystal?(@item)
      for i in @moves
        # Gen 9 Mod - Fix to let Rayquaza mega evolve if it knows Dragon Ascent.
        return true if i.move==:DRAGONASCENT
        # return true if i.id==:DRAGONASCENT
      end
      # return true
    end
	  return v.keys.include?(@item)
  end

  def hasUltraForm?
    return @species == :NECROZMA && @item == :ULTRANECROZIUMZ && self.form!=0
  end

  def isMega?
    # Gen 9 Mod - Ogerpon Mega/Tera is handled differently, we need this to be true
    return true if PBStuff::OGERPONTERAFORMS.keys.include?(@species) && PBStuff::OGERPONTERAFORMS[@species].include?(self.form)
    v = $cache.pkmn[@species].formData.dig(:MegaForm)
    v = $cache.pkmn[@species].formData.dig(:PulseForm) if (Reborn && !v)
    v = $cache.pkmn[@species].formData.dig(:RiftForm) if (Rejuv && !v)
    # Gen 9 Mod - Fixes following line for Rayquaza Mega Evo
    v.values.each{|a| v=a if a.is_a?(Hash)} if v.is_a?(Hash) # filter for nested hashes aka Urshifu (if there is ever a mon with more than 1 megastone and a nested hash this needs rewriting)
    # v.values.each{|a| v=a if a.is_a?(Hash)} if v
    return true if v.is_a?(Hash) && v.values.include?(self.form)
    return false if v.is_a?(Hash)
    return v!=nil && self.form >= v
  end

  def makeMega
    v = $cache.pkmn[@species].formData.dig(:MegaForm)
    v = $cache.pkmn[@species].formData.dig(:PulseForm) if (Reborn && !v)
    v = $cache.pkmn[@species].formData.dig(:RiftForm) if (Rejuv && !v)
    self.originalForm = self.form
    self.originalAbility = self.ability # Gen 9 Mod - This needs to be set earlier to deal with Ogerpon mega functionality. Does not mess up anything for other Megas.
    self.form=v if v.is_a?(Integer)
    self.form=v[@item] if v.is_a?(Hash) && v[@item].is_a?(Integer)
    self.form=v[@item][@form] if v.is_a?(Hash) && v[@item].is_a?(Hash)
    # Set Ogerpon's mega form based on it's current masked form.
    # Required as setting up a Hash with items does not work since Teal Ogerpon can Mega
    # with any (or no) item while other masked forms can't.
    if @species == :OGERPON
      if self.originalForm == 4
        self.form = 8
      elsif self.originalForm == 5
        self.form = 9
      elsif self.originalForm == 6
        self.form = 10
      else
        self.form = 11
      end
    end
    self.ability = self.abilityIndex
  end

  def makeUnmega
    # default values if doesn't have a starting form somehow
    v = $cache.pkmn[@species].formData.dig(:DefaultForm)
    v = v[0] if v.is_a?(Array)
    # actually important part
    self.form= self.originalForm ? self.originalForm : v
    self.ability = self.originalAbility if self.originalAbility
    self.originalAbility = nil
    self.originalForm = nil
  end

  def isPrimal?
    return false if @species != :GROUDON && @species != :KYOGRE
    v = $cache.pkmn[@species].formData.dig(:PrimalForm)
    return v!=nil && v==self.form
  end

  def makePrimal
    v = $cache.pkmn[@species].formData.dig(:PrimalForm)
    self.form=v if v.is_a?(Integer)
    self.originalAbility = self.ability
    self.ability = self.abilityIndex
  end

  def makeUnprimal
    self.form=0
    self.ability = self.originalAbility if self.originalAbility
    self.originalAbility = nil
  end

  def isUltra?
    return false if @species != :NECROZMA
    v = $cache.pkmn[@species].formData.dig(:UltraForm)
    return v!=nil && v==self.form
  end

  def makeUltra
    v = $cache.pkmn[@species].formData.dig(:UltraForm)
    self.originalForm = self.form
    self.form=v
    self.originalAbility = self.ability
    self.ability = self.abilityIndex
  end

  def makeUnultra
    self.form=self.originalForm
    self.ability = self.originalAbility if self.originalAbility
    self.originalAbility = nil
    self.originalForm = nil
  end

  def isPulse?
		v = $cache.pkmn[@species].formData.dig(:PulseForm)
    return false if !v
    if v.is_a?(Hash)
      return v.values.include?(self.form)
    else
      return (self.form >= v)
    end
  end

  def isRift?
		v = $cache.pkmn[@species].formData.dig(:RiftForm)
    return false if !v
    if v.is_a?(Hash)
      return v.values.include?(self.form)
    else
      return (self.form >= v)
    end
  end

  def isPerfection?
		v = $cache.pkmn[@species].formData.dig(:PerfectionForm)
    return false if !v
    if v.is_a?(Hash)
      return v.values.include?(self.form)
    else
      return (self.form >= v)
    end
  end

################################################################################
# Other
################################################################################
  def hasAnItem?
    return !@item.nil?
  end

  def isAirborne?
    return false if @item == :IRONBALL
    return true if (self.type1 == :FLYING || self.type2 == :FLYING)
    return true if @ability == :LEVITATE
    return true if @item == :AIRBALLOON
    return false
  end

  def setItem(value)
    @item=value
    @zmoves=nil if !$cache.items[value] || !$cache.items[value].checkFlag?(:zcrystal)
  end

  def wildHoldItems
    if @form != 0
      v = []
      v.push($cache.pkmn[@species].formData.dig(self.getFormName, :WildItemCommon))
      v.push($cache.pkmn[@species].formData.dig(self.getFormName, :WildItemUncommon))
      v.push($cache.pkmn[@species].formData.dig(self.getFormName, :WildItemRare))
      return v if v != [nil, nil, nil]
    end
    common = $cache.pkmn[@species].checkFlag?(:WildItemCommon,nil)
    uncommon = $cache.pkmn[@species].checkFlag?(:WildItemUncommon,nil)
    rare = $cache.pkmn[@species].checkFlag?(:WildItemRare,nil)
    return [common, uncommon, rare]
  end

  def mail
    return nil if !@mail
    if @mail.item==0 || !self.hasAnItem? || @mail.item!=self.item
      @mail=nil
      return nil
    end
    return @mail
  end

  def language; @language ? @language : 0; end

  def markings
    @markings=0 if !@markings
    return @markings
  end

  def unownShape
    return "ABCDEFGHIJKLMNOPQRSTUVWXYZ?!"[@form,1]
  end

  def weight
    val = formCheck(:Weight)
    return !val.nil? ? val : $cache.pkmn[@species].Weight
  end

  def height
    val = formCheck(:Height)
    return !val.nil? ? val : $cache.pkmn[@species].Height
  end

  def evYield
    val = formCheck(:EVs)
    return !val.nil? ? val : $cache.pkmn[@species].EVs
  end

  def catchRate
    val = formCheck(:CatchRate)
    return !val.nil? ? val : $cache.pkmn[@species].CatchRate
  end

  def eggGroups
    val = formCheck(:EggGroups)
    return !val.nil? ? val : $cache.pkmn[@species].EggGroups
  end

  def dexnum
    return $cache.pkmn[@species].dexnum
  end

  def fakeOT
    @fakeOT = false if !@fakeOT
    @fakeOT
  end

  def egg?
    return @eggsteps > 0
  end

  def hp=(value)
    value=0 if value<0
    @hp=value
    if @hp==0
      @status=nil
      @statusCount=0
    end
  end

  def healHP
    @hp=@totalhp
  end

  def healStatus
    @status=nil
    @statusCount=0
  end

  def healPP(index=-1)
    for i in 0...4
      next if !@moves[i]
      @moves[i].pp=@moves[i].totalpp
    end
  end

  def heal
    return if egg?
    healHP
    healStatus
    healPP
  end

  def changeHappiness(method)
    gain=0; luxury=false
    case method
      when "walking"
        gain=1
        gain+=1 if @happiness<200
        gain+=1 if @obtainMap==$game_map.map_id
      when "level up"
        gain=3
        gain=4 if @happiness<200
        gain=5 if @happiness<100
      when "groom"
        gain=5
        gain=16 if @happiness<200
        luxury=true
      when "groom2"
        gain=8
        gain=13 if @happiness<200
        luxury=true
      when "groom3"
        gain=255
        luxury=true
      when "faint"
        gain=-1
      when "vitamin"
        gain=2
        gain=3 if @happiness<200
        gain=5 if @happiness<100
        luxury=true
      when "mochi"
        gain=2
        gain=3 if @happiness<200
        gain=5 if @happiness<100
        luxury=true
      when "wing"
        gain=1
        gain=2 if @happiness<200
        gain=3 if @happiness<100
      when "EV berry"
        gain=2
        gain=5 if @happiness<200
        gain=10 if @happiness<100
        luxury=true
      when "fresh mochi"
        gain=6
        gain=15 if @happiness<200
        gain=30 if @happiness<100
        luxury=true
      when "powder"
        gain=-10
        gain=-5 if @happiness<200
      when "Energy Root"
        gain=-15
        gain=-10 if @happiness<200
      when "Revival Herb"
        gain=-20
        gain=-15 if @happiness<200
      when "candy"
        gain=3
        gain=4 if @happiness<200
        gain=5 if @happiness<100
        luxury=true
      when "bluecandy"
        gain=220
        luxury=true
      when "badcandy"
        gain=-3
        gain=-4 if @happiness<200
        gain=-5 if @happiness<100
      when "Regular"
        gain=5
        gain=16 if @happiness<200
        luxury=true
      when "Travellers"
        gain=8
        gain=13 if @happiness<200
        luxury=true
      when "Luxurious"
        gain=70
        gain=30 if @happiness<200
        luxury=true
      else
        Kernel.pbMessage(_INTL("Unknown happiness-changing method."))
    end
    gain+=1 if luxury && self.ballused== :LUXURYBALL
    gain*=1.5 if (self.item == :SOOTHEBELL) && gain>0
    gain.round
    @happiness+=gain
    @happiness=[[255,@happiness].min,0].max
  end

  ################################################################################
  # Ownership, obtained information
  ################################################################################
  # Returns whether the specified Trainer is NOT this Pokemon's original trainer.
  def isForeign?(trainer)
    return @trainerID!=trainer.id || @ot!=trainer.name
  end

  # Returns the public portion of the original trainer's ID.
  def publicID
    return @trainerID&0xFFFF
  end

  # Returns this Pokémon's level when this Pokémon was obtained.
  def obtainLevel
    @obtainLevel=0 if !@obtainLevel
    return @obtainLevel
  end

  # Returns the time when this Pokémon was obtained.
  def timeReceived
    return @timeReceived ? Time.at(@timeReceived) : Time.gm(2000)
  end

  # Sets the time when this Pokémon was obtained.
  def timeReceived=(value)
    # Seconds since Unix epoch
    if shouldDivergeTime?
      timediverge=$Settings.unrealTimeDiverge
      $Settings.unrealTimeDiverge=0
      value=Time.new
    end
    if value.is_a?(Time)
      @timeReceived=value.to_i
    else
      @timeReceived=value
    end
    $Settings.unrealTimeDiverge=timediverge if timediverge
  end

  # Returns the time when this Pokémon hatched.
  def timeEggHatched
    if obtainMode==1
      return @timeEggHatched ? Time.at(@timeEggHatched) : Time.gm(2000)
    else
      return Time.gm(2000)
    end
  end

  # Sets the time when this Pokémon hatched.
  def timeEggHatched=(value)
    # Seconds since Unix epoch
    if shouldDivergeTime?
      timediverge=$Settings.unrealTimeDiverge
      $Settings.unrealTimeDiverge=0
      value=Time.new
    end
    if value.is_a?(Time)
      @timeEggHatched=value.to_i
    else
      @timeEggHatched=value
    end
    $Settings.unrealTimeDiverge=timediverge if timediverge
  end

  def activateRelearner()
    if !@relearner
      @relearner =[true,3]
    else
      @relearner[0] = true
    end
  end

end

#gotta put this somewhere!!!!!!!!!!!!!!!
def drawSpot(bitmap,spotpattern,x,y,red,green,blue)
  height=spotpattern.length
  width=spotpattern[0].length
  for yy in 0...height
    spot=spotpattern[yy]
    for xx in 0...width
      if spot[xx]==1
        xOrg=(x+xx)<<1
        yOrg=(y+yy)<<1
        color=bitmap.get_pixel(xOrg,yOrg)
        r=color.red+red
        g=color.green+green
        b=color.blue+blue
        color.red=[[r,0].max,255].min
        color.green=[[g,0].max,255].min
        color.blue=[[b,0].max,255].min
        bitmap.set_pixel(xOrg,yOrg,color)
        bitmap.set_pixel(xOrg+1,yOrg,color)
        bitmap.set_pixel(xOrg,yOrg+1,color)
        bitmap.set_pixel(xOrg+1,yOrg+1,color)
      end
    end
  end
end

def pbSpindaSpots(pokemon,bitmap)
  spot1=[
     [0,0,1,1,1,1,0,0],
     [0,1,1,1,1,1,1,0],
     [1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1],
     [0,1,1,1,1,1,1,0],
     [0,0,1,1,1,1,0,0]
  ]
  spot2=[
     [0,0,1,1,1,0,0],
     [0,1,1,1,1,1,0],
     [1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1],
     [0,1,1,1,1,1,0],
     [0,0,1,1,1,0,0]
  ]
  spot3=[
     [0,0,0,0,0,1,1,1,1,0,0,0,0],
     [0,0,0,1,1,1,1,1,1,1,0,0,0],
     [0,0,1,1,1,1,1,1,1,1,1,0,0],
     [0,1,1,1,1,1,1,1,1,1,1,1,0],
     [0,1,1,1,1,1,1,1,1,1,1,1,0],
     [1,1,1,1,1,1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1,1,1,1,1,1],
     [0,1,1,1,1,1,1,1,1,1,1,1,0],
     [0,1,1,1,1,1,1,1,1,1,1,1,0],
     [0,0,1,1,1,1,1,1,1,1,1,0,0],
     [0,0,0,1,1,1,1,1,1,1,0,0,0],
     [0,0,0,0,0,1,1,1,0,0,0,0,0]
  ]
  spot4=[
     [0,0,0,0,1,1,1,0,0,0,0,0],
     [0,0,1,1,1,1,1,1,1,0,0,0],
     [0,1,1,1,1,1,1,1,1,1,0,0],
     [0,1,1,1,1,1,1,1,1,1,1,0],
     [1,1,1,1,1,1,1,1,1,1,1,0],
     [1,1,1,1,1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1,1,1,1,1],
     [1,1,1,1,1,1,1,1,1,1,1,0],
     [0,1,1,1,1,1,1,1,1,1,1,0],
     [0,0,1,1,1,1,1,1,1,1,0,0],
     [0,0,0,0,1,1,1,1,1,0,0,0]
  ]
  id=pokemon.personalID
  h=(id>>28)&15
  g=(id>>24)&15
  f=(id>>20)&15
  e=(id>>16)&15
  d=(id>>12)&15
  c=(id>>8)&15
  b=(id>>4)&15
  a=(id)&15
  if pokemon.isShiny?
    drawSpot(bitmap,spot1,b+43,a+35,-120,-120,-20)
    drawSpot(bitmap,spot2,d+31,c+34,-120,-120,-20)
    drawSpot(bitmap,spot3,f+49,e+17,-120,-120,-20)
    drawSpot(bitmap,spot4,h+25,g+16,-120,-120,-20)
  else
    drawSpot(bitmap,spot1,b+43,a+35,0,-115,-75)
    drawSpot(bitmap,spot2,d+31,c+34,0,-115,-75)
    drawSpot(bitmap,spot3,f+49,e+17,0,-115,-75)
    drawSpot(bitmap,spot4,h+25,g+16,0,-115,-75)
  end
end

def getListOfSpecies
  arr = []
  $cache.pkmn.each{|symbol,dat|
    arr.push(dat.Name)
  }
  return arr
end

# @SWu's stuff below\

# Giga Evolution
def hasGigaForm?
  v = $cache.pkmn[@species].formData.dig(:GigaForm)
  return false if !v
  # check if current species form *can* Mega
  if !self.isGiga? # don't do this check if you are already a Mega
    k = $cache.pkmn[@species].formData.dig(:DefaultForm)
    if k.is_a?(Array)
      return false if !k.include?(@form)
    else
      return false if k != @form
    end 
  end
  # will need to handle urshifu at some point
  if v.is_a?(Hash)
    return true
  end

  # owning giga stone handled in call pbCanGigaEvolve
  return true
end

def isGiga?
  v = $cache.pkmn[@species].formData.dig(:GigaForm) if (Rejuv && !v)
  # @SWu: Do urshifu below
  return true if v.is_a?(Hash) && v.values.include?(self.form)
  return false if v.is_a?(Hash)
  return v!=nil && self.form >= v
end

def makeGiga
  v = $cache.pkmn[@species].formData.dig(:GigaForm)
  self.originalForm = self.form
  self.form=v # if v.is_a?(Integer)

  # @SWu TODO: only need to handle Urshifu below
  # self.form=v[@item] if v.is_a?(Hash) && v[@item].is_a?(Integer)
  # self.form=v[@item][@form] if v.is_a?(Hash) && v[@item].is_a?(Hash)
end

def pbGigaCompatibleBaseMove?(move)
  pkmn=self.species
  # TODO: reassign base moves
  case pkmn
    when :BUTTERFREE      then return true if move.move == :SPRINGBREEZE
    when :RILLABOOM       then return true if move.move == :BOOMBURST   
    when :CINDERACE       then return true if move.move == :PYROBALL    
    when :INTELEON        then return true if move.move == :SNIPESHOT
    when :TOXTRICITY      then return true if move.move == :BOOMBURST
    when :ALCREMIE        then return true if move.move == :DRAININGKISS
    when :HATTERENE       then return true if move.move == :DAZZLINGGLEAM
    when :COPPERAJAH      then return true if move.move == :IRONHEAD   
    when :CORVIKNIGHT     then return true if move.move == :BRAVEBIRD
    when :MEOWTH          then return true if move.move == :PAYDAY
    when :PIKACHU         then return true if move.move == :VOLTTACKLE
    when :EEVEE           then return true if move.move == :CHARM
    when :GRIMMSNARL      then return true if move.move == :FALSESURRENDER
    when :GENGAR          then return true if move.move == :DARKPULSE
    when :GARBODOR        then return true if move.move == :GUNKSHOT
    when :DURALUDON       then return true if move.move == :DRAGONPULSE
    when :CENTISKORCH     then return true if move.move == :INFERNO
    when :LAPRAS          then return true if move.move == :ICEBEAM
    when :APPLETUN        then return true if move.move == :APPLEACID
    when :DREDNAW         then return true if move.move == :LIQUIDATION
    when :MELMETAL        then return true if move.move == :HYPERBEAM
    when :COALOSSAL       then return true if move.move == :STONEEDGE
    when :VANILLUXE       then return true if move.move == :BLIZZARD
    when :MACHAMP         then return true if move.move == :CROSSCHOP
    when :CHARIZARD       then return true if move.move == :BLASTBURN
    when :VENUSUAR        then return true if move.move == :FRENZYPLANT
    when :BLASTOISE       then return true if move.move == :HYDROCANNON
    when :FERROTHORN      then return true if move.move == :POWERWHIP
    when :URSHIFU         then return true if move.move == :WICKEDBLOW
    when :SANDACONDA      then return true if move.move == :HURRICANE
    when :KINGLER         then return true if move.move == :XSCISSOR
  end
  return false
end