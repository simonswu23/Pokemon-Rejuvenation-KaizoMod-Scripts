def pbFindEncounter(mapid,species)
  return false if $cache.mapdata[mapid] == nil
  return true if !$cache.mapdata[mapid].Land.nil? && $cache.mapdata[mapid].Land.dig(species)
  return true if !$cache.mapdata[mapid].Cave.nil? && $cache.mapdata[mapid].Cave.dig(species)
  return true if !$cache.mapdata[mapid].Water.nil? && $cache.mapdata[mapid].Water.dig(species)
  return true if !$cache.mapdata[mapid].RockSmash.nil? && $cache.mapdata[mapid].RockSmash.dig(species)
  return true if !$cache.mapdata[mapid].OldRod.nil? && $cache.mapdata[mapid].OldRod.dig(species)
  return true if !$cache.mapdata[mapid].GoodRod.nil? && $cache.mapdata[mapid].GoodRod.dig(species)
  return true if !$cache.mapdata[mapid].SuperRod.nil? && $cache.mapdata[mapid].SuperRod.dig(species)
  return true if !$cache.mapdata[mapid].Headbutt.nil? && $cache.mapdata[mapid].Headbutt.dig(species)
  return true if !$cache.mapdata[mapid].LandMorning.nil? && $cache.mapdata[mapid].LandMorning.dig(species)
  return true if !$cache.mapdata[mapid].LandDay.nil? && $cache.mapdata[mapid].LandDay.dig(species)
  return true if !$cache.mapdata[mapid].LandNight.nil? && $cache.mapdata[mapid].LandNight.dig(species)
  return false
end



################################################################################
# Shows the "Nest" page of the Pokédex entry screen.
################################################################################
class PokemonNestMapScene
  def pbStartScene(species,regionmap=-1)
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @sprites={}
    mappos=$cache.mapdata[$game_map.map_id].MapPosition
    region=regionmap
    if region<0                                    # Use player's current region
      region=mappos ? mappos[0] : 0                           # Region 0 default
    end
    @sprites["background"]=IconSprite.new(0,0,@viewport)
    @sprites["background"].setBitmap(_INTL("Graphics/Pictures/Pokedex/pokedexNest"))
    if !Reborn
      if $game_switches[AdvancedPokedexScene::SWITCH]
        @sprites["dexbar"]=IconSprite.new(0,0,@viewport)
        @sprites["dexbar"].setBitmap(_INTL("Graphics/Pictures/Pokedex/advancedPokedexNestBar"))
      end
    end
    @sprites["map"]=IconSprite.new(0,0,@viewport)
    @sprites["map"].setBitmap("Graphics/Pictures/#{$cache.town_map[region][1]}")
    @sprites["map"].x+=(Graphics.width-@sprites["map"].bitmap.width)/2
    @sprites["map"].y+=(Graphics.height-@sprites["map"].bitmap.height)/2
    for hidden in REGIONMAPEXTRAS
      if hidden[0]==region && hidden[1]>0 && $game_switches[hidden[1]]
        if !@sprites["map2"]
          @sprites["map2"]=BitmapSprite.new(480,320,@viewport)
          @sprites["map2"].x=@sprites["map"].x; @sprites["map2"].y=@sprites["map"].y
        end
        pbDrawImagePositions(@sprites["map2"].bitmap,[
           ["Graphics/Pictures/#{hidden[4]}",
              hidden[2]*PokemonRegionMapScene::SQUAREWIDTH,
              hidden[3]*PokemonRegionMapScene::SQUAREHEIGHT,0,0,-1,-1]
        ])
      end
    end
    @point=BitmapWrapper.new(PokemonRegionMapScene::SQUAREWIDTH+4,
                             PokemonRegionMapScene::SQUAREHEIGHT+4)
    @point.fill_rect(0,0,
                     PokemonRegionMapScene::SQUAREWIDTH+4,
                     PokemonRegionMapScene::SQUAREHEIGHT+4,Color.new(255,0,0))
    @point2=BitmapWrapper.new(PokemonRegionMapScene::SQUAREWIDTH+4,
                              PokemonRegionMapScene::SQUAREHEIGHT+4)
    @point2.fill_rect(4,0,
                      PokemonRegionMapScene::SQUAREWIDTH,
                      PokemonRegionMapScene::SQUAREHEIGHT+4,Color.new(255,0,0))
    @point3=BitmapWrapper.new(PokemonRegionMapScene::SQUAREWIDTH+4,
                              PokemonRegionMapScene::SQUAREHEIGHT+4)
    @point3.fill_rect(0,4,
                      PokemonRegionMapScene::SQUAREWIDTH+4,
                      PokemonRegionMapScene::SQUAREHEIGHT,Color.new(255,0,0))
    @point4=BitmapWrapper.new(PokemonRegionMapScene::SQUAREWIDTH+4,
                              PokemonRegionMapScene::SQUAREHEIGHT+4)
    @point4.fill_rect(4,4,
                      PokemonRegionMapScene::SQUAREWIDTH,
                      PokemonRegionMapScene::SQUAREHEIGHT,Color.new(255,0,0))
    points=[]
    mapwidth=1+PokemonRegionMapScene::RIGHT-PokemonRegionMapScene::LEFT
    for mapid in 1...$cache.mapdata.length
      if pbFindEncounter(mapid,species)
        mappos=$cache.mapdata[mapid].MapPosition
        if mappos && mappos[0]==region
          showpoint=true
          #for loc in $cache.town_map[region][2]
          #  showpoint=false if loc[0]==mappos[1] && loc[1]==mappos[2] && loc[7] && !$game_switches[loc[7]]
          #end
          if showpoint
            mapsize=$cache.mapdata[mapid].MapSize
            if mapsize && mapsize[0] && mapsize[0]>0
              sqwidth=mapsize[0]
              sqheight=(mapsize[1].length*1.0/mapsize[0]).ceil
              for i in 0...sqwidth
                for j in 0...sqheight
                  if mapsize[1][i+j*sqwidth,1].to_i>0
                    points[mappos[1]+i+(mappos[2]+j)*mapwidth]=true
                  end
                end
              end
            else
              points[mappos[1]+mappos[2]*mapwidth]=true
            end
          end
        end
      end
    end
    i=0
    for j in 0...points.length
      if points[j]
        s=SpriteWrapper.new(@viewport)
        s.x=(j%mapwidth)*PokemonRegionMapScene::SQUAREWIDTH-2
        s.x+=(Graphics.width-@sprites["map"].bitmap.width)/2
        s.y=(j/mapwidth)*PokemonRegionMapScene::SQUAREHEIGHT-2
        s.y+=(Graphics.height-@sprites["map"].bitmap.height)/2
        if j>=1 && points[j-1]
          if j>=mapwidth && points[j-mapwidth]
            s.bitmap=@point4
          else
            s.bitmap=@point2
          end
        else
          if j>=mapwidth && points[j-mapwidth]
            s.bitmap=@point3
          else
            s.bitmap=@point
          end
        end
        @sprites["point#{i}"]=s
        i+=1
      end
    end
    @numpoints=i
    @sprites["mapbottom"]=MapBottomSprite.new(@viewport)
    @sprites["mapbottom"].maplocation=pbGetMessage(MessageTypes::RegionNames,region)#kill this
    @sprites["mapbottom"].mapdetails=_INTL("{1}'s nest",getMonName(species))
    if points.length==0
      @sprites["mapbottom"].nonests=true
    end
    return true
  end

  def pbUpdate
    @numpoints.times {|i|
       @sprites["point#{i}"].opacity=[64,96,128,160,128,96][(Graphics.frame_count/4)%6]
    }
  end

  def pbMapScene(listlimits)
    Graphics.transition
    ret=0
    loop do
      Graphics.update
      Input.update
      pbUpdate
      if Input.trigger?(Input::LEFT)
        ret=4
        break
      elsif Input.trigger?(Input::RIGHT)
        ret=6
        break
      elsif Input.trigger?(Input::UP) && listlimits&1==0 # If not at top of list
        ret=8
        break
      elsif Input.trigger?(Input::DOWN) && listlimits&2==0 # If not at end of list
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
    @point.dispose
    @viewport.dispose
  end
end



class PokemonNestMap
  def initialize(scene)
    @scene=scene
  end

  def pbStartScreen(species,region,listlimits)
    @scene.pbStartScene(species,region)
    ret=@scene.pbMapScene(listlimits)
    @scene.pbEndScene
    return ret
  end
end



################################################################################
# Shows the "Form" page of the Pokédex entry screen.
################################################################################
class PokedexFormScene
  def pbStartScene(species)
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @species=species
    @gender=$Trainer.pokedex.dexList[species][:lastSeen][:gender]
    @form=$Trainer.pokedex.dexList[species][:lastSeen][:form]
    @shiny=$Trainer.pokedex.dexList[species][:lastSeen][:shiny]
    @available=pbGetAvailable 
    @sprites={}
    @sprites["background"]=IconSprite.new(0,0,@viewport)
    @sprites["background"].setBitmap(_INTL("Graphics/Pictures/Pokedex/pokedexForm"))
    if !Reborn
      if $game_switches[AdvancedPokedexScene::SWITCH]
        @sprites["dexbar"]=IconSprite.new(0,0,@viewport)
        @sprites["dexbar"].setBitmap(_INTL("Graphics/Pictures/Pokedex/advancedPokedexFormBar"))
      end
    end
    @sprites["info"]=BitmapSprite.new(Graphics.width,Graphics.height,@viewport)
    @sprites["front"]=PokemonSprite.new(@viewport)
    @sprites["back"]=PokemonSprite.new(@viewport)
    @sprites["icon"]=PokemonSpeciesIconSprite.new(@species,@viewport)
    @sprites["icon"].gender=@gender
    @sprites["icon"].form=@form
    @sprites["icon"].x=52
    @sprites["icon"].y=290
    pbUpdate
    return true
  end

  def pbUpdate
    @sprites["info"].bitmap.clear
    pbSetSystemFont(@sprites["info"].bitmap)
    gendertext="Gender: #{@gender}"
    formtext = @form
    #formtext = $cache.pkmn[@species].forms[@form == nil ? 0 : @form]
    if @species == :UNOWN
      formtext = "Unown '" + formtext + "'"
    end
    if cancelledgenders.include?(@species)
      formtext = "Normal Form"
    end
    nametext = getMonName(@species)
    nametext = "Shiny " + nametext if @shiny

    text=[
       [_INTL("{1}",nametext),
          (Graphics.width)/2,Graphics.height-86,2,
          Color.new(88,88,80),Color.new(168,184,184)],
       [("#{formtext}         #{gendertext}"),
          (Graphics.width)/2,Graphics.height-54,2,
          Color.new(88,88,80),Color.new(168,184,184)],
    ]
    pbDrawTextPositions(@sprites["info"].bitmap,text)
    frontBitmap=pbPokemonBitmap(@species,@shiny,false,@gender,@form)
    if frontBitmap
      @sprites["front"].bitmap=frontBitmap
    end
    backBitmap=pbPokemonBitmap(@species,@shiny,true,@gender,@form)
    if backBitmap
      @sprites["back"].bitmap=backBitmap
    end
    backMetric=$cache.pkmn[@species].BattlerPlayerY
    pbPositionPokemonSprite(@sprites["front"],74,96)
    pbPositionPokemonSprite(@sprites["back"],310,96)#+16)#+backMetric*2)
    if @species == :EXEGGUTOR && @form == 1
      @sprites["front"].y+=6
      @sprites["back"].y+=6
    end        
    #@sprites["icon"].update
  end
  
  def pbGetAvailable
    available=[] # [forms, genders]
    genderbyte=$cache.pkmn[@species].GenderRatio
    if !$cache.pkmn[@species].forms.empty?
      formnames = $cache.pkmn[@species].forms.values
    else
      formnames = ["Normal"]
    end

    availableForms = []
    for forms in formnames
      availableForms.push(forms) if $Trainer.pokedex.dexList[@species][:forms][forms] && (forms == formnames[0] || !$cache.pkmn[@species].formData[forms][:ExcludeDex])
    end
    
    availableGenders = []
    for genders in $Trainer.pokedex.dexList[@species][:gender].keys
      availableGenders.push(genders) if $Trainer.pokedex.dexList[@species][:gender][genders]
    end

    available = [availableForms, availableGenders]
    return available
  end

  def pbGetCommands
    commands=[]
    for i in @available
      commands.push(i[0])
    end
    return commands
  end

  def pbChooseForm
    oldgender=@gender
    oldform=@form
    choicearr = ["Gender", "Form"]
    choicearr.push("Toggle Shiny") if $Trainer.pokedex.dexList[@species][:shinySeen?]
    choice = Kernel.pbMessage("Which sprite would you like to view?",choicearr, -1)
    return if choice == -1
    if choice == 0
      genderoptions = @available[1]
      genderchoice = Kernel.pbMessage("Which gender would you like to view?", genderoptions, -1)
      return if genderchoice == -1
      if genderchoice > -1
        @gender = @sprites["icon"].gender = genderoptions[genderchoice]
        pbUpdate
      end
    end
    if choice == 1
      formoptions = @available[0]
      if cancelledgenders.include?(@species)
        formoptions = ["Normal Form"]
      end
      formchoice = Kernel.pbMessage("Which form would you like to view?", formoptions, -1)
      return if formchoice == -1
      if formchoice > -1 && !cancelledgenders.include?(@species)
        @form = @sprites["icon"].form = formoptions[formchoice]
        pbUpdate
      end
    end
    if choice == 2
      @shiny = !@shiny
      pbUpdate
    end
  end

  def pbControls(listlimits)
    Graphics.transition
    ret=0
    loop do
      Graphics.update
      Input.update
      @sprites["icon"].update
      if Input.trigger?(Input::C)
        pbChooseForm
      elsif Input.trigger?(Input::LEFT)
        ret=4
        break
      elsif Input.trigger?(Input::RIGHT)
        ret = 6
        break
      elsif Input.trigger?(Input::UP) #&& listlimits&1==0 # If not at top of list
        ret=8
        break
      elsif Input.trigger?(Input::DOWN)# && listlimits&2==0 # If not at end of list
        ret=2
        break
      elsif Input.trigger?(Input::B)
        ret=1
        pbPlayCancelSE()
        pbFadeOutAndHide(@sprites)
        break
      end
    end
    $Trainer.pokedex.dexList[@species][:lastSeen][:gender]=@gender
    $Trainer.pokedex.dexList[@species][:lastSeen][:form]=@form
    return ret
  end

  def pbEndScene
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
end



class PokedexForm
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