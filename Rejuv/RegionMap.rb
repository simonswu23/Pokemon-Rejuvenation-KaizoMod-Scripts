##########################
# Scrollable Map - Haru
#
# Heavily modified RegionMap from old Essentials
##########################

def pbUnpackMapHash
  determinator=$cache.mapdata[$game_map.map_id].MapPosition[:variable]
  mapposition=$cache.mapdata[$game_map.map_id].MapPosition[$game_variables[determinator]]
  if mapposition.nil?
    keyvalues=$cache.mapdata[$game_map.map_id].MapPosition.keys
    for i in 1...keyvalues.length
      if $game_variables[determinator] < keyvalues[i]
        if i==1
          mapposition=$cache.mapdata[$game_map.map_id].MapPosition[keyvalues[i]]
        else
          mapposition=$cache.mapdata[$game_map.map_id].MapPosition[keyvalues[i-1]]
        end
        break
      end
    end
    mapposition=$cache.mapdata[$game_map.map_id].MapPosition[keyvalues[-1]] if mapposition.nil?
  end
  return mapposition
end

class MapBottomSprite < SpriteWrapper
  attr_reader :mapname,:maplocation

  def initialize(viewport=nil)
    super(viewport)
    @mapname=""
    @maplocation=""
    @mapdetails=""
    @nonests=false
    @thisbitmap=BitmapWrapper.new(Graphics.width,Graphics.height)
    pbSetSystemFont(@thisbitmap)
    self.y=0
    self.x=0
    self.bitmap=@thisbitmap
    refresh
  end

  def dispose
    @thisbitmap.dispose
    super
  end

  def nonests=(value)
    @nonests=value
    refresh
  end

  def mapname=(value)
    if @mapname!=value
      @mapname=value
      refresh
    end
  end

  def maplocation=(value)
    value = "" if value.nil?
    if @maplocation!=value
      @maplocation=value
      refresh
    end
  end

  def mapdetails=(value)  # From Wichu
    value = "" if value.nil?
    if @mapdetails!=value
      @mapdetails=value
      refresh
    end
  end

  def refresh
    self.bitmap.clear
    if @nonests
      imagepos=[[sprintf("Graphics/Pictures/Pokedex/pokedexNestUnknown"),108,172,0,0,-1,-1]]
      pbDrawImagePositions(self.bitmap,imagepos)
    end
    textpos=[
       [@mapname,18,-2,0,Color.new(248,248,248),Color.new(0,0,0)],
       [@maplocation,18,354,0,Color.new(248,248,248),Color.new(0,0,0)],
       [@mapdetails,Graphics.width-16,354,1,Color.new(248,248,248),Color.new(0,0,0)]
    ]
    if @nonests
      textpos.push([_INTL("Area Unknown"),Graphics.width/2,Graphics.height/2-16,2,
         Color.new(88,88,80),Color.new(168,184,184)])
    end
    pbDrawTextPositions(self.bitmap,textpos)
  end
end



class PokemonRegionMapScene
  SQUAREWIDTH  = 16
  SQUAREHEIGHT = 16
  LEFT   = 0
  TOP    = 0
  SCREENRIGHT = 28
  SCREENBOTTOM = 18
  MAPSTARTPOS = {
    0 => [6,13],
    1 => [0,24],
    2 => [0,11],
    3 => [0,0]
  }
  FAKEMAPSTARTPOS = {
    0 => [14,20],
    1 => [14,20],
    2 => [14,20],
    3 => [14,20],
    4 => [23,26],
  }

  def initialize(region=0,wallmap=true,basemap=nil)
    region = 0 if region == -1 #weird overrides. trust me.
    @region=[region]
    @region=[0,1,2,3] if [0,1,2,3].include?(region)
    @wallmap=wallmap
    @defaultRegionName = "Aevium Region"
    @defaultRegionName = "Grand Dream City" if region == 4
    @defaultRegionName = "No Signal" if region == 99
    @basemap = basemap

    @BOTTOM = 18
    @RIGHT = 28
    @MAPWIDTH = Graphics.width
    @MAPHEIGHT = Graphics.height
    if @region.length > 1
      @MAPWIDTH = 576
      @MAPHEIGHT = 704
      @RIGHT  = @MAPWIDTH / SQUAREWIDTH - 2
      @BOTTOM = @MAPHEIGHT / SQUAREHEIGHT - 2
    end
    if @region[0]==4
      @MAPWIDTH = 750
      @MAPHEIGHT = 750
      @RIGHT  = @MAPWIDTH / SQUAREWIDTH - 2
      @BOTTOM = @MAPHEIGHT / SQUAREHEIGHT - 2
    end
  end

  def pbUpdate
    pbUpdateSpriteHash(@sprites)
  end

  def pbStartScene(aseditor=false,mode=0,species=nil,showcursor=true)
    @numpoints=0
    @showcursor = showcursor
    @editor=aseditor
    @viewport=Viewport.new(16,32,@MAPWIDTH,@MAPHEIGHT) #Full map dims
    @viewport.z=99999
    @mapoverlay=Viewport.new(0,0,Graphics.width,Graphics.height)
    @mapoverlay.z=99999
    @sprites={}
    @mapdata=$cache.town_map
    if $cache.mapdata[$game_map.map_id].MapPosition.is_a?(Hash)
      playerpos=pbUnpackMapHash
    else
      playerpos=$cache.mapdata[$game_map.map_id].MapPosition
    end
    if !playerpos
      mapindex=0
      @map=@mapdata[0]
      @mapX=LEFT
      @mapY=TOP
    elsif !@region.include?(playerpos[0])
      mapindex = @region[0]
      mapindex = 2 if @region.length > 1
      @map = @mapdata[mapindex]
      @mapX = FAKEMAPSTARTPOS[mapindex][0]
      @mapY = FAKEMAPSTARTPOS[mapindex][1]
    else
      mapindex=playerpos[0]
      @map=@mapdata[@region[0]]
      @mapX=playerpos[1]
      @mapY=playerpos[2]
    end
    @selection = [@mapX, @mapY]
    
    case mapindex
      when 0 #floria
        @viewport.ox += MAPSTARTPOS[0][0] * SQUAREWIDTH
        @viewport.oy += MAPSTARTPOS[0][1] * SQUAREHEIGHT
      when 1 #terajuma
        @viewport.ox += MAPSTARTPOS[1][0] * SQUAREWIDTH
        @viewport.oy += MAPSTARTPOS[1][1] * SQUAREHEIGHT
      when 2 #terrial
        @viewport.ox += MAPSTARTPOS[2][0] * SQUAREWIDTH
        @viewport.oy += MAPSTARTPOS[2][1] * SQUAREHEIGHT
      when 3 #badlands
        @viewport.ox += MAPSTARTPOS[3][0] * SQUAREWIDTH
        @viewport.oy += MAPSTARTPOS[3][1] * SQUAREHEIGHT
      else
        #do nothing
    end
    
    if @region.length > 1
      @mapX -= MAPSTARTPOS[mapindex][0]
      @mapY -= MAPSTARTPOS[mapindex][1]
    end
    
    if mapindex == 4
      x = (@mapX - SCREENRIGHT/2)
      x = 0 if x < LEFT
      x = @RIGHT - SCREENRIGHT if x > @RIGHT
      y = (@mapY - SCREENBOTTOM/2)
      y = 0 if y < TOP
      y = @BOTTOM - SCREENBOTTOM if y > @BOTTOM
      @viewport.ox += x * SQUAREWIDTH
      @viewport.oy += y * SQUAREHEIGHT
      @mapX -= x
      @mapY -= y
    end

    bg=BitmapWrapper.new(Graphics.width,Graphics.height)
    bg.fill_rect(0,0,Graphics.width,Graphics.height,Color.new(0,0,0))
    bg2 = SpriteWrapper.new(@viewport)
    bg2.bitmap=bg
    @sprites["mapbg"] = bg2
    @sprites["overlay"] = IconSprite.new(0,0,@mapoverlay)
    @sprites["overlay"].setBitmap("Graphics/Pictures/RegionMap/mapoverlay")
    @sprites["overlay"].setBitmap("Graphics/Pictures/Pokedex/pokedexNest") if mode == 2 
    @sprites["overlay"].z = 99999
    if mode == 2 && $game_switches[AdvancedPokedexScene::SWITCH]
      @sprites["advancedOverlay"] = IconSprite.new(0,0,@mapoverlay)
      @sprites["advancedOverlay"].setBitmap("Graphics/Pictures/Pokedex/advancedPokedexNestBar") 
      @sprites["advancedOverlay"].z = 99999
    end
    @sprites["map"]=IconSprite.new(0,0,@viewport)
    @sprites["map"].setBitmap("Graphics/Pictures/RegionMap/#{@map[:filename]}")
    for hidden in REGIONMAPEXTRAS #NOT UPDATED - USE AT RISK
      if hidden[0]==mapindex && ((@wallmap && hidden[5]) ||
         (!@wallmap && hidden[1]>0 && $game_switches[hidden[1]]))
        if !@sprites["map2"]
          @sprites["map2"]=BitmapSprite.new(480,320,@viewport)
          @sprites["map2"].x=@sprites["map"].x; @sprites["map2"].y=@sprites["map"].y
        end
        pbDrawImagePositions(@sprites["map2"].bitmap,[
           ["Graphics/Pictures/RegionMap/#{hidden[4]}",hidden[2]*SQUAREWIDTH,hidden[3]*SQUAREHEIGHT,0,0,-1,-1]
        ])
      end
    end
    @sprites["mapbottom"]=MapBottomSprite.new(@mapoverlay)
    @sprites["mapbottom"].mapname=getRegionName
    @sprites["mapbottom"].maplocation=getMapName
    @sprites["mapbottom"].mapdetails=getPOI
    @sprites["mapbottom"].z=99999
    if playerpos && @region.include?(playerpos[0])
      if mode != 2
        @sprites["player"]=IconSprite.new(0,0,@viewport)
        @sprites["player"].setBitmap(pbPlayerHeadFile($Trainer.trainertype))
        @sprites["player"].x=SQUAREWIDTH * @selection[0]
        @sprites["player"].y=SQUAREHEIGHT * @selection[1]
      end
    end
    for i in 0...RoamingSpecies.length #NOT UPDATED - USE AT RISK
      if $game_switches[RoamingSpecies[i][:switch]] && $PokemonGlobal.roamPosition[i] && !$PokemonGlobal.roamPokemonCaught[i] && RoamingSpecies[i][:roamgraphic]
        positiondata=$cache.mapdata[$PokemonGlobal.roamPosition[i]].MapPosition
        mapsize= $cache.mapdata[$PokemonGlobal.roamPosition[i]].MapSize
        if mapsize && mapsize[0] && mapsize[0]>0
          sqwidth=mapsize[0]
          sqheight=(mapsize[1].length*1.0/mapsize[0]).ceil
          if sqwidth>1
            positiondata[1]+=($game_player.x*sqwidth/$game_map.width).floor
          end
          if sqheight>1
            positiondata[2]+=($game_player.y*sqheight/$game_map.height).floor
          end
        end
        @sprites["roaming#{i}"]=IconSprite.new(0,0,@viewport)
        @sprites["roaming#{i}"].setBitmap(RoamingSpecies[i][:roamgraphic])
        @sprites["roaming#{i}"].x=SQUAREWIDTH/2-@sprites["roaming#{i}"].bitmap.width/2+(positiondata[1]*SQUAREWIDTH)+(Graphics.width-@sprites["map"].bitmap.width)/2
        @sprites["roaming#{i}"].y=SQUAREHEIGHT/2-@sprites["roaming#{i}"].bitmap.height/2+(positiondata[2]*SQUAREHEIGHT)+(Graphics.height-@sprites["map"].bitmap.height)/2
      end
    end
    if mode==1 #fly
      k=0
      for i in LEFT..@RIGHT
        for j in TOP..@BOTTOM
          healspot=getFlySpot([i,j])
          if healspot && $PokemonGlobal.visitedMaps[healspot[0]]
            @sprites["point#{k}"]=AnimatedSprite.create("Graphics/Pictures/RegionMap/mapFly",2,30)
            @sprites["point#{k}"].viewport=@viewport
            @sprites["point#{k}"].x=SQUAREWIDTH * i
            @sprites["point#{k}"].y=SQUAREHEIGHT * j
            @sprites["point#{k}"].play
            k+=1
          end
        end
      end
    end
    if mode==2 #nest
      if species
        mapwidth = @RIGHT
        points={}
        @point=BitmapWrapper.new(PokemonRegionMapScene::SQUAREWIDTH+4,
                                 PokemonRegionMapScene::SQUAREHEIGHT+4)
        @point.fill_rect(0,0,
                         PokemonRegionMapScene::SQUAREWIDTH+4,
                         PokemonRegionMapScene::SQUAREHEIGHT+4,Color.new(255,0,0))
        for mapid in 1...$cache.mapdata.length
          if pbFindEncounter(mapid,species)
            if $cache.mapdata[mapid].MapPosition.is_a?(Hash)
              mappos=pbUnpackMapHash
            else
              mappos=$cache.mapdata[mapid].MapPosition
            end  
            next if mappos.nil?
            if @region.include?(mappos[0])
              points[[mappos[1],mappos[2]]]=true 
              #puts mapid
            end
          end
        end
        i=0
        points.each{|point,value|
          s=SpriteWrapper.new(@viewport)
          #more weird offsets. 
          s.x = point[0] * SQUAREWIDTH + 6
          s.y = point[1] * SQUAREHEIGHT + 6
          s.bitmap = @point
          @sprites["point#{i}"]=s
          i+=1
        }
        @numpoints=i
        @sprites["mapbottom"].mapname=""
        @sprites["mapbottom"].maplocation=""
        @sprites["mapbottom"].mapdetails=_INTL("{1}'s nest",getMonName(species))
        if points.length==0
          @sprites["mapbottom"].nonests=true
        end
      end
    end
    @sprites["cursor"]=AnimatedSprite.create("Graphics/Pictures/RegionMap/mapCursor",2,15)
    @sprites["cursor"].viewport=@viewport
    @sprites["cursor"].play
    @sprites["cursor"].x = SQUAREWIDTH * @selection[0]
    @sprites["cursor"].y = SQUAREHEIGHT * @selection[1]
    @sprites["cursor"].visible = false if mode == 2 && !@showcursor
    #@sprites["cursor"].x=-SQUAREWIDTH/2+(@mapX*SQUAREWIDTH)+(Graphics.width-@sprites["map"].bitmap.width)/2 + 16
    #@sprites["cursor"].y=-SQUAREHEIGHT/2+(@mapY*SQUAREHEIGHT)+(Graphics.height-@sprites["map"].bitmap.height)/2 + 32
    @changed=false
    if mode == 2
      pbUpdate
      return true
    end
    pbFadeInAndShow(@sprites){ pbUpdate }
    return true
  end

  def pbSaveMapData
  end

  def pbEndScene
    pbFadeOutAndHide(@sprites) 
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end

  def endNestScene
    pbDisposeSpriteHash(@sprites)
    @point.dispose
    @viewport.dispose
  end

  def pbChangeMapLocation(x,y)
    return if !@editor
    return "" if !@map[2]
    currentname=""
    currentobj=nil
    for loc in @map[2]
      if loc[0]==x && loc[1]==y
        currentobj=loc
        currentname=loc[2]
        break
      end
    end
    currentname=Kernel.pbMessageFreeText(_INTL("Set the name for this point."),
       currentname,false,256) { pbUpdate }
    if currentname
      if currentobj
        currentobj[2]=currentname
      else
        newobj=[x,y,currentname,""]
        @map[2].push(newobj)
      end
      @changed=true
    end
  end

  def getMapName
    return "" if !$cache.town_map[@selection]
    return "" if !@region.include?($cache.town_map[@selection].region)
    return $cache.town_map[@selection].name
  end

  def getPOI
    return "" if !$cache.town_map[@selection]
    return "" if !@region.include?($cache.town_map[@selection].region)
    return $cache.town_map[@selection].poi
  end

  def getRegionName
    return @defaultRegionName if !$cache.town_map[@selection]
    return @defaultRegionName if !@region.include?($cache.town_map[@selection].region)
    region = $cache.town_map[@selection].region
    return $cache.town_map[region][:name]
  end

  def getFlySpot(pos)
    return nil if !$cache.town_map[pos]
    return nil if $cache.town_map[pos].flyData.empty?
    return nil if !@region.include?($cache.town_map[pos].region)
    ret = $cache.town_map[pos].flyData
    if ret[0] == 21 && $game_variables[:Post12thBadge] > 111 #Oceana Pier Neo
      ret[0] = 134
    end
    if ret[0] == 58 && $game_variables[:Post12thBadge] > 111 #Gearen City Neo
      ret[0] = 19
    end 
    return ret
  end

  def getSubMap(pos)
    return nil if $game_variables[:GDCStory] < 1
    return nil if !$cache.town_map[pos]
    return nil if !$cache.town_map[pos].checkFlag?(:submap)
    return nil if !@region.include?($cache.town_map[pos].region)
    return $cache.town_map[pos].checkFlag?(:submap)
  end

  def pbMapScene(mode=0)
    xOffset=0
    yOffset=0
    newX=0
    newY=0
    moveMap=false
    ox=0
    oy=0
    mapfocus = false
    mapfocus = true if @showcursor
    loop do
      Graphics.update
      Input.update
      if mode == 2
        @numpoints.times {|i|
          @sprites["point#{i}"].opacity=[64,96,128,160,128,96][(Graphics.frame_count/4)%6]
        }
      end
      pbUpdate
      if xOffset!=0 || yOffset!=0
        xOffset+=xOffset>0 ? -4 : (xOffset<0 ? 4 : 0)
        yOffset+=yOffset>0 ? -4 : (yOffset<0 ? 4 : 0)
        @sprites["cursor"].x=newX-xOffset
        @sprites["cursor"].y=newY-yOffset
        if @mapY > SCREENBOTTOM || @mapY < TOP
          @mapY -= oy
          @viewport.oy += (oy * SQUAREWIDTH)
        end
        if @mapX > SCREENRIGHT || @mapX < LEFT
          @mapX -= ox
          @viewport.ox += (ox * SQUAREWIDTH)
        end
        @sprites["mapbottom"].maplocation=getMapName
        @sprites["mapbottom"].mapdetails=getPOI if mode!=2
        @sprites["mapbottom"].mapname=getRegionName if mode!=2
        next
      end
      ox=0
      oy=0
      if mapfocus
        case Input.dir8
          when 1 # lower left
            oy=1 if @selection[1]<@BOTTOM
            ox=-1 if @selection[0]>LEFT
          when 2 # down
            oy=1 if @selection[1]<@BOTTOM
          when 3 # lower right
            oy=1 if @selection[1]<@BOTTOM
            ox=1 if @selection[0]<@RIGHT
          when 4 # left
            ox=-1 if @selection[0]>LEFT
          when 6 # right
            ox=1 if @selection[0]<@RIGHT
          when 7 # upper left
            oy=-1 if @selection[1]>TOP
            ox=-1 if @selection[0]>LEFT
          when 8 # up
            oy=-1 if @selection[1]>TOP
          when 9 # upper right
            oy=-1 if @selection[1]>TOP
            ox=1 if @selection[0]<@RIGHT
        end
      end

      if ox!=0 || oy!=0
        @mapX += ox
        @mapY += oy
        @selection[0] += ox
        @selection[1] += oy
        xOffset=ox*SQUAREWIDTH
        yOffset=oy*SQUAREHEIGHT
        newX=@sprites["cursor"].x+xOffset
        newY=@sprites["cursor"].y+yOffset
      end

      if mode == 2
        if !mapfocus
          if Input.trigger?(Input::LEFT)
            return :LEFT
          elsif Input.trigger?(Input::RIGHT)
            return :RIGHT
          elsif Input.trigger?(Input::UP)
            return :UP
          elsif Input.trigger?(Input::DOWN)
            return :DOWN
          elsif Input.trigger?(Input::B)
            return :BACK
            pbPlayCancelSE()
            pbFadeOutAndHide(@sprites)
          end
        end
        if Input.trigger?(Input::B)
          if @basemap && !mapfocus
            return @basemap
          end
          if !mapfocus 
            break
          end
          mapfocus = false
          @sprites["cursor"].visible = false
          @sprites["mapbottom"].maplocation=""
        elsif Input.trigger?(Input::C)
          submap = getSubMap(@selection) #checking for submaps
          if submap
            return [submap[:mapid],submap[:basemap]]
          end
          mapfocus = true
          @sprites["cursor"].visible = true
          @sprites["mapbottom"].maplocation=getMapName
        elsif Input.triggerex?(:B) && $INTERNAL
          puts "Pos: [#{@mapX}, #{@mapY}]"
          puts "SelPos: #{@selection.inspect}"
          puts "CurPos: [#{@sprites["cursor"].x}, #{@sprites["cursor"].y}]"
        elsif Input.trigger?(Input::PAGEUP) || Input.trigger?(Input::PAGEDOWN)
          if @region.length > 1
            return 4
          else
            return 0
          end
        end
      else
        if Input.trigger?(Input::B)
          if @basemap
            return @basemap
          else
            if @editor && @changed
              if Kernel.pbConfirmMessage(_INTL("Save changes?")) { pbUpdate }
                pbSaveMapData
              end
              if Kernel.pbConfirmMessage(_INTL("Exit from the map?")) { pbUpdate }
                break
              end
            else
              break
            end
          end
        elsif Input.trigger?(Input::C) 
          submap = getSubMap(@selection) #checking for submaps
          if submap
            return [submap[:mapid],submap[:basemap]]
          end
          if mode == 1 # Choosing an area to fly to
            healspot=getFlySpot(@selection)
            if healspot
              if $PokemonGlobal.visitedMaps[healspot[0]] ||
                ($DEBUG && Input.press?(Input::CTRL))
                return healspot
              end
            end
          end
        elsif Input.triggerex?(:B) && $INTERNAL
          puts "Pos: [#{@mapX}, #{@mapY}]"
          puts "SelPos: #{@selection.inspect}"
          puts "CurPos: [#{@sprites["cursor"].x}, #{@sprites["cursor"].y}]"
        elsif Input.trigger?(Input::C) && @editor # Intentionally placed after other C button check
          #pbChangeMapLocation(@mapX,@mapY)
        elsif Input.trigger?(Input::PAGEUP) || Input.trigger?(Input::PAGEDOWN)
          if $game_variables[:GDCStory] > 1
            if @region.length > 1
              return 4
            else
              return 0
            end
          end
        end
      end
    end
    return nil
  end
end



class PokemonRegionMap
  def initialize(scene)
    @scene=scene
  end

  def pbStartFlyScreen
    @scene.pbStartScene(false,1)
    ret=@scene.pbMapScene(1)
    @scene.pbEndScene
    return nil if ret.nil?
    ret = [ret, nil] if ret.is_a?(Integer)
    while ret.length != 3
      @scene=PokemonRegionMapScene.new(ret[0],true,ret[1])
      @scene.pbStartScene(false,1)
      ret=@scene.pbMapScene(1)
      ret = [ret, nil] if ret.is_a?(Integer)
      @scene.pbEndScene
      return ret if ret == nil
    end
    return ret
  end

  def pbStartScreen
    @scene.pbStartScene($DEBUG)
    ret = @scene.pbMapScene
    @scene.pbEndScene
    return if ret == nil
    while !ret.nil?
      ret = [ret, nil] if ret.is_a?(Integer)
      @scene=PokemonRegionMapScene.new(ret[0],true,ret[1])
      @scene.pbStartScene($DEBUG)
      ret = @scene.pbMapScene
      @scene.pbEndScene
    end
  end

  def pbStartNestScene(species)
    @scene.pbStartScene(false,2,species,false)
    ret = @scene.pbMapScene(2)
    @scene.endNestScene
    return if ret == nil
    if ret.is_a?(Symbol)
      case ret
        when :LEFT
          return 4
        when :RIGHT
          return 6
        when :UP
          return 8
        when :DOWN
          return 2
        when :BACK
          return 1 
      end
      return 1
    end
    while !ret.nil?
      ret = [ret, nil] if ret.is_a?(Integer)
      @scene=PokemonRegionMapScene.new(ret[0],true,ret[1])
      @scene.pbStartScene(false,2,species,true)
      ret = @scene.pbMapScene(2)
      @scene.endNestScene
      if ret.is_a?(Symbol)
        case ret
          when :LEFT
            return 4
          when :RIGHT
            return 6
          when :UP
            return 8
          when :DOWN
            return 2
          when :BACK
            return 1 
        end
        return 1
      end
    end
  end
end



def pbShowMap(region=0,wallmap=true,basemap=nil)
  pbFadeOutIn(99999) {         
     scene=PokemonRegionMapScene.new(region,wallmap,basemap)
     screen=PokemonRegionMap.new(scene)
     screen.pbStartScreen
  }
end

# since this is mainly related to the fly map let me just put this here - Fal
def inPast?
  mapid = $game_map.map_id
  while mapid != 0
    mapid = $cache.mapinfos[mapid].parent_id
    return true if mapid == 235
  end
  return false
end