class PokeBattle_Trainer
  attr_accessor :name
  attr_accessor :id
  attr_accessor :metaID
  attr_accessor :trainertype
  attr_accessor :outfit
  attr_accessor :badges
  attr_accessor :money
  attr_accessor :seen
  attr_accessor :owned
  attr_accessor :formseen
  attr_accessor :aceline  # lines said when the ace is sent out
  attr_accessor :defeatline  # lines said when trainer is defeated
  attr_accessor :formlastseen
  attr_accessor :shadowcaught
  attr_accessor :party
  attr_accessor :pokedex    # Whether the Pokédex was obtained
  attr_accessor :pokegear   # Whether the Pokégear was obtained
  attr_accessor :language
  attr_accessor :lastSave
  attr_accessor :saveNumber
  attr_accessor :backupNames
  attr_accessor :noOnlineBattle
  attr_accessor :storedOnlineParty  
  attr_accessor :onlineMusic
  attr_accessor :onlineAllowNickNames
  attr_accessor :tempname
  attr_accessor :tempmoney
  attr_accessor :tempbadges
  attr_accessor :tempid
  attr_accessor :skill
  attr_accessor :achievements
  attr_accessor :tutorlist


  def trainerTypeName   # Name of this trainer type (localized)
    return $cache.trainertypes[@trainertype].title
  end

  def fullname
    return _INTL("{1} {2}",self.trainerTypeName,@name)
  end

  def publicID(id=nil)   # Portion of the ID which is visible on the Trainer Card
    return id ? id&0xFFFF : @id&0xFFFF
  end

  def secretID(id=nil)   # Other portion of the ID
    return id ? id>>16 : @id>>16
  end

  def getForeignID(targetID=nil)   # Random ID other than this Trainer's ID
    fid=0
    loop do
      if !targetID.nil?
        fid = targetID
      else
        fid=rand(256)
        fid|=rand(256)<<8
      end
      fid|=rand(256)<<16
      fid|=rand(256)<<24
      break if fid!=@id
    end
    return fid 
  end

  def setForeignID(other,targetID=nil)
    @id=other.getForeignID(targetID)
  end

  def metaID
    @metaID=$PokemonGlobal.trainerID if !@metaID && $PokemonGlobal
    @metaID=0 if !@metaID
    return @metaID
  end

  def outfit
    @outfit=0 if !@outfit
    return @outfit
  end

  def language
    @language=pbGetLanguage() if !@language
    return @language
  end

  def money=(value)
    @money=[[value,MAXMONEY].min,0].max
  end

  def moneyEarned   # Money won when trainer is defeated
    ret=0
    return 30 if !$cache.trainertypes[@trainertype]
    ret=$cache.trainertypes[@trainertype].moneymult ? $cache.trainertypes[@trainertype].moneymult : 30
    return ret
  end

  def skill   # Skill level (for AI)
    if !defined?(@skill)
      ret=0
      return 30 if !$cache.trainertypes[@trainertype]
      ret=$cache.trainertypes[@trainertype].skill
      @skill = ret
      return ret
    else
      return @skill
    end
  end

  def skill=(value)
    @skill=value
  end

  def numbadges   # Number of badges
    ret=0
    return 0 if !@badges
    for i in 0...@badges.length
      ret+=1 if @badges[i]
    end
    return ret
  end

  def gender
    return 2
  end

  def isMale?; return self.gender==0; end
  def isFemale?; return self.gender==1; end

  def pokemonParty
    return @party.find_all {|item| item && !item.isEgg? }
  end

  def ablePokemonParty
    return @party.find_all {|item| item && !item.isEgg? && item.hp>0 }
  end

  def partyCount
    return @party.length
  end

  def pokemonCount
    ret=0
    for i in 0...@party.length
      ret+=1 if @party[i] && !@party[i].isEgg?
    end
    return ret
  end

  def ablePokemonCount
    ret=0
    for i in 0...@party.length
      ret+=1 if @party[i] && !@party[i].isEgg? && @party[i].hp>0
    end
    return ret
  end

  # Returns first slot, regardless if it's dead or an egg
  def firstParty
    return @party[0]
  end

  # Returns the non-egg pokemon, even it it's dead
  def firstPokemon
    p=self.pokemonParty
    return p[0]
  end

  # Returns the first alive non-egg pokemon
  def firstAblePokemon
    p=self.ablePokemonParty
    return p[0]
  end

  def lastParty
    return nil if @party.length==0
    return @party[@party.length-1]
  end

  def lastPokemon
    p=self.pokemonParty
    return nil if p.length==0
    return p[p.length-1]
  end

  def lastAblePokemon
    p=self.ablePokemonParty
    return nil if p.length==0
    return p[p.length-1]
  end

  def initialize(name,trainertype)
    @name=name
    @language=pbGetLanguage()
    @trainertype=trainertype
    @id=rand(256)
    @id|=rand(256)<<8
    @id|=rand(256)<<16
    @id|=rand(256)<<24
    @metaID=0
    @outfit=0
    @pokegear=false
    @aceline = ""
    @defeatline = ""
    @pokedex = Pokedex.new()
    if !@trainertype.nil? && $cache.trainertypes[@trainertype].checkFlag?(:player)
      @pokedex.initDexList()
      @badges=[]
      for i in 0...BADGECOUNT
        @badges[i]=false
      end
      @achievements = nil
      if Rejuv
        @achievements = Achievements.new
      end
      @tutorlist = []
    end
    @money=INITIALMONEY
    @party=[]
    @lastSave=""
    @saveNumber = 0
    @backupNames = []
    @noOnlineBattle = false
    @storedOnlineParty=[]   
    @onlineMusic="Battle- Trainer.mp3"
    @onlineAllowNickNames = true
  end
end
