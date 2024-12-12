module PBDebug
  def PBDebug.logonerr
    begin
      yield
    rescue
      PBDebug.log("**Exception: #{$!.message}")
      PBDebug.log("#{$!.backtrace.inspect}")
      #      if $INTERNAL
      pbPrintException($!)
      #      end
      PBDebug.flush
    end
  end

  @@log = []
  @@foldername = RTP.getSaveFolder + "Battle Logs/"
  @@filename = ""
  @@maxlogs = 5

  def PBDebug.flush
    # if $DEBUG && $INTERNAL && @@log.length>0
    if $INTERNAL && @@log.length > 0
      File.open(@@filename, "a+b") { |f|
        f.write("#{@@log}")
      }
    end
    @@log.clear
  end

  def PBDebug.log(msg)
    # DEBUG LOGS AUTOMATIC FOR TESTING ONLY, switch which of the next two are commented to change what is being done
    # if $DEBUG && $INTERNAL
    Dir.mkdir(@@foldername) unless (File.exists?(@@foldername))
    begin
      if File.exist?(@@filename) && File.size(@@filename) > 10_000_000
        File.delete(@@filename)
      end
      if $INTERNAL
        File.open(@@filename, "a+b") { |f|
          f.write("#{msg}\r\n")
        } if @@filename != ""
      end
    rescue
      $INTERNAL = false
    end
  end

  def PBDebug.dump(msg)
    if $INTERNAL
      begin
        File.open(@@filename, "a+b") { |f|
          f.write("#{msg}\r\n")
        }
      rescue
        $INTERNAL = false
      end
    end
  end

  def PBDebug.setFileName(name)
    Dir.mkdir(@@foldername) unless (File.exists?(@@foldername))
    @@filename = (name == "") ? "" : @@foldername + "#{name}.txt"
    i = 1
    Dir.glob("#{@@foldername.gsub('\\', '/')}battlelog - *.txt").sort { |a, b|
      File.mtime(b) <=> File.mtime(a)
    }.each do |file|
      i += 1
      File.delete(file) if i > @@maxlogs
    end
  end
end
