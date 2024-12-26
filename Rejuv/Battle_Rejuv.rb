 class PokeBattle_Battle 
  attr_accessor :zettacounter
  attr_accessor :snapshot

  def canChangeFE?(newfield=[])
    newfield = [newfield] if newfield && !newfield.is_a?(Array)
    return !([:UNDERWATER,:NEWWORLD,:DRAGONSDEN]+newfield).include?(@field.effect)
  end

  def pbCrestEffects(index,pokemon)
    return if !@battlers[index].crested
    pbCrestEntry(index,pokemon)
    case @battlers[index].crested
    when :CASTFORM
      leadmove=@battlers[index].moves.first
      movedata = $cache.moves[leadmove.move].function
      case movedata
      when 0xFF
        if @weather!=:SUNNYDAY
          @weather=:SUNNYDAY
          @weatherduration=5
          @weatherduration=8 if  @field.effect == :DESERT || @field.effect == :MOUNTAIN || @field.effect == :SNOWYMOUNTAIN || @field.effect == :SKY
          pbCommonAnimation("Sunny",nil,nil)
          pbDisplay(_INTL("{1}'s Sunny Day intensified the sun's rays!",@battlers[index].pbThis))
          @battlers[index].pbCheckForm
        end
      when 0x100
        if @weather!=:RAINDANCE
          @weather=:RAINDANCE
          @weatherduration=5
          @weatherduration=8 if @field.effect == :SKY
          pbCommonAnimation("Rain",nil,nil)
          pbDisplay(_INTL("{1}'s Rain Dance made it rain!",@battlers[index].pbThis))
          @battlers[index].pbCheckForm
        end
      when 0x101
        if @weather!=:SANDSTORM
          @weather=:SANDSTORM
          @weatherduration=5
          @weatherduration=8 if @field.effect == :DESERT || @field.effect == :ASHENBEACH || @field.effect == :SKY
          pbCommonAnimation("Sandstorm",nil,nil)
          pbDisplay(_INTL("{1}'s Sandstorm whipped up a sandstorm!",@battlers[index].pbThis))
          @battlers[index].pbCheckForm
        end
      when 0x102
        if @weather!=:HAIL
          @weather=:HAIL
          @weatherduration=5
          @weatherduration=8 if @field.effect == :ICY || @field.effect == :SNOWYMOUNTAIN || @field.effect == :FROZENDIMENSION || @field.effect == :SKY
          pbCommonAnimation("Hail",nil,nil)
          # Gen 9 Mod - Hail/Snow/Both
          pbDisplay(_INTL("{1}'s " + HAILSNOWNAMEMOD + " made it " + HAILSNOWLOWMOD + "!",@battlers[index].pbThis))
          @battlers[index].pbCheckForm
        end
      end
    when :THIEVUL
      if !@battlers[index].pbOpposing1.isFainted?
        opposing=@battlers[index].pbOpposing1
        if opposing.pbCanReduceStatStage?(PBStats::SPATK)
          opposing.pbReduceStat(PBStats::SPATK,1,statdropper: @battlers[index])
        end
      end
      if !@battlers[index].pbOpposing2.isFainted?
        opposing=@battlers[index].pbOpposing2
        if opposing.pbCanReduceStatStage?(PBStats::SPATK)
          opposing.pbReduceStat(PBStats::SPATK,1,statdropper: @battlers[index])
        end
      end
      if @battlers[index].pbCanIncreaseStatStage?(PBStats::SPATK)
        @battlers[index].pbIncreaseStat(PBStats::SPATK,1)
      end
    when :PROBOPASS
      @battlers[index].effects[:MagnetRise]=8
      pbAnimation(:MAGNETRISE,@battlers[index],nil) # Magnet Rise animation
    when :PHIONE 
      @battlers[index].effects[:AquaRing]=true
      pbAnimation(:AQUARING,@battlers[index],nil) # Aqua Ring animation
    when :VESPIQUEN
      @battlers[index].effects[:VespiCrest] = true
      @battlers[index].pbIncreaseStatBasic(PBStats::ATTACK,1)  
      @battlers[index].pbIncreaseStatBasic(PBStats::SPATK,1)  
    when :ZANGOOSE
      if @battlers[index].status!=:POISON
        @battlers[index].status=:POISON
        @battlers[index].statusCount=1
        pbCommonAnimation("Poison",@battlers[index],nil)
        pbDisplay(_INTL("{1} was poisoned by its {2}!",@battlers[index].pbThis,getItemName(@battlers[index].item)))
      end
    end
  end

  def pbCrestEntry(index,pokemon)
    case @battlers[index].species
    when :FURRET
      attacker = @battlers[index]
      sublife=[(attacker.totalhp/4.0).floor,1].max
      if attacker.hp<=sublife
        @battle.pbDisplay(_INTL("It was too weak to make a substitute!"))
        return -1
      end
      attacker.pbReduceHP(sublife,false,false)
      attacker.effects[:UsingSubstituteRightNow]=true
      attacker.battle.scene.pbAnimation(:SUBSTITUTE,attacker,attacker,1)  #pbShowAnimation(@move,attacker,nil,hitnum,alltargets,true)
      attacker.effects[:UsingSubstituteRightNow]=false
      attacker.effects[:Substitute]=sublife
      pbDisplay(_INTL("{1} put up a substitute!",battlers[index].pbThis))
    when :DELCATTY
      pbDisplay(_INTL("{1} gained strength from The Power of Friendship!",battlers[index].pbThis))
    when :REUNICLUS
      if @battlers[index].moves[0].pbIsPhysical?()
        @battlers[index].attack, @battlers[index].spatk = @battlers[index].spatk, @battlers[index].attack #@type1 == :FIGHTING
        @battlers[index].type1 = :FIGHTING
      end
    end
  
  end

  def pbCanRun?(idxPokemon)
    return false if @opponent
    if @battlers.any?{|battler| battler.isbossmon}
      return true if @battlers.any?{|battler| battler.canrun}
    end
    return false if @battlers.any?{|battler| battler.isbossmon && !@cantescape}
    thispkmn=@battlers[idxPokemon]
    return true if thispkmn.hasWorkingItem(:SMOKEBALL)
    return true if thispkmn.hasWorkingItem(:MAGNETICLURE)
    return true if thispkmn.hasWorkingItem(:MIRRORLURE)
    return true if thispkmn.ability == :RUNAWAY
    return pbCanSwitch?(idxPokemon,-1,false)
  end


  #alias for setpledge to change field
  def setPledge(moveid,fielduration=4)
    @field.pledge = moveid if @field.pledge == nil
    return if @field.pledge == moveid
    pledgepair = [moveid,@field.pledge]
    setField(:SWAMP,fielduration) if !(pledgepair.include?(:FIREPLEDGE))
    setField(:RAINBOW,fielduration) if !(pledgepair.include?(:GRASSPLEDGE))
    setField(:VOLCANIC,fielduration) if !(pledgepair.include?(:WATERPLEDGE))
    @field.pledge = nil
  end

  def partyNameOverwrite(party,newpoke)
    @zettacounter = 0 if @zettacounter.nil?
    if party[newpoke].name == getMonName(party[newpoke].species) && @zettacounter < 4
      zettaNames=["Do","Not","Forget","About"]
      @zettacounter = 0 if @zettacounter.nil?
      party[newpoke].name = zettaNames[@zettacounter]
      @zettacounter+=1
    end
  end

  def runtrainerskills(pkmn,delay=false)
    party = @battle.pbParty(pkmn.index)
    monindex = party.index(pkmn.pokemon)
    trainer = pbPartyGetOwner(pkmn.index,monindex)
    return if trainer.nil?
    return if trainer.trainereffect.nil?
    return if trainer.trainereffect[:effectmode].nil?
    if !delay
      trainer.trainereffectused = [] if !trainer.trainereffectused && trainer.trainereffect[:buffactivation] == :Limited
      if trainer.trainereffect[:effectmode] == :Party
        monindex = monindex-6 if monindex > 5 && @opponent.is_a?(Array)
        trainereffect = trainer.trainereffect[monindex]
        if trainer.trainereffect[:buffactivation] == :Limited
          return if trainer.trainereffectused.include?(monindex)
          trainer.trainereffectused.push(monindex)
        end
      # on god if someone tries to use Fainted effect mode on a Multibattle heads will roll
      elsif trainer.trainereffect[:effectmode] == :Fainted
        trainereffect = trainer.trainereffect[pkmn.pbFaintedPokemonCount]
        if trainer.trainereffect[:buffactivation] == :Limited
          return if trainer.trainereffectused.include?(pkmn.pbFaintedPokemonCount)
          trainer.trainereffectused.push(pkmn.pbFaintedPokemonCount)
        end
      end
    else
      trainereffect = trainer.trainerdelayedeffect
    end
    return if trainereffect.nil?
    if @opponent.is_a?(Array)
      if @opponent.include?(trainer)
        opponent = @opponent.index(trainer)
        @scene.pbShowOpponent(opponent)
        showtrainer = true
      end
    else
      if @opponent == trainer
        @scene.pbShowOpponent(0)
        showtrainer = true
      end
    end
    if trainereffect[:message] && trainereffect[:message] != ""
      pbDisplayPaused(_INTL(trainereffect[:message]))
    end
    if trainereffect[:animation]
      pbAnimation(trainereffect[:animation],pkmn,nil)
    end
    if trainereffect[:fieldChange] && trainereffect[:fieldChange][0] != @field.effect
      pbAnimation(:MAGICROOM,pkmn,nil)
      setField(trainereffect[:fieldChange][0],trainereffect[:fieldChange][2])
      fieldmessage = (trainereffect[:fieldChange][1] != "") ? trainereffect[:fieldChange][1] : "The field was changed!"
      pbDisplay(_INTL("{1}",fieldmessage))
    end
    if trainereffect[:typeChange]
      pkmn.type1 = trainereffect[:typeChange][0]
      pkmn.type2 = trainereffect[:typeChange][1] if trainereffect[:typeChange][1]
      typechangeMessage = trainereffect[:typeChangeMessage]
      pbDisplay(_INTL(typechangeMessage,pkmn.pbThis)) if typechangeMessage
    end
    trainereffect[:pokemonEffect].each_pair {|effect,effectval|
      pkmn.effects[effect] = effectval[0]
      pbAnimation(effectval[1],pkmn,nil) if !effectval[1].nil?
      effectmessage = effectval[2] != "" ? effectval[2] : "An effect was put up by {1}!"
      pbDisplay(_INTL(effectmessage,trainer.name,pkmn.pbThis(true)))
    } if trainereffect[:pokemonEffect]
    trainereffect[:opposingEffects].each_pair {|effect,effectval|
      if !pkmn.pbOpposing1.isFainted?
        pkmn.pbOpposing1.effects[effect] = effectval[0]
        pbAnimation(effectval[1],pkmn.pbOpposing1,nil) if !effectval[1].nil?
      end
      if !pkmn.pbOpposing2.isFainted?
        pkmn.pbOpposing2.effects[effect] = effectval[0]
        pbAnimation(effectval[1],pkmn.pbOpposing2,nil) if !effectval[1].nil?
      end
      effectmessage = effectval[2] != "" ? effectval[2] : "An effect was put up by {1}!"
      pbDisplay(_INTL(effectmessage,trainer.name,pkmn.pbThis(true)))
    } if trainereffect[:opposingEffects]
    trainereffect[:stateChanges].each_pair {|effect,effectval|
      @battle.state.effects[effect] = effectval[0]
      pbAnimation(effectval[1],pkmn,nil) if !effectval[1].nil?
      statemessage = effectval[2] != "" ? effectval[2] : "The state of the battle was changed!"
      pbDisplay(_INTL(statemessage,trainer.name))
    } if trainereffect[:stateChanges]
    side = pkmn.pbOwnSide
    trainereffect[:trainersideChanges].each_pair {|effect,effectval|
      side.effects[effect] = effectval[0]
      pbAnimation(effectval[1],pkmn,nil) if !effectval[1].nil?
      statemessage = effectval[2] != "" ? effectval[2] : "An effect was put up by {1}!"
      pbDisplay(_INTL(statemessage,trainer.name))
    } if trainereffect[:trainersideChanges]
    side = pkmn.pbOpposingSide
    trainereffect[:opposingsideChanges].each_pair {|effect,effectval|
      side.effects[effect] = effectval[0]
      pbAnimation(effectval[1],pkmn,nil) if !effectval[1].nil?
      statemessage = effectval[2] != "" ? effectval[2] : "An effect was put up by {1}!"
      pbDisplay(_INTL(statemessage,trainer.name))
    } if trainereffect[:opposingsideChanges]
    trainereffect[:pokemonStatChanges].each_pair {|stat,statval|
      statval *= -1 if pkmn.ability == :CONTRARY
      if statval > 0 && !pkmn.pbTooHigh?(stat)
        pkmn.pbIncreaseStatBasic(stat,statval)
        @battle.pbCommonAnimation("StatUp",pkmn) if !pkmn.statupanimplayed
        pkmn.statupanimplayed=true
        pbDisplay(_INTL("{1}'s {2} rose!",pkmn.pbThis,pkmn.pbGetStatName(stat)))
      elsif statval < 0 && !pkmn.pbTooLow?(stat)
        pkmn.pbReduceStatBasic(stat,-statval)
        @battle.pbCommonAnimation("StatDown",pkmn) if !pkmn.statdownanimplayed
        pkmn.statdownanimplayed=true
        pbDisplay(_INTL("{1}'s {2} fell!",pkmn.pbThis,pkmn.pbGetStatName(stat)))
      end
    } if trainereffect[:pokemonStatChanges]
    pkmn.statupanimplayed=false
    pkmn.statdownanimplayed=false
    trainereffect[:opposingSideStatChanges].each_pair {|stat,statval|
      for i in @battlers
        next if i.isFainted?
        next if !pkmn.pbIsOpposing?(i.index)
        statval *= -1 if i.ability == :CONTRARY
        if statval > 0 && !i.pbTooHigh?(stat)
          i.pbIncreaseStatBasic(stat,statval)
          @battle.pbCommonAnimation("StatUp",i) if !i.statupanimplayed
          i.statupanimplayed=true
          pbDisplay(_INTL("{1} boosted {2}'s {3}!", trainer.name,i.name,i.pbGetStatName(stat)))
        elsif statval < 0 && !i.pbTooLow?(stat)
          i.pbReduceStatBasic(stat,-statval)
          @battle.pbCommonAnimation("StatDown",i) if !i.statdownanimplayed
          i.statdownanimplayed=true
          pbDisplay(_INTL("{1} lowered {2}'s {3}!", trainer.name,i.name,i.pbGetStatName(stat)))
        end
        i.statupanimplayed=false
        i.statdownanimplayed=false
      end
    } if trainereffect[:opposingSideStatChanges]
    if trainereffect[:instantMove]
      pkmn.pbUseMoveSimple(trainereffect[:instantMove][0],-1,trainereffect[:instantMove][1],false,true)
    end
    if delay
      if trainereffect[:repeat]
        trainer.trainerdelaycounter = trainereffect[:delay]
      else
        trainer.trainerdelayedeffect = nil
        trainer.trainerdelaycounter = nil
      end
    end
    if trainereffect[:delayedaction]
      trainer.trainerdelayedeffect = trainereffect[:delayedaction]
      trainer.trainerdelaycounter = (trainereffect[:delayedaction][:delay])
    end
    @scene.pbHideOpponent if showtrainer
  end
end

def delayedaction
  actionsrun = []
  for i in priority
    next if i.isFainted?
    party = @battle.pbParty(i.index)
    monindex = party.index(i.pokemon)
    trainer = pbPartyGetOwner(i.index,monindex)
    battler = i
    if battler.isbossmon
      next if !battler.bossdelayedeffect
      next if battler.bossdelaycounter.nil?
      battler.bossdelaycounter -=1
      actionsrun.push(battler)
      if battler.bossdelaycounter == 0
        pbShieldEffects(battler,battler.bossdelayedeffect,false,true)
      end
    else
      next if !trainer
      next if trainer.trainerdelaycounter.nil?
      next if actionsrun.include?(trainer)
      trainer.trainerdelaycounter-=1
      actionsrun.push(trainer)
      if trainer.trainerdelaycounter == 0
        runtrainerskills(battler,true)
      end
    end
  end
end

# behold war crime central, these 2 methods are evil and probably messy, but given the result i couldn't care less this is awesome - Fal
def battlesnapshot(battler,snapshotindex=0,uselimit=-1)
  @snapshot = [] if @snapshot.nil?
  return if !@snapshot[snapshotindex].nil?
  party = [nil,nil,nil,nil,nil,nil]
  for i in 0...6
    next if $Trainer.party[i].nil?
    original = $Trainer.party[i]
    backup = original.clone
    backup.moves = []
    for j in 0...original.moves.length; backup.moves[j] = original.moves[j].clone; end
    party[i] = backup
  end
  battledata = @battle.clone
  partyorder = []
  for i in 0...@partyorder.length
    partyorder.push(@partyorder[i])
  end
  battledata.party1 = []
  for i in 0...@battle.party1.length
    next if i < 6
    original = @battle.party1[i]
    backup = original.clone
    backup.moves = []
    for j in 0...original.moves.length; backup.moves[j] = original.moves[j].clone; end
    battledata.party1[i] = backup
  end
  battledata.party2 = []
  for i in 0...@battle.party2.length
    next if @battle.party2[i].nil?
    original = @battle.party2[i]
    backup = original.clone
    backup.moves = []
    for j in 0...original.moves.length; backup.moves[j] = original.moves[j].clone; end
    battledata.party2[i] = backup
  end
  battlerdata= [nil,nil,nil,nil]
  for i in 0...@battlers.length
    next if @battlers[i].pokemon.nil?
    partyindex = @battlers[i].pokemonIndex
    if i == 1 || i == 3
      if battledata.party2[partyindex].nil?
        if @sosbattle == 3
          battledata.doublebattle = false
        end
        battledata.sosbattle = 2
        next
      end
    end
    if @battlers[i].isbossmon
      @battlers[i].pokemon.name = @battlers[i].name
    end
    battlerbackup = @battlers[i].clone
    effectsbackup = @battlers[i].effects.clone
    stagesbackup = @battlers[i].stages.clone
    movesbackup = []
    for j in 0...@battlers[i].moves.length
      movesbackup[j] = @battlers[i].moves[j].clone
      movesbackup[j].pp = @battlers[i].pokemon.moves[j].pp
      if !@battlers[i].nil? && !@battlers[i].pokemon.nil?
        if pbOwnedByPlayer?(i)
          movesbackup[j].basemove = party[partyindex].moves[j]
        else
          movesbackup[j].basemove = battledata.party1[partyindex].moves[j] if i == 0 || i == 2
          movesbackup[j].basemove = battledata.party2[partyindex].moves[j] if i == 1 || i == 3
        end
      end
    end
    if @battlers[i] == battler && @battlers[i].lastHPLost > 0
      battlerbackup.hp = @battlers[i].lastHPLost
      if pbOwnedByPlayer?(i)
        movesbackup[j].basemove = party[@battlers[i].pokemonIndex].moves[j]
        party[@battlers[i].pokemonIndex].hp = @battlers[i].lastHPLost
      else
        battledata.party1[@battlers[i].pokemonIndex].hp = @battlers[i].lastHPLost if i == 0 || i == 2
        battledata.party2[@battlers[i].pokemonIndex].hp = @battlers[i].lastHPLost if i == 1 || i == 3
      end
    end
    battlerbackup = [battlerbackup,partyindex,effectsbackup,stagesbackup,movesbackup]
    battlerdata[i] = battlerbackup
  end
  battledata.megaEvolution = @megaEvolution.clone
  for i in 0...@megaEvolution.length
    battledata.megaEvolution[i] = @megaEvolution[i].clone
  end
  battledata.ultraBurst = @ultraBurst.clone
  for i in 0...@ultraBurst.length
    battledata.ultraBurst[i] = @ultraBurst[i].clone
  end
  battledata.zMove = @zMove.clone
  for i in 0...@zMove.length
    battledata.zMove[i] = @zMove[i].clone
  end
  battledata.items = @battle.items.clone
  battledata.partneritems = @battle.partneritems.clone
  battledata.state= @state.clone
  battledata.state.effects = @state.effects.clone
  battledata.field = @field.clone
  battledata.field.layer = @field.layer.clone
  for i in 0...@field.layer.length
    battledata.field.layer[i] = @field.layer[i].clone
  end
  battledata.sides = @sides.clone
  for i in 0...@sides.length
    battledata.sides[i] = @sides[i].clone
    battledata.sides[i].effects = @sides[i].effects.clone
  end
  bagbackup = $PokemonBag.contents.clone
  pbAnimation(:FUTURESIGHT,battler,nil)
  @snapshot[snapshotindex] = [battledata,battlerdata,party,partyorder,bagbackup,uselimit]
end

def timewarp(battler,snapshotindex=0)
  return if @snapshot.nil?
  return if snapshotindex >= @snapshot.length
  return if @snapshot[snapshotindex].nil?
  return if @snapshot[snapshotindex][5] == 0
  pbAnimation(:ROAROFTIME,battler,nil)
  for i in 0...@battlers.length
    next if @scene.sprites["battlebox#{i}"].nil?
    8.times do
      @scene.sprites["battlebox#{i}"].opacity-=32
      @scene.pbGraphicsUpdate
      Input.update
    end
    @scene.sprites["battlebox#{i}"].visible=false
    @scene.sprites["battlebox#{i}"].dispose if !@battlers[i].pokemon.nil?
    @scene.pbGraphicsUpdate
  end
  #$Trainer.party = @snapshot[snapshotindex][2]
  for i in 0...@battle.party1.length
    if i < 6
      @battle.party1[i].hp = @snapshot[snapshotindex][2][i].hp
      @battle.party1[i].species = @snapshot[snapshotindex][2][i].species
      @battle.party1[i].form = @snapshot[snapshotindex][2][i].form
      @battle.party1[i].ability = @snapshot[snapshotindex][2][i].ability
      @battle.party1[i].level = @snapshot[snapshotindex][2][i].level
      @battle.party1[i].exp = @snapshot[snapshotindex][2][i].exp
      for j in 0...6
        @battle.party1[i].ev[j] = @snapshot[snapshotindex][2][i].ev[j]
      end
      @battle.party1[i].happiness = @snapshot[snapshotindex][2][i].happiness
      @battle.party1[i].status = @snapshot[snapshotindex][2][i].status
      @battle.party1[i].statusCount = @snapshot[snapshotindex][2][i].statusCount
      @battle.party1[i].corrosiveGas = @snapshot[snapshotindex][2][i].corrosiveGas
      @battle.party1[i].landCritical = @snapshot[snapshotindex][2][i].landCritical
      @battle.party1[i].prismPower = @snapshot[snapshotindex][2][i].prismPower
      @battle.party1[i].item = @snapshot[snapshotindex][2][i].item
      @battle.party1[i].itemRecycle = @snapshot[snapshotindex][2][i].itemRecycle
      @battle.party1[i].itemInitial = @snapshot[snapshotindex][2][i].itemInitial
      @battle.party1[i].itemReallyInitialHonestlyIMeanItThisTime= @snapshot[snapshotindex][2][i].itemReallyInitialHonestlyIMeanItThisTime
      @battle.party1[i].belch = @snapshot[snapshotindex][2][i].belch
      @battle.party1[i].heartgauge = @snapshot[snapshotindex][2][i].heartgauge
      @battle.party1[i].hypermode = @snapshot[snapshotindex][2][i].hypermode
      @battle.party1[i].savedev = @snapshot[snapshotindex][2][i].savedev
      @battle.party1[i].savedexp = @snapshot[snapshotindex][2][i].savedexp
      @battle.party1[i].shieldCount = @snapshot[snapshotindex][2][i].shieldCount
      for j in 0...@snapshot[snapshotindex][2][i].moves.length
        @battle.party1[i].moves[j]=PBMove.new(@snapshot[snapshotindex][2][i].moves[j].move)
        @battle.party1[i].moves[j].ppup = @snapshot[snapshotindex][2][i].moves[j].ppup
        @battle.party1[i].moves[j].pp = @snapshot[snapshotindex][2][i].moves[j].pp
      end
      @battle.party1[i].calcStats
      @battle.party1[i].initZmoves(@battle.party1[i].item,true) if $cache.items[@battle.party1[i].item] && $cache.items[@battle.party1[i].item].checkFlag?(:zcrystal)
    else
      @battle.party1[i].hp = @snapshot[snapshotindex][0].party1[i].hp
      @battle.party1[i].species = @snapshot[snapshotindex][0].party1[i].species
      @battle.party1[i].form = @snapshot[snapshotindex][0].party1[i].form
      @battle.party1[i].ability = @snapshot[snapshotindex][0].party1[i].ability
      @battle.party1[i].level = @snapshot[snapshotindex][0].party1[i].level
      @battle.party1[i].exp = @snapshot[snapshotindex][0].party1[i].exp
      for j in 0...6
        @battle.party1[i].ev[j] = @snapshot[snapshotindex][0].party1[i].ev[j]
      end
      @battle.party1[i].happiness = @snapshot[snapshotindex][0].party1[i].happiness
      @battle.party1[i].status = @snapshot[snapshotindex][0].party1[i].status
      @battle.party1[i].statusCount = @snapshot[snapshotindex][0].party1[i].statusCount
      @battle.party1[i].corrosiveGas = @snapshot[snapshotindex][0].party1[i].corrosiveGas
      @battle.party1[i].prismPower = @snapshot[snapshotindex][0].party1[i].prismPower
      @battle.party1[i].landCritical = @snapshot[snapshotindex][0].party1[i].landCritical
      @battle.party1[i].item = @snapshot[snapshotindex][0].party1[i].item
      @battle.party1[i].itemRecycle = @snapshot[snapshotindex][0].party1[i].itemRecycle
      @battle.party1[i].itemInitial = @snapshot[snapshotindex][0].party1[i].itemInitial
      @battle.party1[i].itemReallyInitialHonestlyIMeanItThisTime= @snapshot[snapshotindex][0].party1[i].itemReallyInitialHonestlyIMeanItThisTime
      @battle.party1[i].belch = @snapshot[snapshotindex][0].party1[i].belch
      @battle.party1[i].heartgauge = @snapshot[snapshotindex][0].party1[i].heartgauge
      @battle.party1[i].hypermode = @snapshot[snapshotindex][0].party1[i].hypermode
      @battle.party1[i].savedev = @snapshot[snapshotindex][0].party1[i].savedev
      @battle.party1[i].savedexp = @snapshot[snapshotindex][0].party1[i].savedexp
      @battle.party1[i].shieldCount = @snapshot[snapshotindex][0].party1[i].shieldCount
      for j in 0...@snapshot[snapshotindex][0].party1[i].moves.length
        @battle.party1[i].moves[j]=PBMove.new(@snapshot[snapshotindex][0].party1[i].moves[j].move)
        @battle.party1[i].moves[j].ppup = @snapshot[snapshotindex][0].party1[i].moves[j].ppup
        @battle.party1[i].moves[j].pp = @snapshot[snapshotindex][0].party1[i].moves[j].pp
      end
      @battle.party1[i].calcStats
      @battle.party1[i].initZmoves(@battle.party1[i].item,true) if $cache.items[@battle.party1[i].item] && $cache.items[@battle.party1[i].item].checkFlag?(:zcrystal)
    end
  end
  for i in 0...@snapshot[snapshotindex][0].party2.length
    if @battle.party2[i].nil?
      original = @snapshot[snapshotindex][0].party2[i]
      backup = original.clone
      backup.moves = []
      for j in 0...original.moves.length; backup.moves[j] = original.moves[j].clone; end
      @battle.party2[i] = backup
    else
      @battle.party2[i].hp = @snapshot[snapshotindex][0].party2[i].hp
      @battle.party2[i].species = @snapshot[snapshotindex][0].party2[i].species
      @battle.party2[i].form = @snapshot[snapshotindex][0].party2[i].form
      @battle.party2[i].ability = @snapshot[snapshotindex][0].party2[i].ability
      @battle.party2[i].level = @snapshot[snapshotindex][0].party2[i].level
      @battle.party2[i].exp = @snapshot[snapshotindex][0].party2[i].exp
      for j in 0...6
        @battle.party2[i].ev[j] = @snapshot[snapshotindex][0].party2[i].ev[j]
      end
      @battle.party2[i].happiness = @snapshot[snapshotindex][0].party2[i].happiness
      @battle.party2[i].status = @snapshot[snapshotindex][0].party2[i].status
      @battle.party2[i].statusCount = @snapshot[snapshotindex][0].party2[i].statusCount
      @battle.party2[i].corrosiveGas = @snapshot[snapshotindex][0].party2[i].corrosiveGas
      @battle.party2[i].prismPower = @snapshot[snapshotindex][0].party2[i].prismPower
      @battle.party2[i].landCritical = @snapshot[snapshotindex][0].party2[i].landCritical
      @battle.party2[i].item = @snapshot[snapshotindex][0].party2[i].item
      @battle.party2[i].itemRecycle = @snapshot[snapshotindex][0].party2[i].itemRecycle
      @battle.party2[i].itemInitial = @snapshot[snapshotindex][0].party2[i].itemInitial
      @battle.party2[i].itemReallyInitialHonestlyIMeanItThisTime= @snapshot[snapshotindex][0].party2[i].itemReallyInitialHonestlyIMeanItThisTime
      @battle.party2[i].belch = @snapshot[snapshotindex][0].party2[i].belch
      @battle.party2[i].heartgauge = @snapshot[snapshotindex][0].party2[i].heartgauge
      @battle.party2[i].hypermode = @snapshot[snapshotindex][0].party2[i].hypermode
      @battle.party2[i].savedev = @snapshot[snapshotindex][0].party2[i].savedev
      @battle.party2[i].savedexp = @snapshot[snapshotindex][0].party2[i].savedexp
      @battle.party2[i].shieldCount = @snapshot[snapshotindex][0].party2[i].shieldCount
      for j in 0...@snapshot[snapshotindex][0].party2[i].moves.length
        @battle.party2[i].moves[j]=PBMove.new(@snapshot[snapshotindex][0].party2[i].moves[j].move)
        @battle.party2[i].moves[j].ppup = @snapshot[snapshotindex][0].party2[i].moves[j].ppup
        @battle.party2[i].moves[j].pp = @snapshot[snapshotindex][0].party2[i].moves[j].pp
      end
      @battle.party2[i].calcStats
      @battle.party2[i].initZmoves(@battle.party2[i].item,true) if $cache.items[@battle.party2[i].item] && $cache.items[@battle.party2[i].item].checkFlag?(:zcrystal)
    end
  end
  for i in 0...@partyorder.length
    @partyorder[i] = @snapshot[snapshotindex][3][i]
  end
  if @sosbattle != 2 && @snapshot[snapshotindex][0].sosbattle == 2
    for i in 0...@battlers.length
      if @battlers[i].issossmon
        @scene.sprites["battlebox#{i}"] = @scene.createPokemonDataBox(@battlers[i], @doublebattle, @scene.viewport,self)
        @scene.sprites["shadow#{i}"].visible=false
        @scene.sprites["pokemon#{i}"].visible=false
        @scene.sprites["battlebox#{i}"].visible=false
        @party2.delete_at(@battlers[i].pokemonIndex)
        @battlers[i]= PokeBattle_Battler.new(self,i)
        @battle.choices[i]=[0,0,nil,-1]
      end
    end
  end
  @megaEvolution = @snapshot[snapshotindex][0].megaEvolution.clone
  for i in 0...@megaEvolution.length
    @megaEvolution[i] = @snapshot[snapshotindex][0].megaEvolution[i].clone
  end
  @ultraBurst = @snapshot[snapshotindex][0].ultraBurst.clone
  for i in 0...@ultraBurst.length
    @ultraBurst[i] = @snapshot[snapshotindex][0].ultraBurst[i].clone
  end
  @zMove = @snapshot[snapshotindex][0].zMove.clone
  for i in 0...@zMove.length
    @zMove[i] = @snapshot[snapshotindex][0].zMove[i].clone
  end
  @items = @snapshot[snapshotindex][0].items.clone
  @partneritems = @snapshot[snapshotindex][0].partneritems.clone
  @weather = @snapshot[snapshotindex][0].weather
  @weatherduration = @snapshot[snapshotindex][0].weatherduration
  @weatherbackup = @snapshot[snapshotindex][0].weatherbackup
  @weatherbackupanim = @snapshot[snapshotindex][0].weatherbackupanim
  @storm9 = @snapshot[snapshotindex][0].storm9
  @trickroom = @snapshot[snapshotindex][0].trickroom
  @turncount = @snapshot[snapshotindex][0].turncount
  @eruption = @snapshot[snapshotindex][0].eruption
  @lastMoveUsed = @snapshot[snapshotindex][0].lastMoveUsed
  @lastMoveUser = @snapshot[snapshotindex][0].lastMoveUser
  @state = @snapshot[snapshotindex][0].state.clone
  @state.effects = @snapshot[snapshotindex][0].state.effects.clone
  @field = @snapshot[snapshotindex][0].field.clone
  @field.layer = @snapshot[snapshotindex][0].field.layer.clone
  for i in 0...@field.layer.length
    @field.layer[i] = @snapshot[snapshotindex][0].field.layer[i].clone
  end
  @sides = @snapshot[snapshotindex][0].sides.clone
  for i in 0...@sides.length
    @sides[i] = @snapshot[snapshotindex][0].sides[i].clone
    @sides[i].effects = @snapshot[snapshotindex][0].sides[i].effects.clone
  end
  @doublebattle = @snapshot[snapshotindex][0].doublebattle
  @sosbattle = @snapshot[snapshotindex][0].sosbattle
  $PokemonBag.contents = @snapshot[snapshotindex][4].clone
  pbChangeBGSprite
  for i in 0...@battlers.length
    next if @snapshot[snapshotindex][1][i].nil?
    @battlers[i].initialize(self,i)
    if i == 1 || i == 3
      @battlers[i].pbInitPokemon(@battle.party2[@snapshot[snapshotindex][1][i][1]],@snapshot[snapshotindex][1][i][1])
      @battlers[i].pbInitEffects(false)
      @battlers[i].pbInitBoss(@battle.party2[@snapshot[snapshotindex][1][i][1]],@snapshot[snapshotindex][1][i][1]) if @battle.party2[@snapshot[snapshotindex][1][i][1]].isbossmon
    else
      @battlers[i].pbInitPokemon($Trainer.party[@snapshot[snapshotindex][1][i][1]],@snapshot[snapshotindex][1][i][1])
      @battlers[i].pbInitEffects(false)
    end
    @battlers[i].effects = @snapshot[snapshotindex][1][i][2].clone
    @battlers[i].stages = @snapshot[snapshotindex][1][i][3].clone
    @battlers[i].species = @snapshot[snapshotindex][1][i][0].species
    @battlers[i].type1 = @snapshot[snapshotindex][1][i][0].type1
    @battlers[i].type2 = @snapshot[snapshotindex][1][i][0].type2
    @battlers[i].ability = @snapshot[snapshotindex][1][i][0].ability
    @battlers[i].attack = @snapshot[snapshotindex][1][i][0].attack
    @battlers[i].defense = @snapshot[snapshotindex][1][i][0].defense
    @battlers[i].spatk = @snapshot[snapshotindex][1][i][0].spatk
    @battlers[i].spdef = @snapshot[snapshotindex][1][i][0].spdef
    @battlers[i].speed = @snapshot[snapshotindex][1][i][0].speed
    @battlers[i].participants = []
    for j in 0...@snapshot[snapshotindex][1][i][0].participants.length
      @battlers[i].participants[j] = @snapshot[snapshotindex][1][i][0].participants[j]
    end
    @battlers[i].lastMoveUsed = @snapshot[snapshotindex][1][i][0].lastMoveUsed
    @battlers[i].lastRegularMoveUsed = @snapshot[snapshotindex][1][i][0].lastRegularMoveUsed
    @battlers[i].lastMoveUsedSketch = @snapshot[snapshotindex][1][i][0].lastMoveUsedSketch
    @battlers[i].lastRoundMoved = @snapshot[snapshotindex][1][i][0].lastRoundMoved
    for j in 0...@snapshot[snapshotindex][1][i][0].movesUsed.length
      @battlers[i].movesUsed[j] = @snapshot[snapshotindex][1][i][0].movesUsed[j]
    end
    @battlers[i].unburdened = @snapshot[snapshotindex][1][i][0].unburdened
    @battlers[i].previousMove = @snapshot[snapshotindex][1][i][0].previousMove
    @battlers[i].currentMove = @snapshot[snapshotindex][1][i][0].currentMove
    @battlers[i].wonderroom = @snapshot[snapshotindex][1][i][0].wonderroom
    @battlers[i].itemUsed2 = @snapshot[snapshotindex][1][i][0].itemUsed2
    @battlers[i].lastMoveChoice = @snapshot[snapshotindex][1][i][0].lastMoveChoice
    @battlers[i].lastAttacker = @snapshot[snapshotindex][1][i][0].lastAttacker
    @battlers[i].turncount = @snapshot[snapshotindex][1][i][0].turncount
    @battlers[i].zorotransform = @snapshot[snapshotindex][1][i][0].zorotransform
    @battlers[i].bossdelayedeffect = @snapshot[snapshotindex][1][i][0].bossdelayedeffect
    @battlers[i].bossdelaycounter = @snapshot[snapshotindex][1][i][0].bossdelaycounter
    @battlers[i].currentSOS = @snapshot[snapshotindex][1][i][0].currentSOS
    for j in 0...@snapshot[snapshotindex][1][i][0].moves.length
      if @battlers[i].moves[j].move != @snapshot[snapshotindex][1][i][0].moves[j].move
        newmove=PBMove.new(@snapshot[snapshotindex][1][i][0].moves[j].move)
        newmove.pp = @snapshot[snapshotindex][1][i][0].moves[j].pp
        @battlers[i].moves[j]=PokeBattle_Move.pbFromPBMove(self,newmove,@battlers[i])
        if !(@battlers[i].zmoves.nil? || @battlers[i].item == :INTERCEPTZ)
          self.updateZMoveIndexBattler(j,@battlers[i])
        end
      end
    end
    next if @battlers[i].pokemon.nil?
    @scene.pbChangePokemon(@battlers[i],@battlers[i].pokemon)
  end
  for i in 0...@battlers.length
    next if @snapshot[snapshotindex][1][i].nil?
    doubles = i == 0 && @sosbattle == 3 ? false : @doublebattle
    @scene.sprites["battlebox#{i}"] = @scene.createPokemonDataBox(@battlers[i], doubles, @scene.viewport,self)
    @scene.sprites["battlebox#{i}"].appear
    loop do
      @scene.sprites["battlebox#{i}"].update
      @scene.pbGraphicsUpdate
      Input.update
      break if !@scene.sprites["battlebox#{i}"].appearing
    end
    @battle.scene.pbUnVanishSprite(@battlers[i]) if !@scene.sprites["pokemon#{i}"].visible
    if @battlers[i].isbossmon
      @scene.pbUpdateShield(@battlers[i].shieldCount,@battlers[i].index)
      @battlers[i].bossdelaycounter = 1 if @battlers[i].bossdelaycounter && @battlers[i].bossdelaycounter == 0
    end
  end
  @scene.sprites["fightwindow"].battler = @battlers[0]
  for i in 0...@battlers.length
    next if @battlers[i].pokemon.nil?
    if @battlers[i].isFainted?
      @battlers[i].fainted = false
      @battlers[i].pbFaint
    end
  end
  pbSwitch
  @snapshot[snapshotindex][5]-=1 if @snapshot[snapshotindex][5] > 0
end

def fakeOutBattleEnd
  return if @opponent
  return if !@party2[0].isbossmon
  return if !$cache.bosses[@party2[0].bossId].onBreakEffects
  return if !$cache.bosses[@party2[0].bossId].onBreakEffects[0]
  return if @snapshot[1][5] == 0
  bossname = $cache.bosses[@party2[0].bossId].name
  @scene.pbBossBattleSuccess(bossname)
  pbDisplayPaused(_INTL("{1} defeated\r\n{2}!",self.pbPlayer.name,bossname))
  @scene.sprites["pokemon1"].y = -4
  @decision = 0
  pbShieldEffects(@battlers[1],$cache.bosses[@party2[0].bossId].onBreakEffects[0])
  @battlers[1].currentSOS = 0
  for i in 0...4
    sosmon = @battlers[i] if @battlers[i].issossmon
  end
  if sosmon
    pbResetBattlers(true)
  end
end

# @SWu's shit here

def runstarterskills()
  for i in 0...4
    pkmn = @battlers[i]
    party = @battle.pbParty(pkmn.index)
    monindex = party.index(pkmn.pokemon)
    trainer = pbPartyGetOwner(pkmn.index,monindex)
    next if trainer.nil?
    next if trainer.trainereffect.nil?
    next if trainer.trainereffect[:effectmode].nil?
    # run starter skills
    if trainer.trainereffect[-1]
      trainereffect = trainer.trainereffect[-1]
      if trainereffect[:message] && trainereffect[:message] != ""
        pbDisplayPaused(_INTL(trainereffect[:message]))
      end
      if trainereffect[:instantgiga]
        # giga evolve current battler
        if (pkmn && pbCanGigaEvolve?(i))
          pbGigaEvolve(i)
        end
      end
      if trainereffect[:opposingsideChanges]
        side = pkmn.pbOpposingSide
        trainereffect[:opposingsideChanges].each_pair {|effect,effectval|
          side.effects[effect] = effectval[0]
          pbAnimation(effectval[1],pkmn,nil) if !effectval[1].nil?
          if effectval[2] != nil
            statemessage = effectval[2] != "" ? effectval[2] : "An effect was put up by {1}!"
            pbDisplay(_INTL(statemessage,trainer.name))
          end
        }
      end
      if trainereffect[:trainersideChanges]
        side = pkmn.pbOwnSide
        trainereffect[:trainersideChanges].each_pair {|effect,effectval|
          side.effects[effect] = effectval[0]
          pbAnimation(effectval[1],pkmn,nil) if !effectval[1].nil?
          if effectval[2] != nil
            statemessage = effectval[2] != "" ? effectval[2] : "An effect was put up by {1}!"
            pbDisplay(_INTL(statemessage,trainer.name))
          end
        }
      end
      if trainereffect[:stateChanges]
        trainereffect[:stateChanges].each_pair {|effect,effectval|
          @battle.state.effects[effect] = effectval[0]
          pbAnimation(effectval[1],pkmn,nil) if !effectval[1].nil?
          statemessage = effectval[2] != "" ? effectval[2] : "The state of the battle was changed!"
          pbDisplay(_INTL(statemessage,trainer.name))
        }
      end
      if trainereffect[:setWeather] && trainereffect[:setWeather] != @weather
        weather = trainereffect[:setWeather][0]
        @weather = weather
        @weatherduration= trainereffect[:setWeather][1]
        weatherMessage = ""
        primal = trainereffect[:setWeather][3]
        weatherText = ""
        if (weather == :RAINDANCE)
          weatherText = "Rain"
          weatherMessage = "Rain is falling..."
        elsif (weather == :SUNNYDAY)
          weatherText = "Sunny"
          weatherMessage = "The sunlight is harsh..."
        elsif (weather == :HAIL)
          weatherText = "Hail"
          weatherMessage = "Hail falls..."
        elsif (weather == :SANDSTORM)
          weatherText = "Sandstorm"
          weatherMessage = "A sandstorm is brewing..."
        elsif (weather == :STRONGWINDS)
          weatherText = "Wind"
          weatherMessage = "Strong winds picked up..."
        end
        if (primal)
          if (weather == :SUNNYDAY)
            @state.effects[:HarshSunlight] = true
          elsif (weather == :RAINDANCE)
            @state.effects[:HeavyRain] = true
          elsif (weather == :HAIL)
            @state.effects[:AbsoluteZero] = true
          elsif (weather == :SANDSTORM)
            @state.effects[:DesertNova] = true
          elsif (weather == :STRONGWINDS)
          end
          @permWeather = true
        end
        
        @weatherbackup = weather
        @weatherbackupanim = weatherText
        @scene.pbShowOpponent(opponent) if trainereffect[:setWeather][4]
        pbCommonAnimation(weatherText)
        weatherMessage = trainereffect[:setWeather][2] if trainereffect[:setWeather][2]
        pbDisplay(_INTL("{1}", weatherMessage)) if weatherMessage
        @scene.pbHideOpponent
      end
      if trainereffect[:fieldChange] && trainereffect[:fieldChange][0] != @field.effect
        pbAnimation(:MAGICROOM,pkmn,nil)
        setField(trainereffect[:fieldChange][0],trainereffect[:fieldChange][2])
        fieldmessage = (trainereffect[:fieldChange][1] != "") ? trainereffect[:fieldChange][1] : "The field was changed!"
        pbDisplay(_INTL("{1}",fieldmessage))
      end
    end
    return
  end
end

class PokeBattle_Trainer
  attr_accessor :trainereffect
  attr_accessor :trainereffectused
  attr_accessor :trainerdelayedeffect
  attr_accessor :trainerdelaycounter
  attr_accessor :tempPartyStorage
end