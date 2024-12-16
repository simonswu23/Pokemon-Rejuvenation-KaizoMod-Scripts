#===============================================================================
# Data box for boss battles (by Stochastic)
# - adapted by Sardines for Pokemon Rejuvenation
#===============================================================================
class PokeBattle_Pokemon
  attr_accessor(:isbossmon)   # is a boss pokemon
  attr_accessor(:shieldCount)   # number of shields 
  attr_accessor(:bossId) # id of the boss idk
  attr_accessor(:sosmon) # is it a pokemon called by SOS
  attr_accessor(:originalhp) # is it a pokemon called by SOS
  @isbossmon=false
  @sosmon=false
  def enablebossmon
    @isbossmon=true
  end

  alias __core_baseStats baseStats
  def baseStats
    val = __core_baseStats
    val = $cache.bosses[self.bossId].moninfo[:BaseStats] if self.bossId && $cache.bosses[self.bossId].moninfo[:BaseStats]
    return val
  end
end

def bossHandler(decision, pokemon)
  return if !pokemon.isbossmon
  return if decision != 4
  return raidHandler(decision,pokemon) if $game_switches[:Raid]
  poke = $cache.bosses[pokemon.bossId].moninfo
  if poke[:moves]
    k=0
    for move in poke[:moves]
      next if move.nil?
      pokemon.moves[k]=PBMove.new(move)
      k+=1
    end
  else
    pokemon.resetMoves
  end
  pokemon.level = poke[:level]
  pokemon.isbossmon = false
  pokemon.shieldCount = nil
  pokemon.bossId = nil
  pokemon.item = nil
  for i in 0...6
    pokemon.ev[i]=0
  end
  if decision == 4
      if !$Trainer.pokedex.nil?
          $Trainer.pokedex.dexList[pokemon.species][:shadowCaught?] = true
      end
  end
end

class PokeBattle_Move
  def pbReduceHPDamage(damage, attacker, opponent)
    futureMoves = [:FUTUREDUMMY, :DOOMDUMMY, :HEXDUMMY]
    if futureMoves.include?(@move)
      damage = pbCalcDamage(attacker, opponent)
    end
    if opponent.effects[:Substitute] > 0 && (!attacker || attacker.index != opponent.index) &&
       attacker.ability != :INFILTRATOR && !isSoundBased? &&
       @move != :SPECTRALTHIEF && @move != :HYPERSPACEHOLE && @move != :HYPERSPACEFURY # spectral thief/ hyperspace hole/ hyperspace fury
      damage = opponent.effects[:Substitute] if damage > opponent.effects[:Substitute]
      opponent.effects[:Substitute] -= damage
      opponent.damagestate.substitute = true
      if damage > 0
        @battle.scene.pbDamageAnimation(opponent, 0)
        @battle.pbDisplay(_INTL("The substitute took damage for {1}!", opponent.name))
        if opponent.effects[:Substitute] <= 0
          opponent.effects[:Substitute] = 0
          @battle.scene.pbUnSubstituteSprite(opponent, opponent.pbIsOpposing?(1))
          @battle.pbDisplay(_INTL("{1}'s substitute faded!", opponent.name))
        end
      end
    elsif opponent.effects[:Disguise] && (!attacker || attacker.index != opponent.index) &&
          opponent.effects[:Substitute] <= 0 && opponent.damagestate.typemod != 0 && !opponent.moldbroken
      opponent.pbBreakDisguise
      opponent.damagestate.disguise = true
      opponent.pbReduceHP((opponent.totalhp / 8.0).floor) if Gen > 7
      @battle.pbDisplay(_INTL("{1}'s Disguise was busted!", opponent.name))
      opponent.effects[:Disguise] = false
      damage = 0
    elsif opponent.effects[:IceFace] && (pbIsPhysical?(type) || @battle.FE == :FROZENDIMENSION) && (!attacker || attacker.index != opponent.index) &&
          opponent.effects[:Substitute] <= 0 && opponent.damagestate.typemod != 0 && !opponent.moldbroken
      opponent.pbBreakDisguise
      opponent.damagestate.disguise = true
      @battle.pbDisplay(_INTL("{1} transformed!", opponent.name))
      opponent.effects[:IceFace] = false
      damage = 0
    else
      opponent.damagestate.substitute = false
      opponent.damagestate.disguise = false
      if damage >= opponent.hp
        damage = opponent.hp
        if @function == 0xE9 # False Swipe
          damage = damage - 1
        elsif opponent.effects[:Endure]
          damage = damage - 1
          opponent.damagestate.endured = true
        elsif damage == opponent.totalhp && @battle.FE == :CHESS && opponent.pokemon.piece == :PAWN && !opponent.damagestate.pawnsturdyused
          opponent.damagestate.pawnsturdyused = true
          opponent.damagestate.pawnsturdy = true
          damage = damage - 1
        elsif damage == opponent.totalhp && opponent.ability == :STURDY && !opponent.moldbroken
          opponent.damagestate.sturdy = true
          damage = damage - 1
        elsif opponent.damagestate.focussash && damage == opponent.totalhp && opponent.item
          opponent.damagestate.focussashused = true
          damage = damage - 1
          opponent.pbDisposeItem(false, true, true, true)
        elsif opponent.damagestate.focusband
          opponent.damagestate.focusbandused = true
          damage = damage - 1
        elsif opponent.damagestate.rampcrest && opponent.pokemon.rampCrestUsed == false
          opponent.damagestate.rampcrestused = true
          opponent.pokemon.rampCrestUsed = true
          damage = damage - 1
        elsif damage == opponent.totalhp && opponent.ability == :STALWART && @battle.FE == :COLOSSEUM && !opponent.moldbroken
          opponent.damagestate.stalwart = true
          damage = damage - 1
        end
        damage = 0 if damage < 0
      end
      return @battle.pbShieldDamage(opponent, damage) if opponent.isbossmon
      oldhp = opponent.hp
      opponent.hp -= damage
      effectiveness = 0
      if opponent.damagestate.typemod < 4
        effectiveness = 1   # "Not very effective"
      elsif opponent.damagestate.typemod > 4
        effectiveness = 2   # "Super effective"
      end
      if opponent.damagestate.typemod != 0
        @battle.scene.pbDamageAnimation(opponent, effectiveness)
      end
      @battle.scene.pbHPChanged([[opponent, oldhp]])
    end
    return damage
  end
end

class PokeBattle_Battle
  attr_accessor :typesequence
  def pbShieldDamage(battler,damage=0)
    shielddam = false
    admindam = false
    hpthreshold = -1
    if battler.shieldCount>0 && battler.onBreakEffects
      onBreakdata = battler.onBreakEffects[battler.shieldCount]
      if !@snapshot.nil?
        if @snapshot[1]
          if @snapshot[1][5]==0
            onBreakdata = battler.onBreakEffects[battler.shieldCount*(-1)]
          end
        end
      end
      puts (onBreakdata)
      hpthreshold = (onBreakdata && onBreakdata[:threshold]) ? onBreakdata[:threshold] : 0
      if hpthreshold == 0.1
        if damage>=battler.hp
          damage=damage-1 
          admindam = true
        end
      elsif hpthreshold > 0
        if (battler.hp - damage) <= (battler.totalhp*hpthreshold).round
          damage = (battler.hp - (battler.totalhp*hpthreshold).round)
          shielddam = true
        end
      end
    end
    oldhp=battler.hp
    battler.hp-=damage
    effectiveness=0
    if battler.damagestate.typemod<4
      effectiveness=1   # "Not very effective"
    elsif battler.damagestate.typemod>4
      effectiveness=2   # "Super effective"
    end
    if battler.damagestate.typemod!=0
      scene.pbDamageAnimation(battler,effectiveness)
    end
    scene.pbHPChanged([[battler, oldhp]])
    if shielddam == true
      battler.pbRecoverHP((battler.totalhp).floor,true)
      pbShieldEffects(battler,onBreakdata) if onBreakdata 
      battler.shieldCount-=1 if battler.shieldCount>0
      @scene.pbUpdateShield(battler.shieldCount,battler.index)
    end
    if admindam
      battler.pbRecoverHP((battler.totalhp).floor,true)
      if onBreakdata
        if onBreakdata[:thresholdmessage] && onBreakdata[:thresholdmessage] != ""
          if onBreakdata[:thresholdmessage].start_with?("{1}") 
            pbDisplay(_INTL(onBreakdata[:thresholdmessage],battler.pbThis))
          else
            pbDisplay(_INTL(onBreakdata[:thresholdmessage],battler.pbThis(true)))
          end
        end
        pbShieldEffects(battler,onBreakdata,false,false,true) if onBreakdata 
      end
      battler.reconstructcounter += 1
      if battler.reconstructcounter >=100
        if $game_variables[731] < 122 && $game_variables[756] < 85
          pbDisplay(_INTL("???: You are wasting your time, Interceptor.",battler.pbThis))
        else
          pbDisplay(_INTL("A lost voice echoed in your head...",battler.pbThis))
          pbDisplay(_INTL("???: You are wasting your time, Interceptor.",battler.pbThis))
        end
        pbAnimation(:ROAROFTIME,battler,nil)
        @decision = 2
        pbJudge()
        # if @decision > 0
        #   return
        # end
      elsif battler.reconstructcounter >=3
        pbDisplayBrief(_INTL("{1} seems indestructible...",battler.pbThis))
      end
    end
    return damage
    # battler.pbRecoverHP((battler.totalhp).floor,true)
    # battler.status = nil
  end

  def pbShieldEffects(battler,onBreakdata,onEntry=false,delay=false,admin=false)
    if battler.shieldsBroken[battler.shieldCount+1]==true && !onBreakdata[:delayedaction] && !pbAllFainted?(@party2) && !admin
      return 
    end
    @scene.pbUnVanishSprite(battler) if battler.vanished
    if onBreakdata[:animation]
      pbAnimation(onBreakdata[:animation],battler,nil)
    end
    if onBreakdata[:message] && onBreakdata[:message] != ""
      if onBreakdata[:message].start_with?("{1}") 
        pbDisplayPaused(_INTL(onBreakdata[:message],battler.pbThis))
      else
        pbDisplayPaused(_INTL(onBreakdata[:message],battler.pbThis(true)))
      end
    end
    if onBreakdata[:CustomMethod]
      indexbackup = battler.index if onBreakdata[:CustomMethod].include?("timewarp")
      eval(onBreakdata[:CustomMethod])
      battler = @battlers[indexbackup] if onBreakdata[:CustomMethod].include?("timewarp")
    end
    if onBreakdata[:fieldChange] && onBreakdata[:fieldChange] != @field.effect
      setField(onBreakdata[:fieldChange])
      fieldmessage = (onBreakdata[:fieldChangeMessage] && onBreakdata[:fieldChangeMessage] != "") ? onBreakdata[:fieldChangeMessage] : "The field was changed!"
      pbDisplay(_INTL("{1}",fieldmessage))
    end
    multiturnsymbols = [:CLAMP,:FIRESPIN,:SANDTOMB,:DESERTSMARK,:WRAP,:MAGMASTORM,:INFESTATION,:BIND,:WHIRLPOOL]
    if onBreakdata[:bossEffect]
      if onBreakdata[:bossEffect].is_a?(Array)
        for i in 0...onBreakdata[:bossEffect].length
          if multiturnsymbols.include?(onBreakdata[:bossEffect][i])
            battler.effects[:MultiTurnAttack] = onBreakdata[:bossEffect][i]
            battler.effects[:MultiTurn] = onBreakdata[:bossEffectduration] ? onBreakdata[:bossEffectduration][i] : 5
            pbCommonAnimation(onBreakdata[:bossEffectanimation][i].to_s,battler,nil) if onBreakdata[:bossEffectanimation]
          else
            battler.effects[onBreakdata[:bossEffect][i]] = onBreakdata[:bossEffectduration] ? onBreakdata[:bossEffectduration][i] : 5              
            pbAnimation(onBreakdata[:bossEffectanimation][i],battler,nil) if onBreakdata[:bossEffectanimation]
          end
        end
      else
        if multiturnsymbols.include?(onBreakdata[:bossEffect])
          battler.effects[:MultiTurnAttack] = onBreakdata[:bossEffect]
          battler.effects[:MultiTurn] = onBreakdata[:bossEffectduration] ? onBreakdata[:bossEffectduration] : 5
          pbCommonAnimation(onBreakdata[:bossEffectanimation].to_s,battler,nil) if onBreakdata[:bossEffectanimation]
        else
          battler.effects[onBreakdata[:bossEffect]] = onBreakdata[:bossEffectduration]
          pbAnimation(onBreakdata[:bossEffectanimation],battler,nil) if onBreakdata[:bossEffectanimation]
        end
      end
      if onBreakdata[:bossEffectMessage] 
        if onBreakdata[:bossEffectMessage].is_a?(Array)
          if onBreakdata[:bossEffectMessage][i].start_with?("{1}") 
            pbDisplay(_INTL(onBreakdata[:bossEffectMessage][i],battler.pbThis)) if onBreakdata[:bossEffectMessage][i] != ""
          else
            pbDisplay(_INTL(onBreakdata[:bossEffectMessage][i],battler.pbThis(true))) if onBreakdata[:bossEffectMessage][i] != ""
          end
        else
          if onBreakdata[:bossEffectMessage].start_with?("{1}") 
            pbDisplay(_INTL(onBreakdata[:bossEffectMessage],battler.pbThis)) if onBreakdata[:bossEffectMessage] != ""
          else
            pbDisplay(_INTL(onBreakdata[:bossEffectMessage],battler.pbThis(true))) if onBreakdata[:bossEffectMessage] != ""
          end
        end
      end
    end
    if onBreakdata[:playerEffects]
      if onBreakdata[:playerEffects].is_a?(Array)
        for i in 0...onBreakdata[:playerEffects].length
          if multiturnsymbols.include?(onBreakdata[:playerEffects][i])
            if !battler.pbOpposing1.isFainted?  && !battler.pbOpposing1.issossmon
              battler.pbOpposing1.effects[:MultiTurnAttack] = onBreakdata[:playerEffects][i]
              battler.pbOpposing1.effects[:MultiTurn] = onBreakdata[:playerEffectsduration] ?  onBreakdata[:playerEffectsduration][i] : 5
              pbCommonAnimation(onBreakdata[:playerEffectsAnimation[i].to_s],battler.pbOpposing1,nil) if onBreakdata[:playerEffectsAnimation][i]
            end
            if !battler.pbOpposing2.isFainted?  && !battler.pbOpposing2.issossmon
              battler.pbOpposing2.effects[:MultiTurnAttack] = onBreakdata[:playerEffects][i]
              battler.pbOpposing2.effects[:MultiTurn] = onBreakdata[:playerEffectsduration] ?  onBreakdata[:playerEffectsduration][i] : 5
              pbCommonAnimation(onBreakdata[:playerEffectsAnimation[i].to_s],battler.pbOpposing2,nil) if onBreakdata[:playerEffectsAnimation][i]
            end
          else
            if !battler.pbOpposing1.isFainted?  && !battler.pbOpposing1.issossmon
              battler.pbOpposing1.effects[onBreakdata[:playerEffects][i]] = onBreakdata[:playerEffectsduration][i]
              if onBreakdata[:playerEffects].include?(:PerishSong)
                battler.pbOpposing1.effects[:PerishSongUser]=battler.index
              end
              if onBreakdata[:playerEffects][i] == (:FutureSightMove)
                battler.pbOpposing1.effects[:FutureSightUser] = battler.index
                battler.pbOpposing1.effects[:FutureSightPokemonIndex] = battler.pokemonIndex
              end
              pbAnimation(onBreakdata[:playerEffectsAnimation[i]],battler.pbOpposing1,nil) if onBreakdata[:playerEffectsAnimation][i]
            end
            if !battler.pbOpposing2.isFainted?  && !battler.pbOpposing2.issossmon
              battler.pbOpposing2.effects[onBreakdata[:playerEffects][i]] = onBreakdata[:playerEffectsduration][i]
              if onBreakdata[:playerEffects].include?(:PerishSong)
                battler.pbOpposing2.effects[:PerishSongUser]=battler.index
              end
              if onBreakdata[:playerEffects][i] == (:FutureSightMove)
                battler.pbOpposing2.effects[:FutureSightUser] = battler.index
                battler.pbOpposing2.effects[:FutureSightPokemonIndex] = battler.pokemonIndex
              end
              pbAnimation(onBreakdata[:playerEffectsAnimation][i],battler.pbOpposing2,nil) if onBreakdata[:playerEffectsAnimation][i]
            end
          end
        end
      else
        if multiturnsymbols.include?(onBreakdata[:playerEffects])
          if !battler.pbOpposing1.isFainted? && !battler.pbOpposing1.issossmon
            battler.pbOpposing1.effects[:MultiTurnAttack] = onBreakdata[:playerEffects]
            battler.pbOpposing1.effects[:MultiTurn] = onBreakdata[:playerEffectsduration] ?  onBreakdata[:playerEffectsduration] : 5
            pbCommonAnimation(onBreakdata[:playerEffectsAnimation].to_s,battler.pbOpposing1,nil) if onBreakdata[:playerEffectsAnimation]
          end
          if !battler.pbOpposing2.isFainted?  && !battler.pbOpposing2.issossmon
            battler.pbOpposing2.effects[:MultiTurnAttack] = onBreakdata[:playerEffects]
            battler.pbOpposing2.effects[:MultiTurn] = onBreakdata[:playerEffectsduration] ?  onBreakdata[:playerEffectsduration] : 5
            pbCommonAnimation(onBreakdata[:playerEffectsAnimation].to_s,battler.pbOpposing2,nil) if onBreakdata[:playerEffectsAnimation]
          end
        else
          if !battler.pbOpposing1.isFainted?  && !battler.pbOpposing1.issossmon
            battler.pbOpposing1.effects[onBreakdata[:playerEffects]] = onBreakdata[:playerEffectsduration]
            if onBreakdata[:playerEffects] == (:PerishSong)
              battler.pbOpposing1.effects[:PerishSongUser]=battler.index
            end
            pbAnimation(onBreakdata[:playerEffectsAnimation],battler.pbOpposing1,nil) if onBreakdata[:playerEffectsAnimation]
          end
          if !battler.pbOpposing2.isFainted?  && !battler.pbOpposing2.issossmon
            battler.pbOpposing2.effects[onBreakdata[:playerEffects]] = onBreakdata[:playerEffectsduration]
            if onBreakdata[:playerEffects] == (:PerishSong)
              battler.pbOpposing2.effects[:PerishSongUser]=battler.index
            end
            pbAnimation(onBreakdata[:playerEffectsAnimation],battler.pbOpposing2,nil) if onBreakdata[:playerEffectsAnimation]
          end
        end
      end
      if onBreakdata[:playerEffectsMessage] && onBreakdata[:playerEffectsMessage] != ""
        if onBreakdata[:playerEffectsMessage].is_a?(Array)
          if onBreakdata[:playerEffectsMessage][i].start_with?("{1}") 
            pbDisplay(_INTL(onBreakdata[:playerEffectsMessage][i],battler.pbThis)) if onBreakdata[:playerEffectsMessage] != ""
          else
            pbDisplay(_INTL(onBreakdata[:playerEffectsMessage][i])) if onBreakdata[:playerEffectsMessage] != ""
          end
        else
          if onBreakdata[:playerEffectsMessage].start_with?("{1}") 
            pbDisplay(_INTL(onBreakdata[:playerEffectsMessage],battler.pbThis)) if onBreakdata[:playerEffectsMessage] != ""
          else
            pbDisplay(_INTL(onBreakdata[:playerEffectsMessage])) if onBreakdata[:playerEffectsMessage] != ""
          end
        end
      end
    end
    if onBreakdata[:speciesUpdate]
      battler.pokemon.species = onBreakdata[:speciesUpdate]
      battler.species = onBreakdata[:speciesUpdate]
      pbAnimation(:TRANSFORM,battler,nil)
      battler.pbUpdate(true)
      @scene.pbChangePokemon(battler,battler.pokemon)
    end
    if onBreakdata[:formchange]
      battler.pokemon.form=onBreakdata[:formchange]
      battler.form = battler.pokemon.form 
      battler.pokemon.ability = battler.pokemon.abilityIndex
      pbAnimation(:TRANSFORM,battler,nil)
      battler.pbUpdate(true)
      @scene.pbChangePokemon(battler,battler.pokemon)
    end
    if onBreakdata[:bgmChange]
      pbBGMPlay(onBreakdata[:bgmChange]) if FileTest.audio_exist?("Audio/BGM/"+ onBreakdata[:bgmChange])
    end
    if onBreakdata[:abilitychange]
      battler.ability = onBreakdata[:abilitychange]
      battler.pokemon.ability = onBreakdata[:abilitychange]
      battler.pbAbilitiesOnSwitchIn(true)
    end
    if onBreakdata[:weatherChange]
      @weather=onBreakdata[:weatherChange]
      @weatherduration= onBreakdata[:weatherCount] ? onBreakdata[:weatherCount] : -1
      @weatherduration=-1 if $game_switches[:Gen_5_Weather]==true
      pbCommonAnimation(onBreakdata[:weatherChangeAnimation]) if onBreakdata[:weatherChangeAnimation]
      weathermessage = onBreakdata[:weatherChangeMessage] != "" ? onBreakdata[:weatherChangeMessage] : "The weather was changed!"
      pbDisplayBrief(_INTL("{1}",weathermessage))
      noWeather
    end
    if onBreakdata[:statusCure]
      pbAnimation(:REFRESH,battler,nil)
      battler.status = nil
      pbDisplayBrief(_INTL("{1} recovered from its status!",battler.pbThis))
    end
    animplay = false
    #Gen 9 Mod - Added Salt Cure and Syrup Bomb
    negativeEffects = [:Curse,:GastroAcid,:Imprison,:Nightmare,:TarShot,:SmackDown,:Encore,:HealBlock,:Octolock,:MultiTurn,:ChtonicMalady,:LeechSeed,:Petrification,:Attract,:Torment,:SaltCure,:SyrupBomb]
    if onBreakdata[:effectClear]
      for i in negativeEffects
        if PokeBattle_Battler::SwitchEff.include?(i)
          if battler.effects[i] != false
            battler.effects[i] = false
            animplay = true
          end
        end
        if PokeBattle_Battler::TurnEff.include?(i) || PokeBattle_Battler::CountEff.include?(i) 
          if battler.effects[i] != 0
            battler.effects[i] = 0
            animplay = true
          end
        end
        if PokeBattle_Battler::PosEff.include?(i)
          if battler.effects[i] != -1          
            battler.effects[i] = -1
            animplay = true
          end
        end
        if PokeBattle_Battler::OtherEff.include?(i)
          if battler.effects[i] != nil          
            battler.effects[i] = nil
            animplay = true
          end
        end
      end
      battler.attack = battler.pokemon.attack
      battler.spatk = battler.pokemon.spatk
      battler.defense = battler.pokemon.defense
      battler.spdef = battler.pokemon.spdef
      pbAnimation(:HEALBELL,battler,nil) if animplay = true
      pbDisplayBrief(_INTL("{1} cleared itself of negative effects!",battler.pbThis))
    end
    if onBreakdata[:statDropCure]
      for s in [PBStats::ATTACK,PBStats::DEFENSE,PBStats::SPEED, PBStats::SPATK,PBStats::SPDEF,PBStats::ACCURACY,PBStats::EVASION]
        battler.stages[s] = 0 if battler.stages[s]<0
      end
      pbDisplayBrief(_INTL("{1} cleared itself of stat drops!",battler.pbThis))
    end
    if onBreakdata[:statDropRefresh]
      for s in [PBStats::ATTACK,PBStats::DEFENSE,PBStats::SPEED, PBStats::SPATK,PBStats::SPDEF,PBStats::ACCURACY,PBStats::EVASION]
        battler.stages[s] = 0 if battler.stages[s]!=0
      end
      pbDisplayBrief(_INTL("{1} cleared itself of stat changes!",battler.pbThis))
    end
    if onBreakdata[:playerSideStatusChanges]
      for i in 0..3
        if i % 2 == 0
          next if @battle.battlers[i].nil?
          next if @battle.battlers[i].isFainted?
          canstatus = false
          case onBreakdata[:playerSideStatusChanges][0]
          when :SLEEP
            canstatus = @battle.battlers[i].pbCanSleep?(false)
          when :PARALYSIS
            canstatus = @battle.battlers[i].pbCanParalyze?(false)
            canstatus = false if battler.hasType?(:ELECTRIC) &&  @battle.battlers[i].hasType?(:GROUND)
          when :POISON
            canstatus = @battle.battlers[i].pbCanPoison?(false)
          when :FREEZE
            canstatus = @battle.battlers[i].pbCanFreeze?(false)
          when :PETRIFIED
            canstatus = @battle.battlers[i].pbCanPetrify?(false)
          end
          if canstatus
            @battle.battlers[i].status = onBreakdata[:playerSideStatusChanges][0]
            @battle.battlers[i].statusCount=2 if onBreakdata[:playerSideStatusChanges][0] == :SLEEP
            @battle.pbCommonAnimation(onBreakdata[:playerSideStatusChanges][1],@battle.battlers[i]) 
          end
        end
      end
    end
    if onBreakdata[:bossSideStatusChanges]
      for i in 0..3
        if i % 2 != 0
          next if @battle.battlers[i].nil?
          next if @battle.battlers[i].isFainted?
          canstatus = false
          case onBreakdata[:bossSideStatusChanges][0]
          when :SLEEP
            canstatus = @battle.battlers[i].pbCanSleep?(false)
          when :PARALYSIS
            canstatus = @battle.battlers[i].pbCanParalyze?(false)
          when :POISON
            canstatus = @battle.battlers[i].pbCanPoison?(false)
          when :FREEZE
            canstatus = @battle.battlers[i].pbCanFreeze?(false)
          when :PETRIFIED
            canstatus = @battle.battlers[i].pbCanPetrify?(false)
          end
          if canstatus 
            @battle.battlers[i].status = onBreakdata[:bossSideStatusChanges][0]
            @battle.pbCommonAnimation(onBreakdata[:bossSideStatusChanges][1],@battle.battlers[i]) 
          end
        end
      end
    end
    if onBreakdata[:playersideChanges]
      side = 0
      playerstatemessageplayed = false
      if onBreakdata[:playersideChanges].is_a?(Array)
        for i in 0...onBreakdata[:playersideChanges].length
          @battle.sides[side].effects[onBreakdata[:playersideChanges][i]] = onBreakdata[:playersideChangeCount] ? onBreakdata[:playersideChangeCount][i] : 5
          pbAnimation(onBreakdata[:playersideChangeAnimation][i],battler,nil) if onBreakdata[:playersideChangeAnimation]
          if onBreakdata[:playersideChangeMessage].is_a?(Array)
            statemessage = onBreakdata[:playersideChangeMessage][i] != "" ? onBreakdata[:playersideChangeMessage][i] : "The state of the battle was changed!"
          else
            statemessage = onBreakdata[:playersideChangeMessage] != "" ? onBreakdata[:playersideChangeMessage] : "An effect was put up on !"
            playerstatemessageplayed = true
          end
          pbDisplay(_INTL("{1}",statemessage)) if !playerstatemessageplayed
        end
      else
        @battle.sides[side].effects[onBreakdata[:playersideChanges]] = onBreakdata[:playersideChangeCount] ? onBreakdata[:playersideChangeCount] : 5
        pbAnimation(onBreakdata[:playersideChangeAnimation],battler,nil) if onBreakdata[:playersideChangeAnimation]
        statemessage = onBreakdata[:playersideChangeMessage] != "" ? onBreakdata[:playersideChangeMessage] : "An effect was put up on !"
        pbDisplay(_INTL("{1}",statemessage))
      end
    end
    if onBreakdata[:bosssideChanges]
      side = 1
      if onBreakdata[:bosssideChanges].is_a?(Array)
        bossstatemessageplayed = false
        for i in 0...onBreakdata[:bosssideChanges].length
          @battle.sides[side].effects[onBreakdata[:bosssideChanges][i]] = onBreakdata[:bosssideChangeCount] ? onBreakdata[:bosssideChangeCount][i] : 5
          pbAnimation(onBreakdata[:bosssideChangeAnimation][i],battler,nil) if onBreakdata[:bosssideChangeAnimation]
          if onBreakdata[:bosssideChangeMessage].is_a?(Array)
            statemessage = onBreakdata[:bosssideChangeMessage][i] != "" ? onBreakdata[:bosssideChangeMessage][i] : "The state of the battle was changed!"
          else
            statemessage = onBreakdata[:bosssideChangeMessage] != "" ? onBreakdata[:bosssideChangeMessage] : "An effect was put up on !"
            statemessageplayed = true
          end
          pbDisplay(_INTL("{1}",statemessage)) if !statemessageplayed
        end
      else
        @battle.sides[side].effects[onBreakdata[:bosssideChanges]] = onBreakdata[:bosssideChangeCount] ? onBreakdata[:bosssideChangeCount] : 5
        pbAnimation(onBreakdata[:bosssideChangeAnimation],battler,nil) if onBreakdata[:bosssideChangeAnimation]
        statemessage = onBreakdata[:bosssideChangeMessage] != "" ? onBreakdata[:bosssideChangeMessage] : "An effect was put up on !"
        pbDisplay(_INTL("{1}",statemessage))
      end
    end
    if onBreakdata[:stateChanges]
      if onBreakdata[:stateChanges].is_a?(Array)
        for i in 0...onBreakdata[:stateChanges].length
          if onBreakdata[:stateChanges][i] == :TrickRoom
            @battle.trickroom = onBreakdata[:stateChangeCount] ? onBreakdata[:stateChangeCount][i] : 5
          else
            @battle.state.effects[onBreakdata[:stateChanges][i]] = onBreakdata[:stateChangeCount] ? onBreakdata[:stateChangeCount][i] : 5
          end
          pbAnimation(onBreakdata[:stateChangeAnimation][i],battler,nil) if onBreakdata[:stateChangeAnimation]
          statemessage = onBreakdata[:stateChangeMessage][i] != "" ? onBreakdata[:stateChangeMessage][i] : "The state of the battle was changed!"
          pbDisplay(_INTL("{1}",statemessage))
        end
      else
        if onBreakdata[:stateChanges] == :TrickRoom
          @battle.trickroom = onBreakdata[:stateChangeCount] ? onBreakdata[:stateChangeCount] : 5
        else
          @battle.state.effects[onBreakdata[:stateChanges]] = onBreakdata[:stateChangeCount] ? onBreakdata[:stateChangeCount] : 5
        end
        pbAnimation(onBreakdata[:stateChangeAnimation],battler,nil) if onBreakdata[:stateChangeAnimation]
        statemessage = onBreakdata[:stateChangeMessage] != "" ? onBreakdata[:stateChangeMessage] : "The state of the battle was changed!"
        pbDisplay(_INTL("{1}",statemessage))
      end
    end
    boostlevel = ["","","sharply ", "drastically "]
    # Stat boost from seed
    statupanimplayed=false
    statdownanimplayed=false
    if battler.randomSetChanges
      items = battler.randomSetChanges.values
      setdetails=items[rand(items.length)]
      if setdetails[:typeChange]
        battler.type1 = setdetails[:typeChange][0]
        battler.type2 = setdetails[:typeChange][1] if setdetails[:typeChange][1]
      end
      if setdetails[:movesetUpdate]
        k=0
        for move in setdetails[:movesetUpdate]
          next if move.nil?
          battler.pokemon.moves[k]=PBMove.new(move)
          if battler.level >=100 && opponent.skill>=PokeBattle_AI::BESTSKILL
            battler.pokemon.moves[k].ppup=3
            battler.pokemon.moves[k].pp=battler.pokemon.moves[k].totalpp
          end
          k+=1
        end
        battler.moves = []
        for move in battler.pokemon.moves
          battler.moves.push(PokeBattle_Move.pbFromPBMove(@battle,move,battler.pokemon)) if move
        end
      end
      setdetails[:bossStatChanges].each_pair {|stat,statval|
        statval *= -1 if battler.ability == :CONTRARY
        if statval > 0 && !battler.pbTooHigh?(stat)
          battler.pbIncreaseStatBasic(stat,statval)
          @battle.pbCommonAnimation("StatUp",battler) if !statupanimplayed
          statupanimplayed=true
          pbDisplay(_INTL("{1}'s fracturing aura boosted its {3}!", battler.pbThis,boostlevel[statval.abs],battler.pbGetStatName(stat)))
        elsif statval < 0 && !battler.pbTooLow?(stat)
          battler.pbReduceStatBasic(stat,-statval)
          @battle.pbCommonAnimation("StatDown",battler) if !statdownanimplayed
          statdownanimplayed=true
          pbDisplay(_INTL("{1}'s fracturing aura lowered its {3}!", battler.pbThis,boostlevel[statval.abs],battler.pbGetStatName(stat)))
        end
      } if setdetails[:bossStatChanges]
      battler.randomSetChanges.delete(battler.randomSetChanges.key(setdetails))
    else
      if onBreakdata[:typeChange]
        battler.type1 = onBreakdata[:typeChange][0]
        battler.type2 = onBreakdata[:typeChange][1] if onBreakdata[:typeChange][1]
      end
      if onBreakdata[:movesetUpdate]
        k=0
        battler.pokemon.moves = []
        for move in onBreakdata[:movesetUpdate]
          next if move.nil?
          battler.pokemon.moves[k]=PBMove.new(move)
          if battler.level >=75 
            battler.pokemon.moves[k].ppup=3
            battler.pokemon.moves[k].pp=battler.pokemon.moves[k].totalpp
          end
          if battler.item && $cache.items[battler.item].checkFlag?(:zcrystal) && battler.item != :INTERCEPTZ
            battler.pokemon.updateZMoveIndex(k)
          end
          k+=1
        end
        battler.moves = []
        k=0
        for move in battler.pokemon.moves
          battler.moves.push(PokeBattle_Move.pbFromPBMove(@battle,move,battler.pokemon)) if move
          if battler.item && $cache.items[battler.item].checkFlag?(:zcrystal) && battler.item != :INTERCEPTZ
            @battle.updateZMoveIndexBattler(k,battler)
          end
          k+=1
        end
      end
    end
    if onBreakdata[:typeSequence] 
      if delay
        typeset =  onBreakdata[:typeSequence].values
        battler.type1 = typeset[@typesequence][:typeChange][0]
        battler.type2 = typeset[@typesequence][:typeChange][1] if typeset[@typesequence][:typeChange][1]
        pbSet(1,@typesequence)
        @typesequence = (@typesequence + 1) % typeset.length
      end
    end
    if onBreakdata[:itemchange]
      battler.item = onBreakdata[:itemchange]
      battler.pokemon.setItem(onBreakdata[:itemchange])
      if $cache.items[battler.item] && $cache.items[battler.item].checkFlag?(:zcrystal)
        battler.pokemon.initZmoves(battler.item,false)
        if !battler.pokemon.zmoves.nil?
          battler.zmoves       = [nil,nil,nil,nil]
          for i in 0...battler.pokemon.zmoves.length
            zmove = battler.pokemon.zmoves[i]
            battler.zmoves[i] = PokeBattle_Move.pbFromPBMove(self,zmove,battler.pokemon,battler.moves[i]) if !zmove.nil?
          end
        end
      else
        battler.pokemon.zmoves= nil
        battler.zmoves = nil
      end
    end
    onBreakdata[:bossStatChanges].each_pair {|stat,statval|
      statval *= -1 if battler.ability == :CONTRARY
      if statval > 0 && !battler.pbTooHigh?(stat)
        battler.pbIncreaseStatBasic(stat,statval)
        @battle.pbCommonAnimation("StatUp",battler) if !statupanimplayed
        statupanimplayed=true
        pbDisplay(_INTL("{1}'s fracturing aura boosted its {3}!", battler.pbThis,boostlevel[statval.abs],battler.pbGetStatName(stat)))
      elsif statval < 0 && !battler.pbTooLow?(stat)
        battler.pbReduceStatBasic(stat,-statval)
        @battle.pbCommonAnimation("StatDown",battler) if !statdownanimplayed
        statdownanimplayed=true
        pbDisplay(_INTL("{1}'s fracturing aura lowered its {3}!", battler.pbThis,boostlevel[statval.abs],battler.pbGetStatName(stat)))
      end
    } if onBreakdata[:bossStatChanges]
    onBreakdata[:playerSideStatChanges].each_pair {|stat,statval|
      for i in @battlers
        next if i.isFainted?
        next if !battler.pbIsOpposing?(i.index)
        next if i.issossmon
        statval *= -1 if i.ability == :CONTRARY
        if statval > 0 && !i.pbTooHigh?(stat) && i.pbCanIncreaseStatStage?(stat)
          i.pbIncreaseStatBasic(stat,statval)
          @battle.pbCommonAnimation("StatUp",i) if !statupanimplayed
          i.statupanimplayed=true
          pbDisplay(_INTL("{1}'s fracturing aura boosted {2}'s {3}!", battler.pbThis,i.name,i.pbGetStatName(stat)))
        elsif statval < 0 && !i.pbTooLow?(stat) && i.pbCanReduceStatStage?(stat)
          i.pbReduceStatBasic(stat,-statval)
          @battle.pbCommonAnimation("StatDown",i) if !statdownanimplayed
          i.statdownanimplayed=true
          pbDisplay(_INTL("{1}'s fracturing aura lowered {2}'s {3}!", battler.pbThis,i.name,i.pbGetStatName(stat)))
        end
        i.statupanimplayed=false
        i.statdownanimplayed=false
      end
    } if onBreakdata[:playerSideStatChanges]
    if delay
      if !onBreakdata[:CustomMethod] || !onBreakdata[:CustomMethod].include?("timewarp")
        if onBreakdata[:repeat]
          battler.bossdelaycounter = onBreakdata[:delay]
        else
          battler.bossdelayedeffect = nil
          battler.bossdelaycounter = nil
        end
      end
    end
    if onBreakdata[:soscontinuous]
      if battler.sosDetails
        battler.sosDetails[:continuous] = true
      end
    end
    if onBreakdata[:delayedaction]
      battler.bossdelayedeffect = onBreakdata[:delayedaction]
      battler.bossdelaycounter = (onBreakdata[:delayedaction][:delay])
    end
    if onEntry == true
      pbBossSOS(@battlers,false,onEntry)
    else
      pbBossSOS(@battlers,shieldbreak=true,onEntry)
    end
  end

  def spaceaManip
    sosmon = []
    for i in priority
      battler = i if i.isbossmon
      sosmon.push(i) if i.issossmon
    end
    return if !battler 
    return if sosmon.empty?
    animplay=false
    if !battler.status.nil?
      for j in 0..sosmon.length
        next if !sosmon[j]
        next if sosmon[j].isFainted?
        sosmon[j].status = battler.status
      end
      battler.status = nil
      animplay=true
    end
    negativeEffects = [:Curse,:GastroAcid,:Imprison,:Nightmare,:TarShot,:SmackDown,:Encore,:HealBlock,:MultiTurn,:LeechSeed,:Petrification,:Attract,:Torment,:Octolock]
    for i in negativeEffects
      if PokeBattle_Battler::SwitchEff.include?(i)
        if battler.effects[i] != false
          for j in 0..sosmon.length
            next if !sosmon[j]
            next if sosmon[j].isFainted?
            sosmon[j].effects[i] = battler.effects[i]
          end
          battler.effects[i] = false
          animplay = true
        end
      end
      if PokeBattle_Battler::TurnEff.include?(i) || PokeBattle_Battler::CountEff.include?(i) 
        if battler.effects[i] != 0
          for j in 0..sosmon.length
            next if !sosmon[j]
            next if sosmon[j].isFainted?
            sosmon.effects[i] = battler.effects[i]
          end
          battler.effects[i] = 0
          animplay = true
        end
      end
      if PokeBattle_Battler::PosEff.include?(i)
        if battler.effects[i] != -1
          for j in 0..sosmon.length
            next if !sosmon[j]
            next if sosmon[j].isFainted?
            sosmon[j].effects[i] = battler.effects[i]
          end          
          battler.effects[i] = -1
          animplay = true
        end
      end
      if PokeBattle_Battler::OtherEff.include?(i)
        if battler.effects[i] != nil
          for j in 0..sosmon.length
            next if !sosmon[j]
            next if sosmon[j].isFainted?
            sosmon[j].effects[i] = battler.effects[i]
          end          
          battler.effects[i] = nil
          animplay = true
        end
      end
    end
    for j in 0..sosmon.length
      pbAnimation(:PAINSPLIT,battler,sosmon[j]) if animplay==true
    end
    pbDisplay(_INTL("Spacea transferred her ailments around!"))
  end
  
  def pbBossSOS(battlers,shieldbreak=false,onEntry=false)
    for i in priority
      battler = i if i.isbossmon
    end
    return if !battler
    sosData = battler.sosDetails
    battlerIndex = battler.index
    if sosData
      if sosData[:refreshingRequirement]
        if (shieldbreak && onEntry==false && @sosbattle > 2 && sosData[:refreshingRequirement].include?(battler.shieldCount-1))
          variable = pbRefreshSOSPokemon(sosData) 
          return if variable == true
        end
      end
      if sosData[:clearingRequirement]
        return pbResetBattlers  if (shieldbreak && onEntry==false && @sosbattle > 2 && sosData[:clearingRequirement].include?(battler.shieldCount-1))
      end
      allowed = false
      allowed = (shieldbreak==true || onEntry ==true || sosData[:continuous])
      if !(sosData[:playerMons] || sosData[:playerParty])
        if eval(sosData[:activationRequirement]) && @battlers[battlerIndex].pbPartner.isFainted?
          if (@opponent && pbPokemonCount(@party2)==1) || !(@opponent)
            if (allowed == true) 
              if sosData[:totalMonCount] 
                sosBattle(battler) if battler.currentSOS<sosData[:totalMonCount] 
              else
                sosBattle(battler)
              end
            end
          else
            return false
          end
        end
      else
        if eval(sosData[:activationRequirement]) 
          if (@opponent && pbPokemonCount(@party2)==1) || !(@opponent)
            if (allowed == true) 
              if sosData[:totalMonCount] 
                sosBattle(battler) if battler.currentSOS<sosData[:totalMonCount] 
              else
                sosBattle(battler)
              end
            end
          else
            return false
          end
        end
      end
    end
  end 

  def pbRefreshSOSPokemon(sosData)
    return false if @sosbattle != 3
    for i in priority
      sosmon = i if i.issossmon
      # sosmonarray.push(i) if i.issossmon
      bossmon = i if i.isbossmon
    end
    # sosmonarray.uniq!
    return false if !sosmon
    if sosmon.isFainted?
      pbCommonAnimation("ZPower",bossmon,nil)
      pbAnimation(:HELPINGHAND,bossmon,sosmon)
      sosBattle(bossmon) 
      return true
    end
    bossmon.currentSOS += 1
    pbCommonAnimation("ZPower",bossmon,nil)
    pbAnimation(:HELPINGHAND,bossmon,sosmon)
    pbDisplayPaused(_INTL("{1} revitalized its allies!",bossmon.name))
    if sosData[:moninfos][bossmon.currentSOS]
      pbAnimation(:REFRESH,sosmon,nil)
      sosmon.pbRecoverHP(sosmon.totalhp,true) if sosmon.hp != sosmon.totalhp
      sosmon.status = nil if  sosmon.status != nil 
      sosmon.pokemon = pbLoadSOSMon(sosData[:moninfos][bossmon.currentSOS][:species],sosData[:moninfos][bossmon.currentSOS],sosmon)
      sosmon.species = sosmon.pokemon.species
      sosmon.form = sosmon.pokemon.form
      sosmon.ability = sosmon.pokemon.ability
      sosmon.moves = []
      for move in sosmon.pokemon.moves
        sosmon.moves.push(PokeBattle_Move.pbFromPBMove(@battle,move,sosmon.pokemon)) if move
      end
      sosmon.item = sosmon.pokemon.item
      if $cache.items[sosmon.item] && $cache.items[sosmon.item].checkFlag?(:zcrystal)
        sosmon.pokemon.initZmoves(sosmon.item,false)
        if !sosmon.pokemon.zmoves.nil?
          sosmon.zmoves       = [nil,nil,nil,nil]
          for i in 0...sosmon.pokemon.zmoves.length
            zmove = sosmon.pokemon.zmoves[i]
            sosmon.zmoves[i] = PokeBattle_Move.pbFromPBMove(self,zmove,sosmon.pokemon,sosmon.moves[i]) if !zmove.nil?
          end
        end
      else
        sosmon.pokemon.zmoves= nil
        sosmon.zmoves = nil
      end
      sosmon.pbUpdate(true)
    end
    return true
  end

  def returnStolenPokemon(returnall=false,sosmons=nil,lastattacker=nil)
    sosmonarray = []
    for i in priority
      sosmonarray.push(i) if i.issossmon
      bossmon = i if i.isbossmon
    end
    sosmonarray.uniq!
    return if sosmonarray.empty?
    return if !(bossmon.sosDetails && (bossmon.sosDetails[:playerMons] || bossmon.sosDetails[:playerParty]))
    if returnall==true
      for j in 0..sosmonarray.length
        next if sosmonarray[j].nil?
        if sosmonarray[j].pokemon.ot != "Spacea"
          trainer = @battle.player
          if trainer.tempPartyStorage.length > 0 
            for k in 0..trainer.tempPartyStorage.length
              next if trainer.tempPartyStorage[k].nil?
              if trainer.tempPartyStorage[k] = sosmonarray[j].pokemon
                trainer.tempPartyStorage[k].sosmon = false
                @battle.party1.push(trainer.tempPartyStorage[k])
                @battlers[sosmonarray[j].index].pbReset
                # if lastattacker
                #   @battle.party1[-1].hp = trainer.tempPartyStorage[k].originalhp if lastAttacker != bossmon.index
                # end
              end
            end
          end
        end
      end
      trainer.tempPartyStorage = []
      sosmonarray = []
    else
      if sosmons
        if sosmons.pokemon.ot != "Spacea"
          trainer = @battle.player
          if trainer.tempPartyStorage.length > 0
            for k in 0..trainer.tempPartyStorage.length
              next if trainer.tempPartyStorage[k].nil?
              if trainer.tempPartyStorage[k] = sosmons.pokemon
                trainer.tempPartyStorage[k].sosmon = false
                returningmon = trainer.tempPartyStorage[k].clone
                returningmon.hp = trainer.tempPartyStorage[k].hp.clone
                @battle.party1.push(returningmon)
                if lastattacker
                  @battle.party1[-1].hp = trainer.tempPartyStorage[k].originalhp.clone if lastattacker != bossmon.index
                  @battle.party1[-1].hp = 0 if lastattacker == bossmon.index
                end
                sosmons.hp = 0
                sosmons.pokemon.hp = 0
                trainer.tempPartyStorage.delete_at(k)
                trainer.tempPartyStorage.uniq!
                break
              end
            end
          end
        end
      end
    end
  end

  def pbRemoveFromPartyTemporary(battlerIndex,partyIndex,trainer)
    party=pbParty(battlerIndex)
    side=(pbIsOpposing?(battlerIndex)) ? @opponent : @player
    if !trainer.tempPartyStorage
      trainer.tempPartyStorage = []
    end
    storedmon = party[partyIndex]
    storedmon.hp = party[partyIndex].hp.clone
    storedmon.originalhp = party[partyIndex].originalhp.clone
    trainer.tempPartyStorage.push(storedmon)
    party[partyIndex]=nil
    @party1.compact!
  end

  def pbResetBattlers(settonormal=false)
    return if !(@sosbattle>2)
    for i in 0...@battlers.length
      battler = @battlers[i] if @battlers[i].isbossmon
    end
    return if !battler
    sosData = battler.sosDetails
    for i in 0...@battlers.length
      next if @battlers[i].isFainted?
      next if @battlers[i].nil?
      if @battlers[i].issossmon
        next if @scene.sprites["battlebox#{i}"].nil?
        pbAnimation(:SPACIALREND,@battlers[i],nil)
        @scene.pbFainted(@battlers[i])
        8.times do
          @scene.sprites["battlebox#{i}"].opacity-=32
          @scene.pbGraphicsUpdate
          Input.update
        end
        @scene.sprites["battlebox#{i}"].visible=false
        @scene.sprites["shadow#{i}"].visible=false
        @scene.sprites["pokemon#{i}"].visible=false
        @scene.pbGraphicsUpdate
      end   
    end
    if sosData[:playerMons] ||sosData[:playerParty]
      returnStolenPokemon(true,nil)
    else
      for i in 0...@battlers.length
        next if @battlers[i].isFainted?
        next if @battlers[i].nil?
        if !(i == 0 || i == 1)
          @battlers[i].pbReset
        end
      end
    end
    for i in 0..@party2.length
      next if @party2[i].nil?
      @party2.delete_at(i) if !@party2[i].isbossmon
    end
    if !(doublebattle == false && @sosbattle ==2)
      if settonormal
         @doublebattle = false
         @sosbattle = 2
      end
      for i in 0...@battlers.length
        next if @battlers[i].isFainted?
        next if @battlers[i].nil?
          @scene.sprites["battlebox#{i}"].visible=false
          @scene.sprites["battlebox#{i}"].dispose if !@battlers[i].pokemon.nil?
          @scene.pbChangePokemon(@battlers[i],@battlers[i].pokemon)
          @scene.sprites["battlebox#{i}"] = @scene.createPokemonDataBox(@battlers[i], @doublebattle, @scene.viewport,self)
          @scene.sprites["battlebox#{i}"].appear
          loop do
            @scene.sprites["battlebox#{i}"].update
            @scene.pbGraphicsUpdate
            Input.update
            break if !@scene.sprites["battlebox#{i}"].appearing
          end
        # end
        @battlers[i].vanished=false
      end
    end
    @scene.sprites["fightwindow"].battler = @battlers[0]
  end

  # def sosBattleSpecial(battler)
  # end

  def sosBattleSpecial(battler)
    sosData = battler.sosDetails
    playerMon = battler.pbOppositeOpposing 
    return if !playerMon
    return if !battler.pbPartner.isFainted?
    trainer = pbPartyGetOwner(playerMon.index,playerMon.pokemonIndex)
    if sosData
      battler.currentSOS += 1
      if sosData[:playerMons]
        sosmon = $Trainer.party[playerMon.pokemonIndex].clone if !playerMon.isFainted?
        return false if battler.isFainted?
        return false if !sosmon
        # if !sosmon
        sosmon.originalhp = sosmon.hp.clone
        sosmon.hp = sosmon.hp.clone
        sosmon.sosmon = true
        @party2.push(sosmon)
        @doublebattle=true
        if @opponent
          sosIndex = battler.pbPartner.index
        else
          sosIndex = 3
        end
        @sosbattle = $PokemonGlobal.partner ? 4 : 3
        pbAnimation(:SPACIALREND,playerMon,nil)
        @scene.pbFainted(playerMon)
        pbRemoveFromPartyTemporary(playerMon.index,playerMon.pokemonIndex,trainer)
        playerMon.pbReset
        playerMon.participants=[]
        @battlers[sosIndex].pbInitialize(@party2[-1],(@party2.length-1),false) 
        @scene.pbIntroBoss(self,sosIndex)
        @ai.aimondata[sosIndex] = AI_MonData.new(nil,sosIndex,@battle) if @ai.aimondata[sosIndex] == nil
        @ai.aimondata[sosIndex].skill = 100
        @state.effects[:sosBuffer]=6
        for data in @ai.aimondata
          next if data.nil?
          @ai.mondata = data
          @ai.mondata.partyroles = (@ai.mondata.skill >= PokeBattle_AI::HIGHSKILL) ? @ai.pbGetMonRoles : Array.new(@ai.mondata.party.length) {Array.new()}
        end
        pbDisplayPaused(_INTL("SPACEA: What's yours is mine! I'll take good care of it! ",
          battler.name,@party2[-1].name))
        pbOnActiveOne(@battlers[sosIndex])
        @battlers[sosIndex].pbAbilitiesOnSwitchIn(true)
        pbJudge()
        if @decision > 0
          return
        end
        spaceaManip
        for i in priority
          i.pbCancelMoves
          pbClearChoices(i.index)
        end
        for i in priority
          i.pbEndTurn(@choices[battler.index])
        end
      end
      if sosData[:playerParty]
        if (battler.currentSOS == 1)
          sosmon1 = $Trainer.party[playerMon.pokemonIndex] if !battler.pbOppositeOpposing.isFainted?
          sosmon1.sosmon = true
          @party2.push(sosmon1)
          if @opponent
            sosIndex1 = battler.pbPartner.index
          else
            sosIndex1 = 3
          end
          @sosbattle = 5
          pbAnimation(:SPACIALREND,playerMon,nil)
          @scene.pbFainted(playerMon)
          pbRemoveFromPartyTemporary(playerMon.index,playerMon.pokemonIndex,trainer)
          playerMon.pbReset
          playerMon.participants=[]
          @doublebattle=true
          @scene.pbDisposeSprite(@scene.sprites,["battlebox0"])
          @scene.sprites["battlebox0"]=PokemonDataBox.new(@battlers[0],@doublebattle,@scene.viewport,self)    
          @scene.sprites["battlebox0"].visible=false
          @battlers[sosIndex1].pbInitialize(@party2[-1],(@party2.length-1),false) 
          @scene.pbIntroBoss(self,sosIndex1)
          pbOnActiveOne(@battlers[sosIndex1])
          @battlers[sosIndex1].pbAbilitiesOnSwitchIn(true)
          @ai.aimondata[sosIndex1] = AI_MonData.new(nil,sosIndex1,@battle) if @ai.aimondata[sosIndex1] == nil
          @ai.aimondata[sosIndex1].skill = 100
          for data in @ai.aimondata
            next if data.nil?
            @ai.mondata = data
            @ai.mondata.partyroles = (@ai.mondata.skill >= PokeBattle_AI::HIGHSKILL) ? @ai.pbGetMonRoles : Array.new(@ai.mondata.party.length) {Array.new()}
          end
        else
          if @battlers[3].isFainted?
            for i in 0...$Trainer.party.length
              next if $Trainer.party[i].nil?
              next if $Trainer.party[i].hp <= 0
              next if i == newpoke
              sosmon1 = $Trainer.party[i] 
              sosmon1index = i
              break if sosmon1
            end
            sosmon1.sosmon = true
            sosIndex = 3
            @party2.push(sosmon1)
            pbRemoveFromPartyTemporary(sosIndex,sosmon1index,trainer)
            @battlers[sosIndex].pbReset
            @battlers[sosIndex].participants=[]
            @battlers[sosIndex].pbInitialize(@party2[-1],(@party2.length-1),false) 
            @scene.pbIntroBoss(self,sosIndex)
            pbDisplayPaused(_INTL("SPACEA: What's yours is mine! I'll take good care of it!",
              battler.name,@party2[-1].name))
            pbOnActiveOne(@battlers[sosIndex])
            @battlers[sosIndex].pbAbilitiesOnSwitchIn(true)
            @ai.aimondata[sosIndex] = AI_MonData.new(nil,sosIndex,@battle) if @ai.aimondata[sosIndex] == nil
            @ai.aimondata[sosIndex].skill = 100
            for data in @ai.aimondata
              next if data.nil?
              @ai.mondata = data
              @ai.mondata.partyroles = (@ai.mondata.skill >= PokeBattle_AI::HIGHSKILL) ? @ai.pbGetMonRoles : Array.new(@ai.mondata.party.length) {Array.new()}
            end
          end
        end
        if @battlers[2].isFainted?
          for i in 0...$Trainer.party.length
            next if $Trainer.party[i].nil?
            next if $Trainer.party[i].hp <= 0
            sosmon2 = $Trainer.party[i] 
            sosmon2index = i
            break if sosmon2
          end
          sosmon2.sosmon = true
          sosIndex2 = 2
          @party2.push(sosmon2)
          pbRemoveFromPartyTemporary(sosIndex2,sosmon2index,trainer)
          @battlers[sosIndex2].pbReset
          @battlers[sosIndex2].participants=[]
          @battlers[sosIndex2].pbInitialize(@party2[-1],(@party2.length-1),false) 
          # @scene.pbSendOut(2,sosmon2)
          @scene.pbIntroBoss(self,sosIndex2)
          pbDisplayPaused(_INTL("SPACEA: What's yours is mine! I'll take good care of it!",
            battler.name,@party2[-1].name))
          pbOnActiveOne(@battlers[sosIndex2])
          @battlers[sosIndex2].pbAbilitiesOnSwitchIn(true)
          @ai.aimondata[sosIndex2] = AI_MonData.new(nil,sosIndex2,@battle) if @ai.aimondata[sosIndex2] == nil
          @ai.aimondata[sosIndex2].skill = 100
          for data in @ai.aimondata
            next if data.nil?
            @ai.mondata = data
            @ai.mondata.partyroles = (@ai.mondata.skill >= PokeBattle_AI::HIGHSKILL) ? @ai.pbGetMonRoles : Array.new(@ai.mondata.party.length) {Array.new()}
          end
        end
        pbJudge()
        if @decision > 0
          return
        end
        newpoke=pbSwitchInBetween(0,true,false)
        pbMessagesOnReplace(0,newpoke)
        pbReplace(0,newpoke,true)
        spaceaManip
        if sosData[:playerParty]
          for i in priority
            i.pbCancelMoves
            pbClearChoices(i.index)
          end
          for i in priority
            i.pbEndTurn(@choices[battler.index])
          end
        end
      end
    end
  end

  def sosBattle(battler)
    sosData = battler.sosDetails
    return sosBattleSpecial(battler) if (sosData[:playerMons] || sosData[:playerParty])
    playerMon = battler.pbOppositeOpposing 
    if sosData
        battler.currentSOS += 1
        if !@snapshot.nil?
          if @snapshot[1][5]==0 
            return false
          else
            if sosData[:moninfos][battler.currentSOS]
              sosmon=sosData[:moninfos][battler.currentSOS]
            else
              items = sosData[:moninfos].values
              sosmon=items[rand(items.length)]
            end
          end
        else
          if sosData[:moninfos][battler.currentSOS]
            sosmon=sosData[:moninfos][battler.currentSOS]
          else
            items = sosData[:moninfos].values
            sosmon=items[rand(items.length)]
          end
        end
        genwildpoke = pbLoadSOSMon(sosmon[:species],sosmon,battler)
        @party2.push(genwildpoke)
        @doublebattle=true
        if @opponent
          sosIndex = battler.pbPartner.index
        else
          sosIndex = 3
        end
        @sosbattle = $PokemonGlobal.partner ? 4 : 3
        @battlers[sosIndex].pbInitialize(@party2[-1],(@party2.length-1),false) 
        @scene.pbIntroBoss(self,sosIndex)
        pbOnActiveOne(@battlers[sosIndex])
        @battlers[sosIndex].pbAbilitiesOnSwitchIn(true)
        @ai.aimondata[sosIndex] = AI_MonData.new(nil,sosIndex,@battle) if @ai.aimondata[sosIndex] == nil
        @ai.aimondata[sosIndex].skill = 100
        for data in @ai.aimondata
          next if data.nil?
          @ai.mondata = data
          @ai.mondata.partyroles = (@ai.mondata.skill >= PokeBattle_AI::HIGHSKILL) ? @ai.pbGetMonRoles : Array.new(@ai.mondata.party.length) {Array.new()}
        end
        if sosData[:entryMessage]
          if sosData[:entryMessage].is_a?(Array)
            if sosData[:entryMessage][battler.currentSOS-1].start_with?("{1}") 
              pbDisplay(_INTL(sosData[:entryMessage][battler.currentSOS-1],battler.pbThis)) if sosData[:entryMessage] != ""
            else
              pbDisplay(_INTL(sosData[:entryMessage][battler.currentSOS-1])) if sosData[:entryMessage] != ""
            end
          else
            if sosData[:entryMessage].start_with?("{1}") 
              pbDisplay(_INTL(sosData[:entryMessage],battler.pbThis)) if sosData[:entryMessage] != ""
            else
              pbDisplay(_INTL(sosData[:entryMessage])) if sosData[:entryMessage] != ""
            end
          end
        else
          pbDisplayPaused(_INTL("{1} called for help and\r\n{2} appeared!",
            battler.name,@party2[-1].name))
        end
      end
    end
  end

class PokeBattle_Battler
  attr_accessor :bossdelayedeffect
  attr_accessor :bossdelaycounter
  def bossMoveCheck(basemove,user,target)
    immunitylist = target.immunities[:moves]
    if immunitylist.include?(basemove.move)
      @battle.pbDisplay(_INTL("{1} resisted the attack!",target.pbThis))
      return 0
    end
    return 1
  end

  def pbReduceHP(amt,anim=false,emercheck=true)
    if amt>=self.hp
      amt=self.hp
    elsif amt<=0 && !self.isFainted?
      amt=1
    end
    shielddam = false
    admindam = false
    priority=@battle.pbPriority
    if self.isbossmon 
      if self.shieldCount>0
        onBreakdata = self.onBreakEffects[self.shieldCount]
        if !@battle.snapshot.nil?
          if @battle.snapshot[1]
            if @battle.snapshot[1][5]==0
              onBreakdata = self.onBreakEffects[self.shieldCount*(-1)]
            end
          end
        end
        hpthreshold = (onBreakdata && onBreakdata[:threshold]) ? onBreakdata[:threshold] : 0
        if hpthreshold == 0.1
          if amt>=self.hp
            amt=amt-1 
            admindam = true
          end
        else
          if (self.hp - amt) <= (self.totalhp*hpthreshold).round
            amt = (self.hp - (self.totalhp*hpthreshold).round)
            shielddam = true
          end
        end
      end
    end
    oldhp=self.hp
    self.hp-=amt
    raise _INTL("HP less than 0") if self.hp<0
    raise _INTL("HP greater than total HP") if self.hp>@totalhp
    
    @battle.scene.pbHPChanged([[self, oldhp]], anim) if amt > 0
    if self.issossmon
      if (self.hp - amt) == 0
        for i in priority
          bossmon = i if i.isbossmon
        end
        if bossmon
          self.lastAttacker = bossmon.index
        end
      end
    end
    if admindam == true
      self.pbRecoverHP(self.totalhp,true)
      if onBreakdata
        if onBreakdata[:thresholdmessage] && onBreakdata[:thresholdmessage] != ""
          if onBreakdata[:thresholdmessage].start_with?("{1}") 
            @battle.pbDisplay(_INTL(onBreakdata[:thresholdmessage],self.pbThis))
          else
            @battle.pbDisplay(_INTL(onBreakdata[:thresholdmessage],self.pbThis(true)))
          end
        end
      end
      @battle.pbShieldEffects(self,onBreakdata,false,false,true) if onBreakdata 
      self.reconstructcounter += 1
      if self.reconstructcounter >=100
        if $game_variables[731] < 122 && $game_variables[756] < 85
          @battle.pbDisplayBrief(_INTL("???: You are wasting your time, Interceptor.",self.pbThis))
        else
          @battle.pbDisplayBrief(_INTL("A lost voice echoed in your head...",self.pbThis))
          @battle.pbDisplayBrief(_INTL("???: You are wasting your time, Interceptor.",self.pbThis))
        end
        @battle.pbAnimation(:ROAROFTIME,self,nil)
        @battle.decision = 2
        @battle.pbJudge()
        # if @battle.decision > 0
        #   return
        # end
      elsif self.reconstructcounter >=3
        @battle.pbDisplayBrief(_INTL("{1} seems indestructible...",self.pbThis))
      end
    end
    if shielddam == true
      self.pbRecoverHP(self.totalhp,true) if self.hp==0
      @battle.pbShieldEffects(self,onBreakdata) if onBreakdata
      self.shieldCount-=1 if self.shieldCount>0
      @battle.scene.pbUpdateShield(self.shieldCount,self.index)
      battlerIndex = self.index
      if self.sosDetails
        @battle.pbBossSOS(@battle.battlers,shieldbreak=true)
      end
    end
    pbEmergencyExitCheck(oldhp) if emercheck
    return amt
  end
end

def pbLoadWildBoss(poke,bossdata)
  boss = bossdata[poke]
  bossid = poke
  poke = boss.moninfo
  species = poke[:species]
  level = poke[:level]
  if $game_switches[:Offset_Trainer_Levels]
    if $game_variables[:Level_Offset_Value] < 0 
      level = [(level+$game_variables[:Level_Offset_Value]),1].max
    else
      level = (level+$game_variables[:Level_Offset_Value])
    end
  end
  if $game_switches[:Percent_Trainer_Level]
    if $game_variables[:Level_Offset_Percent] < 100 
      level = [(level*($game_variables[:Level_Offset_Percent]*0.01)).round,1].max
    else
      level = (level($game_variables[:Level_Offset_Percent]*0.01))
    end
  end
  form = poke[:form]? poke[:form]:0
  pokemon = PokeBattle_Pokemon.new(species,level,$Trainer,false,form) 
  bossFunction(boss,bossid,pokemon)
  pokemon.setItem(poke[:item])
  if poke[:moves]
    k=0
    for move in poke[:moves]
      next if move.nil?
      pokemon.moves[k]=PBMove.new(move)
      if level >=100
        pokemon.moves[k].ppup=3
        pokemon.moves[k].pp=pokemon.moves[k].totalpp
      end
      k+=1
    end
  else
    pokemon.resetMoves
  end
  pokemon.initZmoves(pokemon.item,false) if $cache.items[pokemon.item] && $cache.items[pokemon.item].checkFlag?(:zcrystal)
  pokemon.setAbility(poke.fetch(:ability,pokemon.getAbilityList[0]))
  case poke[:gender]
    when "M" then pokemon.setGender(0)
    when "F" then pokemon.setGender(1)
    when "N" then pokemon.setGender(2)
    else
      pokemon.setGender(rand(2))
  end
  if !(boss.capturable)
    pokemon.shinyflag = poke[:shiny] || false
  end
  pokemon.setNature(poke.fetch(:nature,:HARDY))
  iv=poke.fetch(:iv,10)
  if iv==32 # Trick room IVS
    pokemon.iv=Array.new(6,31)
    pokemon.iv[5]=0
  else
    iv = 31 if ($game_switches[:Only_Pulse_2] && !(poke[:shadow])) || (poke[:shadow] && ($game_switches[:Full_IVs] || $game_switches[:Standard_S]))  # pulse 2 mode
    iv = 31 if $game_switches[:Only_Pulse_2] # pulse 2 mode
    iv = 0 if $game_switches[:Empty_IVs_And_EVs_Password]
    pokemon.iv=Array.new(6,iv)
  end
  evs = poke[:ev]
  evs = Array.new(6,[85,level*3/2].min) if !evs
  evs = Array.new(6,252) if $game_switches[:Only_Pulse_2] && !(poke[:shadow])# pulse 2 mode
  evs = Array.new(6,85) if $game_switches[:Flat_EV_Password]
  evs = Array.new(6,0) if $game_switches[:Empty_IVs_And_EVs_Password]
  pokemon.ev = evs.clone
  pokemon.ev[PBStats::SPEED] = 0 if iv==32 #TR team, just to make sure!
  puts evs.object_id
  puts pokemon.ev.object_id
  pokemon.happiness=poke.fetch(:happiness,70)
  pokemon.name=poke[:name] if poke[:name]
  if poke[:shadow]   # if this is a Shadow Pokémon
    pokemon.makeShadow rescue nil
    pokemon.pbUpdateShadowMoves(true) rescue nil
    pokemon.makeNotShiny
  end
  pokemon.ballused=poke.fetch(:ball,:POKEBALL)
  pokemon.calcStats
  return pokemon
end

def pbLoadSOSMon(poke,sosdata,boss)
  poke = sosdata
  species = poke[:species]
  level = poke[:level]
  form = poke[:form]? poke[:form]:0
  pokemon = PokeBattle_Pokemon.new(species,level,$Trainer,false,form) 
  pokemon.setItem(poke[:item])
  if poke[:moves]
    k=0
    for move in poke[:moves]
      next if move.nil?
      pokemon.moves[k]=PBMove.new(move)
      if level >=100
        pokemon.moves[k].ppup=3
        pokemon.moves[k].pp=pokemon.moves[k].totalpp
      end
      k+=1
    end
  else
    pokemon.resetMoves
  end
  pokemon.initZmoves(pokemon.item,false) if $cache.items[pokemon.item] && $cache.items[pokemon.item].checkFlag?(:zcrystal)
  pokemon.setAbility(poke.fetch(:ability,pokemon.getAbilityList[0]))
  case poke[:gender]
    when "M" then pokemon.setGender(0)
    when "F" then pokemon.setGender(1)
    when "N" then pokemon.setGender(2)
    else
      pokemon.setGender(rand(2))
  end
  pokemon.shinyflag = poke[:shiny] || false
  pokemon.setNature(poke.fetch(:nature,:HARDY))
  iv=poke.fetch(:iv,10)
  if iv==32 # Trick room IVS
    pokemon.iv=Array.new(6,31)
    pokemon.iv[5]=0
  else
    iv = 31 if ($game_switches[:Only_Pulse_2] && !(poke[:shadow])) || (poke[:shadow] && ($game_switches[:Full_IVs] || $game_switches[:Standard_S]))  # pulse 2 mode
    iv = 0 if $game_switches[:Empty_IVs_And_EVs_Password]
    pokemon.iv=Array.new(6,iv)
  end
  evs = poke[:ev]
  evs = Array.new(6,[85,level*3/2].min) if !evs
  evs = Array.new(6,252) if $game_switches[:Only_Pulse_2] # pulse 2 mode
  evs = Array.new(6,85) if $game_switches[:Flat_EV_Password]
  evs = Array.new(6,0) if $game_switches[:Empty_IVs_And_EVs_Password]
  pokemon.ev = evs.clone
  pokemon.ev[PBStats::SPEED] = 0 if iv==32 #TR team, just to make sure!
  pokemon.happiness=poke.fetch(:happiness,70)
  pokemon.name=poke[:name] if poke[:name]
  if poke[:shadow]   # if this is a Shadow Pokémon
    pokemon.makeShadow rescue nil
    pokemon.pbUpdateShadowMoves(true) rescue nil
    pokemon.makeNotShiny
  end
  pokemon.ot = boss.name
  pokemon.ballused=poke.fetch(:ball,:POKEBALL)
  pokemon.calcStats
  pokemon.sosmon = true
  return pokemon
end

class BossPokemonDataBox < SpriteWrapper
  HP_GAUGE_SIZE = 240
  HP_COLOR_WHITE = Color.new(255, 255, 255)
  HP_COLOR_RED = Color.new(248,88,40)
  HPGAUGE_Y = 44
  TEXT_COLOR_GRAY = Color.new(225,225,225)
  
  attr_reader :battler
  attr_accessor :selected
  attr_reader :animatingHP
  attr_reader :animatingEXP
  attr_reader :appearing
  attr_accessor :shieldCount
  attr_reader :shieldX
  attr_reader :shieldY
  attr_reader :shieldGaugeX
  attr_reader :shieldGaugeY
  attr_accessor   :doublebattle

  def initialize(battler, doublebattle, viewport=nil,battlerindex,battle)
    super(viewport)
    @battler = battler
    @battlerindex=battlerindex
    @battle = battle
    @frame = 0
    @showhp = true
    @animatingHP = false
    @starthp = 0
    @currenthp = 0
    @endhp = 0
    @appearing = false
    @appeared = true
    @doublebattle = doublebattle
    @shieldCount = battler.shieldCount
    @statuses = AnimatedBitmap.new("Graphics/Pictures/Battle/battleStatuses")
    @hpbox = Bitmap.new("Graphics/Pictures/Battle/boss_bar")
    if battler.barGraphic && battler.barGraphic != ""
      @hpbox = Bitmap.new("Graphics/Pictures/Battle/%s",battler.barGraphic)
    end
    if battlerindex==1
      @hpboxX = 0
      @hpboxY = 10
      @hpGaugeY = 50
      @shieldX = 90
      @shieldY = 31
      @shieldGaugeX = 210
      @shieldGaugeY = 28
    else
      @hpboxX = 0
      @hpboxY = 62
      @hpGaugeY = 102
      @shieldX = 90
      @shieldY = 71
      @shieldGaugeX = 210
      @shieldGaugeY = 80
    end
    self.bitmap = BitmapWrapper.new(@hpbox.width + 100, @hpbox.height + 100)
    self.visible = false
    self.x = ((Graphics.width - @hpbox.width) / 6)-27
    if @doublebattle
        self.y = battlerindex==1 ? -12 : 2
    else
      self.y = 2
    end
    self.z = 50
    pbSetSmallFont(self.bitmap)
    
    
    refresh
  end

  def dispose
    @statuses.dispose
    @hpbox.dispose
    @shields.dispose
    super
  end

  def exp
    return 0
  end

  def hp
    return @animatingHP ? @currenthp : @battler.hp
  end

  def animateHP(oldhp,newhp)
    @starthp=oldhp
    @currenthp=oldhp
    @endhp=newhp
    @animatingHP=true
  end

  def animateEXP(oldexp,newexp)
  end

  def appear
    refresh
    self.visible = true
    self.opacity = 255
    self.x=@hpboxX-314
    @appearing = true
    @appeared = false
    @framesToAppear = 39
  end

  def battlerType(battler)
    typearray = [battler.type1.to_s.upcase]
    typearray.push(battler.type2.to_s.upcase) if battler.type2 && (battler.type2 != battler.type1)
    return typearray
  end

  def battlerStatus(battler)
    case battler.status 
      when :SLEEP  
        return "Sleep"  
      when :FROZEN 
        return "Freeze"  
      when :BURN 
        return "Burn"  
      when :POISON 
        return "Poison"  
      when :PARALYSIS  
        return "Paralysis"
      when :PETRIFIED
        return "Petrified"  
    end 
    return "" 
  end 



  def refresh
    self.bitmap.clear
    
    return if !@appeared
    if @shieldCount > 0
      @hpbar = AnimatedBitmap.new("Graphics/Pictures/Battle/hpbarbossshields")
    else
      @hpbar = AnimatedBitmap.new("Graphics/Pictures/Battle/hpbarboss")
    end
    hpgauge = @battler.totalhp==0 ? 0 : (self.hp*HP_GAUGE_SIZE/@battler.totalhp)
    hpgauge=2 if hpgauge==0 && self.hp>0
    hpzone=0
    hpzone=1 if self.hp<=(@battler.totalhp/2).floor
    hpzone=2 if self.hp<=(@battler.totalhp/4).floor
    self.bitmap.blt(@hpboxX, @hpboxY, @hpbox, Rect.new(0, 0, @hpbox.width, @hpbox.height))
    self.bitmap.blt(@hpboxX+4,@hpGaugeY-6,@hpbar.bitmap,Rect.new(0,(hpzone)*12,hpgauge,12))
    base = PBScene::BOXBASE
    shadow = PBScene::BOXSHADOW
    hpText = "#{self.hp} / #{@battler.totalhp}"
    battlerText = @battler.name
    pbSetSystemFont(self.bitmap)
    textpos = [
       ["#{@battler.name}", 12,
         @hpboxY+6, false, base, shadow]
    ]
    pbDrawTextPositions(self.bitmap, textpos)
    shieldXPos = @shieldX
    shieldYPos = @shieldY
    shieldX=[214,224,234,244,254,264,274]
    if @battlerindex==1
      shieldY=[32,42,32,42,32,42,32]
    elsif @battlerindex==3
      shieldY=[84,94,84,94,84,94,84]
    end
    @shieldsdisplay = Bitmap.new("Graphics/Pictures/Battle/boss_shieldbar")
    self.bitmap.blt(@shieldGaugeX,@shieldGaugeY,@shieldsdisplay,Rect.new(0,0,@hpbox.width,@hpbox.height))
    @shields = Bitmap.new("Graphics/Pictures/Battle/bossbarshield")
    @shieldsBroken = Bitmap.new("Graphics/Pictures/Battle/bossbarshieldcracked")
    if @shieldCount > 0
        count=0
        loop do
          self.bitmap.blt(shieldX[count],shieldY[count],@shields,Rect.new(0,0,@shields.width,@shields.height))
          count+=1
        break if count==@shieldCount
        end
    end
    battlerTypes = battlerType(battler)
    typepos=[]
    typepos.push([sprintf("Graphics/Icons/bosstype%s",battlerTypes[0]),@shieldGaugeX+24,@shieldGaugeY+24,0,0,64,28])
    if !battler.type2.nil?
      typepos.push([sprintf("Graphics/Icons/bosstype%s",battlerTypes[1]),@shieldGaugeX+44,@shieldGaugeY+24,0,0,64,28])
    end
    pbDrawImagePositions(self.bitmap, typepos)
    if @battler.status != nil
      status=(@battler.hp==0) ? :FAINTED : battlerStatus(battler)
      imagepos=[]
      doubles = @doubleBattle ? "D" : ""
      imagepos.push([sprintf("Graphics/Pictures/Battle/battleStatuses" + doubles + "%s",battlerStatus(battler)),@hpboxX+4, @hpboxY+32,0,0,64,28])
      pbDrawImagePositions(self.bitmap, imagepos)
    end

    
  end

  def update
    super
    @frame += 1
    if @animatingHP
      if @currenthp < @endhp
        @currenthp += [2, (0.5 * @battler.totalhp / HP_GAUGE_SIZE).floor].max
        @currenthp = @endhp if @currenthp > @endhp
      elsif @currenthp > @endhp
        @currenthp -= [2, (0.5 * @battler.totalhp / HP_GAUGE_SIZE).floor].max
        @currenthp = @endhp if @currenthp<@endhp
      end
      @animatingHP = false if @currenthp==@endhp
      refresh
    end
    if @appearing && @framesToAppear
      self.x+=8
      @framesToAppear -= 1 if @framesToAppear > 0
      if @framesToAppear<=0
        @appearing=false 
        @appeared = true
      end
    end
    return
  end
end