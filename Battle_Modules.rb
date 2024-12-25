# Results of battle:
#    0 - Undecided or aborted
#    1 - Player won
#    2 - Player lost
#    3 - Player or wild Pokémon ran from battle, or player forfeited the match
#    4 - Wild Pokémon was caught
#    5 - Draw
################################################################################
# Success State.
################################################################################
class PokeBattle_SuccessState
  attr_accessor :typemod
  attr_accessor :useState # 0 - not used, 1 - failed, 2 - succeeded
  attr_accessor :protected
  attr_accessor :skill # Used in Battle Arena

  def initialize
    clear
  end

  def clear
    @typemod=4
    @useState=0
    @protected=false
    @skill=0
  end

  def updateSkill
    if @useState==1 && !@protected
      @skill-=2
    elsif @useState==2
      if @typemod>4
        @skill+=2 # "Super effective"
      elsif @typemod>=1 && @typemod<4
        @skill-=1 # "Not very effective"
      elsif @typemod==0
        @skill-=2 # Ineffective
      else
        @skill+=1
      end
    end
    @typemod=4
    @useState=0
    @protected=false
  end
end

class PokeBattle_RealBattlePeer
  def pbOnEnteringBattle(battle,pokemon)
  end
end

################################################################################
# Catching and storing Pokémon.
################################################################################
module PokeBattle_BattleCommon
  def pbStorePokemon(pokemon)
    if !(pokemon.isShadow? rescue false)
      if pbDisplayConfirm(_INTL("Would you like to give a nickname to {1}?",pokemon.name))
        species=getMonName(pokemon.species)
        nickname=@scene.pbNameEntry(_INTL("{1}'s nickname?",species),pokemon)
        pokemon.name=nickname if nickname!=""
      end
    end
    oldcurbox=@peer.pbCurrentBox()
    storedbox=@peer.pbStorePokemon(self.pbPlayer,pokemon)
    creator=@peer.pbGetStorageCreator()
    return if storedbox<0
    curboxname=@peer.pbBoxName(oldcurbox)
    boxname=@peer.pbBoxName(storedbox)
    if storedbox!=oldcurbox
      if creator
        pbDisplayPaused(_INTL("Box \"{1}\" on {2}'s PC was full.",curboxname,creator))
      else
        pbDisplayPaused(_INTL("Box \"{1}\" on someone's PC was full.",curboxname))
      end
      pbDisplayPaused(_INTL("{1} was transferred to box \"{2}\".",pokemon.name,boxname))
    else
      if creator
        pbDisplayPaused(_INTL("{1} was transferred to {2}'s PC.",pokemon.name,creator))
      else
        pbDisplayPaused(_INTL("{1} was transferred to someone's PC.",pokemon.name))
      end
      pbDisplayPaused(_INTL("It was stored in box \"{1}\".",boxname))
    end
  end


  def pbBallFetch(pokeball)
    for i in 0...4
      if self.battlers[i].ability == (:BALLFETCH) && self.battlers[i].item.nil?
        self.battlers[i].effects[:BallFetch]=pokeball
      end
    end
  end


  def pbThrowPokeBall(idxPokemon,ball,rareness=nil,showplayer=false)
    itemname=getItemName(ball)
    battler=nil
    if pbIsOpposing?(idxPokemon)
      battler=self.battlers[idxPokemon]
    else
      battler=self.battlers[idxPokemon].pbOppositeOpposing
    end
    if battler.isFainted?
      battler=battler.pbPartner
    end
    oldform=battler.form
    battler.form=battler.pokemon.getForm(battler.pokemon)
    pbDisplayBrief(_INTL("{1} threw a {2}!",self.pbPlayer.name,itemname))
    if battler.isFainted?
      pbDisplay(_INTL("But there was no target..."))
      pbBallFetch(ball)
      return
    end
    if @opponent && (!pbIsSnagBall?(ball) || !battler.isShadow?)
      @scene.pbThrowAndDeflect(ball,1)
      if $game_switches[:No_Catching]==false
        pbDisplay(_INTL("The Trainer blocked the Ball!\nDon't be a thief!"))
      else
        pbDisplay(_INTL("The Pokémon knocked the ball away!"))
      end
    else
      if $game_switches[:No_Catching]==true
        pbDisplay(_INTL("The Pokémon knocked the ball away!"))
        pbBallFetch(ball)
        return
      end
      pokemon=battler.pokemon
      species=pokemon.species
      rareness = pokemon.catchRate if !rareness
      a=battler.totalhp
      b=battler.hp
      rareness=BallHandlers.modifyCatchRate(ball,rareness,self,battler)
      rareness +=1 if $PokemonBag.pbQuantity(:CATCHINGCHARM)>0
      rareness +=1 if Reborn && $PokemonBag.pbQuantity(:CATCHINGCHARM2)>0
      rareness +=1 if Reborn && $PokemonBag.pbQuantity(:CATCHINGCHARM3)>0
      rareness +=1 if Reborn && $PokemonBag.pbQuantity(:CATCHINGCHARM4)>0
      x=(((a*3-b*2)*rareness)/(a*3))
      if battler.status== :SLEEP || (battler.status== :FROZEN || SWUMOD)
        x=(x*2.5)
      elsif !battler.status.nil?
        x=(x*3/2)
      end
      #Critical Capture chances based on caught species'
      c = 0
      if $Trainer
        mod = -3
        mod += 0.5 if $Trainer.pokedexOwned > 500
        mod += 0.5 if $Trainer.pokedexOwned > 400
        mod += 0.5 if $Trainer.pokedexOwned > 300
        mod += 0.5 if $Trainer.pokedexOwned > 200
        mod += 0.5 if $Trainer.pokedexOwned > 100
        mod += 0.5 if $Trainer.pokedexOwned > 30
        c = (x * (2**mod).floor)
      end
      shakes = 0
      critical = false
      critsuccess = false
      if x > 255 || BallHandlers.isUnconditional?(ball, self, battler)
        shakes = 4
      else
        x=1 if x==0
        y = (65536/((255.0/x)**0.1875)).floor
        puts "c = #{c}; x = #{x}"
        percentage = (1/((255.0/x)**0.1875))**4
        puts "Catch chance: #{percentage}%"
        percentage = c/256.0 * (1/((255.0/x)**0.1875))
        puts "Crit chance: #{percentage}%"
        if pbRandom(256)<c
          critical=true
          if pbRandom(65536)<y
            critsuccess=true
            shakes=4
          end
        else
          shakes+=1 if pbRandom(65536)<y
          shakes+=1 if pbRandom(65536)<y
          shakes+=1 if pbRandom(65536)<y
          shakes+=1 if pbRandom(65536)<y
        end
      end
      shakes=4 if $DEBUG && Input.press?(Input::CTRL)
      # @SWu make catching easier
      shakes+=2 if SWUMOD && shakes <= 2
      @scene.pbThrow(ball,(critical) ? 1 : shakes,critical,critsuccess,battler.index,showplayer)
      case shakes
        when 0
          pbDisplay(_INTL("Oh no! The Pokémon broke free!"))
          pbBallFetch(ball)
          BallHandlers.onFailCatch(ball,self,pokemon)
          battler.form=oldform
        when 1
          pbDisplay(_INTL("Aww... It appeared to be caught!"))
          pbBallFetch(ball)
          BallHandlers.onFailCatch(ball,self,pokemon)
          battler.form=oldform
        when 2
          pbDisplay(_INTL("Aargh! Almost had it!"))
          pbBallFetch(ball)
          BallHandlers.onFailCatch(ball,self,pokemon)
          battler.form=oldform
        when 3
          pbDisplay(_INTL("Shoot! It was so close, too!"))
          pbBallFetch(ball)
          BallHandlers.onFailCatch(ball,self,pokemon)
          battler.form=oldform
        when 4
          @scene.pbWildBattleSuccess
          pbDisplayBrief(_INTL("Gotcha! {1} was caught!",pokemon.name))
          @scene.pbThrowSuccess
          if pbIsSnagBall?(ball) && @opponent
            pbRemoveFromParty(battler.index,battler.pokemonIndex)
            battler.pbReset
            battler.participants=[]
          else
            @decision=4
          end
          if pbIsSnagBall?(ball)
            pokemon.ot=self.pbPlayer.name
            pokemon.trainerID=self.pbPlayer.id
          end
          BallHandlers.onCatch(ball,self,pokemon)
          pokemon.ballused=pbGetBallType(ball)
          pokemon.pbRecordFirstMoves
          if !self.pbPlayer.owned[species]
            self.pbPlayer.owned[species]=true
            if $Trainer.pokedex
              pbDisplayPaused(_INTL("{1}'s data was added to the Pokédex.",pokemon.name))
              @scene.pbShowPokedex(species)
            end
          end
          @scene.pbHideCaptureBall
          pbGainEXP
          pokemon.form=pokemon.getForm(pokemon)
          if pbIsSnagBall?(ball) && @opponent
            pokemon.pbUpdateShadowMoves rescue nil
            @snaggedpokemon.push(pokemon)
          else
            pbStorePokemon(pokemon)
          end

      end
    end
  end
end

