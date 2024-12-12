# The SCRIPTS constant is initialized in game's respective Bootstrap.rb file which is loaded before this one.
# Note that ScriptLoader needs to be loaded using Scripts.rxdata. Loading it using preloadScript in mkxp.json breaks F12 reset.
d = Dir.pwd.downcase
if d.include?("/temp/")
   print "Please extract the game before playing it.\n- RebornVerse Team"
   exit
end

SCRIPTS.each do |path|
  begin
    #scripttime = Time.now
    code = File.open('Scripts/' + path + '.rb', 'r') { |f| f.read }
    eval(code, nil, path)
    #scripttimes.append(Time.now-scripttime)
    #scripttimes.append(script[1])
    #scripttimes.append("\n")
  rescue
    #pbPrintException($!)
    e = $!
    btrace = ""
    if e.backtrace
      maxlength = $INTERNAL ? 25 : 10
      e.backtrace[0,maxlength].each do |i|
        btrace = btrace + "#{i}\n"
      end
    end
    message = "Exception: #{e.class}\nMessage: #{e.message}\n#{btrace}"
    errorlog = "errorlog.txt"
    if (Object.const_defined?(:RTP) rescue false)
      errorlog = RTP.getSaveFileName("errorlog.txt")
    end
    errorlogline = errorlog.sub(Dir.pwd + "\\", "").sub(Dir.pwd + "/", "")
    if errorlogline.length > 20
      errorlogline = "\n" + errorlogline
    end
    File.open(errorlog,"ab"){ |f| f.write(message) }
    print("#{message}\nThis exception was logged in #{errorlogline}.\nPress Ctrl+C to copy this message to the clipboard.")
  end
end

# Prevents game from forcibly closing after an error so you can restart using F12.
loop do
  Graphics.update
  Input.update
end
