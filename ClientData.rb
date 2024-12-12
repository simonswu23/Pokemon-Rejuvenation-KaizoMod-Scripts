def buildClientData
    $Unidata = {}
    $Unidata[:saveslot] = 1
    pokemonSystem=nil
    lastsavefile = RTP.getSaveFileName("LastSave.dat")
    if File.exists?(lastsavefile)
        $Unidata[:saveslot] = File.open(lastsavefile).first.to_i
    end
    File.delete(RTP.getSaveFileName("latest_save.txt")) if File.exists?(RTP.getSaveFileName("latest_save.txt"))
    $Unidata[:saveslot] = 1 if $Unidata[:saveslot] == 0
    savefile = RTP.getSaveSlotPath($Unidata[:saveslot])
    $Settings=PokemonOptions.new
    saveSettings
    saveClientData
end

def loadClientData
    begin
        File.open(RTP.getSaveFileName("Game.dat")){|f|
            $Unidata = Marshal.load(f)
        }
    rescue 
       print ("Client data is corrupted and will be deleted. Save files will not be affected.") 
       File.delete(RTP.getSaveFileName("Game.dat")) if File.exist?(RTP.getSaveFileName("Game.dat"))
       buildClientData
    end
end

def saveClientData(data=$Unidata)
    save_data(data,RTP.getSaveFileName("Game.dat"))
end

def saveSettings(set=$Settings)
    save_data(set,RTP.getSaveFileName("Settings.dat"))
end

def loadSettings
    begin
        File.open(RTP.getSaveFileName("Settings.dat")){|f|
            $Settings = Marshal.load(f)
        }
    rescue 
       print ("Client settings are corrupted and will be deleted. Save files will not be affected.") 
       File.delete(RTP.getSaveFileName("Settings.dat")) if File.exist?(RTP.getSaveFileName("Game.dat"))
       buildClientData
    end
end

def startup
    #print "start"
    #convertSaveFolder
    System.set_window_title(GAMETITLE)
    buildClientData if !(File.exist?(RTP.getSaveFileName("Game.dat")))
    saveSettings(PokemonOptions.new) if !(File.exist?(RTP.getSaveFileName("Settings.dat")))
    loadClientData
    loadSettings
    pbSetUpSystem
    Dir["./Data/Mods/*.rb"].each {|file| load File.expand_path(file) }
    
end

def makePortable
    Dir.mkdir("Save Data") unless (File.exists?("Save Data"))
    saveClientData
    saveSettings
end

#def getNGPData
    #SEE SUBGAME FOLDER
#end