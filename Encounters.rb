module EncounterTypes
  Land         = 0
  Cave         = 1
  Water        = 2
  RockSmash    = 3
  OldRod       = 4
  GoodRod      = 5
  SuperRod     = 6
  Headbutt     = 7
  LandMorning  = 8
  LandDay      = 9
  LandNight    = 10
  BugContest   = 11
  Names = [
    "Land",
    "Cave",
    "Water",
    "RockSmash",
    "OldRod",
    "GoodRod",
    "SuperRod",
    "Headbutt",
    "LandMorning",
    "LandDay",
    "LandNight",
    "BugContest"
  ]
  EnctypeChances = [
    [20, 15, 12, 10, 10, 10, 5, 5, 5, 4, 2, 2],
    [20, 15, 12, 10, 10, 10, 5, 5, 5, 4, 2, 2],
    [50, 25, 15, 7, 3],
    [50, 25, 15, 7, 3],
    [70, 30],
    [60, 20, 20],
    [40, 35, 15, 7, 3],
    [30, 25, 20, 10, 5, 5, 4, 1],
    [20, 15, 12, 10, 10, 10, 5, 5, 5, 4, 2, 2],
    [20, 15, 12, 10, 10, 10, 5, 5, 5, 4, 2, 2],
    [20, 15, 12, 10, 10, 10, 5, 5, 5, 4, 2, 2],
    [20, 15, 12, 10, 10, 10, 5, 5, 5, 4, 2, 2]
  ]
  EnctypeDensities = [25, 10, 10, 0, 0, 0, 0, 0, 0, 25, 25, 25, 25]
  EnctypeCompileDens = [1, 2, 3, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1]
end

class PokemonEncounters
  def initialize
    @enctypes=[]
    @density=nil
  end

  def stepcount
    return @stepcount
  end

  def clearStepCount
    @stepcount=0
  end

  def hasEncounter?(enc)
    return false if @density==nil || enc<0
    return @enctypes[enc] ? true : false  
  end

  def isCave?
    return false if @density==nil
    return @enctypes[EncounterTypes::Cave] ? true : false
  end

  def isGrass?
    return false if @density==nil
    return (@enctypes[EncounterTypes::Land] ||
            @enctypes[EncounterTypes::LandMorning] ||
            @enctypes[EncounterTypes::LandDay] ||
            @enctypes[EncounterTypes::LandNight] ||
            @enctypes[EncounterTypes::BugContest]) ? true : false
  end

  def isRegularGrass?
    return false if @density==nil
    return (@enctypes[EncounterTypes::Land] ||
            @enctypes[EncounterTypes::LandMorning] ||
            @enctypes[EncounterTypes::LandDay] ||
            @enctypes[EncounterTypes::LandNight]) ? true : false
  end

  def isWater?
    return false if @density==nil
    return @enctypes[EncounterTypes::Water] ? true : false
  end

  def pbEncounterType
    if $PokemonGlobal && $PokemonGlobal.surfing 
      return EncounterTypes::Water
    elsif self.isCave?
      return EncounterTypes::Cave
    elsif self.isGrass? #lavasurfing?
      time=pbGetTimeNow
      enctype=EncounterTypes::Land
      enctype=EncounterTypes::LandNight if self.hasEncounter?(EncounterTypes::LandNight) && PBDayNight.isNight?(time)
      enctype=EncounterTypes::LandDay if self.hasEncounter?(EncounterTypes::LandDay) && PBDayNight.isDay?(time)
      enctype=EncounterTypes::LandMorning if self.hasEncounter?(EncounterTypes::LandMorning) && PBDayNight.isMorning?(time)
      return enctype
    end
    return -1
  end

  def isEncounterPossibleHere?
    currentTag = pbGetTerrainTag($game_player)
    if currentTag==PBTerrain::Waterfall || currentTag==PBTerrain::WaterfallCrest
      return false
    elsif $PokemonGlobal && $PokemonGlobal.surfing
      return true
    elsif currentTag==PBTerrain::Ice
      return false
    elsif self.isCave?
      return true
    elsif self.isGrass? #lavasurfing?
      return pbIsGrassTag?(currentTag)
    end
    return false
  end

  def setup(mapID)
    mapdata = $cache.mapdata[mapID]
    encounterMultiplier = ((!Reborn) && $game_switches[:FirstUse]) ? $game_variables[:EncounterRateModifier] : 1
    @density=nil
    @stepcount=0
    @enctypes=[]
    begin
      if $cache.mapdata[mapID] && $cache.mapdata[mapID].landrate
        landrate=mapdata.landrate*encounterMultiplier*($game_switches[:WildBattles]? 0 : 1)
        waterrate=mapdata.waterrate*encounterMultiplier*($game_switches[:WildBattles]? 0 : 1)
        caverate=mapdata.caverate*encounterMultiplier*($game_switches[:WildBattles]? 0 : 1)
        @density= [landrate,caverate,waterrate,caverate,waterrate,waterrate,landrate,landrate,landrate,landrate,landrate,landrate,landrate]
        @enctypes=[mapdata.Land.nil? ? nil : mapdata.Land, mapdata.Cave.nil? ? nil : mapdata.Cave, mapdata.Water.nil? ? nil : mapdata.Water,
        mapdata.RockSmash.nil? ? nil : mapdata.RockSmash, mapdata.OldRod.nil? ? nil : mapdata.OldRod, mapdata.OldRod.nil? ? nil : mapdata.GoodRod,
        mapdata.SuperRod.nil? ? nil : mapdata.SuperRod, mapdata.Headbutt.nil? ? nil : mapdata.Headbutt,
        mapdata.LandMorning.nil? ? nil : mapdata.LandMorning, mapdata.LandDay.nil? ? nil : mapdata.LandDay, mapdata.LandNight.nil? ? nil : mapdata.LandNight, mapdata.BugContest ? nil : mapdata.BugContest,]
      else
        @density=nil
        @enctypes=[]
      end
      rescue
      @density=nil
      @enctypes=[]
    end
  end
  
  def pbEncounteredPokemon(enctype,tries=1)
    if enctype<0 || enctype>EncounterTypes::EnctypeChances.length
      raise ArgumentError.new(_INTL("Encounter type out of range"))
    end
    return nil if @enctypes[enctype]==nil
    encounters = []
    chances    = []
    @enctypes[enctype].each do |key,x| 
      x.each{ |y|
        encounters.push([key,y[1],y[2]])
        chances.push(y[0])
      }
    end
    # Should we force encountering uncaptured mons?
    forcedEncounter=pbForceEncounterUncapturedPkmn(encounters, chances)
    return forcedEncounter if forcedEncounter

    # Proceed with the normal mode instead
    if !$Trainer.party[0].egg?
      firstpoke = $Trainer.party[0] 
    else
      firstpoke = false
    end
    

    if firstpoke && rand(2) == 0
      type = -1
      if firstpoke.ability == :STATIC
        type = :ELECTRIC
      elsif firstpoke.ability == :MAGNETPULL
        type = :STEEL
      elsif firstpoke.ability == :FLASHFIRE
        type = :FIRE
      elsif firstpoke.ability == :HARVEST
        type = :GRASS
      elsif firstpoke.ability == :LIGHTNINGROD
        type = :ELECTRIC
      elsif firstpoke.ability == :STORMDRAIN
        type = :WATER        
      end
      if type != -1
        newencs = []; newchances = []
        for i in 0...encounters.length
          species = encounters[i][0]
          t1 = $cache.pkmn[species].Type1
          t2 = $cache.pkmn[species].Type2.nil? ? nil : $cache.pkmn[species].Type2
          alt_types = pbISActuallyDifferentForm(species)
          t1,t2 = alt_types if alt_types != [-1,-1]
          if t1==type || t2==type
            newencs.push(encounters[i])
            newchances.push(chances[i])
          end
        end
        if newencs.length>0
          encounters = newencs
          chances    = newchances
        end
      end
    end
    chancetotal = 0
    chances.each {|a| chancetotal += a }
    rnd = 0
    tries.times do
      r = rand(chancetotal)
      rnd = r if rnd<r
    end
    chosenpkmn = 0
    chance = 0
    for i in 0...chances.length
      chance += chances[i]
      if rnd<chance
        chosenpkmn = i
        break
      end
    end
    encounter = encounters[chosenpkmn]
    return nil if !encounter
    level=pbGetEncounterLevel(encounter)
    return [encounter[0],level]
  end

  def pbForceEncounterUncapturedPkmn(encounters, chances)
    
    return nil if !(pbShouldFilterKnownPkmnFromEncounter?) && !(pbShouldFilterOtherPkmnFromEncounter?)

    # return nil if !encounters
    # return nil if !chances
    if pbShouldFilterKnownPkmnFromEncounter?
      encounter=pbFilterKnownPkmnFromEncounter(chances, encounters)
    elsif pbShouldFilterOtherPkmnFromEncounter?
      encounter=pbFilterOtherPkmnFromEncounter(chances, encounters)
    end
    return nil if !encounter
    level=pbGetEncounterLevel(encounter)
    return [encounter[0],level]
  end

  def pbFilterOtherPkmnFromEncounter(chances, encounters)
    uncaptured=[]
    for i in 0...encounters.length
      # First, filter out the mons that have no chance of spawning
      # Just in case...
      next if !chances[i]
      next if chances[i] <= 0
      # Then filter out all captured mons
      enc=encounters[i]
      next if !enc
      next if !(enc[0]==$Trainer.party[0].species)
      uncaptured.push(enc)
    end
    return nil if uncaptured.length <= 0
    randId=rand(uncaptured.length)
    return uncaptured[randId]
  end


  def pbGetEncounterLevel(encounter)
    # UPDATE 11/19/2013
    # pressure, hustle and vital spirit will now have a 150% chance of
    # finding higher leveled pokemon in encounters
    if !$Trainer.party[0].egg?
      if [:PRESSURE,:HUSTLE,:VITALSPIRIT].include?($Trainer.party[0].ability) && rand(2) == 0
      # increase the lower bound to half way in-between lower and upper
        encounter[1] += (encounter[2] - encounter[1]) / 2
      end
    end
    # end of update
    level=encounter[1]+rand(1+encounter[2]-encounter[1])
    return level
  end

  def pbFilterKnownPkmnFromEncounter(chances, encounters)
    uncaptured = []
    for i in 0...encounters.length
      # First, filter out the mons that have no chance of spawning
      # Just in case...
      next if !chances[i]
      next if chances[i] <= 0

      # Then filter out all captured mons
      enc = encounters[i]
      next if !enc
      # handle forms
      if $Trainer.pokedex.dexList[enc[0]][:owned?]
        # If a pokemon is owned but no forms are owned then it's a legacy save file before forms were tracked
        # Consider all forms as owned in that case
        next if $Trainer.pokedex.dexList[enc[0]][:formsOwned].nil?
        next if $cache.pkmn[enc[0]].forms.length <= 1  # skip if no altforms
        encform = !$cache.pkmn[enc[0]].formInit.empty? ? eval($cache.pkmn[enc[0]].formInit).call : 0
        # next if isCosmeticForm(enc[0], encform)
        $Trainer.pokedex.refreshDex() if !$Trainer.pokedex.dexList[enc[0]][:formsOwned]
        next if $Trainer.pokedex.dexList[enc[0]][:formsOwned][encform]
      end

      uncaptured.push(enc)
    end
    return nil if uncaptured.length <= 0

    randId = rand(uncaptured.length)
    return uncaptured[randId]
  end

  def pbShouldFilterKnownPkmnFromEncounter?
    # Should also check for $Trainer.party[0].hp > 0 by logic, but then
    #  it wouldn't be in line with the other overworld party leader checks
    return false if $Trainer.party[0].egg?
    return true if $Trainer.party[0].item == :MAGNETICLURE

    return false
  end

  def pbShouldFilterOtherPkmnFromEncounter?
    # Should also check for $Trainer.party[0].hp > 0 by logic, but then
    #  it wouldn't be in line with the other overworld party leader checks
    return false if $Trainer.party[0].egg?
    return true if $Trainer.party[0].item == :MIRRORLURE

    return false
  end

  def pbISActuallyDifferentForm(species)
    # Check if a different form exists
    return [-1,-1] if $cache.pkmn[species].forms.empty?
    return [-1,-1] if !$cache.pkmn[species].formInit || $cache.pkmn[species].formInit.empty?
    form = eval($cache.pkmn[species].formInit).call

    return [-1,-1] if form == 0 || form.nil?
    formname = $cache.pkmn[species].forms[form]
    return [-1,-1] if formname.empty?
    return [-1,-1] if !$cache.pkmn[species].formData[formname]
    # Check Typing of different form
    type1 = $cache.pkmn[species].formData[formname][:Type1]
    type2 = $cache.pkmn[species].formData[formname][:Type2]
    type1 = $cache.pkmn[species].Type1 if type1.nil?
    type2 = $cache.pkmn[species].Type2 if type2.nil?
    return [type1, type2]
  end

  def isCosmeticForm(species, form)
    # Due to engine difference with Reborn 19.5 I am forcing this to false while leaving it existing, so nothing is considered cosmetic form here.
    return false
  end

  def pbCanEncounter?(encounter)
    return false if $game_system.encounter_disabled
    return false if !encounter || !$Trainer
    return false if $DEBUG && Input.press?(Input::CTRL)
    if !pbPokeRadarOnShakingGrass
      return false if $PokemonGlobal.repel>0 && $Trainer.ablePokemonCount>0 &&
                      encounter[1]<$Trainer.ablePokemonParty[0].level
    end
    return true
  end

  def pbGenerateEncounter(enctype)
    if enctype<0 || enctype>EncounterTypes::EnctypeChances.length
      raise ArgumentError.new(_INTL("Encounter type out of range"))
    end
    return nil if @density==nil
    return nil if @density[enctype]==0 || !@density[enctype]
    return nil if @enctypes[enctype]==nil
    @stepcount+=1
    return nil if @stepcount<=10 && (Reborn || $game_variables[:EncounterRateModifier]<=1)# Check three steps after battle ends
    encount=@density[enctype]*16
    if $PokemonGlobal.bicycle
      encount*=4/5
    end
    if $PokemonMap.blackFluteUsed
      encount/=2
    end
    if $PokemonMap.whiteFluteUsed
      encount*=3/2
    end
    if $Trainer.party.length>0 && !$Trainer.party[0].isEgg?
      case $Trainer.party[0].ability
      when :STENCH then encount/=2
      when :WHITESMOKE then encount/=2
      when :QUICKFEET then encount/=2
      when :INFILTRATOR then encount/=2
      when :SNOWCLOAK then encount/=2 if [:Snow,:Hail,:Blizzard].include?($game_screen.weather_type)
      when :SANDVEIL then encount/=2 if $game_screen.weather_type == :Sandstorm
      when :SWARM then encount*=3/2
      when :ILLUMINATE then encount*=2
      when :ARENATRAP then encount*=2
      when :NOGUARD then encount*=2
      else
        # Item doesn't stack with ability
        if $Trainer.party[0].item == :CLEANSETAG
          encount*=2/3
        elsif $Trainer.party[0].item == :PUREINCENSE
          encount*=2/3
        end
      end
    end
    return nil if rand(250*16)>=encount
    encpoke=pbEncounteredPokemon(enctype)
    if $Trainer.party.length>0 && !$Trainer.party[0].isEgg?
      if encpoke && $Trainer.party[0].ability == :INTIMIDATE &&
         encpoke[1]<=$Trainer.party[0].level-5 && rand(2)==0
        encpoke=nil
      end
      if encpoke && $Trainer.party[0].ability == :KEENEYE &&
         encpoke[1]<=$Trainer.party[0].level-5 && rand(2)==0
        encpoke=nil
      end
    end
    return encpoke
  end
end
