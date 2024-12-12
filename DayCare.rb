def pbEggGenerated?
  return false if pbDayCareDeposited!=2
  return $PokemonGlobal.daycareEgg==1
end

def pbDayCareDeposited
  ret=0
  for i in 0...2
    ret+=1 if $PokemonGlobal.daycare[i][0]
  end
  return ret
end

def pbDayCareDeposit(index)
  for i in 0...2
    if !$PokemonGlobal.daycare[i][0]
      $PokemonGlobal.daycare[i][0]=$Trainer.party[index]
      $PokemonGlobal.daycare[i][1]=$Trainer.party[index].level
      $PokemonGlobal.daycare[i][0].heal if !$game_switches[:Nuzlocke_Mode]
      $Trainer.party[index]=nil
      $Trainer.party.compact!
      $PokemonGlobal.daycareEgg=0
      $PokemonGlobal.daycareEggSteps=0
      return
    end
  end
  raise _INTL("No room to deposit a Pokémon") 
end

def pbDayCareGetLevelGain(index,nameVariable,levelVariable)
  pkmn=$PokemonGlobal.daycare[index][0]
  return false if !pkmn
  $game_variables[nameVariable]=pkmn.name
  $game_variables[levelVariable]=pkmn.level-$PokemonGlobal.daycare[index][1]
  return true
end

def pbDayCareGetDeposited(index,nameVariable,costVariable)
  for i in 0...2
    if (index<0||i==index) && $PokemonGlobal.daycare[i][0]
      cost=$PokemonGlobal.daycare[i][0].level-$PokemonGlobal.daycare[i][1]
      cost+=1
      cost*=100
      $game_variables[costVariable]=cost if costVariable>=0
      $game_variables[nameVariable]=$PokemonGlobal.daycare[i][0].name if nameVariable>=0
      return
    end
  end
  raise _INTL("Can't find deposited Pokémon")
end

def pbIsDitto?(pokemon)
  return pokemon.species == :DITTO
end

def pbDayCareCompatibleGender(pokemon1,pokemon2)
  if (pokemon1.isFemale? && pokemon2.isMale?) ||
     (pokemon1.isMale? && pokemon2.isFemale?)
    return true
  end
  ditto1=pbIsDitto?(pokemon1)
  ditto2=pbIsDitto?(pokemon2)
  return true if ditto1 && !ditto2
  return true if ditto2 && !ditto1
  return false
end

def pbDayCareGetCompat
  return 0 if pbDayCareDeposited!=2
  pokemon1=$PokemonGlobal.daycare[0][0]
  pokemon2=$PokemonGlobal.daycare[1][0]
  return 0 if (pokemon1.isShadow? rescue false)
  return 0 if (pokemon2.isShadow? rescue false)
  compat1=pokemon1.eggGroups
  compat2=pokemon2.eggGroups
  #check array intersection or ditto
  return 0 if compat1.include?(:Undiscovered) || compat2.include?(:Undiscovered)
  if (compat1 & compat2) || pokemon1.species == :DITTO || pokemon2.species == :DITTO
    if pbDayCareCompatibleGender(pokemon1,pokemon2)
      if pokemon1.species==pokemon2.species
        return (pokemon1.trainerID==pokemon2.trainerID) ? 2 : 3
      else
        return (pokemon1.trainerID==pokemon2.trainerID) ? 1 : 2
      end
    end
  end
  return 0
end

def pbDayCareGetCompatibility(variable)
  $game_variables[variable]=pbDayCareGetCompat
end

def pbDayCareWithdraw(index)
  if !$PokemonGlobal.daycare[index][0]
    raise _INTL("There's no Pokémon here...")
  else
    addPkmnToPartyOrPC($PokemonGlobal.daycare[index][0])
    lvldiff=$PokemonGlobal.daycare[index][0].level-$PokemonGlobal.daycare[index][1]
    pkmn=$PokemonGlobal.daycare[index][0]
    movelist=pkmn.getMoveList
    for i in 1..lvldiff
      for j in movelist
        pkmn.pbLearnMove(j[1]) if j[0]==($PokemonGlobal.daycare[index][1]+i)      # Learned a new move
      end
    end    
    $PokemonGlobal.daycare[index][0]=nil
    $PokemonGlobal.daycare[index][1]=0
    $PokemonGlobal.daycareEgg=0
  end  
end

def pbDayCareChoose(text,variable)
  count=pbDayCareDeposited
  if count==0
    raise _INTL("There's no Pokémon here...")
  elsif count==1
    $game_variables[variable]=$PokemonGlobal.daycare[0][0] ? 0 : 1
  else
    choices=[]
    for i in 0...2
      pokemon=$PokemonGlobal.daycare[i][0]
      if pokemon.isMale?
        choices.push(_ISPRINTF("{1:s} (M, Lv{2:d})",pokemon.name,pokemon.level))
      elsif pokemon.isFemale?
        choices.push(_ISPRINTF("{1:s} (F, Lv{2:d})",pokemon.name,pokemon.level))
      else
        choices.push(_ISPRINTF("{1:s} (Lv{2:d})",pokemon.name,pokemon.level))
      end
    end
    choices.push(_INTL("CANCEL"))
    command=Kernel.pbMessage(text,choices,choices.length)
    $game_variables[variable]=(command==2) ? -1 : command
  end
end

# Given a baby species, returns the lowest possible evolution of that species
# assuming no incense is involved.
# passing the form of the mainparent instead of the baby to the function so the right mr.mime gets returned mainly
def pbGetNonIncenseLowestSpecies(baby,parentform)
  # Gen 9 Mod - Added option to breed without incense
  if $Settings.chooseBabyIncense != 1
    case baby
      when :MUNCHLAX    then return [:SNORLAX,parentform]
      when :WYNAUT      then return [:WOBBUFFET,parentform]
      when :HAPPINY     then return [:CHANSEY,parentform]
      when :MIMEJR      then return [:MRMIME,parentform]
      when :CHINGLING   then return [:CHIMECHO,parentform]
      when :BONSLY      then return [:SUDOWOODO,parentform]
      when :BUDEW       then return [:ROSELIA,parentform]
      when :AZURILL     then return [:MARILL,parentform]
      when :MANTYKE     then return [:MANTINE,parentform]
    end
  end
  return [baby,parentform]
end

def pbDayCareGenerateEgg
  if pbDayCareDeposited!=2
    return
 # elsif $Trainer.party.length>=6
 #   raise _INTL("Can't store the egg")
  end
  pokemon0=$PokemonGlobal.daycare[0][0]
  pokemon1=$PokemonGlobal.daycare[1][0]
  mother=nil
  father=nil
  babyspecies=0
  ditto0=pbIsDitto?(pokemon0)
  ditto1=pbIsDitto?(pokemon1)
  if pokemon0.isFemale? || (ditto0 && ! pokemon1.isFemale?)
    babyspecies = ditto0 ? pokemon1.species : pokemon0.species
    mother=pokemon0
    father=pokemon1
  else
    babyspecies = ditto1 ? pokemon0.species : pokemon1.species
    mother=pokemon1
    father=pokemon0
  end
  if babyspecies == mother.species
    mainparent = mother
    otherparent = father
  else
    mainparent = father
    otherparent = mother
  end
  babyspecies=pbGetBabySpecies(babyspecies,mainparent.form)
  if (babyspecies[0] == :MANAPHY) && !($cache.pkmn[:PHIONE].nil?)
    babyspecies[0]=:PHIONE
  end
  if (babyspecies[0] == :NIDORANfE) && !($cache.pkmn[:NIDORANmA].nil?)
    babyspecies[0]=[(:NIDORANmA), (:NIDORANfE)][rand(2)]
  elsif (babyspecies[0] == :NIDORANmA) && !($cache.pkmn[:NIDORANfE].nil?)
    babyspecies[0]=[(:NIDORANmA), (:NIDORANfE)][rand(2)]
  elsif (babyspecies[0] == :VOLBEAT) && !($cache.pkmn[:ILLUMISE].nil?)
    babyspecies[0]=[:VOLBEAT, :ILLUMISE][rand(2)]
  elsif (babyspecies[0] == :ILLUMISE) && !($cache.pkmn[:VOLBEAT].nil?)
    babyspecies[0]=[:VOLBEAT, :ILLUMISE][rand(2)]
  elsif (babyspecies[0] == :MUNCHLAX) && !(mother.item == :FULLINCENSE) && !(father.item == :FULLINCENSE)
    babyspecies=pbGetNonIncenseLowestSpecies(babyspecies[0],mainparent.form)
  elsif (babyspecies[0] == :WYNAUT) && !(mother.item == :LAXINCENSE) && !(father.item == :LAXINCENSE)
    babyspecies=pbGetNonIncenseLowestSpecies(babyspecies[0],mainparent.form)
  elsif (babyspecies[0] == :HAPPINY) && !(mother.item == :LUCKINCENSE) && !(father.item == :LUCKINCENSE)
    babyspecies=pbGetNonIncenseLowestSpecies(babyspecies[0],mainparent.form)
  elsif (babyspecies[0] == :MIMEJR) && !(mother.item == :ODDINCENSE) && !(father.item == :ODDINCENSE)
    babyspecies=pbGetNonIncenseLowestSpecies(babyspecies[0],mainparent.form)
  elsif (babyspecies[0] == :CHINGLING) && !(mother.item == :PUREINCENSE) && !(father.item == :PUREINCENSE)
    babyspecies=pbGetNonIncenseLowestSpecies(babyspecies[0],mainparent.form)
  elsif (babyspecies[0] == :BONSLY) && !(mother.item == :ROCKINCENSE) && !(father.item == :ROCKINCENSE)
    babyspecies=pbGetNonIncenseLowestSpecies(babyspecies[0],mainparent.form)
  elsif (babyspecies[0] == :BUDEW) && !(mother.item == :ROSEINCENSE) && !(father.item == :ROSEINCENSE)
    babyspecies=pbGetNonIncenseLowestSpecies(babyspecies[0],mainparent.form)
  elsif (babyspecies[0] == :AZURILL) && !(mother.item == :SEAINCENSE) && !(father.item == :SEAINCENSE)
    babyspecies=pbGetNonIncenseLowestSpecies(babyspecies[0],mainparent.form)
  elsif (babyspecies[0] == :MANTYKE) && !(mother.item == :WAVEINCENSE) && !(father.item == :WAVEINCENSE)
    babyspecies=pbGetNonIncenseLowestSpecies(babyspecies[0],mainparent.form)
  end
  if Rejuv
    babyspecies[1] = 0 if babyspecies[0] == :SOLROCK || babyspecies[0] == :LUNATONE
  end
  # Generate egg
  egg=PokeBattle_Pokemon.new(babyspecies[0],EGGINITIALLEVEL,$Trainer,false,babyspecies[1])

  # Inheriting Moves
  moves=[]
  othermoves=[] 
  movefather=father
  movefather=mother if pbIsDitto?(movefather) && mother.gender!=1
  # Initial Moves
  initialmoves=egg.getMoveList
  for k in initialmoves
    if k[0]<=EGGINITIALLEVEL
      moves.push(k[1])
    else
      othermoves.push(k[1]) if mother.knowsMove?(k[1]) && father.knowsMove?(k[1])
    end
  end
  # Inheriting Natural Moves
  for move in othermoves
    moves.push(move)
  end
  # Inheriting Machine Moves
  # Inheriting Egg Moves
  if egg.formCheck(:EggMoves)!=nil
    for move in egg.formCheck(:EggMoves)
      moves.push(move) if father.knowsMove?(move)
      moves.push(move) if mother.knowsMove?(move)
    end
  else 
    movelist = $cache.pkmn[babyspecies[0]].EggMoves
    if movelist
      for i in movelist
        moves.push(i) if father.knowsMove?(i)
        moves.push(i) if mother.knowsMove?(i)
      end
    end
  end
  # Volt Tackle
  if (((mother.species == :PIKACHU || mother.species == :RAICHU) && mother.item == :LIGHTBALL) ||
      ((father.species == :PIKACHU || father.species == :RAICHU) && father.item == :LIGHTBALL)) && (babyspecies[0] == :PICHU)
    moves.push(:VOLTTACKLE)
  end

  moves = moves.reverse
  moves|=[] # remove duplicates
  moves = moves.reverse # This is to ensure deletion of duplicates is from the start, not the end

  # Assembling move list
  finalmoves=[]
  listend=moves.length-4
  listend=0 if listend<0
  j=0
  for i in listend..listend+3
    moveid = moves[i]
    finalmoves[j] = moveid.nil? ? nil : PBMove.new(moveid)
    j+=1
  end 
  # Inheriting Individual Values
  ivs=[]
  for i in 0...6
    ivs[i]=rand(32)
  end
  ivinherit=[]
  powercount = 0
  for i in 0...2
    parent=[mother,father][i]
    if (parent.item == :POWERWEIGHT|| parent.item == :CANONPOWERWEIGHT)
      ivinherit[i]=PBStats::HP 
      powercount+=1
    end  
    if (parent.item == :POWERBRACER|| parent.item == :CANONPOWERBRACER)
      ivinherit[i]=PBStats::ATTACK 
      powercount+=1
    end  
    if (parent.item == :POWERBELT|| parent.item == :CANONPOWERBELT)
      ivinherit[i]=PBStats::DEFENSE 
      powercount+=1
    end  
    if (parent.item == :POWERLENS|| parent.item == :CANONPOWERLENS)
      ivinherit[i]=PBStats::SPATK 
      powercount+=1
    end  
    if (parent.item == :POWERBAND|| parent.item == :CANONPOWERBAND)
      ivinherit[i]=PBStats::SPDEF 
      powercount+=1
    end
    if (parent.item == :POWERANKLET|| parent.item == :CANONPOWERANKLET)
      ivinherit[i]=PBStats::SPEED
      powercount+=1
    end
  end
  num=0; r=rand(2)
  for i in 0...2
    if ivinherit[r]!=nil
      parent=[mother,father][r]
      ivs[ivinherit[r]]=parent.iv[ivinherit[r]]
      num+=1
      break if num == powercount
    end
    r=(r+1)%2
  end

  destiny= (mother.item == :DESTINYKNOT || father.item == :DESTINYKNOT)
  
  i=0; stats=[PBStats::HP,PBStats::ATTACK,PBStats::DEFENSE,
              PBStats::SPEED,PBStats::SPATK,PBStats::SPDEF]
  loop do
    r=stats[rand(stats.length)]
    if !ivinherit.include?(r)
      parent=[mother,father][rand(2)]
      ivs[r]=parent.iv[r]
      ivinherit.push(r)
      i+=1
    end
    
    # inheriting conditional
    # d.knot
    if destiny
      break if i == 4 && powercount == 1
      break if i == 5
    # no d.knot; power item(s)
    elsif powercount>0
      break if i == 2
    # no d.knot; no power item(s)
    else 
      break if i == 3
    end
  end
  
  # Inheriting nature
  newnatures=[]
  newnatures.push(mother.nature) if (mother.item == :EVERSTONE)
  newnatures.push(father.nature) if (father.item == :EVERSTONE)
  if newnatures.length>0
    egg.setNature(newnatures[rand(newnatures.length)])
  end
  # Masuda method and Shiny Charm
  shinyretries = 0
  shinyretries += 5 if father.language != mother.language
  if shinyretries > 0
    shinyretries.times do
      break if egg.isShiny?

      egg.personalID = rand(65536) | (rand(65536) << 16)
    end
  end
  egg.ballused = pbDayCareChooseOffspringBall(mainparent, otherparent)
  egg.iv[0] = ivs[0]
  egg.iv[1] = ivs[1]
  egg.iv[2] = ivs[2]
  egg.iv[3] = ivs[3]
  egg.iv[4] = ivs[4]
  egg.iv[5] = ivs[5]
  egg.iv.map! { |_| 31 } if $game_switches[:Full_IVs]
  egg.iv.map! { |_| 0 } if $game_switches[:Empty_IVs_Password]
  egg.moves[0] = finalmoves[0]
  egg.moves[1] = finalmoves[1]
  egg.moves[2] = finalmoves[2]
  egg.moves[3] = finalmoves[3]
  egg.moves.compact!
  egg.calcStats
  egg.obtainText = _INTL("Day-Care Couple")
  egg.name = _INTL("Egg")
  egg.eggsteps = $cache.pkmn[egg.species].EggSteps
  if rand(65536) < POKERUSCHANCE
    egg.givePokerus
  end
  # $Trainer.party[$Trainer.party.length]=egg
  addPkmnToPartyOrPC(egg)
end

NON_INHERITABLE_BALLS = [:MASTERBALL, :CHERISHBALL]

def pbDayCareChooseOffspringBall(mainparent, otherparent)
  balls = []
  balls.push(mainparent.ballused)
  mainparentbaby = pbGetBabySpecies(mainparent.species)[0]
  otherparentbaby = pbGetBabySpecies(otherparent.species)[0]
  if mainparentbaby == otherparentbaby ||
     mainparentbaby == :NIDORANfE && otherparentbaby == :NIDORANmA ||
     mainparentbaby == :ILLUMISE && otherparentbaby == :VOLBEAT
    balls.push(otherparent.ballused)
  end
  ball = balls.sample
  return :POKEBALL if NON_INHERITABLE_BALLS.include?(ball)

  return ball
end

Events.onStepTaken += proc { |sender, e|
  next if !$Trainer

  deposited = pbDayCareDeposited
  if deposited == 2 && $PokemonGlobal.daycareEgg == 0
    $PokemonGlobal.daycareEggSteps = 0 if !$PokemonGlobal.daycareEggSteps
    $PokemonGlobal.daycareEggSteps += 1
    if $PokemonGlobal.daycareEggSteps == 256
      $PokemonGlobal.daycareEggSteps = 0
      compatval = [0, 20, 50, 70][pbDayCareGetCompat]
      if $PokemonBag.pbQuantity(:OVALCHARM) > 0
        compatval = [0, 40, 80, 88][pbDayCareGetCompat]
      end
      rnd = rand(100)
      if rnd < compatval
        # Egg is generated
        $PokemonGlobal.daycareEgg = 1
      end
    end
  end
  for i in 0...2
    pkmn = $PokemonGlobal.daycare[i][0]
    next if !pkmn

    maxexp = PBExp.maxExperience(pkmn.growthrate)
    if $game_switches[:Hard_Level_Cap] || Rejuv # Rejuv-style Level Cap
      badgenum = $Trainer.numbadges
      if badgenum != 18
        maxexp = PBExp.startExperience(LEVELCAPS[badgenum], pkmn.growthrate)
      end
    end
    if pkmn.exp < maxexp && !noExp?
      # Exp Increases
      if $game_switches[:Percent_Exp_Gains]
        $game_variables[:Exp_DayCare] += $game_variables[:Exp_Percent]
        pkmn.exp += ($game_variables[:Exp_DayCare] / 100).floor
        $game_variables[:Exp_DayCare] %= $game_variables[:Exp_DayCare]
      else
        pkmn.exp += 1
      end
      newlevel = PBExp.levelFromExperience(pkmn.exp, pkmn.growthrate)
      if newlevel != pkmn.level
        pkmn.level = newlevel
        pkmn.calcStats
        #         movelist=pkmn.getMoveList
        #         for i in movelist
        #           pkmn.pbLearnMove(i[1]) if i[0]==pkmn.level       # Learned a new move
        #         end
      end
    end
  end
}