#===============================================================================
# * Advanced Pokédex - by FL (Credits will be apreciated)
#===============================================================================
#
 # This script is for Pokémon Essentials. When a switch is ON, it displays at 
# pokédex the pokémon PBS data for a caught pokémon like: base exp, egg steps
# to hatch, abilities, wild hold item, evolution, the moves that pokémon can 
# learn by level/breeding/machines/tutors, among others.
#
 #===============================================================================
#
 # To this script works, put it above main, put a 512x384 background for this
# screen in "Graphics/Pictures/advancedPokedex" location and three 512x384 for
# the top pokédex selection bar at "Graphics/Pictures/advancedPokedexEntryBar",
# "Graphics/Pictures/advancedPokedexNestBar" and
# "Graphics/Pictures/advancedPokedexFormBar".
#
 # -In PokemonPokedex script section, after line (use Ctrl+F to find it)
# '@sprites["searchlist"].visible=false' add:
#
# @sprites["dexbar"]=IconSprite.new(0,0,@viewport)
# @sprites["dexbar"].setBitmap(_INTL("Graphics/Pictures/advancedPokedexEntryBar"))
# @sprites["dexbar"].visible=false
#
 # -After line '@sprites["dexentry"].visible=true' add:
#
 # if @sprites["dexbar"] && $game_switches[AdvancedPokedexScene::SWITCH]
#   @sprites["dexbar"].visible=true 
# end 
 #
 # -Change line 'newpage=page+1 if page<3' to 
# 'newpage=page+1 if page<($game_switches[AdvancedPokedexScene::SWITCH] ? 4 : 3)'.
# -After line 'ret=screen.pbStartScreen(@dexlist[curindex][0],listlimits)' add:
#
# when 4 # Advanced Data
#   scene=AdvancedPokedexScene.new
#   screen=AdvancedPokedex.new(scene)
#   ret=screen.pbStartScreen(@dexlist[curindex][0],listlimits)
#
# -In PokemonNestAndForm script section, before line 
# '@sprites["map"]=IconSprite.new(0,0,@viewport)' add:
#
# if $game_switches[AdvancedPokedexScene::SWITCH]
#   @sprites["dexbar"]=IconSprite.new(0,0,@viewport)
#   @sprites["dexbar"].setBitmap(_INTL("Graphics/Pictures/advancedPokedexNestBar"))
# end
#
# -Before line 
# '@sprites["info"]=BitmapSprite.new(Graphics.width,Graphics.height,@viewport)'
# add:
#
# if $game_switches[AdvancedPokedexScene::SWITCH]
#   @sprites["dexbar"]=IconSprite.new(0,0,@viewport)
#   @sprites["dexbar"].setBitmap(_INTL("Graphics/Pictures/advancedPokedexFormBar"))
# end
#
# -After line 'pbChooseForm' add:
#
# elsif Input.trigger?(Input::RIGHT)
#   if $game_switches[AdvancedPokedexScene::SWITCH]
#     ret=6
#     break
#   end
#
#===============================================================================

class AdvancedPokedexScene
  # Switch number that toggle this script ON/OFF
  SWITCH=704
  
  # When true always shows the egg moves of the first evolution stage
  EGGMOVESFIRSTSTAGE = true
  
  # When false shows different messages for each of custom evolutions,
  # change the messages to ones that fills to your method
  HIDECUSTOMEVOLUTION = false
  
  # When true displays TMs/HMs/Tutors moves
  SHOWMACHINETUTORMOVES = true
  
  # When true picks the number for TMs and the first digit after a H for 
  # HMs (like H8) when showing machine moves.
  FORMATMACHINEMOVES = true
  
  # When false doesn't displays moves in tm.txt PBS that aren't in
  # any TM/HM item
  SHOWTUTORMOVES = true
  
  # The division between tutor and machine (TM/HMs) moves is made by 
  # the TM data in items.txt PBS 
  
  def pbStartScene(species)
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @species=species
    @form = $Trainer.pokedex.dexList[species][:lastSeen][:form]
    # Maybe Here?
    @formnum = $cache.pkmn[@species].forms.empty? ? 0 : $cache.pkmn[@species].forms.values.index(@form)
    @pokemonDummy = PokeBattle_Pokemon.new(@species,1)
    @pokemonDummy.form = @formnum
    @sprites={}
    @sprites["background"]=IconSprite.new(0,0,@viewport)
    @sprites["background"].setBitmap(_INTL("Graphics/Pictures/Pokedex/advancedPokedex"))
    @sprites["overlay"]=BitmapSprite.new(
        Graphics.width,Graphics.height,@viewport)
    pbSetSystemFont(@sprites["overlay"].bitmap)
    @sprites["overlay"].x=0
    @sprites["overlay"].y=0
    @sprites["info"]=BitmapSprite.new(Graphics.width,Graphics.height,@viewport)
    @sprites["icon"]=PokemonSpeciesIconSprite.new(@species,@viewport)
    @sprites["icon"].x=52
    @sprites["icon"].y=290
    @type1=nil
    @type2=nil
    @page=1
    @totalPages=0
    if $Trainer.pokedex.dexList[@species][:owned?]
      @infoPages=3
      @infoArray=getInfo
      @levelMovesArray=getLevelMoves
      @eggMovesArray=getEggMoves
      @machineMovesArray=getMachineMoves if SHOWMACHINETUTORMOVES
      @levelMovesPages = (@levelMovesArray.size+9)/10
      @eggMovesPages = (@eggMovesArray.size+9)/10
      @machineMovesPages=(@machineMovesArray.size+9)/10 if SHOWMACHINETUTORMOVES
      @totalPages = @infoPages+@levelMovesPages+@eggMovesPages
      @totalPages+=@machineMovesPages if SHOWMACHINETUTORMOVES
      displayPage
    end
    pbUpdate
    return true
  end
  
  BASECOLOR = Color.new(88,88,80)
  SHADOWCOLOR = Color.new(168,184,184)
  BASE_X = 32
  EXTRA_X = 224
  BASE_Y = 64
  EXTRA_Y = 32
  
  def getInfo
    ret = []
    for i in 0...2*4
      ret[i]=[]
      for j in 0...6
        ret[i][j]=nil
      end
    end
    # Type
    @type1=@pokemonDummy.type1
    @type2=@pokemonDummy.type2
    # Base Exp
    ret[0][0]=_INTL("BASE EXP: {1}",@pokemonDummy.baseExp)
    # Catch Rate
    ret[1][0]=_INTL("CATCH RARENESS: {1}",@pokemonDummy.catchRate)
    # Happiness base
    ret[0][1]=_INTL("HAPPINESS BASE: {1}",$cache.pkmn[@species].Happiness)
    # Color
    ret[1][1]=_INTL("COLOR: {1}",$cache.pkmn[@species].Color)
    # Egg Steps to Hatch
    stepsToHatch = $cache.pkmn[@species].EggSteps
    ret[0][2]=_INTL("EGG STEPS TO HATCH: {1} ({2} cycles)",
        stepsToHatch,stepsToHatch/255)
    # Growth Rate
    growthRate=$cache.pkmn[@species].GrowthRate
    growthRateString = {:MediumFast => _INTL("Medium Fast"), :Erratic => _INTL("Erratic"), :Fluctuating => _INTL("Fluctuating"),
        :MediumSlow => _INTL("Medium Slow"), :Fast => _INTL("Fast"), :Slow => _INTL("Slow")}[growthRate]
    ret[0][3]=_INTL("GROWTH RATE: {1} ({2})",
        growthRateString,PBExp.maxExperience(growthRate))
    # Gender Rate
    genderbyte=$cache.pkmn[@species].GenderRatio
    case genderbyte
      when :Genderless then genderString = "Genderless" # genderless
      when :MaleZero then genderString = "Always female" # always female
      when :FemZero then genderString = "Always male" # always male
      when :FemEighth then genderString = "Male #{100-((31+1)*100/256.0)}%"
      when :FemQuarter then genderString = "Male #{100-((63+1)*100/256.0)}%"
      when :FemHalf then genderString = "Male #{100-((127+1)*100/256.0)}%"
      when :MaleQuarter then genderString = "Male #{100-((191+1)*100/256.0)}%"
      when :MaleEighth then genderString = "Male #{100-((223+1)*100/256.0)}%"
    end
    ret[0][4]=_INTL("GENDER RATE: {1}",genderString)
    # Breed Group
    eggGroups = "#{$cache.pkmn[@species].EggGroups[0]}"
    if $cache.pkmn[@species].EggGroups.length > 1
      eggGroups += ", #{$cache.pkmn[@species].EggGroups[1]}"
    end
    ret[0][5]=_INTL("BREED GROUP: {1}",eggGroups)
    # Base Stats
    baseStats = $cache.pkmn[@species].formData.dig($cache.pkmn[@species].forms[@pokemonDummy.form],:BaseStats)
    baseStats = $cache.pkmn[@species].BaseStats if !baseStats
    baseStatsTot=0
    for i in 0...baseStats.size
      baseStatsTot+=baseStats[i]
    end
    baseStats.push(baseStatsTot)
    ret[2][0]=_ISPRINTF(
        "                                        HP    ATK DEF SPA SPD SPE TOTAL")
    ret[2][1]=_ISPRINTF(
        "BASE STATS:          {1:03d} {2:03d} {3:03d} {4:03d} {5:03d} {6:03d} {7:03d}",
        baseStats[0],baseStats[1],baseStats[2],
        baseStats[3],baseStats[4],baseStats[5],baseStats[6])
    # Effort Points
    effortPoints = $cache.pkmn[@species].formData.dig($cache.pkmn[@species].forms[@pokemonDummy.form],:EVs)
    effortPoints= $cache.pkmn[@species].EVs if !effortPoints
    effortPointsTot=0
    for i in 0...effortPoints.size
      effortPoints[i]=0 if  !effortPoints[i]
      effortPointsTot+=effortPoints[i]
    end
    effortPoints.push(effortPointsTot)
    ret[2][2]=_ISPRINTF(
        "EFFORT POINTS: {1:03d} {2:03d} {3:03d} {4:03d} {5:03d} {6:03d} {7:03d}",
        effortPoints[0],effortPoints[1],effortPoints[2],
        effortPoints[3],effortPoints[4],effortPoints[5],effortPoints[6])
    # Abilities
    abilityString = getAbilityName(@pokemonDummy.getAbilityList[0])
    for ability in 1...@pokemonDummy.getAbilityList.length
      break if @pokemonDummy.getAbilityList.length == 1
      abilityString += ", " + getAbilityName(@pokemonDummy.getAbilityList[ability])
    end
    ret[2][3]=_INTL("ABILITIES: {1}",abilityString)
    # Wild hold item 
    wilditems = {}
    if $cache.pkmn[@species].formData.dig($cache.pkmn[@species].forms[@pokemonDummy.form],:WildItemCommon)
      wilditems.store(:common, $cache.pkmn[@species].formData.dig($cache.pkmn[@species].forms[@pokemonDummy.form],:WildItemCommon))
    elsif $cache.pkmn[@species].flags.dig(:WildItemCommon)
      wilditems.store(:common, $cache.pkmn[@species].flags[:WildItemCommon])
    end
    if $cache.pkmn[@species].formData.dig($cache.pkmn[@species].forms[@pokemonDummy.form],:WildItemUncommon)
      wilditems.store(:uncommon, $cache.pkmn[@species].formData.dig($cache.pkmn[@species].forms[@pokemonDummy.form],:WildItemUncommon))
    elsif $cache.pkmn[@species].flags.dig(:WildItemUncommon)
      wilditems.store(:uncommon, $cache.pkmn[@species].flags[:WildItemUncommon])
    end
    if $cache.pkmn[@species].formData.dig($cache.pkmn[@species].forms[@pokemonDummy.form],:WildItemRare)
      wilditems.store(:rare, $cache.pkmn[@species].formData.dig($cache.pkmn[@species].forms[@pokemonDummy.form],:WildItemRare))
    elsif $cache.pkmn[@species].flags.dig(:WildItemRare)
      wilditems.store(:rare, $cache.pkmn[@species].flags[:WildItemRare])
    end
    if wilditems.size == 0
      ret[4][0] = _INTL("HOLD ITEMS: None")
    elsif wilditems.size == 3 && (wilditems[:common] == wilditems[:uncommon] && wilditems[:uncommon] == wilditems[:rare])
      ret[4][0] = _INTL("HOLD ITEMS: {1} (always)",getItemName(wilditems[:common]))
    else
      wilditemsString = []
      if wilditems.dig(:common)
        wilditemsString.push(getItemName(wilditems[:common]))
      end
      if wilditems.dig(:uncommon)
        wilditemsString.push(getItemName(wilditems[:uncommon]))
      end
      if wilditems.dig(:rare)
        wilditemsString.push(getItemName(wilditems[:rare]))
      end

      ret[4][0] = _INTL("HOLD ITEMS: {1}",wilditemsString.empty? ? 
          "" : wilditemsString[0])
      ret[4][1] = wilditemsString[1] if wilditemsString.size>1
      ret[4][2] = wilditemsString[2] if wilditemsString.size>2
    end
    # Evolutions
    evolutionsStrings = []
    lastEvolutionSpecies = -1
    if pbGetEvolvedFormData(@species,@pokemonDummy) != nil
      for evolution in pbGetEvolvedFormData(@species,@pokemonDummy)
        # The below "if" it's to won't list the same evolution species more than
        # one time. Only the last is displayed.
        evolutionsStrings.pop if lastEvolutionSpecies==evolution[0]
        evolutionsStrings.push(getEvolutionMessage(evolution))
        lastEvolutionSpecies=evolution[0]
        
      end
      if @species == :EEVEE
        evolutionsStrings.reject! {|element| element.start_with?("Glaceon")}
        evolutionsStrings.reject! {|element| element.start_with?("Leafeon")}
        evolutionsStrings.insert(3,_INTL("Glaceon using Ice Stone"))
        evolutionsStrings.insert(3,_INTL("Leafeon using Leaf Stone"))
      end
    end
    line=3
    column=4
    ret[column][line] = _INTL("EVO: {1}",evolutionsStrings.empty? ? 
        "Does not evolve" : evolutionsStrings[0])
    evolutionsStrings.shift
    line+=1
     for string in evolutionsStrings
      if(line>5) # For when the pokémon has more than 3 evolutions (AKA Eevee) 
        line=0
         column+=2
        @infoPages+=1 # Creates a new page
      end
       ret[column][line] = string
      line+=1
     end
     # End
    return ret
   end  
  
   # Gets the evolution array and return evolution message
  def getEvolutionMessage(evolution)
    evoPokemon = getMonName(evolution[0])
    evoMethod = evolution[1]
    evoItem = evolution[2] # Sometimes it's level
    ret = case evoMethod
      when :Happiness; _INTL("{1} when happy",evoPokemon)
      when :HappinessDay; _INTL("{1} when happy during daytime",evoPokemon)
      when :HappinessNight; _INTL("{1} when happy during nighttime",evoPokemon)
      when :Level, :Ninjask;_INTL("{1} at level {2}",
          evoPokemon,evoItem) # Pokémon that evolve by level AND Ninjask
      when :Trade; _INTL("{1} trading",evoPokemon)
      when :TradeItem; _INTL("{1} trading holding {2}",
          evoPokemon,getItemName(evoItem))
      when :Item; _INTL("{1} using {2}",evoPokemon,getItemName(evoItem))
      when :Hitmonlee; _INTL("{1} at level {2} and ATK > DEF",
          evoPokemon,evoItem) # Hitmonlee
      when :Hitmontop; _INTL("{1} at level {2} and ATK = DEF",
          evoPokemon,evoItem) # Hitmontop
      when :Hitmonchan;_INTL("{1} at level {2} and DEF < ATK",
          evoPokemon,evoItem) # Hitmonchan 
      when :Silcoon,:Cascoon; _INTL("{1} at level {2} with personalID",
          evoPokemon,evoItem) # Silcoon/Cascoon
      when :Shedinja;_INTL("{1} at level {2} with empty space",
          evoPokemon,evoItem) # Shedinja
      when :Milotic;_INTL("{1} when beauty is greater than {2}",
          evoPokemon,evoItem) # Milotic 
      when :ItemMale;_INTL("{1} using {2} and it's male",
          evoPokemon,getItemName(evoItem))
      when :ItemFemale;_INTL("{1} using {2} and it's female",
          evoPokemon,getItemName(evoItem))
      when :DayHoldItem;_INTL("{1} holding {2} at day",
          evoPokemon,getItemName(evoItem))
      when :NightHoldItem;_INTL("{1} holding {2} at night",
          evoPokemon,getItemName(evoItem))
      when :HasMove;_INTL("{1} when has move {2}",
          evoPokemon,getMoveName(evoItem))
      when :HasInParty;_INTL("{1} when has {2} at party",
          evoPokemon,getMonName(evoItem))
      when :LevelMale;_INTL("{1} at level {2} and it's male",
          evoPokemon,evoItem)
      when :LevelFemale;_INTL("{1} at level {2} and it's female",
          evoPokemon,evoItem)
      when :Location
          case evolution[0]
          when :CRABOMINABLE;_INTL("{1} when you level up in a cold environment.",
            evoPokemon) # Evolves on a certain map
          when :PROBOPASS, :VIKAVOLT;_INTL("{1} when you level up on Terajuma.",
            evoPokemon) # Evolves on a certain map
          else;_INTL("{1} at {2}",
            evoPokemon, pbGetMapNameFromId(evoItem)) # Evolves on a certain map
          end
      when :TradeSpecies;_INTL("{1} trading by {2}",
          evoPokemon,getMonName(evoItem)) # Escavalier/Accelgor
      when :LevelRain;_INTL("{1} at level {2} while raining",
          evoPokemon,evoItem)
      when :LevelDay;_INTL("{1} at level {2} during daytime",
          evoPokemon,evoItem)
      when :LevelRain;_INTL("{1} at level {2} during nighttime",
          evoPokemon,evoItem)
      when :BadInfluence;_INTL("{1} at level {2} with Dark Type in party", 
          evoPokemon,evoItem) 
      when :Affection;_INTL("{1} when affection is greater than {2}", 
          evoPokemon,evoItem) 
      when :Sirfetchd;_INTL("{1} when you land 3 crits in one battle", 
          evoPokemon)
      when :Runerigus;_INTL("{1} when you take 49 damage without fainting in Wispy Ruins", 
          evoPokemon)
      when 33;_INTL("{1} custom8 with {2}", 
          evoPokemon,evoItem)  
      else; "Does not evolve."  
    end  
     ret = _INTL("{1} by an unknown way", evoPokemon) if(ret.empty?)
    return ret    
  end
   
   def getLevelMoves
    ret=[]
    movelist = $cache.pkmn[@species].Moveset
    if @formnum != 0 
      movelist = @pokemonDummy.formCheck(:Moveset)
      movelist = $cache.pkmn[@species].Moveset if movelist == nil
    end
    #puts "#{@species}\n"
    for move in movelist
      level=move[0]
      name=""
      begin
        name=getMoveName(move[1])
      rescue
        puts "\t#{move[1]}\n"
      end
      ret.push(_ISPRINTF("{1:02d} {2:s}",level,name))
    end
    return ret
   end  
   
   def getEggMoves
    movelist=[]
    ret=[]

    if defined?($cache.pkmn[@species].EggMoves)
      if @formnum != 0
        movelist = $cache.pkmn[@species].formData.dig(@form,:EggMoves)
      end
      movelist = $cache.pkmn[@species].EggMoves if  (movelist == [] || movelist == nil)
    end
    if EGGMOVESFIRSTSTAGE &&  (movelist == [] || movelist == nil)
      movelist = @pokemonDummy.getEggMoveList
    end
    return [] if (movelist == [] || movelist == nil)
    for move in movelist
      name=""
      begin
        name=getMoveName(move)
      rescue
        puts "\t#{move}\n"
      end
      ret.push(_ISPRINTF("     {1:s}",name))
    end
    return ret.sort
   end  
   
   def getMachineMoves
    ret=[]
    tms = {}
    hms = {}
    tutors = []
    movesArray = []
    if @formnum != 0
      movesArray = $cache.pkmn[@species].formData.dig(@form,:compatiblemoves)
    end
    movesArray = $cache.pkmn[@species].compatiblemoves if (movesArray == [] || movesArray == nil)
    return [] if  movesArray == []
    return [] if movesArray.nil?
    for move in movesArray
      if FORMATMACHINEMOVES
        tm = getTMFromMove(move)
        if !tm.nil?
          if tm.name[0,2] == "HM"
            hms.store(tm.name[2,tm.name.length].to_i, {
              :name => tm.name,
              :move => tm.flags[:tm]
            })
          else
            tms.store(tm.name[2,tm.name.length].to_i, {
              :name => tm.name,
              :move => tm.flags[:tm]
            })
          end
        else
          name=""
          begin
            name=getMoveName(move)
          rescue
            puts "\t#{move}\n"
          end
          tutors.push(_ISPRINTF("     {1:s}",name))
        end  
      else
        name=""
        begin
          name=getMoveName(move)
        rescue
          puts "\t#{move}\n"
        end
        ret.push(_ISPRINTF("     {1:s}",name))
      end  
    end
    if FORMATMACHINEMOVES
      tutors.sort!
      tmlist = tms.keys.sort
      for key in tmlist
        ret.push(_ISPRINTF("{1:s} {2:s}",tms[key][:name],getMoveName(tms[key][:move])))
      end
      hmlist = hms.keys.sort
      for key in hmlist
        ret.push(_ISPRINTF("{1:s} {2:s}",hms[key][:name],getMoveName(hms[key][:move])))
      end
      ret += tutors
      return ret
    else 
      return ret.sort
    end
   end  
   
   def displayPage
    return if !$Trainer.pokedex.dexList[@species][:owned?]
    if(@page<=@infoPages)
      pageInfo(@page)
    elsif(@page<=@infoPages+@levelMovesPages)
      pageMoves(@levelMovesArray,_INTL("LEVEL UP MOVES:"),@page-@infoPages)
    elsif(@page<=@infoPages+@levelMovesPages+@eggMovesPages)
      pageMoves(@eggMovesArray,_INTL("EGG MOVES:"),
          @page-@infoPages-@levelMovesPages)
    elsif(SHOWMACHINETUTORMOVES && 
        @page <= @infoPages+@levelMovesPages+@eggMovesPages+@machineMovesPages)
      pageMoves(@machineMovesArray,_INTL("MACHINE MOVES:"),
          @page-@infoPages-@levelMovesPages-@eggMovesPages)
    end
   end  
   
   def pageInfo(page)
    @sprites["overlay"].bitmap.clear
    textpos = []
    for i in (12*(page-1))...(12*page)
      line = i%6
      column = i/6
      next if !@infoArray[column][line]
      x = BASE_X+EXTRA_X*(column%2)
      y = BASE_Y+EXTRA_Y*line
      textpos.push([@infoArray[column][line],x,y,false,BASECOLOR,SHADOWCOLOR])
    end
     pbDrawTextPositions(@sprites["overlay"].bitmap,textpos)
  end  
   
   def pageMoves(movesArray,label,page)
    @sprites["overlay"].bitmap.clear
    textpos = [[label,BASE_X,BASE_Y,false,BASECOLOR,SHADOWCOLOR]]
     for i in (10*(page-1))...(10*page)
      break if i>=movesArray.size
      line = i%5
      column = i/5
      x = BASE_X+EXTRA_X*(column%2)
      y = BASE_Y+EXTRA_Y*(line+1)
      textpos.push([movesArray[i],x,y,false,BASECOLOR,SHADOWCOLOR])
    end
     pbDrawTextPositions(@sprites["overlay"].bitmap,textpos)
  end  
   
   def pbUpdate
     @sprites["info"].bitmap.clear
    pbSetSystemFont(@sprites["info"].bitmap)
    height = Graphics.height-54
    text=[[getMonName(@species),(Graphics.width+72)/2,height-32,
         2,BASECOLOR,SHADOWCOLOR]]
    text.push([_INTL("{1}/{2}",@page,@totalPages),Graphics.width-52,height,
         1,BASECOLOR,SHADOWCOLOR]) if $Trainer.pokedex.dexList[@species][:owned?]
    pbDrawTextPositions(@sprites["info"].bitmap,text)
    if !@type1 # This "if" only occurs when the getInfo isn't called
      @type1=$cache.pkmn[@species].Type1
      if defined?($cache.pkmn[@species].Type2)
        @type2=$cache.pkmn[@species].Type2
      end
    end
    type1bitmap = AnimatedBitmap.new("Graphics/Pictures/Pokedex/pokedex#{@type1.to_s}")
    @sprites["info"].bitmap.blt((Graphics.width+16-144)/2,height,type1bitmap.bitmap,Rect.new(0,0,96,32))
    type1bitmap.dispose

    if @type2 != nil
      type2bitmap = AnimatedBitmap.new("Graphics/Pictures/Pokedex/pokedex#{@type2.to_s}") 
      @sprites["info"].bitmap.blt((Graphics.width+16+72)/2,height,type2bitmap.bitmap,Rect.new(0,0,96,32)) 
      type2bitmap.dispose
    end 
    @sprites["icon"].update
  end
 
   def pbControls(listlimits)
    Graphics.transition
    ret=0
     loop do
       Graphics.update
      Input.update
      pbUpdate
       if Input.trigger?(Input::C) || Input.trigger?(Input::PAGEDOWN)
        @page+=1
        @page=1 if @page>@totalPages
        displayPage
      elsif Input.trigger?(Input::A) || Input.trigger?(Input::PAGEUP)
        @page-=1
        @page=@totalPages if @page<1
        displayPage
      elsif Input.trigger?(Input::LEFT)
        ret=4
         break
       # If not at top of list  
      elsif Input.trigger?(Input::UP) && listlimits&1==0 
        ret=8
         break
       # If not at end of list  
      elsif Input.trigger?(Input::DOWN) && listlimits&2==0 
        ret=2
         break
       elsif Input.trigger?(Input::B)
        ret=1
         pbPlayCancelSE()
        pbFadeOutAndHide(@sprites)
        break
       end
     end
     return ret
   end
 
   def pbEndScene
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
 end
 
 
 class AdvancedPokedex
   def initialize(scene)
    @scene=scene
  end
 
   def pbStartScreen(species,listlimits)
    @scene.pbStartScene(species)
    ret=@scene.pbControls(listlimits)
    @scene.pbEndScene
    return ret
   end
 end