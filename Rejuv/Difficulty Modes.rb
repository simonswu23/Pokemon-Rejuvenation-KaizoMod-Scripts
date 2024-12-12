module DifficultModes
  # Variable number that control the difficult.
  # To use a different variable, change this. 0 deactivates this script
  VARIABLE=200 
  
  def self.currentMode
    difficultHash={}
    
    
    easyMode = Difficult.new
    
    # partyid (six parameter) number for trainer than can have other party.
    # Trainers loaded this way ignores the levelProcedure.
    # IN THIS EXAMPLE: If you start a battle versus YOUNGSTER Ben team 1,
    # the game searches for the YOUNGSTER Ben team 101 (100+1),
    # if the game founds it loads instead of the team 1.
    easyMode.idJump = 100
    
    # A formula to change all trainers pokémon level. 
    # This affects money earned in battle.
    # IN THIS EXAMPLE: Every opponent pokémon that aren't found by idJump value
    # have the level*0.8 (round down). A pokémon level 6 will be level 4.
    easyMode.levelProcedure = proc{|level|
      next level*0.9
    }
    
    # A formula to change all trainers pokémon money.
    # This is the last formula to apply.
    # IN THIS EXAMPLE: Multiplier the money given by the opponent by 1.3 (round
    # down), so if the final money earned is 99, the money will be 128.
    easyMode.moneyProcedure = proc{|money|
      next money*1.3
    }
    # You can delete any of these three attributes if you didn't want them.
    
    # The Hash index is the value than when are in the VARIABLE number value,
    # the difficult will be ON.
    # IN THIS EXAMPLE: Only when variable 90 value is 1 than this changes
    # will occurs 
    difficultHash[1] = easyMode
    
    
    hardMode = Difficult.new
    hardMode.idJump = 200
    hardMode.levelProcedure = proc{|level|
      next level
    }
    hardMode.moneyProcedure = proc{|money|
      next money*0.8
    }
    difficultHash[2] = hardMode
    
    return DifficultModes::VARIABLE>0 ? 
      difficultHash[pbGet(DifficultModes::VARIABLE)] : nil
  end 
  
  def self.applyLevelProcedure(level,procedure)
    return procedure ? [[procedure.call(level).floor,MAXIMUMLEVEL].min,1].max : level
  end
  
  def self.applyMoneyProcedure(money)
    difficultSelected = self.currentMode
    return difficultSelected && difficultSelected.moneyProcedure ? [difficultSelected.moneyProcedure.call(money).floor,0].max : money
  end
  
  def self.loadTrainer(trainerid,trainername,partyid=0,noscaling=false)
    trainer = nil
    procedure = nil
    difficultSelected = self.currentMode
    difficultSelected = nil if noscaling
    if difficultSelected
      trainer=pbLoadTrainerDifficult(trainerid,trainername,partyid + difficultSelected.idJump) if difficultSelected.idJump>0
      procedure = difficultSelected.levelProcedure
    end
    return trainer ? trainer : pbLoadTrainerDifficult(trainerid,trainername,partyid,procedure)
  end
    
  private
  class Difficult
    attr_accessor :idJump
    attr_accessor :levelProcedure
    attr_accessor :moneyProcedure
    
    def initialize
      @idJump = 0
      @levelProcedure = nil
      @moneyProcedure = nil
    end  
  end  
end

def pbLoadTrainer(trainerid,trainername,partyid=0,noscaling=false)
  return DifficultModes.loadTrainer(trainerid,trainername,partyid,noscaling)
end

def bossFunction(boss,bossid,pokemon)
  pokemon.enablebossmon 
  pokemon.shieldCount = boss.shieldCount
  pokemon.bossId = bossid
end

def pbLoadTrainerDifficult(type,name,id=0,procedure=nil)
  trainer = findParty(type,name,id)
  puts "Team could not be loaded, please report this: #{type}, #{name}, #{id} \n ty <3" if !trainer
  return nil if !trainer
  items=trainer[2]
  opponent=PokeBattle_Trainer.new(name,type)
  opponent.name = $game_variables[:KieranName].capitalize if type == :UNKNOWN_1 && name == "???" && $game_variables[:KieranName] != 0
  opponent.setForeignID($Trainer,$cache.trainertypes[type].trainerID) if $Trainer
  opponent.aceline = trainer[3]
  opponent.defeatline = trainer[4] ? trainer[4] : ""
  if opponent.defeatline == "" && $game_variables[:DifficultyModes] > 0 && id>=100
    case $game_variables[:DifficultyModes]
    when 1
      id-=100
    when 2
      id-=200
    end
    trainermode = findParty(type,name,id)
    opponent.defeatline = trainermode[4] ? trainermode[4] : ""
  end
  if opponent.aceline == "" && $game_variables[:DifficultyModes] > 0 && id>=100
    case $game_variables[:DifficultyModes]
    when 1
      id-=100
    when 2
      id-=200
    end
    trainermode = findParty(type,name,id)
    opponent.aceline = trainermode[3] ? trainermode[3] : ""
  end
  opponent.trainereffect = trainer[5]
  bossdata = $cache.bosses
  party = []
  for poke in trainer[1]
    boss = poke[:boss] ? bossdata[poke[:boss]] : nil
    bossid = poke[:boss]
    poke = boss.moninfo if boss 
    species = poke[:species]
    level = DifficultModes.applyLevelProcedure(poke[:level],procedure)
    form = poke[:form]? poke[:form]:0
    pokemon = PokeBattle_Pokemon.new(species,level,opponent,false,form) 
    bossFunction(boss,bossid,pokemon) if boss
    pokemon.setItem(poke[:item])
    pokemon.form = pokemon.getForm(pokemon)
    if poke[:moves]
      k=0
      for move in poke[:moves]
        next if move.nil?
        pokemon.moves[k]=PBMove.new(move)
        if level >=100 && opponent.skill>=PokeBattle_AI::BESTSKILL
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
      iv = 31 if ($game_switches[:Only_Pulse_2] && !(poke[:shadow])) || (poke[:shadow] &&  $game_switches[:Full_IVs])  # pulse 2 mode
    end
    iv = 0 if $game_switches[:Empty_IVs_And_EVs_Password]
    pokemon.iv=Array.new(6,iv)
    evs = poke[:ev]
    evs = Array.new(6,[85,level*3/2].min) if !evs
    if $game_switches[:NotPlayerCharacter] == false
      evs = Array.new(6,252) if $game_switches[:Only_Pulse_2] && !(poke[:shadow]) # pulse 2 mode
      evs = Array.new(6,85) if $game_switches[:Flat_EV_Password]
      evs = Array.new(6,0) if $game_switches[:Empty_IVs_And_EVs_Password]
    end
    pokemon.ev = evs.clone
    pokemon.ev[PBStats::SPEED] = 0 if iv==32 #TR team, just to make sure!
    pokemon.happiness=poke.fetch(:happiness,70)
    pokemon.name=poke[:name] if poke[:name]
    if poke[:shadow]   # if this is a Shadow Pokémon
      pokemon.makeShadow rescue nil
      pokemon.pbUpdateShadowMoves(true) rescue nil
      pokemon.makeNotShiny
    end
    pokemon.obtainText = poke[:catchtext] if poke[:catchtext]
    pokemon.obtainMode = poke[:obtaintype] if poke[:obtaintype]
    pokemon.obtainLevel = poke[:catchlevel] if poke[:catchlevel]
    pokemon.obtainMap = poke[:catchmap] if poke[:catchmap]
    timediverge = $Settings.unrealTimeDiverge
    $Settings.unrealTimeDiverge = 0
    timeNow = pbGetTimeNow
    pokemon.timeReceived= Time.unrealTime_oldTimeNew(timeNow.year+poke[:catchtime][0],poke[:catchtime][1],poke[:catchtime][2],timeNow.hour,timeNow.min,timeNow.sec) if poke[:catchtime]
    pokemon.hatchedMap = poke[:hatchmap] if poke[:hatchmap]
    pokemon.timeEggHatched= Time.unrealTime_oldTimeNew(timeNow.year+poke[:hatchtime][0],poke[:hatchtime][1],poke[:hatchtime][2],timeNow.hour,timeNow.min,timeNow.sec) if poke[:hatchtime]
    $Settings.unrealTimeDiverge = timediverge
    pokemon.ot = poke[:originalTrainer] if poke[:originalTrainer]
    pokemon.trainerID = poke[:trainerID] if poke[:trainerID]
    pokemon.personalID = pokemon.personalID.to_s if poke[:hiddenID]
    pokemon.ballused=poke.fetch(:ball,:POKEBALL)
    pokemon.calcStats
    pokemon.hp = pokemon.totalhp
    party.push(pokemon)
  end
  return [opponent,items,party]
end