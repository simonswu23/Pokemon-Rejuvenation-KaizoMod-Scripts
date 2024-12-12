class DataObject
  attr_reader :flags

  def checkFlag?(flag,default=false)
    return @flags.fetch(flag,default)
  end
end

class MonData < DataObject
  attr_reader :mon
  attr_reader :name
  attr_reader :dexnum
  attr_reader :Type1
  attr_reader :Type2
  attr_reader :BaseStats
  attr_reader :EVs
  attr_reader :Abilities
  attr_reader :GrowthRate
  attr_reader :GenderRatio
  attr_reader :BaseEXP
  attr_reader :CatchRate
  attr_reader :Happiness
  attr_reader :EggSteps
  attr_reader :EggMoves
  attr_reader :Moveset
  attr_reader :compatiblemoves
  attr_reader :moveexceptions
  attr_reader :shadowmoves
  attr_reader :Color
  attr_reader :Habitat
  attr_reader :EggGroups
  attr_reader :Height
  attr_reader :Weight
  attr_reader :kind
  attr_reader :dexentry
  attr_reader :BattlerPlayerY
  attr_reader :BattlerEnemyY
  attr_reader :BattlerAltitude
  attr_reader :preevo
  attr_reader :evolutions
  attr_accessor :forms
  attr_accessor :formInit
  attr_accessor :formData

  def initialize(monsym,data)
    @flags = {}
    @mon              = monsym
    data.values[0].each do |key, value|
      case key
        when :name             then @name             = value
        when :dexnum           then @dexnum           = value
        when :Type1            then @Type1            = value
        when :Type2            then @Type2            = value
        when :BaseStats        then @BaseStats        = value
        when :EVs              then @EVs              = value
        when :Abilities        then @Abilities        = value
        when :GrowthRate       then @GrowthRate       = value
        when :GenderRatio      then @GenderRatio      = value
        when :BaseEXP          then @BaseEXP          = value
        when :CatchRate        then @CatchRate        = value
        when :Happiness        then @Happiness        = value
        when :EggSteps         then @EggSteps         = value
        when :EggMoves         then @EggMoves         = value
        when :Moveset          then @Moveset          = value
        when :compatiblemoves  then @compatiblemoves  = value
        when :moveexceptions   then @moveexceptions   = value
        when :shadowmoves      then @shadowmoves      = value
        when :Color            then @Color            = value
        when :Habitat          then @Habitat          = value
        when :EggGroups        then @EggGroups        = value
        when :Height           then @Height           = value
        when :Weight           then @Weight           = value
        when :kind             then @kind             = value
        when :dexentry         then @dexentry         = value
        when :BattlerPlayerY   then @BattlerPlayerY   = value
        when :BattlerEnemyY    then @BattlerEnemyY    = value
        when :BattlerAltitude  then @BattlerAltitude  = value
        when :preevo           then @preevo           = value
        when :evolutions       then @evolutions       = value
        else @flags[key] = value
      end
    end
    @formInit = {}
    if data[:OnCreation] && !data[:OnCreation].is_a?(Hash)
      @formInit = extractFormProc(data[:OnCreation], mon)
    end
    data.delete(:OnCreation)
    baseform = data.keys[0]
    data.delete(data.keys[0])
    @formData = data
    formnames = {
      0 => baseform
    }
    for form in 0...data.length
      next if !data.keys[form].is_a?(String)
      formnames[formnames.length] = data.keys[form]
    end
    @forms = formnames
  end
end

class MoveData < DataObject
  attr_reader :move
  attr_reader :name
  attr_reader :function
  attr_reader :type
  attr_reader :category
  attr_reader :basedamage
  attr_reader :accuracy
  attr_reader :maxpp
  attr_reader :target
  attr_reader :desc
  attr_reader :priority

  def initialize(movesym,data)
    @flags = {}
    @move            = movesym
    data.each do |key, value|
      case key
      when :name then           @name            = value
      when :function then       @function        = value
      when :type then           @type            = value
      when :category then       @category        = value
      when :basedamage then     @basedamage      = value
      when :accuracy then       @accuracy        = value
      when :maxpp then          @maxpp           = value
      when :target then         @target          = value
      when :desc then           @desc            = value
      when :priority then       @priority        = value ? value : 0
      else @flags[key] = value
      end
    end
  end
end

class ItemData < DataObject
  attr_reader :item
  attr_reader :name
  attr_reader :desc
  attr_reader :price

  def initialize(itemsym,data)
    @flags = {}
    @item         = itemsym
    data.each do |key, value|
      case key
      when :name then         @name         = value
      when :desc then         @desc         = value
      when :price then        @price        = value
      else @flags[key] = value
      end
    end
  end
end

class AbilityData < DataObject
  attr_reader :ability
  attr_reader :name
  attr_reader :desc
  attr_reader :fullName
  attr_reader :fullDesc

  def initialize(abilsym,data)
    @ability  = abilsym
    @name     = data[:name]
    @desc     = data[:desc]
    @fullName = data[:fullName]
    @fullName = @name if @fullName.nil?
    @fullDesc = data[:fullDesc]
    @fullDesc = @desc if @fullDesc.nil?
  end
end

class MapMetadata < DataObject
  #metadata
  attr_reader :mapid
  attr_reader :HealingSpot
  attr_reader :MapPosition
  attr_reader :Outdoor
  attr_reader :ShowArea
  attr_reader :Bicycle
  attr_reader :Weather
  attr_reader :DiveMap
  attr_reader :DarkMap
  attr_reader :SafariMap
  attr_reader :SnapEdges
  attr_reader :BattleBack
  attr_reader :WildBattleBGM
  attr_reader :TrainerBattleBGM
  attr_reader :WildVictoryME
  attr_reader :TrainerVictoryME
  attr_reader :MapSize
  #encounters
  attr_reader :Land
  attr_reader :Cave
  attr_reader :Water
  attr_reader :RockSmash
  attr_reader :OldRod
  attr_reader :GoodRod
  attr_reader :SuperRod
  attr_reader :Headbutt
  attr_reader :LandMorning
  attr_reader :LandDay
  attr_reader :LandNight
  attr_reader :landrate
  attr_reader :caverate
  attr_reader :waterrate
  attr_reader :BugContest

  def initialize(key,encounters,metadata)
    @mapid              = key
    metadata.each do |key, value|
      case key
        when :Outdoor then            @Outdoor            = value ? true : false
        when :ShowArea then           @ShowArea           = value ? true : false
        when :Bicycle then            @Bicycle            = value ? true : false
        when :Weather then            @Weather            = value
        when :DiveMap then            @DiveMap            = value
        when :DarkMap then            @DarkMap            = value ? true : false
        when :SafariMap then          @SafariMap          = value ? true : false
        when :SnapEdges then          @SnapEdges          = value ? true : false
        when :BattleBack then         @BattleBack         = value
        when :HealingSpot then        @HealingSpot        = value
        when :MapPosition then        @MapPosition        = value
        when :WildBattleBGM then      @WildBattleBGM      = value
        when :TrainerBattleBGM then   @TrainerBattleBGM   = value
        when :WildVictoryME then      @WildVictoryME      = value
        when :TrainerVictoryME then   @TrainerVictoryME   = value
        when :MapSize then            @MapSize            = value ? true : false
      end
    end
    encounters = {} if !encounters
    #encounters
    @Land               = encounters[:Land] ? encounters[:Land] : nil
    @Cave               = encounters[:Cave] ? encounters[:Cave] : nil
    @Water              = encounters[:Water] ? encounters[:Water] : nil
    @RockSmash          = encounters[:RockSmash] ? encounters[:RockSmash] : nil
    @OldRod             = encounters[:OldRod] ? encounters[:OldRod] : nil
    @GoodRod            = encounters[:GoodRod] ? encounters[:GoodRod] : nil
    @SuperRod           = encounters[:SuperRod] ? encounters[:SuperRod] : nil
    @Headbutt           = encounters[:Headbutt] ? encounters[:Headbutt] : nil
    @LandMorning        = encounters[:LandMorning] ? encounters[:LandMorning] : nil
    @LandDay            = encounters[:LandDay] ? encounters[:LandDay] : nil
    @LandNight          = encounters[:LandNight] ? encounters[:LandNight] : nil
    @BugContest         = encounters[:BugContest] ? encounters[:BugContest] : nil
    #rates
    @landrate           = encounters[:landrate]
    @caverate           = encounters[:caverate]
    @waterrate          = encounters[:waterrate]
  end

  def syncMapData(region, point, flyData)
    @MapPosition=[region,point[0],point[1]]
    @HealingSpot=flyData
  end
end

class PlayerData < DataObject
	attr_reader :id
	attr_reader :tclass
	attr_reader :walk
	attr_reader :run
	attr_reader :bike
	attr_reader :surf
	attr_reader :dive
	attr_reader :fishing
	attr_reader :surffish
	attr_reader :tauros

	def initialize(key,data)
		@id         = key
		@tclass     = data[:tclass]
		@walk       = data[:walk]
		@run        = data[:run]
		@bike       = data[:bike]
		@surf       = data[:surf]
		@dive       = data[:dive]
		@fishing    = data[:fishing]
		@surffish   = data[:surffish]
		@tauros     = data[:tauros]
	end
end

class TypeData
	attr_reader :type
	attr_reader :name
	attr_reader :weak
	attr_reader :resist
	attr_reader :immune
	attr_reader :specialtype
  
	def initialize(typesym,data)
	  @type = typesym
		@name = data.fetch(:name,"")
		@weak = data.fetch(:weaknesses,[])
		@resist = data.fetch(:resistances,[])
		@immune = data.fetch(:immunities,[])
    @specialtype = data.fetch(:specialtype,false)
	end
  
	def checkFlag?(flag,default=false)
    return @flags.fetch(flag,default)
  end

	def weak?(type)
		return @weak.include?(type)
	end

  def specialtype?(type)
		return @specialtype
	end

	def resists?(type)
		return @resist.include?(type)
	end

	def immune?(type)
		return @immune.include?(type)
	end
end

class TrainerData < DataObject
	attr_reader :ttype
	attr_reader :title
	attr_reader :skill
	attr_reader :moneymult
	attr_reader :battleBGM
	attr_reader :winBGM
	attr_reader :teams
  attr_reader :trainerID
	attr_reader :flags

	def initialize(ttypesym,data)
		@ttype        = ttypesym
		@flags = {}
		data.each do |key, value|
			case key
				when :title     then 	@title      = value
        when :trainerID then  @trainerID  = value
				when :skill     then 	@skill      = value
				when :moneymult then  @moneymult  = value
				when :battleBGM then 	@battleBGM  = value
				when :winBGM    then 	@winBGM     = value
				else @flags[key] = value
			end
		end
	end

	def checkFlag?(flag,default=false)
    return @flags.fetch(flag,default)
  end
end

class FEData
	attr_accessor :name
	attr_accessor :message
	attr_accessor :graphic
	attr_accessor :secretPower
	attr_accessor :naturePower
	attr_accessor :mimicry
	attr_accessor :seeddata
	attr_accessor :fieldtypedata
	attr_accessor :fieldmovedata
	attr_accessor :movemessagelist
	attr_accessor :typemessagelist
	attr_accessor :changemessagelist
	attr_accessor :statusMods
  attr_accessor :fieldchangeconditions
  #Overlay stuff
  attr_accessor :overlaymovedata
  attr_accessor :overlaytypedata
  attr_accessor :overlayStatusMods
  attr_accessor :overlaymovemessagelist
	attr_accessor :overlaytypemessagelist

	def initialize
		@name = nil
		@message = nil
		@graphic = "IndoorA"
		@secretPower = "TRIATTACK"
		@naturePower = :TRIATTACK
		@mimicry = :NORMAL
		@fieldmovedata = {}
		@fieldtypedata = {}
		@seeddata = {}
		@movemessagelist = {}
		@typemessagelist = {}
		@changemessagelist = {}
		@statusMods = []
    #Overlay stuff
    @overlaymovedata = {}
    @overlaytypedata = {}
    @overlayStatusMods = []
    @overlaymovemessagelist = {}
		@overlaytypemessagelist = {}
	end
end

class BossData < DataObject
  attr_accessor :mon
  attr_accessor :name
  attr_accessor :barGraphic
  attr_accessor :entryText
	attr_accessor :immunities
	attr_accessor :shieldCount
  attr_accessor :capturable
  attr_accessor :canrun
  attr_accessor :onBreakEffects
  attr_accessor :onEntryEffects
	attr_accessor :moninfo
  attr_accessor :sosDetails
  attr_accessor :chargeAttack
  attr_accessor :randomSetChanges
  
  def initialize(monsym,data)
    @flags = {}
    @mon              = monsym
    data.each do |key, value|
      case key 
        when :name            then @name            = value
        when :immunities      then @immunities      = value
        when :barGraphic      then @barGraphic      = value
        when :entryText       then @entryText       = value
        when :shieldCount     then @shieldCount     = value
        when :immunities      then @immunities      = value
        when :capturable      then @capturable      = value
        when :canrun          then @canrun          = value
        when :moninfo         then @moninfo         = value
        when :onBreakEffects  then @onBreakEffects  = value
        when :onEntryEffects  then @onEntryEffects  = value
        when :sosDetails      then @sosDetails      = value
        when :chargeAttack      then @chargeAttack      = value
        when :randomSetChanges  then @randomSetChanges      = value
        else @flags[key] = value
      end
    end
  end
end

class NatureData
  attr_accessor :name
  attr_accessor :nature
  attr_accessor :incStat
  attr_accessor :decStat
  attr_accessor :like
  attr_accessor :dislike

  def initialize(naturesym, data)
    @flags = {}
    @nature = naturesym
    data.each{|key, value|
      case key
        when :name      then  @name     = value
        when :incStat   then  @incStat  = value
        when :decStat   then  @decStat  = value
        when :like      then  @like     = value
        when :dislike   then  @dislike  = value
      end
    }
  end

end

class TownMapData < DataObject
  attr_reader :name
  attr_reader :pos
  attr_reader :poi
  attr_reader :flyData
  attr_reader :region

  def initialize(pos, data, region)
    @flags = {}
    @pos = pos
    @region = region
    data.each{|key, value|
      case key
        when :name    then  @name     = value
        when :poi     then  @poi      = value
        when :flyData then  @flyData  = value
        else @flags[key] = value
      end
    }
  end
end
