module RTP
  @rtpPaths = nil

  def self.exists?(filename, extensions = [])
    return false if !filename || filename == ""

    eachPathFor(filename) { |path|
      return true if fileExists?(path)

      for ext in extensions
        return true if fileExists?(path + ext)
      end
    }
    return false
  end

  def self.getImagePath(filename)
    return self.getPath(filename, ["", ".png", ".jpg", ".gif", ".bmp", ".jpeg"])
  end

  def self.getAudioPath(filename)
    return self.getPath(filename, ["", ".mp3", ".wav", ".wma", ".mid", ".ogg", ".midi"])
  end

  def self.getPath(filename, extensions = [])
    return filename if !filename || filename == ""

    eachPathFor(filename) { |path|
      return path if fileExists?(path)

      for ext in extensions
        file = path + ext
        return file if fileExists?(file)
      end
    }
    return filename
  end

  # Gets the absolute RGSS paths for the given file name
  def self.eachPathFor(filename)
    return if !filename

    if filename[/^[A-Za-z]\:[\/\\]/] || filename[/^[\/\\]/]
      # filename is already absolute
      yield filename
    else
      # relative path
      RTP.eachPath { |path|
        if path == "./"
          yield filename
        else
          yield path + filename
        end
      }
    end
  end

  # Gets all RGSS search paths
  def self.eachPath
    # XXX: Use "." instead of Dir.pwd because of problems retrieving files if
    # the current directory contains an accent mark
    yield ".".gsub(/[\/\\]/, "/").gsub(/[\/\\]$/, "") + "/"
  end

  private

  def self.isPortable
    return $joiplay || File.exists?("Save Data/.portable")
  end

  def self.makePortable
    Dir.mkdir("Save Data") unless File.exists?("Save Data")
    File.open("Save Data/.portable", "w").close unless File.exists?("Save Data/.portable")
  end

  def self.makeNonPortable
    File.delete("Save Data/.portable") if File.exists?("Save Data/.portable")
  end

  def self.getSaveFileName(filename)
    return getSaveFolder().gsub(/[\/\\]$/, "") + "/" + filename
  end

  def self.getSaveSlotPath(slot = 1)
    number = (slot == 1 ? "" : "_" + slot.to_s)
    filename = "Game" + number + ".rxdata"
    return getSaveFolder().gsub(/[\/\\]$/, "") + "/" + filename
  end

  def self.getSaveFolder
    if isPortable
      savefolder = "Save Data/"
      Dir.mkdir(savefolder) unless File.exists?(savefolder)
      return savefolder
    elsif System.platform[/Windows/]
      savewrapper = ENV['USERPROFILE'] + "/Saved Games/"
      Dir.mkdir(savewrapper) unless File.exists?(savewrapper)
      if !RejuvGen9Mod
        folder = SAVEFOLDER
      else
        folder = GEN9MODFOLDER
        if GEN9MODTYPE == "Base"
          savefolder = ENV['USERPROFILE'] + "/Saved Games/#{folder}/"
        else
          folder = folder + " - " + GEN9MODTYPE
          savefolder = ENV['USERPROFILE'] + "/Saved Games/#{folder}/"
        end
      end
      savefolder = ENV['USERPROFILE'] + "/Saved Games/#{folder}/"
      Dir.mkdir(savefolder) unless File.exists?(savefolder)
      return savefolder
    else
      # MKXP makes sure that this folder has been created
      # once it starts. The location differs depending on
      # the operating system:
      # Windows: %APPDATA%
      # Linux: $HOME/.local/share
      # macOS (unsandboxed): $HOME/Library/Application Support
      return System.data_directory + "/"
    end
  end
end
