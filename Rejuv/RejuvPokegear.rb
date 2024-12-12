class Scene_Pokegear
    def setup
        @cmdMap=-1
        @cmdJukebox=-1
        @cmdAchievements=-1
        @cmdRift=-1
        @cmdScent=-1
        @cmdTutor=-1
        @buttons = []
        @buttons[@cmdMap=@buttons.length] = "Map"
        @buttons[@cmdJukebox=@buttons.length] = "Jukebox"
        @buttons[@cmdAchievements=@buttons.length] = "Achievements"
        @buttons[@cmdRift=@buttons.length] = "Rift Dex" if $game_switches[:RiftDex]
        @buttons[@cmdScent=@buttons.length] = "Spice Scent" 
        if $Trainer.tutorlist && ($game_switches[:NotPlayerCharacter] == false ||  $game_switches[:InterceptorsWish] == true)
            @buttons[@cmdTutor=@buttons.length] = "Move Tutor"
        end 
    end

    def checkChoice
        if @cmdMap>=0 && @sprites["command_window"].index==@cmdMap
            pbPlayDecisionSE()
            if $cache.mapdata[$game_map.map_id].MapPosition.is_a?(Hash)
                region = pbUnpackMapHash[0]
            else
                region=$cache.mapdata[$game_map.map_id].MapPosition[0]
            end  
            pbShowMap(region,false)
        end
        if @cmdJukebox>=0 && @sprites["command_window"].index==@cmdJukebox
            pbPlayDecisionSE()
            $scene = Scene_Jukebox.new
        end
        if @cmdAchievements>=0 && @sprites["command_window"].index==@cmdAchievements
            pbPlayDecisionSE()
            scene = PokemonAchievementsScene.new
            screen = PokemonAchievements.new(scene)
            pbFadeOutIn(99999) { 
              screen.pbStartScreen
            }
        end
        if @cmdRift>=0 && @sprites["command_window"].index==@cmdRift
            pbPlayDecisionSE()
            $scene = RiftDexScene.new
        end
        if @cmdScent>=0 && @sprites["command_window"].index==@cmdScent
            pbPlayDecisionSE()
            $scene = Scene_EncounterRate.new
        end
        if ($game_switches[:NotPlayerCharacter] == false ||  $game_switches[:InterceptorsWish] == true)
            if @cmdTutor>=0  && @sprites["command_window"].index==@cmdTutor
                pbPlayDecisionSE()
                pbRelearnMoveTutorScreen
            end
        end
    end

end

    
class Scene_EncounterRate
   
    def initialize(menu_index = 0)
        @menu_index = menu_index
    end
    
    def main
        if !defined?($game_variables[:EncounterRateModifier]) || $game_switches[:FirstUse]!=true
            $game_variables[:EncounterRateModifier]=1
        end
        fadein = true
        @sprites={}
        @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
        @viewport.z=99999
        @sprites["background"] = IconSprite.new(0,0)
        @sprites["background"].setBitmap("Graphics/Pictures/SpiceScentbg")
        @sprites["background"].z=255
      
        Graphics.transition
        params=ChooseNumberParams.new
        params.setRange(0,9999)
        params.setInitialValue($game_variables[:EncounterRateModifier].to_f*100)
        params.setCancelValue($game_variables[:EncounterRateModifier].to_f*100)
        $game_variables[:EncounterRateModifier]=Kernel.pbMessageChooseNumberCentered(params).to_f/100
        $game_switches[:FirstUse]=true
        if defined?($game_map.map_id)
            $PokemonEncounters.setup($game_map.map_id)
        end
        $scene = Scene_Pokegear.new
        Graphics.freeze
        pbDisposeSpriteHash(@sprites)
        @viewport.dispose
    end
end