################################################################################
# This section was created solely for you to put various bits of code that
# modify various wild Pokémon and trainers immediately prior to battling them.
# Be sure that any code you use here ONLY applies to the Pokémon/trainers you
# want it to apply to!
################################################################################

# Make all wild Pokémon shiny while a certain Switch is ON (see Settings).
Events.onWildPokemonCreate+=proc {|sender,e|
  pokemon=e[0]
  if $game_switches[:Force_Wild_Shiny]
     pokemon.makeShiny
  end
  if $game_switches[:No_Catching]
    pokemon.makeNotShiny
  end
}

Events.onTrainerPartyLoad+=proc {|sender,e|
  if e[0] # Trainer data should exist to be loaded, but may not exist somehow
    trainer=e[0][0] # A PokeBattle_Trainer object of the loaded trainer
    items=e[0][1]   # An array of the trainer's items they can use
    party=e[0][2]   # An array of the trainer's Pokémon
    if Reborn && (trainer.trainertype==:SHELLY || trainer.trainertype==:FUTURESHELLY) && trainer.name=="Shelly"
      if party[5].species==:LEAVANNY # [0] is the Pokemon's place in the trainer party, with 0 being slot 1 and so forth (must be changed in all following lines) & where species is the species to change
        party[5].name=$Trainer.name
        case $game_variables[:Player_Gender]
          when 0 # Male player
            party[5].makeMale
          when 1 # Female player
            party[5].makeFemale
          when 2 # Nonbinary player - added in PokeBattle_Pokemon
            party[5].makeGenderless
        end
      end
    end
    if Reborn && (trainer.trainertype==:DARKRAI) && trainer.name=="Darkrai"
      if party[3].species==:DARKRAI # [0] is the Pokemon's place in the trainer party, with 0 being slot 1 and so forth (must be changed in all following lines) & where species is the species to change
        party[3].name = $game_variables[782] if $game_variables[782].is_a?(String) && $game_variables[782] != ""
        party[3].makeShiny if $game_switches[2200]==true
      end
    end
    if Rejuv && ($game_variables[665] == 9 && $game_variables[181] == 56) # story setup
      for i in party
        i.hp=1
      end
    end
    if $game_switches[:Offset_Trainer_Levels]
      for i in 0...party.length
        if $game_variables[:Level_Offset_Value] < 0 
          party[i].level = [(party[i].level+$game_variables[:Level_Offset_Value]),1].max
        else
          party[i].level = (party[i].level+$game_variables[:Level_Offset_Value])
        end
        party[i].calcStats
      end
    end
    if $game_switches[:Percent_Trainer_Levels]
      for i in 0...party.length
        if $game_variables[:Level_Offset_Percent] < 100 
          party[i].level = [(party[i].level*($game_variables[:Level_Offset_Percent]*0.01)).round,1].max
        else
          party[i].level = (party[i].level*($game_variables[:Level_Offset_Percent]*0.01))
        end
        party[i].calcStats
      end
    end
  end
}

# UPDATE 11/19/2013
# Cute Charm now gives a 2/3 chance of being opposite gender
Events.onWildPokemonCreate+=proc {|sender,e|
  pokemon=e[0]
  if !$Trainer.party[0].egg?
    ourpkmn = $Trainer.party[0]
    abl = ourpkmn.ability
    if abl == :CUTECHARM && rand(3) < 2
      pokemon.setGender(ourpkmn.gender == 0 ? 1 : 0)
    end
  end
}
# UPDATE 8/1/2022
# sync will now give a 100% chance of encountered pokemon having
# the same nature as the party leader
Events.onWildPokemonCreate+=proc {|sender,e|
  pokemon=e[0]
  if !$Trainer.party[0].egg?
    ours = $Trainer.party[0]
    if ours.ability == :SYNCHRONIZE
      pokemon.setNature(ours.nature)
    end
  end
}
#Regional Variants + Other things with multiple movesets (Wormadam, Meowstic, etc)
Events.onWildPokemonCreate+=proc {|sender,e|
  pokemon=e[0]
	v = pokemon.formCheck(:MoveList)
  if v!=nil
    moves = v
  else      
    moves = pokemon.getMoveList
  end
  movelist=[]
  for i in moves
    if i[0]<=pokemon.level
      movelist[movelist.length]=i[1]
    end
  end
  movelist.reverse!
  movelist.uniq!
  # Use the first 4(or less) items in the move list
  movelist = movelist[0,movelist.length]
  for i in 0...4
    next if i>=movelist.length
    moveid = movelist[i]
    pokemon.moves[i] = moveid.nil? ? nil : PBMove.new(moveid)
  end
}