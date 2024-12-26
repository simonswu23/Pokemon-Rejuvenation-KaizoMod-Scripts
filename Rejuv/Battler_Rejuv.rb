class PokeBattle_Battler
    attr_accessor :shieldCount
    attr_accessor :barGraphic
    attr_accessor :entryText
    attr_accessor :sosDetails
    attr_accessor :randomSetChanges
    attr_accessor :shieldsBroken
    attr_accessor :shieldsBrokenThisTurn
    attr_accessor :currentSOS
    attr_accessor :zorotransform
    attr_accessor :reconstructcounter
    def pbInitBoss(pkmn,index)
        bossdata = $cache.bosses
        boss = bossdata[pkmn.bossId]
        if boss.immunities
          @immunities = {
            :moves => [],
            :fieldEffectDamage => [],
          }
          immunitiesarray = []
          if boss.immunities[:moves]
            for i in boss.immunities[:moves]
              immunitiesarray.push(i)
            end
          end
          @immunities[:moves] = immunitiesarray
          immunitiesarray = []
          if boss.immunities[:fieldEffectDamage]
            for i in boss.immunities[:fieldEffectDamage]
              immunitiesarray.push(i)
            end
          end
          @immunities[:fieldEffectDamage] = immunitiesarray
        else
          @immunities = {
            :moves => [],
            :fieldEffectDamage => [],
          }
        end
        @onBreakEffects = boss.onBreakEffects
        @onEntryEffects = boss.onEntryEffects
        @barGraphic    = boss.barGraphic
        @entryText    = boss.entryText ? boss.entryText : nil
        if boss.chargeAttack
          @chargeAttack  = {}
          boss.chargeAttack.each do |key,value|
            @chargeAttack[key] = value
          end
        else
          @chargeAttack = nil
        end
        if boss.sosDetails
          @sosDetails = {}
          boss.sosDetails.each do |key,value|
            @sosDetails[key] = value
          end
        else
          @sosDetails = nil
        end
        if boss.randomSetChanges
          @randomSetChanges = {}
          boss.randomSetChanges.each do |key,value|
            @randomSetChanges[key] = value
          end
        else
          @randomSetChanges = nil
        end
        @name = boss.name unless boss.name == ""
        @shieldCount = pkmn.shieldCount
        @reconstructcounter = 0
        @shieldsBroken = Array.new(pkmn.shieldCount,false)
        @shieldsBrokenThisTurn = [0,0,0,0]
        @currentSOS = 0
        @battle.typesequence = 0
        @capturable = boss.capturable ? boss.capturable : false
        @canrun = boss.canrun ? boss.canrun : false
        @battle.cantescape=true if !@canrun
    end

    def pbInitialize(pkmn,index,batonpass)
        # Gen 9 Mod - Added Ability Shield when Trace
        # Cure status of previous Pokemon with Natural Cure
        if self.ability == :NATURALCURE || ((self.ability == :TRACE && self.item != :ABILITYSHIELD) &&
          self.effects[:TracedAbility]==:NATURALCURE) && @pokemon
          self.status = nil
        end
        if (self.ability == :REGENERATOR || ((self.ability == :TRACE && self.item != :ABILITYSHIELD) &&
          self.effects[:TracedAbility] == :REGENERATOR)) && @pokemon && @hp > 0
            self.pbRecoverHP((totalhp / 3.0).floor)
        end
        # Gen 9 Mod - Zero To Hero - Change base Palafin for someone else
        if self.species == :PALAFIN && self.ability == :ZEROTOHERO && self.form == 0
          self.form = 1
          self.pokemon.justTransformed = 0 if !self.pokemon.justTransformed
          self.pokemon.justTransformed = 1
          pbUpdate(true)
        end
        pbInitPokemon(pkmn,index)
        pbInitEffects(batonpass)
        pbInitBoss(pkmn,index) if self.isbossmon
        @zorotransform = (self.crested == :ZOROARK && self.ability == :STANCECHANGE) ? 0 : nil
    end


    def rejuvAbilities(onactive)
      if self.ability == :PRISMPOWER && onactive
        if self.pokemon.prismPower == false
          @battle.pbDisplay(_INTL("{1}'s {2} activated!", pbThis,getAbilityName(ability)))
          self.pokemon.prismPower = true
          @battle.scene.pbChangePokemon(self,@pokemon)
          for stat in 1..5
            if self.pbCanIncreaseStatStage?(stat,false)
              self.pbIncreaseStat(stat,1,abilitymessage:false)
            end
          end
        end
      end
    end

    def pbBeginTurn(choice)
      # Cancel some lingering effects which only apply until the user next moves
      @effects[:DestinyBond]=false
      @effects[:Grudge]=false
      # Encore's effect ends if the encored move is no longer available
      if @effects[:Encore]>0 &&
         @moves[@effects[:EncoreIndex]].move!=@effects[:EncoreMove]
        PBDebug.log("[Resetting Encore effect]") if $INTERNAL
        @effects[:Encore]=0
        @effects[:EncoreIndex]=0
        @effects[:EncoreMove]=0
      end
      # Wake up in an uproar
      if self.status== :SLEEP && self.ability != :SOUNDPROOF
        for i in 0...4
          if @battle.battlers[i].effects[:Uproar]>0
            pbCureStatus(false)
            @battle.pbDisplay(_INTL("{1} woke up in the uproar!",pbThis))
          end
        end
      end
      if self.isbossmon
        @shieldsBrokenThisTurn = [0,0,0,0]
      end
    end

    def pbZoroCrestForms(basemove = nil)
      if (self.pokemon && self.crested == :ZOROARK) && !self.isFainted?
        transformed=false
        if (self.ability == :STANCECHANGE && !@effects[:Transform])
          if @zorotransform == 0 && !basemove.nil? && basemove.basedamage > 0
            @zorotransform = 1; transformed = true
          elsif @zorotransform == 1 && !basemove.nil? && basemove.move == :KINGSSHIELD
            @zorotransform = 0; transformed = true
          end
          if self.effects[:Illusion] != nil
            self.effects[:Illusion].form = @zorotransform
          end
          if transformed
            if self.effects[:Illusion] != nil
              if self.effects[:Illusion].form == 1
                @battle.pbCommonAnimation("StanceAttack",self,nil)
              else
                if self.index == 0 || self.index == 2
                  @battle.pbCommonAnimation("StanceProtect",self,nil)
                else
                  @battle.pbCommonAnimation("StanceProtectOpp",self,nil)
                end
              end
              pbUpdate(true)
              @battle.scene.pbChangePokemon(self,self.effects[:Illusion])
              @battle.pbDisplay(_INTL("{1} transformed!",pbThis))
            end
            if (self.ability == :STANCECHANGE) && (@battle.FE == :FAIRYTALE || (Rejuv && @battle.FE == :CHESS))
              if (@zorotransform== 0)
                self.pbReduceStat(PBStats::ATTACK,1,abilitymessage:false)
                self.pbIncreaseStat(PBStats::DEFENSE,1,abilitymessage:false)
              else
                self.pbReduceStat(PBStats::DEFENSE,1,abilitymessage:false)
                self.pbIncreaseStat(PBStats::ATTACK,1,abilitymessage:false)
              end
            end
          end
        end
      end # end of update
    end

    def pbUseMoveSimpleBoss(moveid, index = -1, target = -1, danced = false, specialZ = false)
      choice = [:move, index, moveid, self, target]
      @simplemove = danced == false
      if index >= 0
        @battle.choices[@index][1] = index
      end
      @usingsubmove = true
      side = @battle.pbIsOpposing?(self.index) ? 1 : 0
      owner = @battle.pbGetOwnerIndex(self.index)
      if @battle.zMove[side][owner] == self.index && choice[2].basedamage > 0 && !danced
        crystal = pbZCrystalFromType(choice[2].type)
        zmoveID = PBStuff::CRYSTALTOZMOVE[crystal]
        choice[2] = PokeBattle_Move.pbFromPBMove(@battle, PBMove.new(zmoveID), self, choice[2])
      end
      pbUseMove(choice, { specialusage: true, danced: danced, specialZ: specialZ })
      @usingsubmove=false
      @simplemove=false
      return
    end

      def crestStats
        case @crested
        when :SILVALLY
          @ability = PBStuff::SILVALLYCRESTABILITIES.keys.include?(@item) ? PBStuff::SILVALLYCRESTABILITIES[@item] : :SCRAPPY
        when :INFERNAPE
          @attack,@defense = @defense,@attack
          @spatk,@spdef = @spdef,@spatk
        when :MAGCARGO
          @defense,@speed = @speed,@defense
          @spatk *= 1.1
        when :TYPHLOSION
          @attack = @spatk
        when :CLAYDOL
          @spatk = @defense
        when :DEDENNE
          @attack = @speed
        when :RELICANTH
          @attack *=1.2
          @spdef *= 1.3
        when :SKUNTANK
          @attack *=1.2
          @spatk *= 1.2
        when :HYPNO
          @spatk *= 1.5
        when :STANTLER, :WYRDEER
          @attack *= 1.5
        when :ORICORIO
          @spatk *= 1.25
          @speed *= 1.25
        when :SEVIPER
          @speed *=1.5
        when :DUSKNOIR
          @attack *= 1.5
        when :COFAGRIGUS
          @spatk *=1.25
          @spdef *= 1.25
        when :ARIADOS
          @speed *= 1.5
        when :PHIONE
          @defense *= 1.5
          @spdef *= 1.5
        when :DELCATTY
          party = @battle.pbParty(@index)
          boost = false
          for mon in party
            if !mon || mon==self || mon.hp <= 0
              next
            end
            @attack += (0.1 * mon.attack)
            @defense += (0.1 * mon.defense)
            @speed += (0.1 * mon.speed)
            @spatk += (0.1 * mon.spatk)
            @spdef += (0.1 * mon.spdef)
            boost = true
          end
        when :WHISCASH
          @attack *= 1.2
          @spatk *= 1.2
        when :NOCTOWL
          @defense *= 1.2
        when :CRABOMINABLE
          @defense *= 1.2
          @spdef *= 1.2
        when :REUNICLUS
          if @battle.choices[@index][0]==1 && @battle.choices[@index][1]>=0
            @attack, @spatk = @spatk, @attack if self.moves[@battle.choices[@index][1]].pbIsPhysical?
          end
        when :SAWSBUCK
          @type1 = :WATER  if @form == 0
          @type1 = :FIRE   if @form == 1
          @type1 = :GROUND if @form == 2
          @type1 = :ICE    if @form == 3
        when :SIMISAGE
          @attack *= 1.2
          @spatk *= 1.2
        when :SIMISEAR
          @attack *= 1.2
          @spatk *= 1.2
        when :SIMIPOUR
          @attack *= 1.2
          @spatk *= 1.2
        when :CRYOGONAL
          @spdef *= 1.2
          @attack += @spdef * 0.1
          @defense += @spdef * 0.1
          @spatk += @spdef * 0.1
          @speed += @spdef * 0.1
        when :ZOROARK
          blacklist = PBStuff::ABILITYBLACKLIST - [:STANCECHANGE,:TRACE]
          party = @battle.pbPartySingleOwner(@index)
          party=party.find_all {|item| item && !item.egg? && item.hp>0 }
          if party.length > 0
            if party[party.length-1] != self.pokemon
              @ability = party[party.length-1].ability if !blacklist.include?(party[party.length-1].ability)
            end
          end
        end
      end

      def pbFaint(showMessage=true)
        if !self.isFainted?
          PBDebug.log("!!!***Can't faint with HP greater than 0") if $INTERNAL
          return true
        end
        if @fainted
          return true
        end
        if self.isbossmon
          if self.shieldCount > 0 && self.onBreakEffects
            onBreakdata = self.onBreakEffects[self.shieldCount]
            if !@battle.snapshot.nil?
              if @battle.snapshot[1]
                if @battle.snapshot[1][5]==0
                  onBreakdata = self.onBreakEffects[self.shieldCount*(-1)]
                end
              end
            end
            hpthreshold = (onBreakdata && onBreakdata[:threshold]) ? onBreakdata[:threshold] : 0
            #self.pbRecoverHP(self.totalhp,true) if self.hp==0
            case hpthreshold
            when 0
              boss = @battle.battlers[self.index]
              self.pbRecoverHP(self.totalhp,true)
              @battle.pbShieldEffects(self,onBreakdata) if onBreakdata
              self.shieldCount-=1 if self.shieldCount>0
              @battle.scene.pbUpdateShield(boss.shieldCount,self.index)
              if boss.sosDetails
                @battle.pbBossSOS(@battle.battlers,shieldbreak=true)
              end
            when 0.1
              self.pbRecoverHP(self.totalhp,true)
              if onBreakdata
                if onBreakdata[:thresholdmessage] && onBreakdata[:thresholdmessage] != ""
                  if onBreakdata[:thresholdmessage].start_with?("{1}")
                    pbDisplay(_INTL(onBreakdata[:thresholdmessage],self.pbThis))
                  else
                    pbDisplay(_INTL(onBreakdata[:thresholdmessage],self.pbThis(true)))
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
                  pbDisplayBrief(_INTL("{1} seems indestructible...",self.pbThis))
                end
              end
            end
            return false
          end
        end
        @battle.returnStolenPokemon(false,self,self.lastAttacker) if self.issossmon
        if ((@species==:PARAS && @pokemon.form==1 || @species==:PARASECT && @pokemon.form==1) && @ability == :RESUSCITATION)
          @battle.scene.pbFakeOutFainted(self)
          #@effects[PBEffects::Resusitated]=true
          pbUpdate(true)
          self.pbRecoverHP((self.totalhp).floor,true)
          @battle.pbDisplayPaused(_INTL("{1} was resuscitated!",self.pbThis))
          if @battle.FE==:HAUNTED
            for i in [PBStats::ATTACK,PBStats::DEFENSE,PBStats::SPEED,
              PBStats::SPATK,PBStats::SPDEF,PBStats::EVASION,PBStats::ACCURACY]
              @stages[i]=0 if @stages[i]<0
            end
          end
          return false
        else
          @battle.scene.pbFainted(self)
        end
        @battle.neutralizingGasDisable(self.index) if self.ability == :NEUTRALIZINGGAS
        if (pbPartner.ability == :POWEROFALCHEMY || pbPartner.ability == :RECEIVER) && self.item != :ABILITYSHIELD && pbPartner.hp > 0
          if PBStuff::ABILITYBLACKLIST.none? {|forbidden_ability| forbidden_ability==@ability}
            oldability = pbPartner.ability
            partnerability=@ability
            pbPartner.ability=partnerability
            abilityname=getAbilityName(partnerability)
            if oldability == :POWEROFALCHEMY
              @battle.pbDisplay(_INTL("{1} took on {2}'s {3}!",pbPartner.pbThis,pbThis,abilityname))
            else
              @battle.pbDisplay(_INTL("{1} received {2}'s {3}!",pbPartner.pbThis,pbThis,abilityname))
            end
            if pbPartner.ability == :INTIMIDATE
              for i in @battle.battlers
                next if i.isFainted? || !pbIsOpposing?(i.index)
                i.pbReduceAttackStatStageIntimidate(pbPartner)
              end
            end
            # Gen 9 Mod - Supersweet Syrup implementation
            if pbPartner.ability == :SUPERSWEETSYRUP
              for i in @battle.battlers
                next if i.isFainted? || !pbIsOpposing?(i.index)
                i.pbReduceEvasionStatStageSyrup(pbPartner)
              end
            end
          end
        end
        for i in @battle.battlers
          next if i.isFainted?
          if i.ability == :SOULHEART && !i.pbTooHigh?(PBStats::SPATK)
            @battle.pbDisplay(_INTL("{1}'s Soul-heart activated!",i.pbThis))
            i.pbIncreaseStat(PBStats::SPATK,1)
            if (@battle.FE==:MISTY || @battle.FE==:RAINBOW || @battle.FE==:FAIRYTALE) && !i.pbTooHigh?(PBStats::SPDEF)
              i.pbIncreaseStat(PBStats::SPDEF,1)
            end
          end
        end
        droprelease = self.effects[:SkyDroppee]
        #if locked in sky drop while fainting
        if self.effects[:SkyDrop]
          for i in @battle.battlers
            next if i.isFainted?
            if i.effects[:SkyDroppee]==self
              @battle.scene.pbUnVanishSprite(i)
              i.effects[:TwoTurnAttack] = 0
              i.effects[:SkyDroppee] = nil
            end
          end
        end
        # Gen 9 Mod - Get Tatsugiri out of Dondozo's mouth when Dondozo faints
        if self.effects[:Commandee] && self.pbPartner.effects[:Commander]
          self.pbPartner.effects[:Commander] = false
          @battle.scene.pbUnVanishSprite(self.pbPartner,true)
        end
        @battle.pbDisplayPaused(_INTL("{1} fainted!",pbThis)) if showMessage
        pbInitEffects(false)
        self.bossdelayedeffect = nil
        self.bossdelaycounter = nil
        self.onEntryEffects = nil
        self.vanished=false
        # reset status
        self.status=nil
        self.statusCount=0
        if @pokemon && @battle.internalbattle
          @pokemon.changeHappiness("faint")
        end
        if self.isMega? || self.isGiga?
          @pokemon.makeUnmega
        end
        if self.isUltra?
          @pokemon.makeUnultra(@startform)
        end
        @fainted=true
        # reset choice
        @battle.choices[@index]=[0,0,nil,-1]
        if @userSwitch
          @userSwitch = false
        end
        #reset mimikyu form if it faints
        if (@species==:MIMIKYU || @species==:EISCUE) && @pokemon.form==1
          self.form=0
        end
        if ((@species == :PARAS || @species == :PARASECT) && @pokemon.form == 2)
          self.form=1
        end
        # Gen 9 Mod - Return Palafin to it's Zero form if it faints.
        if @species==:PALAFIN && @pokemon.form!=0
          self.form = 0
        end
        # Gen 9 Mod - Return Terapagos to it's normal form if it faints.
        if @species==:TERAPAGOS && @pokemon.form!=0
          self.form = 0
        end
        #stops being in middle of a spread move
        @midwayThroughMove = false
        #deactivate ability
        self.ability=nil
        self.crested=false
        if droprelease!=nil
          oppmon = droprelease
          oppmon.effects[:SkyDrop]=false
          @battle.scene.pbUnVanishSprite(oppmon)
          @battle.pbDisplay(_INTL("{1} is freed from Sky Drop effect!",oppmon.pbThis))
        end
        @battle.party2.pop if self.issossmon
        # set ace message flag
        if (self.index==1 || self.index==3) && !@battle.pbIsWild? && !@battle.opponent.is_a?(Array) && @battle.pbPokemonCount(@battle.party2)==1 && !@battle.ace_message_handled
          @battle.ace_message=true
        end
        @battle.scene.partyBetweenKO1(self.index==1 || self.index==3) unless (@battle.doublebattle || pbNonActivePokemonCount==0)
        PBDebug.log("[#{pbThis} fainted]") if $INTERNAL
        return true
      end

end

class PokeBattle_BossMove < PokeBattle_Move	#Fake move used by AI to determine damage if no damaging AI memory move
	def initialize(battle,user,bossmove)
		type = bossmove[:type] ? bossmove[:type] : :QMARKS
		@move = bossmove[:move]
		@battle = battle
		@name 			 = bossmove[:name]
    @longname    = bossmove[:longname] ? bossmove[:longname] : bossmove[:name]
		@function    = bossmove[:function]
		@basedamage  = bossmove[:basedamage]
		@type        = type
		@category    = (bossmove[:category])
		@accuracy    = 100
		@target      = bossmove[:target]
		@maxpp       = 15
		@priority    = 0
		@zmove       = false
		@user        = user
    @effect      = bossmove[:effect] ? bossmove[:effect] : 0
    @moreeffect  = bossmove[:moreeffect] ? bossmove[:moreeffect] : @effect
    @recoil      = 0
		# @data				 = MoveData.new(@move,hash)
	end
end
