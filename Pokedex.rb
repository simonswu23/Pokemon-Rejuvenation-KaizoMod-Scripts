=begin
This is a Pokedex Object meant for the Reborn-verse scripts. 
Aims to remove the need for old global variables as well as 
remove the need for every battler to have their own array of 
Pokedex info.

Made by Haru
=end

def printGenderDiff
  text = ""
  Dir.each_child("Graphics/Battlers"){|f|
    if f.include?("f") && !f.include?("Egg")
      id = f[0..2].to_i - 1
      text += ":#{$cache.pkmn.keys[id]},\n"
    end
  }
  puts text
end

# because no one wants to deal with this stupid gender shit, be nonbinary gdi
def cancelledgenders
  # Gen 9 Mod - Added Oinkologne
  return [:MEOWSTIC,:INDEEDEE,:BASCULEGION,:OINKOLOGNE]
end

class Pokedex
  attr_accessor :dexList
  attr_accessor :formList
  attr_accessor :seenCount
  attr_accessor :ownedCount
  attr_accessor :canViewDex

  def genderDifferenceArr
    # Gen 9 Mod - Added Oinkologne
    return [
      :VENUSAUR,
      :BUTTERFREE,
      :RATTATA,
      :RATICATE,
      :PIKACHU,
      :RAICHU,
      :ZUBAT,
      :GOLBAT,
      :GLOOM,
      :VILEPLUME,
      :KADABRA,
      :ALAKAZAM,
      :DODUO,
      :DODRIO,
      :HYPNO,
      :RHYHORN,
      :RHYDON,
      :GOLDEEN,
      :SEAKING,
      :SCYTHER,
      :MAGIKARP,
      :GYARADOS,
      :EEVEE,
      :MEGANIUM,
      :LEDYBA,
      :LEDIAN,
      :XATU,
      :SUDOWOODO,
      :POLITOED,
      :AIPOM,
      :WOOPER,
      :QUAGSIRE,
      :MURKROW,
      :WOBBUFFET,
      :GIRAFARIG,
      :GLIGAR,
      :STEELIX,
      :SCIZOR,
      :HERACROSS,
      :SNEASEL,
      :URSARING,
      :PILOSWINE,
      :OCTILLERY,
      :HOUNDOOM,
      :DONPHAN,
      :TORCHIC,
      :COMBUSKEN,
      :BLAZIKEN,
      :BEAUTIFLY,
      :DUSTOX,
      :LUDICOLO,
      :NUZLEAF,
      :SHIFTRY,
      :MEDITITE,
      :MEDICHAM,
      :ROSELIA,
      :GULPIN,
      :SWALOT,
      :NUMEL,
      :CAMERUPT,
      :CACTURNE,
      :MILOTIC,
      :RELICANTH,
      :STARLY,
      :STARAVIA,
      :STARAPTOR,
      :BIDOOF,
      :BIBAREL,
      :KRICKETOT,
      :KRICKETUNE,
      :SHINX,
      :LUXIO,
      :LUXRAY,
      :BUDEW,
      :ROSERADE,
      :COMBEE,
      :PACHIRISU,
      :BUIZEL,
      :FLOATZEL,
      :AMBIPOM,
      :GIBLE,
      :GABITE,
      :GARCHOMP,
      :HIPPOPOTAS,
      :HIPPOWDON,
      :CROAGUNK,
      :TOXICROAK,
      :FINNEON,
      :LUMINEON,
      :SNOVER,
      :ABOMASNOW,
      :WEAVILE,
      :RHYPERIOR,
      :TANGROWTH,
      :MAMOSWINE,
      :UNFEZANT,
      :FRILLISH,
      :JELLICENT,
      :PYROAR,
      :MEOWSTIC,
      :INDEEDEE,
      :BASCULEGION,
      :OINKOLOGNE
    ]
  end

  def initialize(*args)
    #initDexList()
    @seenCount = 0
    @ownedCount = 0
    @canViewDex = false
  end

  def initDexList(debug = false)
    @dexList = Hash.new()
    $cache.pkmn.each { |monKey, data|
      monDexHash = {
        :name => monKey,
        :seen? => debug,
        :owned? => debug,
        :shadowCaught? => debug,
        :shinySeen? => debug,
        :seenCount => 0,
        :ownedCount => 0,
      }

      formNames = data.forms
      forms = Hash.new()
      formsOwned = Hash.new()
      for i in 0...formNames.length
        forms.store(formNames[i], debug)
        formsOwned.store(formNames[i], debug)
      end
      monDexHash.store(:forms, forms)
      monDexHash.store(:formsOwned, formsOwned)
      debugform = formNames[0]

      if genderDifferenceArr.include?(monKey)
        monDexHash.store(
          :gender,
          {
            "Male" => debug,
            "Female" => debug
          }
        )
        debuggender = "Male"
      else
        monDexHash.store(
          :gender,
          {
            "Any" => debug
          }
        )
        debuggender = "Any"
      end

      monDexHash.store(
        :lastSeen,
        {
          :gender => debug ? debuggender : "",
          :form => debug ? debugform : "",
          :shiny => false
        }
      )

      @dexList.store(monKey, monDexHash)
    }
  end
  
  def dexList
    if @dexList
      refreshDex if $cache.pkmn.length != @dexList.length
    end
    return @dexList
  end

  def updateGenderFormEntries
    return if !@dexList
    $cache.pkmn.each{|monKey, data|
      next if !@dexList.keys.include?(monKey)
      changed = false
      if @dexList[monKey][:forms].length != data.forms.length
        newforms = {}
        data.forms.values.each{|form|
          newforms.store(form,@dexList[monKey][:seen?])
        }
        @dexList[monKey][:forms] = newforms 
        changed = true
      end
      if genderDifferenceArr.include?(monKey) && @dexList[monKey][:gender].length == 1
        @dexList[monKey][:gender] = {
          "Male" => @dexList[monKey][:seen?],
          "Female" => @dexList[monKey][:seen?],
        }
        changed = true
      end
      if changed
        @dexList[monKey][:lastSeen][:gender] = @dexList[monKey][:gender].keys[0]
        @dexList[monKey][:lastSeen][:form] = @dexList[monKey][:forms].keys[0]
        @dexList[monKey][:lastSeen][:shiny] = false
      end
    }
  end

  def refreshDex()
    # return if @dexList.length == $cache.pkmn.length
    $cache.pkmn.each { |monKey, data|
      next if @dexList.keys.include?(monKey) && @dexList[monKey][:forms].length == $cache.pkmn[monKey].forms.length && @dexList[monKey][:formsOwned]

      monDexHash = {}
      if @dexList.keys.include?(monKey)
        monDexHash = {
          :name => monKey,
          :seen? => @dexList[monKey][:seen?],
          :owned? => @dexList[monKey][:owned?],
          :shadowCaught? => @dexList[monKey][:shadowCaught?],
          :shinySeen? => @dexList[monKey][:shinySeen?],
          :seenCount => @dexList[monKey][:seenCount],
          :ownedCount => @dexList[monKey][:ownedCount],
        }
        formNames = data.forms
        forms = Hash.new()
        formsOwned = Hash.new()
        for i in 0...formNames.length
          forms.store(formNames[i], @dexList[monKey][:forms][formNames[i]])
          if @dexList[monKey][:formsOwned]
            formsOwned.store(i, @dexList[monKey][:formsOwned][i])
          else
            formsOwned.store(i, false)
          end
        end
        monDexHash.store(:forms, forms)
        monDexHash.store(:formsOwned, formsOwned)

        if genderDifferenceArr.include?(monKey)
          monDexHash.store(
            :gender,
            {
              "Male" => @dexList[monKey][:gender]["Male"],
              "Female" => @dexList[monKey][:gender]["Female"]
            }
          )
        else
          monDexHash.store(
            :gender,
            {
              "Any" => @dexList[monKey][:gender]["Any"]
            }
          )
        end

        monDexHash.store(
          :lastSeen,
          {
            :gender => @dexList[monKey][:lastSeen][:gender],
            :form => @dexList[monKey][:lastSeen][:form],
            :shiny => @dexList[monKey][:lastSeen][:shiny]
          }
        )
      else
        monDexHash = {
          :name => monKey,
          :seen? => false,
          :owned? => false,
          :shadowCaught? => false,
          :shinySeen? => false,
          :seenCount => 0,
          :ownedCount => 0,
        }

        formNames = data.forms
        forms = Hash.new()
        for i in 0...formNames.length

          forms.store(formNames[i], false)
        end
        monDexHash.store(:forms, forms)
        debugform = formNames[0]

        if genderDifferenceArr.include?(monKey)
          monDexHash.store(
            :gender,
            {
              "Male" => false,
              "Female" => false
            }
          )
          debuggender = "Male"
        else
          monDexHash.store(
            :gender,
            {
              "Any" => false
            }
          )
          debuggender = "Any"
        end

        monDexHash.store(
          :lastSeen,
          {
            :gender => false,
            :form => false,
            :shiny => false
          }
        )

      end

      @dexList[monKey] = monDexHash
    }
  end

  def getSeenCount()
    return "???" if !self.dexList
    ret = 0
    for key in self.dexList.keys
      ret += 1 if self.dexList[key][:seen?]
    end
    return ret
  end

  def getOwnedCount()
    return "???" if !self.dexList
    ret = 0
    for key in self.dexList.keys
      ret += 1 if self.dexList[key][:owned?]
    end
    return ret
  end

  def getShadowCount()
    return "???" if !self.dexList
    ret = 0
    for key in self.dexList.keys
      ret += 1 if self.dexList[key][:shadowCaught?]
    end
    return ret
  end

  def shadowCaught?(mon)
    return false if !self.dexList
    return self.dexList[mon][:shadowCaught?]
  end

  def setSeen(pokemon)
    return if !pokemon.is_a?(PokeBattle_Pokemon)
    #REJUV
    if $game_switches
      return if $game_switches[:NotPlayerCharacter]
    end
    return if pokemon.formCheck(:ExcludeDex)

    self.dexList[pokemon.species][:seen?] = true

    if genderDifferenceArr.include?(pokemon.species)
      gender = "Male" if pokemon.gender == 0
      gender = "Female" if pokemon.gender == 1
    else
      gender = "Any"
    end
    self.dexList[pokemon.species][:gender][gender] = true

    form = pokemon.getFormName
    
    self.dexList[pokemon.species][:forms][form] = true

    self.dexList[pokemon.species][:shinySeen?] = true if pokemon.isShiny?
    self.setLastFormSeen(pokemon)
  end
  
  def setFormSeen(pokemon)
    self.setSeen(pokemon)
  end

  def setLastFormSeen(pokemon)
    if $game_switches
      return if $game_switches[:NotPlayerCharacter]
    end
    return if pokemon.formCheck(:ExcludeDex)
    if genderDifferenceArr.include?(pokemon.species)
      gender = "Male" if pokemon.gender == 0
      gender = "Female" if pokemon.gender == 1
    else
      gender = "Any"
    end
    self.dexList[pokemon.species][:lastSeen][:gender] = gender
    
    self.dexList[pokemon.species][:lastSeen][:form] = pokemon.getFormName

    self.dexList[pokemon.species][:lastSeen][:shiny] = pokemon.isShiny?
  end

  def setOwned(pokemon)
    return if !pokemon.is_a?(PokeBattle_Pokemon)

    if $game_switches
      return if $game_switches[:NotPlayerCharacter]
    end
    self.dexList[pokemon.species][:owned?] = true

    if pokemon.isShadow?
      self.dexList[pokemon.species][:shadowCaught?] = true
    end

    self.setFormOwned(pokemon)
    self.setSeen(pokemon)
  end

  def setFormOwned(pokemon)
    return if !pokemon.is_a?(PokeBattle_Pokemon)
    return if $game_switches && $game_switches[:NotPlayerCharacter]

    self.refreshDex() if !self.dexList[pokemon.species][:formsOwned]
    self.dexList[pokemon.species][:formsOwned][pokemon.form] = true
  end

  def clearPokedex
    initDexList()
  end

  def debugDex
    initDexList(true)
  end

end