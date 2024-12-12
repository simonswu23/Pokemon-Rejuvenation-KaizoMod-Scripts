class PokemonSystem
  attr_accessor :textspeed
  attr_accessor :volume
  attr_accessor :sevolume
  attr_accessor :bagsorttype
  attr_accessor :battlescene
  attr_accessor :battlestyle
  attr_accessor :frame
  attr_accessor :textskin
  attr_accessor :font
  attr_accessor :screensize
  attr_accessor :language
  attr_accessor :border
  attr_accessor :backup
  attr_accessor :maxBackup
  attr_accessor :field_effects_highlights
  attr_accessor :remember_commands
  attr_accessor :photosensitive
  attr_accessor :autosave
  attr_accessor :autorunning
  attr_accessor :bike_and_surf_music
  attr_accessor :streamermode
  attr_accessor :audiotype


  attr_accessor :unrealTimeDiverge
  attr_accessor :unrealTimeClock
  attr_accessor :unrealTimeTimeScale

  attr_accessor :chooseBabyIncense # Gen 9 Mod Baby Incense needed or not
  attr_accessor :itemRestoreGen9 # Gen 9 Mod - Restore items after battle

  def language
    return (!@language) ? 0 : @language
  end

  def textskin
    return (!@textskin) ? 0 : @textskin
  end

  def border
    return (!@border) ? 0 : @border
  end

  def photosensitive
    return (!@photosensitive) ? 0 : @photosensitive
  end

  def remember_commands
    return (!@remember_commands) ? 0 : @remember_commands
  end 

  def field_effects_highlights
    return (!@field_effects_highlights) ? 0 : @field_effects_highlights
  end
  
  def tilemap; return MAPVIEWMODE; end

  def unrealTimeDiverge
    return (!@unrealTimeDiverge) ? 1 : @unrealTimeDiverge
  end

  def unrealTimeClock
    return (!@unrealTimeClock) ? 2 : @unrealTimeClock
  end

  def unrealTimeTimeScale
    return (!@unrealTimeTimeScale) ? 30 : @unrealTimeTimeScale
  end

  def autorunning
    return (!@autorunning) ? 0 : @autorunning
  end

  def bike_and_surf_music
    return (!@bike_and_surf_music) ? 0 : @bike_and_surf_music
  end

  def streamermode
    return (!@streamermode) ? 0 : @streamermode
  end

  def audiotype
    return (!@audiotype) ? 0 : @audiotype
  end
  # Gen 9 Mod Baby Incense needed or not Start
  def chooseBabyIncense
    return (!@chooseBabyIncense) ? 0 : @chooseBabyIncense
  end
  # Gen 9 Mod Baby Incense needed or not End
  # Gen 9 Mod - Restore items after battle. Start
  def itemRestoreGen9
    return (!@itemRestoreGen9) ? 0 : @itemRestoreGen9
  end
  # Gen 9 Mod - Restore items after battle. End
end

class PBMove
  attr_reader(:id)       # just to make sure we can convert the move.
end

class PokeBattle_Pokemon
  def form=(value)
    @form=value
  end
end

TPSPECIES   = 0
TPLEVEL     = 1
TPITEM      = 2
TPMOVE1     = 3
TPMOVE2     = 4
TPMOVE3     = 5
TPMOVE4     = 6
TPABILITY   = 7
TPGENDER    = 8
TPFORM      = 9
TPSHINY     = 10
TPNATURE    = 11
TPIV        = 12
TPHAPPINESS = 13
TPNAME      = 14
TPSHADOW    = 15
TPBALL      = 16
TPHIDDENPOWER = 17
TPHPEV        = 18
TPATKEV       = 19
TPDEFEV       = 20
TPSPEEV       = 21
TPSPAEV       = 22
TPSPDEV       = 23
TPDEFAULTS = [0,10,0,0,0,0,0,nil,nil,0,false,:HARDY,10,70,nil,false,0,17,0,0,0,0,0,0]

MetadataOutdoor             = 1
MetadataShowArea            = 2
MetadataBicycle             = 3
MetadataBicycleAlways       = 4
MetadataHealingSpot         = 5
MetadataWeather             = 6
MetadataMapPosition         = 7
MetadataDiveMap             = 8
MetadataDarkMap             = 9
MetadataSafariMap           = 10
MetadataSnapEdges           = 11
MetadataDungeon             = 12
MetadataBattleBack          = 13
MetadataMapWildBattleBGM    = 14
MetadataMapTrainerBattleBGM = 15
MetadataMapWildVictoryME    = 16
MetadataMapTrainerVictoryME = 17
MetadataMapSize             = 18

ITEMID        = 0
ITEMNAME      = 1
ITEMPOCKET    = 2
ITEMPRICE     = 3
ITEMDESC      = 4
ITEMUSE       = 5
ITEMBATTLEUSE = 6
ITEMTYPE      = 7
ITEMMACHINE   = 8