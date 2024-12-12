module BallHandlers
  IsUnconditional=ItemHandlerHash.new
  ModifyCatchRate=ItemHandlerHash.new
  OnCatch=ItemHandlerHash.new
  OnFailCatch=ItemHandlerHash.new
  if Reborn || Desolation
    BallTypes={
      0=>:POKEBALL,
      1=>:GREATBALL,
      2=>:SAFARIBALL,
      3=>:ULTRABALL,
      4=>:MASTERBALL,
      5=>:NETBALL,
      6=>:DIVEBALL,
      7=>:NESTBALL,
      8=>:REPEATBALL,
      9=>:TIMERBALL,
      10=>:LUXURYBALL,
      11=>:PREMIERBALL,
      12=>:DUSKBALL,
      13=>:HEALBALL,
      14=>:QUICKBALL,
      15=>:CHERISHBALL,
      16=>:FASTBALL,
      17=>:LEVELBALL,
      18=>:LUREBALL,
      19=>:HEAVYBALL,
      20=>:LOVEBALL,
      21=>:FRIENDBALL,
      22=>:MOONBALL,
      23=>:SPORTBALL,
      24=>:BEASTBALL,
      25=>:GLITTERBALL, 
      26=>:DREAMBALL
    }
  else
    BallTypes={
      0=>:POKEBALL,
      1=>:GREATBALL,
      2=>:SAFARIBALL,
      3=>:ULTRABALL,
      4=>:MASTERBALL,
      5=>:NETBALL,
      6=>:DIVEBALL,
      7=>:NESTBALL,
      8=>:REPEATBALL,
      9=>:TIMERBALL,
      10=>:LUXURYBALL,
      11=>:PREMIERBALL,
      12=>:DUSKBALL,
      13=>:HEALBALL,
      14=>:QUICKBALL,
      15=>:CHERISHBALL,
      16=>:FASTBALL,
      17=>:LEVELBALL,
      18=>:LUREBALL,
      19=>:HEAVYBALL,
      20=>:LOVEBALL,
      21=>:FRIENDBALL,
      22=>:MOONBALL,
      23=>:SPORTBALL,
      24=>:STEAMBALL,
      25=>:MINERALBALL,
      26=>:BEASTBALL,
      27=>:DREAMBALL
    }
  end

  def self.isUnconditional?(ball,battle,battler)
    if !IsUnconditional[ball]
      return false
    end
    return IsUnconditional.trigger(ball,battle,battler)
  end

  def self.modifyCatchRate(ball,catchRate,battle,battler)
    if !ModifyCatchRate[ball]
      return catchRate
    end
    return ModifyCatchRate.trigger(ball,catchRate,battle,battler)
  end

  def self.onCatch(ball,battle,pokemon)
    if OnCatch[ball]
      OnCatch.trigger(ball,battle,pokemon)
    end
  end

  def self.onFailCatch(ball,battle,pokemon)
    if OnFailCatch[ball]
      OnFailCatch.trigger(ball,battle,pokemon)
    end
  end
end

def pbBallTypeToBall(balltype)
  return BallHandlers::BallTypes[balltype] if BallHandlers::BallTypes[balltype]
  return :POKEBALL
end

def pbGetBallType(ball)
  for key in BallHandlers::BallTypes.keys
    return key if BallHandlers::BallTypes[key] == ball
  end
  return 0
end

def pbIsUltraBeast?(battler)
  return PBStuff::ULTRABEASTS.include?(battler.species)
end

################################

BallHandlers::ModifyCatchRate.add(:POKEBALL,proc{|ball,catchRate,battle,battler|
  catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
  next catchRate
})

BallHandlers::ModifyCatchRate.add(:LUXURYBALL,proc{|ball,catchRate,battle,battler|
  catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
  next catchRate
})

BallHandlers::ModifyCatchRate.add(:PREMIERBALL,proc{|ball,catchRate,battle,battler|
  catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
  next catchRate
})

BallHandlers::ModifyCatchRate.add(:HEALBALL,proc{|ball,catchRate,battle,battler|
  catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
  next catchRate
})

BallHandlers::ModifyCatchRate.add(:CHERISHBALL,proc{|ball,catchRate,battle,battler|
  catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
  next catchRate
})

BallHandlers::ModifyCatchRate.add(:FRIENDBALL,proc{|ball,catchRate,battle,battler|
  catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
  next catchRate
})

BallHandlers::ModifyCatchRate.add(:GREATBALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   next (catchRate*1.5).floor
})

BallHandlers::ModifyCatchRate.add(:SAFARIBALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   next (catchRate*1.5).floor
})

BallHandlers::ModifyCatchRate.add(:ULTRABALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   next (catchRate*2).floor
})

BallHandlers::IsUnconditional.add(:MASTERBALL,proc{|ball,battle,battler|
   next true
})

BallHandlers::ModifyCatchRate.add(:NETBALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   catchRate*=3.5 if battler.hasType?(:BUG) || battler.hasType?(:WATER)
   next catchRate
})

BallHandlers::ModifyCatchRate.add(:DIVEBALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   catchRate=(catchRate*3.5).floor if battle.environment==:Underwater || battle.FE == :WATERSURFACE || battle.FE == :UNDERWATER
   next catchRate
})

BallHandlers::ModifyCatchRate.add(:NESTBALL,proc{|ball,catchRate,battle,battler|
 #  if battler.level<=40
 #    catchRate*=(41-battler.level)/10
 #  end
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   modifier = [8-0.2*(battler.level - 1),1].max
   catchRate*=modifier
   next catchRate
})

BallHandlers::ModifyCatchRate.add(:REPEATBALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   catchRate*=3.5 if battle.pbPlayer.pokedex.dexList[battler.species][:owned?]
   next catchRate
})

BallHandlers::ModifyCatchRate.add(:TIMERBALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   multiplier=[1+(0.3*battle.turncount),4].min
   catchRate*=multiplier
   next catchRate
})

BallHandlers::ModifyCatchRate.add(:DUSKBALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   catchRate*=3.5 if PBDayNight.isNight?(pbGetTimeNow) || battle.FE == :DARKCRYSTALCAVERN || battle.FE == :SHORTCIRCUIT || battle.FE == :UNDERWATER || battle.FE == :CAVE || battle.FE == :CRYSTALCAVERN || battle.FE == :DRAGONSDEN || battle.FE == :STARLIGHT || battle.FE == :NEWWORLD || battle.FE == :INVERSE 
   next catchRate
})

BallHandlers::OnCatch.add(:HEALBALL,proc{|ball,battle,pokemon|
   pokemon.heal
})

BallHandlers::ModifyCatchRate.add(:QUICKBALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   catchRate*=5 if battle.turncount<=1
   next catchRate
})

BallHandlers::ModifyCatchRate.add(:FASTBALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   basestats = $cache.pkmn[battler.species].BaseStats
   basespeed = basestats[-1]
   catchRate*=4 if basespeed>=100
   next catchRate
})

BallHandlers::ModifyCatchRate.add(:LEVELBALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   pbattler=battle.battlers[0].level
   pbattler=battle.battlers[2].level if battle.battlers[2] &&
                                        battle.battlers[2].level>pbattler
   if pbattler>=battler.level*4
     catchRate*=8
   elsif pbattler>=battler.level*2
     catchRate*=4
   elsif pbattler>battler.level
     catchRate*=2
   end
   next catchRate
})

BallHandlers::ModifyCatchRate.add(:LUREBALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   catchRate*=5 if $PokemonTemp.encounterType==EncounterTypes::OldRod ||
                   $PokemonTemp.encounterType==EncounterTypes::GoodRod ||
                   $PokemonTemp.encounterType==EncounterTypes::SuperRod
   next catchRate
})

BallHandlers::ModifyCatchRate.add(:HEAVYBALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   weight=battler.weight
   if weight>4000
     catchRate+=40
   elsif weight>3000
     catchRate+=30
   elsif weight>=2050
     catchRate+=20
   else
     catchRate-=20
   end
   catchRate=[catchRate,1].max
   next catchRate
})

BallHandlers::ModifyCatchRate.add(:LOVEBALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   pbattler=battle.battlers[0]
   pbattler2=battle.battlers[2] if battle.battlers[2]
   catchRate*=8 if (pbattler.species==battler.species && ((battler.gender==0 && pbattler.gender==1) || (battler.gender==1 && pbattler.gender==0))) || (pbattler2 && pbattler2.species==battler.species && ((battler.gender==0 && pbattler2.gender==1) || (battler.gender==1 && pbattler2.gender==0)))
   next catchRate
})

BallHandlers::OnCatch.add(:FRIENDBALL,proc{|ball,battle,pokemon|
   pokemon.happiness=200
})

BallHandlers::ModifyCatchRate.add(:MOONBALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   evos = pbGetEvolvedFormData(battler.pokemon.species,battler.pokemon)
   next catchRate if evos.nil?
   for i in 0..(evos.length)-1
     if evos[i][2] == :MOONSTONE
       catchRate *= 4
       break
     end
   end
   next catchRate
})

BallHandlers::ModifyCatchRate.add(:SPORTBALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   # Commented out because the 1.5 modifier only applies in bug catching contest which we don't use.
   # next (catchRate*3/2).floor
   next catchRate
})

BallHandlers::ModifyCatchRate.add(:BEASTBALL,proc{|ball,catchRate,battle,battler|
   if pbIsUltraBeast?(battler)
     next (catchRate*5).floor
   else
     next (catchRate*1/10).floor
   end   
})

BallHandlers::ModifyCatchRate.add(:DREAMBALL,proc{|ball,catchRate,battle,battler|
   catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
   catchRate = (catchRate*4).floor if battler.status == :SLEEP
   next catchRate
})

BallHandlers::ModifyCatchRate.add(:GLITTERBALL,proc{|ball,catchRate,battle,battler|
  catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
  catchRate = (catchRate*8).floor if battler.pokemon.isShiny?
  next catchRate
})

BallHandlers::OnCatch.add(:GLITTERBALL,proc{|ball,battle,pokemon|
  pokemon.makeShiny
})

BallHandlers::ModifyCatchRate.add(:STEAMBALL,proc{|ball,catchRate,battle,battler|
  catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
  catchRate*=3.5 if battler.hasType?(:FIRE) || battler.hasType?(:WATER)
  next catchRate
})

BallHandlers::ModifyCatchRate.add(:MINERALBALL,proc{|ball,catchRate,battle,battler|
  catchRate = (catchRate*0.1).floor if pbIsUltraBeast?(battler)
  catchRate*=3.5 if battler.hasType?(:ROCK) || battler.hasType?(:GROUND) || battler.hasType?(:STEEL)
  next catchRate
})
