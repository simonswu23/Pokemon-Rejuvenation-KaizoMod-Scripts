def getNGPData
    cprint "Checking for WLL save..."
    $Unidata[:WLL] = findWLLSave()
    cprint "done.\n"
    $Unidata[:BadgeCount] = $Trainer.numbadges if !$Unidata[:BadgeCount]
    $Unidata[:BadgeCount] = $Trainer.numbadges if $Trainer.numbadges > $Unidata[:BadgeCount]
    saveClientData
end

def findWLLSave(path=getSavedGamesFolder)
    return true if $game_switches[:Finished_WLL] || $Unidata[:WLL]
    Dir.each_child(path) {|file|
        next if file === '.' || file == '..'
        next if !file.include?("Where Love Lies")
        newpath = path + "/" + file
        Dir.each_child(newpath) {|wllFile|
            if wllFile.include?(".rxdata")
                return true if checkForCompletion(newpath + "/" + wllFile)
            end
        }
    }
    return false
end

def getSavedGamesFolder
    return ("Save Data") if $Settings && $Settings.portable == 1
    if System.platform[/Windows/]
        savefolder = ENV['USERPROFILE'] + "/Saved Games/"
        Dir.mkdir(savefolder) unless (File.exists?(savefolder))
        return savefolder
    else
        # MKXP makes sure that this folder has been created
        # once it starts. The location differs depending on
        # the operating system:
        # Windows: %APPDATA%
        # Linux: $HOME/.local/share
        # macOS (unsandboxed): $HOME/Library/Application Support
        return System.data_directory
    end
end

def checkForCompletion(file)
    File.open("Scripts/ConversionClasses.rb"){|f| eval(f.read) }
    #file needed to check old classes
    trainer=nil
    framecount=nil
    game_system=nil
    pokemonSystem=nil
    mapid=nil
    switches = []
    variables = []
    File.open(file){|f|
        trainer         =Marshal.load(f)
        framecount      =Marshal.load(f)
        game_system     =Marshal.load(f)
        pokemonSystem   =Marshal.load(f)
        mapid           =Marshal.load(f)
        switches        =Marshal.load(f)
        variables       =Marshal.load(f)
    }
    return false if !trainer.is_a?(PokeBattle_Trainer)
    return false if !framecount.is_a?(Numeric)
    return false if !game_system.is_a?(Game_System)
    return false if !pokemonSystem.is_a?(PokemonSystem)
    return false if !mapid.is_a?(Numeric)
    if switches[88] || variables[7] >= 139
        $game_switches[:Finished_WLL] = true
        return true
    end
    return false
end