# Field Catalogue class. Based on xLed's Jukebox Scene class. 
class Scene_FieldNotes
  #-----------------------------------------------------------------------------
  # * Object Initialization
  #     menu_index : command cursor's initial position
  #-----------------------------------------------------------------------------
  def initialize(menu_index = 0)
    @menu_index = menu_index
  end

  def pbFieldsSeen
    hash = deep_copy(checkSeenFields)
    ret = []
    #puts hash
    for i in 1..TOTALFIELDS
      hash.store(i, "???") if !hash[i]
      ret.push(hash[i])
    end
    ret.push("Back")

    return ret
  end
  #-----------------------------------------------------------------------------
  # * Main Processing
  #-----------------------------------------------------------------------------
  def main
    fadein = true
    # Makes the text window
    @sprites={}
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @sprites["background"] = IconSprite.new(0,0)
    @sprites["background"].setBitmap("Graphics/Pictures/navbg")
    @sprites["background"].setBitmap("Graphics/Pictures/navbgFieldNotes") if Desolation
    @sprites["background"].z=255
    @choices= pbFieldsSeen
    @sprites["header"]=Window_UnformattedTextPokemon.newWithSize(_INTL("Field Notes"),
       2,-18,256,64,@viewport)
    @sprites["header"].baseColor=Color.new(248,248,248)
    @sprites["header"].shadowColor=Color.new(0,0,0)
    @sprites["header"].windowskin=nil
    @sprites["command_window"] = Window_CommandPokemonWhiteArrow.new(@choices,324)
    @sprites["command_window"].windowskin=nil
    @sprites["command_window"].baseColor=Color.new(248,248,248)
    @sprites["command_window"].shadowColor=Color.new(0,0,0)
    @sprites["command_window"].index = @menu_index
    @sprites["command_window"].setHW_XYZ(282,324,94,46,256)
    # Execute transition
    Graphics.transition
    # Main loop
    loop do
      # Update game screen
      Graphics.update
      # Update input information
      Input.update
      # Frame update
      update
      # Abort loop if screen is changed
      if $scene != self
        break
      end
    end
    # Prepares for transition
    Graphics.freeze
    # Disposes the windows
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
  #-----------------------------------------------------------------------------
  # * Frame Update
  #-----------------------------------------------------------------------------
  def update
    pbUpdateSpriteHash(@sprites)
    #update command window and the info if it's active
    if @sprites["command_window"].active
      update_command
      return
    end
  end
    
  #-----------------------------------------------------------------------------
  # * Command controls
  #-----------------------------------------------------------------------------
  def update_command
    # If B button was pressed
    if Input.trigger?(Input::B)
      # Switch to map screen
      pbPlayCancelSE()
      $scene = Scene_Pokegear.new
      return
    end
    # If C button was pressed
    if Input.trigger?(Input::C)
      # Branch by command window cursor position
      fieldindex = @sprites["command_window"].index
      if fieldindex != TOTALFIELDS
        if checkSeenFields[fieldindex + 1] != nil
          pbPlayDecisionSE()
          $scene = Scene_FieldNotes_Info.new(@sprites["command_window"].index,fieldindex)
        else
          pbPlayBuzzerSE()
        end
        return
      else
        # Switch to map screen
        pbPlayCancelSE()
        $scene = Scene_Pokegear.new
        return
      end
    end
  end
end

#-----------------------------------------------------------------------------
# * Determines which Fields the trainer has data for
#-----------------------------------------------------------------------------
def checkSeenFields      
  #puts $Unidata[:fieldNotes]  
  fieldSeen = {}
  if Rejuv
    for i in 1...$cache.FEData.keys.length
      fieldSeen.store(i, "#{i}. #{$cache.FEData[fieldIDToSym(i)].name}")
    end
    return fieldSeen
  else
    start = 598 if Reborn
    start = 854 if Desolation
    for i in 1..TOTALFIELDS
      if $game_switches[i+start]
        name = (i).to_s + ". " + $cache.FEData[fieldIDToSym(i)].name
        fieldSeen.store(i, name)
      end
    end
  end
  if $Unidata[:fieldNotes] != nil
    fieldSeen.merge!($Unidata[:fieldNotes])
    if fieldSeen.length > $Unidata[:fieldNotes].length
      $Unidata[:fieldNotes] = fieldSeen
    end
    for i in 1..TOTALFIELDS
      $game_switches[i+start]=$Unidata[:fieldNotes].keys.include?(i)
    end
  end
  return fieldSeen
end

class Window_FieldEffectNotes < Window_AdvancedCommandPokemon
  attr_accessor :notes

  def initialize(notes,width)
    @notes=notes
    super(notes.map {|note| note.text},width)
  end

  def drawCursor(index,rect)
    selarrow=AnimatedBitmap.new("Graphics/Pictures/selarrowwhite")
    if self.index==index
      pbCopyBitmap(self.contents,selarrow.bitmap,rect.x,rect.y)
    end
    return Rect.new(rect.x+24,rect.y,rect.width-24,rect.height)
  end

  def drawItem(index,count,rect)
    pbSetSystemFont(self.contents)
    rect=drawCursor(index,rect)
    if toUnformattedText(@commands[index]).gsub(/\n/,"")==@commands[index]
      # Use faster alternative for unformatted text without line breaks
      pbDrawShadowText(self.contents,rect.x,rect.y,rect.width,rect.height,
         @commands[index],self.baseColor,self.shadowColor)
    else
      chars=getFormattedText(
         self.contents,rect.x,rect.y,rect.width,rect.height,
         @commands[index],rect.height,true,true)
      drawFormattedChars(self.contents,chars)
    end
  end

  def refresh
    @item_max=itemCount()
    dwidth=self.width-self.borderX
    dheight=self.height-self.borderY
    self.contents=pbDoEnsureBitmap(self.contents,dwidth,dheight)
    self.contents.clear
    for i in 0...@item_max
      if i<self.top_item || i>self.top_item+self.page_item_max
        next
      end
      drawItem(i,@item_max,itemRect(i))
      drawCogWheel(i,cogwheelRect(i))
    end
  end

  def cogwheelRect(item)
    note = @notes[item]
    if item<0 || item>=@item_max || item<self.top_item || item>self.top_item+self.page_item_max || note.elaboration == "" && note.cogwheeltext == ""
      return Rect.new(0,0,0,0)
    else
      x = 414
      y = item / @column_max * @row_height - @virtualOy
      return Rect.new(x, y, 40, @row_height)
    end
  end

  def drawCogWheel(item,rect)
    pbSetSystemFont(self.contents)
    note = @notes[item]
    return if note.elaboration == "" && note.cogwheeltext == ""
    if  note.elaboration != "" && note.cogwheeltext == ""
      cogwheel = AnimatedBitmap.new("Graphics/Icons/fieldTabStar")
      pbCopyBitmap(self.contents,cogwheel.bitmap,rect.x,rect.y)
      return
    end
    if note.elaboration != "" && note.cogwheeltext != ""
      text = " <fs=28><b>" + note.cogwheeltext + "</b><icon=fieldTabStarEmpty> "
    else
      text = " <fs=28><b>" + note.cogwheeltext + "</b>"
    end
    chars = getFormattedText(self.contents,rect.x,rect.y-2,rect.width,rect.height, text ,rect.height,true,true)
    case chars.length
    when 1,2 then boxtype="fieldTab1"
    when 3,4 then boxtype="fieldTab2"
    when 5,6 then boxtype="fieldTab3"
    else
      boxtype="fieldTab4"
    end
    textbox = AnimatedBitmap.new("Graphics/Icons/#{boxtype}")
    pbCopyBitmap(self.contents,textbox.bitmap,rect.x,rect.y)
    drawFormattedChars(self.contents,chars)
  end
end
  
class Scene_FieldNotes_Info
  attr_accessor :from_index
  #-----------------------------------------------------------------------------
  # * Object Initialization
  #     menu_index : command cursor's initial position
  #-----------------------------------------------------------------------------
  def initialize(fieldeffect,from_index)
    @from_index = from_index
    @menu_index = 0
    @fieldeffectid = fieldeffect + 1
    @fieldeffect = fieldIDToSym(@fieldeffectid)
  end
  #-----------------------------------------------------------------------------
  # * Main Processing
  #-----------------------------------------------------------------------------
  def main
    fadein = true
    @fieldnotes = $cache.FENotes.find_all {|note| note.fieldeffect==@fieldeffectid}
    f = []; @fieldnotes.each {|note| f.push(note.text)}
    @choices= f
    # Makes the text window
    @sprites={}
    @viewport=Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z=99999
    @sprites["fieldbackground"] = IconSprite.new(0,30)
    background=$cache.FEData[@fieldeffectsym].graphic[0]
    background="FlowerGarden4" if @fieldeffectsym==:FLOWERGARDEN
    @sprites["fieldbackground"].setBitmap("Graphics/Battlebacks/battlebg" + background)
    @sprites["fieldbackground"].z=254
    @sprites["fieldbackground"].opacity-=200
    @sprites["background"] = IconSprite.new(0,0)
    @sprites["background"].setBitmap("Graphics/Pictures/fieldapp")
    @sprites["background"].z=255
    @sprites["header"]=Window_UnformattedTextPokemon.newWithSize($cache.FEData[@fieldeffectsym].name,
        2,-18,256,64,@viewport)
    @sprites["header"].baseColor=Color.new(248,248,248)
    @sprites["header"].shadowColor=Color.new(0,0,0)
    @sprites["header"].windowskin=nil
    @sprites["command_window"] = Window_FieldEffectNotes.new(@fieldnotes,Graphics.width-8)
    @sprites["command_window"].windowskin=nil
    @sprites["command_window"].baseColor=Color.new(248,248,248)
    @sprites["command_window"].shadowColor=Color.new(0,0,0)
    @sprites["command_window"].index = @menu_index
    @sprites["command_window"].setHW_XYZ(282,Graphics.width-8,8,46,256)
    # Execute transition
    Graphics.transition
    # Main loop
    loop do
      # Update game screen
      Graphics.update
      # Update input information
      Input.update
      # Frame update
      update
      # Abort loop if screen is changed
      if $scene != self
        break
      end
    end
    # Prepares for transition
    Graphics.freeze
    # Disposes the windows
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
  #-----------------------------------------------------------------------------
  # * Frame Update
  #-----------------------------------------------------------------------------
  def update
    pbUpdateSpriteHash(@sprites)
    #update command window and the info if it's active
    if @sprites["command_window"].active
      update_command
      return
    end
  end
    
  #-----------------------------------------------------------------------------
  # * Command controls
  #-----------------------------------------------------------------------------
  def update_command
    # If B button was pressed
    if Input.trigger?(Input::B)
      # Switch to map screen
      pbPlayCancelSE()
      $scene = Scene_FieldNotes.new(@from_index)
      return
    end
    # If C button was pressed
    if Input.trigger?(Input::C)
      # Branch by command window cursor position
      fieldindex = @sprites["command_window"].index
      if !@fieldnotes[fieldindex].nil? && @choices[fieldindex] != @choices.length && @fieldnotes[fieldindex].elaboration != ""
        Kernel.pbMessage(@fieldnotes[fieldindex].elaboration)
      elsif @choices[fieldindex]==@choices.length
        # Switch to map screen
        $scene = Scene_Pokegear.new
        return
      end
    end
  end

  #-----------------------------------------------------------------------------
  # * Compile all the field effects that should exist
  #-----------------------------------------------------------------------------
end