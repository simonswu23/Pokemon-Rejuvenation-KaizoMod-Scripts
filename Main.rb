class Scene_DebugIntro
  def main
    Graphics.transition(0)
    sscene=PokemonLoadScene.new
    sscreen=PokemonLoad.new(sscene)
    sscreen.pbStartLoadScreen
    Graphics.freeze
  end
end
print "it works??" if $folder || $FOLDER
def pbCallTitle #:nodoc:
  if $DEBUG
    return Scene_DebugIntro.new
  else
    splash = "sp"
    return Scene_Intro.new(['intro1'], splash)
  end
end

def mainFunction #:nodoc:
  if $DEBUG
    pbCriticalCode { mainFunctionDebug }
  else
    mainFunctionDebug
  end
  return 1
end

def mainFunctionDebug #:nodoc:
  begin
    startup
    $game_system        = Game_System.new
    Graphics.update
    Graphics.freeze
    rebornCheckRemoteVersion() if Reborn && $DEBUG != true
    desolationCheckRemoteVersion() if Desolation && $DEBUG != true
    puts (Time.now - $boottime)
    $scene = pbCallTitle
    while $scene != nil
      $scene.main
    end
    Graphics.transition(2)
  rescue Hangup
    pbEmergencySave
    raise
  end
end

def mainFunctionNoGraphics
  $game_system   = Game_System.new
  $game_switches       = Game_Switches.new
  $game_variables      = Game_Variables.new
  $PokemonTemp   = PokemonTemp.new
  $game_temp     = Game_Temp.new
  $game_system   = Game_System.new
  $Trainer=PokeBattle_Trainer.new("deez nutz",5)
  $game_screen         = Game_Screen.new
  $game_player         = Game_Player.new
  $PokemonGlobal       = PokemonGlobalMetadata.new
  $PokemonBag=PokemonBag.new
  $testing = true
  File.open("Scripts/PokeBattle_TestEnvironment.rb"){|f|
    eval(f.read)
  }
  #battle=pbListScreenpop(_INTL("SINGLE TRAINER"),TrainerBattleLister.new(0,false))
  #save_data(battle,"battle") battleTowerRanking dumpbtmons
  battleTowerRanking
end


loop do
  retval=mainFunction
  if retval==0 # failed
    loop do
      Graphics.update
    end
  elsif retval==1 # ended successfully
    break
  end
end

if System.platform[/Windows/] && (defined?(DiscordAPI) && DiscordAPI.is_a?(Class))
  $DiscordRPC.shutdown
end