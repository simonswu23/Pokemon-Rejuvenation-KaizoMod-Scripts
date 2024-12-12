class PokemonSaveScene
  def pbStartScreen
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @sprites={}
    totalsec = Graphics.time_passed / 40 + (Process.clock_gettime(Process::CLOCK_MONOTONIC) - Graphics.start_playing).to_i
    hour = totalsec / 60 / 60
    min = totalsec / 60 % 60
    mapname=$game_map.name
    textColor="0070F8,78B8E8"
    loctext=_INTL("<ac><c2=06644bd2>{1}</c2></ac>",mapname)
    loctext+=_INTL("Player<r><c3={1}>{2}</c3><br>",textColor,$Trainer.name)
    loctext+=_ISPRINTF("Time<r><c3={1:s}>{2:02d}:{3:02d}</c3><br>",textColor,hour,min)
    loctext+=_INTL("Badges<r><c3={1}>{2}</c3><br>",textColor,$Trainer.numbadges)
    if $Trainer.pokedex.canViewDex
      loctext+=_INTL("Pokédex<r><c3={1}>{2}/{3}</c3><br>",textColor,$Trainer.pokedex.getOwnedCount,$Trainer.pokedex.getSeenCount)
    end
    if $Unidata[:saveslot]>1
      loctext+=_INTL("Save File:<r><c3={1}>{2}</c3><br>",textColor,$Unidata[:saveslot])
    else
      loctext+=_INTL("Save File:<r><c3={1}>1</c3><br>",textColor)
    end
    @sprites["locwindow"]=Window_AdvancedTextPokemon.new(loctext)
    @sprites["locwindow"].viewport=@viewport
    @sprites["locwindow"].x=0
    @sprites["locwindow"].y=0
    @sprites["locwindow"].width=228 if @sprites["locwindow"].width<228
    @sprites["locwindow"].visible=true
  end
 
  def pbEndScreen
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
end
 
def pbEmergencySave
  oldscene=$scene
  $scene=nil
  Kernel.pbMessage(_INTL("The script is taking too long.  The game will restart."))
  return if !$Trainer
  if safeExists?(RTP.getSaveSlotPath(data[:saveslot]))
    File.open(RTP.getSaveSlotPath(data[:saveslot]),  'rb') {|r|
       File.open(RTP.getSaveSlotPath(data[:saveslot]+".bak"), 'wb') {|w|
          while s = r.read(4096)
            w.write s
          end
       }
    }
  end
#if Kernel.pbConfirmMessage(_INTL("Would you like to save the game?"))
  if pbSave
    Kernel.pbMessage(_INTL("\\se[]The game was saved.\\se[save]\\wtnp[30]"))
  else
    Kernel.pbMessage(_INTL("\\se[]Save failed.\\wtnp[30]"))
  end
#end
  $scene=oldscene
end
 
def pbSave(safesave=false)
  # Handling backups
  if $Settings.backup == 0
    counter = 0
    trainer    = nil
    mapid      = nil
    framecount = 0
    system     = nil

    # Loading current save
    if safeExists?(RTP.getSaveSlotPath($Unidata[:saveslot]))
      File.open(RTP.getSaveSlotPath($Unidata[:saveslot]), 'rb') {|save|
        data = Marshal.load(save)
        trainer    = data[:Trainer]
        framecount = data[:playtime]
        system     = data[:system]
        mapid      = data[:map_id]
      }

      # Figuring out which save number this is
      number = 1
      if trainer.saveNumber
        number += trainer.saveNumber
      end
      if !trainer.backupNames
        trainer.backupNames = []
        $Trainer.backupNames = []
        number = 1
      end

      # Deleting the save that's older that max backup
      if number > $Settings.maxBackup
        for i in 0...(number - $Settings.maxBackup)
          next if !trainer.backupNames[i]
          next if !safeExists?(RTP.getSaveFileName(trainer.backupNames[i]))
          File.delete(RTP.getSaveFileName(trainer.backupNames[i]))
        end
      end

      # Giving the current save a different name
      totalsec = framecount / 40 #Graphics.frame_rate  #Because Turbo exists
      hour = totalsec / 60 / 60
      min = totalsec / 60 % 60
      mapname = pbGetMapNameFromId(mapid)
      mapname.gsub!(/[^0-9A-Za-z ]/, '')
      trainame = trainer.name
      trainame.gsub!(/[^0-9A-Za-z ]/, '')
      savename = "Game" + ($Unidata[:saveslot] == 1 ? "" : "_" + $Unidata[:saveslot].to_s)
      savename += " - #{trainame} - #{number} - #{hour}h #{min}m - #{trainer.numbadges} badges - #{mapname}.rxdata"
      $Trainer.lastSave   = savename
      $Trainer.saveNumber = number
      $Trainer.backupNames.push(savename)
      File.open(RTP.getSaveSlotPath($Unidata[:saveslot]), 'rb') {|oldsave|
        File.open(RTP.getSaveFileName(savename), 'wb') {|backup|
          while line = oldsave.read(4096)
            backup.write line
          end
        }
      }
    end
  end

  #The actual saving handling
  return saveNew
end

def saveNew
  $Trainer.metaID=$PokemonGlobal.playerID
  saveClientData
  if $cache.RXsystem.respond_to?("magic_number")
    $game_system.magic_number = $cache.RXsystem.magic_number
  else
    $game_system.magic_number = $cache.RXsystem.version_id
  end
  $game_system.save_count+=1
  playtime = Graphics.time_passed + 40*(Process.clock_gettime(Process::CLOCK_MONOTONIC) - Graphics.start_playing).to_i #turn into frames
  savehash = {}
  savehash[:Trainer]        = $Trainer
  savehash[:playtime]       = playtime
  savehash[:system]         = $game_system
  savehash[:map_id]         = $game_map.map_id
  savehash[:switches]       = $game_switches
  savehash[:variable]       = $game_variables
  savehash[:self_switches]  = $game_self_switches
  savehash[:game_screen]    = $game_screen
  savehash[:Map]            = $MapFactory.map
  savehash[:position]       = [$game_player.x,$game_player.y]
  savehash[:game_player]    = $game_player
  savehash[:PokemonGlobal]  = $PokemonGlobal
  savehash[:PokemonMap]     = $PokemonMap
  savehash[:PokemonBag]     = $PokemonBag
  savehash[:PokemonStorage] = $PokemonStorage
  #savehash[:Interpreter]    = pbMapInterpreter
  puts savehash[:Trainer]
  begin
    File.open(RTP.getSaveSlotPath($Unidata[:saveslot]), "wb") { |f|
      Marshal.dump(savehash, f)
    }
    
    Graphics.frame_reset
  rescue
    return false
  end
  return true
end

def makeSaveHash
  $Trainer.metaID=$PokemonGlobal.playerID
  playtime = Graphics.time_passed + 40*(Process.clock_gettime(Process::CLOCK_MONOTONIC) - Graphics.start_playing).to_i #turn into frames
  savehash = {}
  savehash[:Trainer]        = Marshal.dump($Trainer)
  savehash[:playtime]       = Marshal.dump(playtime)
  savehash[:system]         = Marshal.dump($game_system)
  savehash[:map_id]         = Marshal.dump($game_map.map_id)
  savehash[:switches]       = Marshal.dump($game_switches)
  savehash[:variable]       = Marshal.dump($game_variables)
  savehash[:self_switches]  = Marshal.dump($game_self_switches)
  savehash[:game_screen]    = Marshal.dump($game_screen)
  #savehash[:MapFactory]      = Marshal.dump($MapFactory)
  savehash[:game_player]    = Marshal.dump($game_player)
  savehash[:PokemonGlobal]  = Marshal.dump($PokemonGlobal)
  savehash[:PokemonMap]     = Marshal.dump($PokemonMap)
  savehash[:PokemonBag]     = Marshal.dump($PokemonBag)
  savehash[:PokemonStorage] = Marshal.dump($PokemonStorage)
  
  return savehash
end

def makeSaveFromHash(hash, name= "Anna's Wish Game")
  # Making the save file name
  if $Unidata[:saveslot]>1
    savename= name + "_"+$Unidata[:saveslot].to_s+".rxdata"
  else
    savename= name + ".rxdata"
  end

  # Saving the hash in a file
  File.open(RTP.getSaveFileName(savename),"wb"){|f|
    f.write(hash[:Trainer])
    f.write(hash[:playtime])
    f.write(hash[:system])
    f.write(Marshal.dump("perry doing jank stuff to fix you save")) #pokemon system no longer needed
    f.write(hash[:map_id])
    f.write(hash[:switches])
    f.write(hash[:variable])
    f.write(hash[:self_switches])
    f.write(hash[:game_screen])
    #f.write(hash[:MapFactory])
    f.write(hash[:game_player])
    f.write(hash[:PokemonGlobal])
    f.write(hash[:PokemonMap])
    f.write(hash[:PokemonBag])
    f.write(hash[:PokemonStorage])
  }
end
 
class PokemonSave
  def initialize(scene)
    @scene=scene
  end
 
  def pbDisplay(text,brief=false)
    @scene.pbDisplay(text,brief)
  end
 
  def pbDisplayPaused(text)
    @scene.pbDisplayPaused(text)
  end
 
  def pbConfirm(text)
    return @scene.pbConfirm(text)
  end
 
  def pbSaveScreen
    ret=false
    @scene.pbStartScreen
    if Kernel.pbConfirmMessage(_INTL("Would you like to save the game?"))
      $PokemonTemp.begunNewGame=false
      if pbSave
        Kernel.pbMessage(_INTL("\\se[]{1} saved the game.\\se[save]\\wtnp[30]",$Trainer.name))
        ret=true
      else
        Kernel.pbMessage(_INTL("\\se[]Save failed.\\wtnp[30]"))
        ret=false
      end
    end
    @scene.pbEndScreen
    return ret
  end
end
