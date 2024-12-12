class Achievements
    attr_accessor :steps
    attr_accessor :encounters
    attr_accessor :trainerBattles

    attr_accessor :itemsUsed
    attr_accessor :itemsBought
    attr_accessor :itemsSold
    attr_accessor :itemsFound
    attr_accessor :itemsUsedBattle
    attr_accessor :itemsPickup

    attr_accessor :movesUsed
    
    attr_accessor :eggsHatched

    attr_accessor :pokemonCaught
    attr_accessor :shiniesCaught
    attr_accessor :pokemonEvolved
    attr_accessor :pokemonEvolvedStone

    attr_accessor :maxFriendship

    def initialize()
        @steps = {
            :progress => 0,
            :level => 0
        }
        @encounters = {
            :progress => 0,
            :level => 0
        }
        @trainerBattles = {
            :progress => 0,
            :level => 0
        }
        @itemsUsed = {
            :progress => 0,
            :level => 0
        }
        @itemsBought = {
            :progress => 0,
            :level => 0
        }
        @itemsSold = {
            :progress => 0,
            :level => 0
        }
        @itemsUsedBattle = {
            :progress => 0,
            :level => 0
        }
        @itemsFound = {
            :progress => 0,
            :level => 0
        }
        @itemsPickup = {
            :progress => 0,
            :level => 0
        }
        @movesUsed = {
            :progress => 0,
            :level => 0
        }
        @eggsHatched = {
            :progress => 0,
            :level => 0
        }
        @pokemonCaught = {
            :progress => 0,
            :level => 0
        }
        @shiniesCaught = {
            :progress => 0,
            :level => 0
        }
        @pokemonEvolved = {
            :progress => 0,
            :level => 0
        }
        @pokemonEvolvedStone = {
            :progress => 0,
            :level => 0
        }
        @maxFriendship = {
            :progress => 0,
            :level => 0
        }
    end

    def [](category)
        begin
            eval("return @#{category[1..]}")
        rescue 
            raise "#{category} is not a valid achievement! Report this to the forums!"
        end
    end

    def getMilestone(category)
        if !category.is_a?(Symbol)
            print "#{category} is not a symbol!"
            return nil
        end
        v = achievementText[category][:milestones][self.getLevel(category)]
        if v == nil
            return achievementText[category][:milestones][achievementText[category][:milestones].length - 1]
        end
        return v
    end
    def getProgress(category)
        eval("return @#{category}[:progress]")
    end
    def getLevel(category)
        eval("return @#{category}[:level]")
    end

    def progress(category,amount=1)
        return if $game_switches[:NotPlayerCharacter]
        eval("
        achievement = @#{category}
        achievement[:progress] += amount
        begin
            if achievement[:progress] >= getMilestone(category) && achievement[:level] < achievementText[category][:milestones].length
                achievement[:level] += 1
                $game_variables[:AchievementsCompleted] += 1
                $game_variables[:APPoints] += reward = (($game_variables[:AchievementsCompleted] / 5) + 1)
                if $scene.spriteset == nil
                    Kernel.pbMessage(\"Achievement Reached!\n\#{achievementText[category][:name]} (Level \#{achievement[:level]})\nAP earned: \#{reward}\")
                else
                    $scene.spriteset.addUserSprite(LocationWindow.new(\"Achievement Reached!\n\#{achievementText[category][:name]} (Level \#{achievement[:level]})\nAP earned: \#{reward}\"))
                end
            end
        rescue
            print \"achievement: '\#{category}' is missing initialization or milestones.\"
        end
        ")
    end
end

def achievementText
    return {
        :steps => {
          :id => 1,
          :name => "Tired Feet",
          :description => "Walk around the world.",
          :milestones => [1000,5000,10000,50000,100000,150000,200000,250000,350000,500000],
          :reward => 2
        },
        :pokemonCaught => {
          :id => 2,
          :name => "Gotta Catch 'Em All",
          :description => "Catch Pokémon.",
          :milestones => [100,250,500],
          :reward => 2
        },
        :encounters => {
          :id => 3,
          :name => "Running in the Tall Grass",
          :description => "Encounter Pokémon.",
          :milestones => [75,150,225],
          :reward => 2
        },
        :trainerBattles => {
          :id => 4,
          :name => "Battlin' Every Day",
          :description => "Go into Trainer battles.",
          :milestones => [50,100,150],
          :reward => 2
        },
        :itemsUsed => {
          :id => 5,
          :name => "Items Are Handy",
          :description => "Use items.",
          :milestones => [50,100,150],
          :reward => 2
        },
        :itemsBought => {
          :id => 6,
          :name => "Buying Supplies",
          :description => "Buy items.",
          :milestones => [250,500,1000],
          :reward => 2
        },
        :itemsSold => {
          :id => 7,
          :name => "Seller",
          :description => "Sell items.",
          :milestones => [50,100,150],
          :reward => 2
        },
        :itemsFound => {
          :id => 8,
          :name => "Finding Treasure",
          :description => "Find items in item balls.",
          :milestones => [75,150,225],
          :reward => 2
        },
        :movesUsed => {
          :id => 9,
          :name => "Ferocious Fighting",
          :description => "Use moves in battle.",
          :milestones => [200,500,800],
          :reward => 2
        },
        :itemsUsedBattle => {
          :id => 10,
          :name => "Mid-Battle Maintenance",
          :description => "Use items in battle.",
          :milestones => [50,100,150],
          :reward => 2
        },
        :shiniesCaught => {
          :id => 11,
          :name => "A Drive to Hunt",
          :description => "Catch shiny Pokémon.",
          :milestones => [1,10,30],
          :reward => 2
        },
        :eggsHatched => {
          :id => 12,
          :name => "Baby Boomer",
          :description => "Hatch eggs.",
          :milestones => [5,50,100],
          :reward => 2
        },
        :pokemonEvolved => {
          :id => 13,
          :name => "Fruitful Efforts",
          :description => "Evolve Pokémon.",
          :milestones => [15,60,120],
          :reward => 2
        },
        :pokemonEvolvedStone => {
          :id => 14,
          :name => "That's a stone, Luigi",
          :description => "Evolve Pokémon with an evolution stone.",
          :milestones => [5,10,20],
          :reward => 2
        },
        :itemsPickup => {
          :id => 15,
          :name => "Trashman",
          :description => "Gather items through Pickup.",
          :milestones => [10,50,100],
          :reward => 2
        },
        :maxFriendship => {
          :id => 16,
          :name => "Friendship is Magic",
          :description => "Reach Max(255) Friendship with Pokémon.",
          :milestones => [1,5,15],
          :reward => 2
        }
      }
end

## Achievement Overrides/Aliases
Events.onStepTaken+=proc{|sender,e| #steps
    if !$PokemonGlobal.stepcount.nil? && $Trainer.achievements
      $Trainer.achievements.progress(:steps)
    end
}

class PokeBattle_Pokemon #max friendship
    alias __core_changeHappiness changeHappiness 
    def changeHappiness(*args)
        oldHappiness = @happiness
        __core_changeHappiness(*args)
        return if !$Trainer.achievements
        $Trainer.achievements.progress(:maxFriendship, 1) if @happiness == 255 && oldHappiness != 255
    end
end

alias __core_egghatch pbHatchAnimation #eggs hatched
    def pbHatchAnimation(*args)
        ret = __core_egghatch(*args)
        return if !$Trainer.achievements
        $Trainer.achievements.progress(:eggsHatched, 1) if ret
    end
#end

class PokemonEvolutionScene #pokemon evolved
    alias __core_evo pbEvolution
    def pbEvolution(*args)
        __core_evo(*args)
        return if !$Trainer.achievements || @canceled
        $Trainer.achievements.progress(:pokemonEvolved, 1)
        $Trainer.achievements.progress(:pokemonEvolvedStone, 1) if pbIsEvolutionStone?(args[1])
    end
end

module ItemHandlers #items uses!!
    self.singleton_class.send(:alias_method, :__core_triggerUseFromBag, :triggerUseFromBag)
    self.singleton_class.send(:alias_method, :__core_triggerUseInField, :triggerUseInField)
    self.singleton_class.send(:alias_method, :__core_triggerUseOnPokemon, :triggerUseOnPokemon)
    self.singleton_class.send(:alias_method, :__core_triggerBattleUseOnBattler, :triggerBattleUseOnBattler)
    self.singleton_class.send(:alias_method, :__core_triggerBattleUseOnPokemon, :triggerBattleUseOnPokemon)
    self.singleton_class.send(:alias_method, :__core_triggerUseInBattle, :triggerUseInBattle)

    def self.triggerUseFromBag(item)
        ret = __core_triggerUseFromBag(item)
        return ret if !$Trainer.achievements
        puts ret
        $Trainer.achievements.progress(:itemsUsed, 1) if ret.is_a?(Numeric) && ret != 0
        return ret
    end

    def self.triggerUseInField(item)
        ret = __core_triggerUseInField(item)
        return ret if !$Trainer.achievements
        $Trainer.achievements.progress(:itemsUsed, 1) if ret
        return ret
    end

    def self.triggerUseOnPokemon(item,battler,scene)
        ret = __core_triggerUseOnPokemon(item,battler,scene)
        return ret if !$Trainer.achievements
        $Trainer.achievements.progress(:itemsUsed, 1) if ret
        return ret
    end

    def self.triggerBattleUseOnBattler(item,battler,scene)
        ret = __core_triggerBattleUseOnBattler(item,battler,scene)
        return ret if !$Trainer.achievements
        $Trainer.achievements.progress(:itemsUsed, 1) if ret
        $Trainer.achievements.progress(:itemsUsedBattle, 1) if ret
        return ret
    end

    def self.triggerBattleUseOnPokemon(item,pokemon,battler,scene)
        ret = __core_triggerBattleUseOnPokemon(item,pokemon,battler,scene)
        return ret if !$Trainer.achievements
        $Trainer.achievements.progress(:itemsUsed, 1) if ret
        $Trainer.achievements.progress(:itemsUsedBattle, 1) if ret
        return ret
    end

    def self.triggerUseInBattle(item,battler,battle)
        ret = __core_triggerUseInBattle(item,battler,battle)
        return ret if !$Trainer.achievements
        $Trainer.achievements.progress(:itemsUsed, 1) if ret
        $Trainer.achievements.progress(:itemsUsedBattle, 1) if ret
        return ret
    end

end

module BallHandlers #catching mons!
    self.singleton_class.send(:alias_method, :__core_onCatch, :onCatch)
    def self.onCatch(ball,battle,pokemon)
        __core_onCatch(ball,battle,pokemon)
        if $Trainer.achievements
            $Trainer.achievements.progress(:pokemonCaught, 1)
            $Trainer.achievements.progress(:shiniesCaught, 1) if pokemon.isShiny?
        end
    end
end

Events.onWildPokemonCreate+=proc {|sender,e| 
    next if !$Trainer.achievements
    $Trainer.achievements.progress(:encounters,1)
}

Events.onTrainerPartyLoad+=proc {|sender,e|
    next if !$Trainer.achievements
    if e[0]
        trainer=e[0][0]
    end
    
    if $PokemonGlobal.partner.nil? || $PokemonGlobal.partner[0]!=trainer.trainertype
		$Trainer.achievements.progress(:trainerBattles, 1)
	end
}

class PokemonMartAdapter
    # IN MART FILE
end

Kernel.singleton_class.send(:alias_method, :__core_itemBall, :pbItemBall)
def Kernel.pbItemBall(*args)
    ret = __core_itemBall(*args)
    return ret if ret == false
    return ret if !$Trainer.achievements
    $Trainer.achievements.progress(:itemsFound, args[1].nil? ? 1 : args[1])
    return ret
end

Kernel.singleton_class.send(:alias_method, :__core_pbPickup, :pbPickup)
def Kernel.pbPickup(*args)
    ret = __core_pbPickup(*args)
    return ret if ret.nil? || !$Trainer.achievements
    $Trainer.achievements.progress(:itemsPickup, 1)
    return ret
end

class PokeBattle_Battler
    alias __core_pbReducePP pbReducePP
    def pbReducePP(*args)
        ret = __core_pbReducePP(*args)
        return ret if !$Trainer.achievements
        $Trainer.achievements.progress(:movesUsed, 1) if ret
        return ret
    end
end

#Save Converter
def achievementConvert(oldachieve)
    return Achievements.new() if !oldachieve.is_a?(Hash)
    achievements = Achievements.new()
    for i in 0...oldachieve.length
        oldkey = oldachieve.keys[i]
        newkey = achievementText.keys[i]
        eval("achievements.#{newkey.to_s}[:progress] = oldachieve[oldkey][\"progress\"]")
        eval("achievements.#{newkey.to_s}[:level] = oldachieve[oldkey][\"level\"]")
    end
    return achievements
end

#$Trainer.achievements = Achievements.new if !$Trainer.achievements