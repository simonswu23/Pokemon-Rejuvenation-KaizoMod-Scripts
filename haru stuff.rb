
############# 
# Game Window Mover - Haru
#
# SetWindowPos sets the window position based on:
#   l: window object (in C, HWND)
#   i: don't care put it as 0
#   i: x pos int
#   i: y pos int
#   i: width int
#   i: height int
#   p: don't care put it as zero (pointer)
# FindWindowEx gets the game window using GAMETITLE (Defined in SystemConstants.rb for Reborn-Essentials games):
#   l: parent window object
#   l: child window object
#   p: class pointer
#   p: title pointer (pointers are typically packed 'l4' strings for MiniFFI/Win32API)
# AdjustWindowRectEx adjusts given rect bounds so MiniFFI/Win32API doesn't royally screw it up:
#   p: bounds to convert [left, top, right, bottom]
#   l: style long. don't change this unless you know the proper hex values
#   i: does the window have a menu? prolly not, leave as 0
#   p: extended window pointer. why is this not a long? why is the other not a pointer? don't touch it again.
# GetWindowRect gets the current window position"
#   l: window object
#   p: packed string to store data into
#
# (0,0) may not be top left corner depending on the monitor. Sucks.
#############
if Rejuv
  if System.platform[/Windows/]
    SetWindowPos        = Win32API.new 'user32', 'SetWindowPos', ['l','i','i','i','i','i','p'], 'i'
    FindWindowEx        = Win32API.new 'user32', 'FindWindowEx', ['l','l','p','p'], 'i'
    AdjustWindowRectEx  = Win32API.new 'user32', 'AdjustWindowRectEx', ['p','l','i','p'], 'i'
    GetWindowRect       = Win32API.new 'user32', 'GetWindowRect', ['l','p'], 'i'
  end
end

def moveWindow(x=0,y=0,forceNonWindows=false)
  return if $Settings.photosensitive == 1
  if !defined?(SetWindowPos) || forceNonWindows
    $game_screen.start_shake(10,10,10) if $game_screen.shake == 0
    return
  end
  window = FindWindowEx.call(0,0,0,GAMETITLE)

  posStr = [0,0,0,0].pack('l4') #empty
  GetWindowRect.call(window, posStr)
  pos = posStr.unpack('l4')
  #puts pos.inspect

  rect = [0,0,Graphics.width,Graphics.height].pack('l4') #left, top, right, bottom
  style = 0x00CF0000 #WS_OVERLAPPEDWINDOW
  hasMenu = 0 #false
  styleEx = 0x00000200 #WS_EX_CLIENTEDGE
  AdjustWindowRectEx.call(rect, style, hasMenu, styleEx)
  newrect = rect.unpack('l4')
  #puts newrect.inspect
  
  
  SetWindowPos.call(window,0,pos[0]+x,pos[1]+y,newrect[2]-newrect[0]-3,newrect[3]-newrect[1]-3,0)
end

def shakeScreen1
   moveWindow(20,-20)
end
def shakeScreen2
    moveWindow(-20,40)
end
def shakeScreen3
    moveWindow(30,-30)
end
def shakeScreen4
    moveWindow(-30,10)
end
def shakeScreen5
	moveWindow(10,-5)
end
def shakeScreen6
	moveWindow(-10,5)
end
def shakeScreen
  shakeScreen1
  sleep(1.0/5.0)
  shakeScreen2
  sleep(1.0/5.0)
  shakeScreen3
  sleep(1.0/5.0)
  shakeScreen4
  sleep(1.0/5.0)
  shakeScreen5
  sleep(1.0/5.0)
  shakeScreen6
end

def cprint(value) #i didn't want to type out $stdout.print every time lol
  $stdout.print(value)
end

def deep_copy(obj)
    return Marshal.load(Marshal.dump(obj))
end

def toProperCase(str)
  str = str.to_s if str.is_a?(Symbol)
  split = str.split(" ")
  ret = ""
  split.each{|s|
    ret += s[0].upcase + s[1,s.length].downcase
    ret += " " if split.length != 1
  }
  return ret
end

def extractFormProc(data, key) #string of file contents from reading, specific hash proc value
    basefile = ""
	File.open("Scripts/"+GAMEFOLDER+"/montext.rb"){|f|
		basefile = f.read
	}
    basefilearr = basefile.split(/\n/)
    loc1 = data.source_location
    contents = basefilearr
    ret = contents[loc1[1] - 1]
    ret = ret[ret.index("p")..]
    
    return ret.chop if ret[-2..] == "},"

    for line in loc1[1]...contents.length
    line = contents[line].gsub(/\s+/," ")
    ret += "\n#{line}"

    break if checkStringBracketSyntax(ret, key)
    end
    ret.chop! if ret[-1] == ","
    return ret
end

def checkStringBracketSyntax(string, key)
    stack = []
    convert = { "[" => "]", "{" => "}", "(" => ")" }
    for char in 0...string.length
    stack.push(string[char]) if string[char] == "[" || string[char] == "{" || string[char] == "("
    if string[char] == "]" || string[char] == "}" || string[char] == ")"
        if string[char] != convert[stack.last]
            raise "#{key} syntax error, check your code"
            break
        end
        stack.pop
    end
    end
    return stack.empty?
end

class TrueClass
    def to_i
        return 1
    end
end
class FalseClass
    def to_i
        return 0
    end
end

def fieldSymFromGraphic(graphic)
    return :INDOOR if graphic == nil
    $cache.FEData.each{|key,data|
    return key if data.graphic.include?(graphic)
    }
    return :INDOOR
end

def rbgToHSL(red, green, blue)
    red /= 255.0
    green /= 255.0
    blue /= 255.0
    max = [red, green, blue].max
    min = [red, green, blue].min
    hue = (max + min) / 2.0
    sat = (max + min) / 2.0
    light = (max + min) / 2.0

    if(max == min)
    hue = 0
    sat = 0
    else
    d = max - min;
    sat = light >= 0.5 ? d / (2.0 - max - min) : d / (max + min)
    case max
        when red 
        hue = (green - blue) / d + (green < blue ? 6.0 : 0)
        when green 
        hue = (blue - red) / d + 2.0
        when blue 
        hue = (red - green) / d + 4.0
    end
    hue /= 6.0
    end
    return [(hue*360), (sat*100), (light*100)]
end

def hslToRGB(hue, sat, light)
    hue = hue/360.0
    sat = sat/100.0
    light = light/100.0

    red = 0.0
    green = 0.0
    blue = 0.0
    
    if(sat == 0.0)
    red = light.to_f
    green = light.to_f
    blue = light.to_f
    else
    q = light < 0.5 ? light * (1 + sat) : light + sat - light * sat
    p = 2 * light - q
    red = hueToRGB(p, q, hue + 1/3.0)
    green = hueToRGB(p, q, hue)
    blue = hueToRGB(p, q, hue - 1/3.0)
    end

    return [(red * 255), (green * 255), (blue * 255)]
end

def hueToRGB(p, q, t)
    t += 1                                  if(t < 0) 
    t -= 1                                  if(t > 1)
    return (p + (q - p) * 6 * t)            if(t < 1/6.0) 
    return q                                if(t < 1/2.0) 
    return (p + (q - p) * (2/3.0 - t) * 6)  if(t < 2/3.0) 
    return p
end

def checkAbilDescs
  $cache.abil.each{|abil, data|
    puts "#{abil},\n" if data.desc.length > 50
  }
end

def getMonOutput(mon)
    exporttext = ""
    exporttext += "\t\t:name => \"#{mon.name}\",\n"
    exporttext += "\t\t:dexnum => #{mon.dexnum},\n"
    exporttext += "\t\t:Type1 => :#{mon.Type1},\n"
    exporttext += "\t\t:Type2 => :#{mon.Type2},\n" if mon.Type2 && (mon.Type1 != mon.Type2)
    exporttext += "\t\t:BaseStats => #{mon.BaseStats.inspect},\n"
    exporttext += "\t\t:EVs => #{mon.EVs.inspect},\n"
    exporttext += "\t\t:Abilities => #{mon.Abilities},\n"
    exporttext += "\t\t:HiddenAbilities => :#{mon.checkFlag?(:HiddenAbilities)},\n" if mon.checkFlag?(:HiddenAbilities)
    exporttext += "\t\t:GrowthRate => :#{mon.GrowthRate},\n"
    exporttext += "\t\t:GenderRatio => :#{mon.GenderRatio},\n"
    exporttext += "\t\t:BaseEXP => #{mon.BaseEXP},\n"
    exporttext += "\t\t:CatchRate => #{mon.CatchRate},\n"
    exporttext += "\t\t:Happiness => #{mon.Happiness},\n"
    exporttext += "\t\t:EggSteps => #{mon.EggSteps},\n"
    if mon.EggMoves
      exporttext += "\t\t:EggMoves => ["
      for eggmove in mon.EggMoves
        exporttext += ":#{eggmove},"
      end
      exporttext += "],\n"
    end
    if mon.preevo
      exporttext += "\t\t:preevo => {\n"
      exporttext += "\t\t\t:species => :#{mon.preevo[:species]},\n"
      exporttext += "\t\t\t:form => #{mon.preevo[:form]}\n"
      exporttext += "\t\t},\n"
    end
    if mon
      check = 1
      exporttext += "\t\t:Moveset => [\n"
      for move in mon.Moveset
        exporttext += "\t\t\t[#{move[0]},:#{move[1]}]"
        exporttext += ",\n" if check != mon.Moveset.length
        check += 1
      end
      exporttext += "],\n"
    end
    exporttext += "\t\t:compatiblemoves => ["
    for j in mon.compatiblemoves
      next if PBStuff::UNIVERSALTMS.include?(j)
      exporttext += ":#{j},"
    end
    exporttext += "],\n"
    exporttext += "\t\t:moveexceptions => ["
    for j in mon.moveexceptions
      exporttext += ":#{j},"
    end
    exporttext += "],\n"
    if mon.shadowmoves
      exporttext += "\t\t:shadowmoves => ["
      for shadowmove in mon.shadowmoves
        exporttext += ":#{shadowmove},"
      end
      exporttext += "],\n"
    end
    exporttext += "\t\t:Color => \"#{mon.Color.to_s}\",\n"
    exporttext += "\t\t:Habitat => \"#{mon.Habitat.to_s}\",\n" if mon.Habitat 
    exporttext += "\t\t:EggGroups => #{mon.EggGroups},\n"
    exporttext += "\t\t:Height => #{mon.Height},\n"
    exporttext += "\t\t:Weight => #{mon.Weight},\n"
    exporttext += "\t\t:WildItemCommon => :#{mon.checkFlag?(:WildItemCommon)},\n" if mon.checkFlag?(:WildItemCommon)
    exporttext += "\t\t:WildItemUncommon => :#{mon.checkFlag?(:WildItemUncommon)},\n" if mon.checkFlag?(:WildItemUncommon)
    exporttext += "\t\t:WildItemRare => :#{mon.checkFlag?(:WildItemRare)},\n" if mon.checkFlag?(:WildItemRare)
    exporttext += "\t\t:kind => \"#{mon.kind}\",\n"
    exporttext += "\t\t:dexentry => \"#{mon.dexentry}\",\n"
    exporttext += "\t\t:BattlerPlayerY => #{mon.BattlerPlayerY},\n"
    exporttext += "\t\t:BattlerEnemyY => #{mon.BattlerEnemyY},\n"
    exporttext += "\t\t:BattlerAltitude => #{mon.BattlerAltitude},\n"
    if mon.evolutions != nil
      evos = mon.evolutions
      check = 1
      exporttext += "\t\t:evolutions => [\n"
      for evo in evos
        exporttext += "\t\t\t[:#{evo[0].to_s},:#{evo[1].to_s}"
        evomethods = ["Item","ItemMale","ItemFemale","TradeItem","DayHoldItem","NightHoldItem"]
        if evomethods.include?(evo[1].to_s)
          exporttext += ",:#{evo[2].to_s}"
        else
          exporttext += ",#{evo[2].is_a?(Integer) ? "" : ":"}#{evo[2].to_s}" if evo[2]
        end
        exporttext += "],\n" if check != evos.length
        exporttext += "]\n" if check == evos.length
        check += 1
      end
      exporttext += "\t\t]\n"
    end
    exporttext += "\t},\n\n"
    return exporttext
end

def fixtheoops
  $PokemonForms.each{|species, speciesdata|
    next if !$cache.pkmn.keys.include?(species)
    speciesdata.each{|form, formdata|
      next if !form.is_a?(String)
      skip = true
      $cache.pkmn[species].forms.each{|id, name| skip = false if name.include?(form)}
      next if skip
      cacheform = ""
      $cache.pkmn[species].forms.each{|id, name| cacheform = name if name.include?(form)}
      if formdata.dig(:Ability)
        $cache.pkmn[species].formData[cacheform][:Abilities] = formdata.dig(:Ability) 
        $cache.pkmn[species].formData[cacheform][:Abilities] = [formdata.dig(:Ability)] if formdata.dig(:Ability) .is_a?(Symbol)
      end
      $cache.pkmn[species].formData[cacheform][:evolutions] = formdata.dig(:GetEvo) if formdata.dig(:GetEvo)
      $cache.pkmn[species].formData[cacheform][:dexentry] = formdata.dig(:DexEntry) if formdata.dig(:DexEntry)
      $cache.pkmn[species].formData[cacheform][:Moveset] = formdata.dig(:Movelist) if formdata.dig(:Movelist)
      $cache.pkmn[species].formData[cacheform][:WildItemCommon] = formdata.dig(:WildHoldItems)[0] if formdata.dig(:WildHoldItems)
      $cache.pkmn[species].formData[cacheform][:WildItemUncommon] = formdata.dig(:WildHoldItems)[1] if formdata.dig(:WildHoldItems)
      $cache.pkmn[species].formData[cacheform][:WildItemRare] = formdata.dig(:WildHoldItems)[2] if formdata.dig(:WildHoldItems)
    }
  }
  $GamePokemonForms.each{|species, speciesdata|
    next if !$cache.pkmn.keys.include?(species)
    speciesdata.each{|form, formdata|
      next if !form.is_a?(String)
      skip = true
      $cache.pkmn[species].forms.each{|id, name| skip = false if name.include?(form)}
      next if skip
      cacheform = ""
      $cache.pkmn[species].forms.each{|id, name| cacheform = name if name.include?(form)}
      if formdata.dig(:Ability)
        $cache.pkmn[species].formData[cacheform][:Abilities] = formdata.dig(:Ability) 
        $cache.pkmn[species].formData[cacheform][:Abilities] = [formdata.dig(:Ability)] if formdata.dig(:Ability) .is_a?(Symbol)
      end
      $cache.pkmn[species].formData[cacheform][:evolutions] = formdata.dig(:GetEvo) if formdata.dig(:GetEvo)
      $cache.pkmn[species].formData[cacheform][:dexentry] = formdata.dig(:DexEntry) if formdata.dig(:DexEntry)
      $cache.pkmn[species].formData[cacheform][:Moveset] = formdata.dig(:Movelist) if formdata.dig(:Movelist)
      $cache.pkmn[species].formData[cacheform][:WildItemCommon] = formdata.dig(:WildHoldItems)[0] if formdata.dig(:WildHoldItems)
      $cache.pkmn[species].formData[cacheform][:WildItemUncommon] = formdata.dig(:WildHoldItems)[1] if formdata.dig(:WildHoldItems)
      $cache.pkmn[species].formData[cacheform][:WildItemRare] = formdata.dig(:WildHoldItems)[2] if formdata.dig(:WildHoldItems)
    }
  }
  
  monDump
  compileMons
end

def enforceTrainerType
  $cache.trainertypes.each{|sym, data|
    $Trainer.trainertype = sym if data.checkFlag?(:ID) == $Trainer.trainertype
  }
  $Trainer.trainertype = $cache.trainertypes.keys[0] if $Trainer.trainertype.is_a?(Integer)
end

def battlerDimChecker
  for mon in $cache.pkmn.keys
    next if $cache.pkmn[mon].flags[:toobig]
    id = $cache.pkmn.keys.index(mon) + 1
    bitmapFileName=sprintf("Graphics/Battlers/%03d.png",id)
		next if !pbResolveBitmap(bitmapFileName)
    monbitmap = RPG::Cache.load_bitmap(bitmapFileName)
    puts "#{id}: #{mon}" if monbitmap.rect.width != 384
  end
end

def convertMapPos(pos) #REJUV
  return pos if !Rejuv
  return pos if pos[0] == 0 || pos[0] == 1
  return pos if pos[0] == 2 && pos[1] > 15 
  pos[0] += 1
  return pos
end

def convertTownMap
  mapdat = $cache.town_map
  exporttext = "TOWNMAP={\n"
  for i in 0...mapdat.length
    region = mapdat[i]
    exporttext += "#{i} => {\n"
    exporttext += "\t:name => #{region[0].inspect},\n"
    exporttext += "\t:filename => #{region[1].inspect},\n"
    exporttext += "\t:points => {\n"
    if !region[2].nil?
      region[2].each{|arr|
        pos = [i,arr[0],arr[1]]
        pos = convertMapPos(pos) if Rejuv
        exporttext += "\t\t[#{pos[1]},#{pos[2]}] => {\n"
        exporttext += "\t\t\t:name => \"#{arr[2]}\",\n"
        exporttext += "\t\t\t:poi => #{arr[3].nil? ? "nil" : "\"#{arr[3]}\""},\n"
        exporttext += "\t\t\t:flyData => ["
        exporttext += "#{arr[4]},#{arr[5]},#{arr[6]}" if arr[4]
        exporttext += "], #mapid, x, y\n"
        exporttext += "\t\t},\n"
      }
    end
    exporttext += "\t},\n"
    exporttext += "},\n"
  end
  exporttext += "}"

  File.open("Scripts/"+GAMEFOLDER+"/townmap.rb","w"){|f|
    f.write(exporttext)
  }
end


def grayscale(col, method)
  case method
    when :L #luminance
      return (col.red * 0.2989 + col.green * 0.587 + col.blue * 0.114).floor
    when :A #average
      return ([col.red,col.green,col.blue].sum / 3).floor
    when :S #sight
      return (0.2126 * col.red + 0.7152 * col.green + 0.0722 * col.blue).floor
    else
      return col
  end
end

def fonttester(num=22)
  str = "The quick brown fox jumps over the lazy dog."
  Kernel.pbMessage("\\gsc#{str}\n<fn=Garufan><fs=36>stupid</fs></fn> fox.\\egsc")
end

def thegif
  viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
  viewport.z=99999
  spr = Sprite.new()
  spr.bitmap = Bitmap.new(".karma.gif")
  spr.viewport = viewport
  spr.bitmap.play
end

def theogv
  viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
  viewport.z=99999
  spr = Sprite.new()
  Graphics.play_movie("out.ogv")

end

def fixShadowConversion
  File.open("Scripts/"+GAMEFOLDER+"/movetext.rb"){|f| eval(f.read) }
  for mon in $Trainer.party
    next if !mon.isShadow?
    fixShadowconvertMon(mon)
  end
  for box in 0...$PokemonStorage.maxBoxes
    for index in 0...$PokemonStorage[box].length
      mon = $PokemonStorage[box, index]
      next if !mon 
      next if !mon.isShadow?
      fixShadowconvertMon(mon)
    end
  end
  if $PokemonGlobal.daycare[0][0] && $PokemonGlobal.daycare[0][0].isShadow?
    fixShadowconvertMon($PokemonGlobal.daycare[0][0])
  end
  if $PokemonGlobal.daycare[1][0] && $PokemonGlobal.daycare[1][0].isShadow?
    fixShadowconvertMon($PokemonGlobal.daycare[1][0])
  end
  remove_const(:MOVEHASH)
end

def fixShadowConvertMon(mon)
  if mon.shadowmoves
    newShadows = []
    for move in mon.shadowmoves
      if move == 0
        newShadows.push(0)
        next
      end
      for i in MOVEHASH.keys
        if MOVEHASH[i][:ID] == move
          newShadows.push(i)
          break
        end
      end
    end
    mon.shadowmoves = newShadows
  end
end

class Bitmap
  def pixel(x, y)
    return x + (y * self.width)
  end
end

class Color
  def to_i
    return self.alpha.to_i << 24 | self.blue.to_i << 16 | self.green.to_i << 8 | self.red.to_i
  end
end

class Integer
  def to_color
    a = self >> 24
    b = self >> 16 & 0xff
    g = self >> 8 & 0xff
    r = self & 0xff
    return Color.new(r, g, b, a)
  end
end