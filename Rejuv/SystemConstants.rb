GAMETITLE = "Pokemon Rejuvenation"
GAMEFOLDER = "Rejuv"
SAVEFOLDER = "Rejuv"
Reborn = false
Desolation = false
Rejuv = true
Gen = 9
LegacyBattleBond = false
# Gen 9 Mod - Added System Constants for the Mod.
RejuvGen9Mod = true
GEN9MODFOLDER = "Rejuv Gen 9 Mod"
GEN9MODTYPE = "Base"
GEN9MODVERSION = "0.80"
GEN9MODVERSIONHAILSNOW = "0"
# Gen 9 Mod - These constants are required to allow the Hail/Snow integrated mod to work properly.
# Recompile after changing this constant or using a mod that changes it to get the changes applied everywhere.
# On Other Options inside the PC, you can use the inegrated mod to change between the options, this will create a Mod file making the changes, so no need to touch this.
# The integrated mod closes the game to have the mod file apply and then compiles again after opening up, closing up again. Open again and it works.
HAILSNOWMOD = "Hail"
HAILSNOWLOWMOD = "hail"
HAILSNOWNAMEMOD = "Hail"
HAILSNOWCOMPILED = true

LEVELCAPS           = [18,25,30,35,40,45,50,55,60,65,70,75,80,85,85,90,90,100,100]
BADGECOUNT          = 18
STARTINGMAP         = 136
LEFT   = 0
TOP    = 0
RIGHT  = 14
BOTTOM = 18 
SQUAREWIDTH  = 16
SQUAREHEIGHT = 16
#===============================================================================
# * Mon Specific Map Data (for both evos and form encounters)
#===============================================================================

#Evos first
Crabominable = [146,269,338,339,343,344,346,470,471,479,480,481,482,483,485,486,490,491]
#Nosepass, Magnezone...
Magnetic = [183,271]
#Alolan/Galarian evos
Marowak = [14,71,62,85,90,95,102,112,113,155,158,321,357,358,359,360,362,368,396,400,
            401,403,404,408,434]
Weezing = [238,239,256,266,270,271,415,474]
Exeggutor = [26,29,30,63,65,92,120,154,175,191,203,207,208,210,211,225,226,268,295,298,
            299,300,301,302,309,323,324,325,326,327,329,330,331,332,333,334,335,347,348,
            406,409,410,411,412,414,543]
Raichu = []
EastShellos = [201,300]
Deerling = []

#Alolan
Rattata = [55,58,59,91,144,194,209,218,24,82,390,391] #and aMeowth!
Sandshrew = [146,150,165,171,174,178,181,269,479,480,481,482,483,485,486,490,491]
Vulpix = []
Diglett = [97,116,403,404]  
Geodude = [269,289,419,489,569] 
Grimer = [64,66,138]
Cubone = []
# Galarian
MrMime = [75,146,150,165,171,174,178,181,269,470,471,479,480,481,482,483,485,486,490,491]
Darumaka = []
Meowth = [97,238] #gmeowth
Ponyta = [357,358,359,360,368]
Slowpoke = [474]
PonyShowMaps = []
Farfetchd = [201]
Zigzagoon = [12,95]
YamaskEvo = [11,12,489,508]
YamaskSpawn = [12,489,508]
Stunfisk = [201]
Corsola = [584]
# Hisui
Growlithe = [140,523]
Voltorb = [179,181]
Typhlosion = []
Qwilfish = [300]
Sneasel = [521]
Samurott = []
Lilligant = [7,15,30,127,131,202,206,254,273,285,315,419,423,424,425,426,]
Basculin = [395]
Zorua = [107,470]
Braviary = [75,146,150,165,171,174,178,181,269,470,471,479,480,481,482,483,485,486,490,491]
Sliggoo = [600,601,602]
Avalugg = [295]
Decidueye = []
# Aevian
Paras = [64]
Magikarp = [221]
Misdreavus = [201,371]
Shroomish = [357,358,359,360,361,368]
Feebas = [474]
Snorunt = [221,295]
Munna = [57,145] # Mellow mellow Munna!
Sigilyph = [458]
Litwick = [111]
Budew = [373,478,510,515,523,525]
Bronzor = [137,227,357,358,359,360,363,368,494,498,499]
AevShellos = [300,329,540]
Toxtricity = []
Jangmoo = []
Wimpod = [523]
Larvesta = []
Sewaddle = [254]
Mareep = []
Lapras = [109]

#===============================================================================
# * Constants for maps to reflect sprites on
#===============================================================================

ReflectSpritesOn=[
    
]

#===============================================================================
# * Constants for field differences
#===============================================================================

Glitchtypes = [:FAIRY]
CHESSMOVES = [:STRENGTH,:ANCIENTPOWER,:PSYCHIC,:CONTINENTALCRUSH, 
    :SECRETPOWER,:SHATTEREDPSYCHE,:BARRAGE]
STRIKERMOVES = [:STRENGTH, :WOODHAMMER, :DUALCHOP, :HEATCRASH, :SKYDROP, 
    :BULLDOZE, :POUND, :ICICLECRASH, :BODYSLAM, :STOMP, :SLAM, :GIGAIMPACT, :SMACKDOWN, :IRONTAIL, 
    :METEORMASH, :DRAGONRUSH, :CRABHAMMER, :BOUNCE, :HEAVYSLAM, :MAGNITUDE, :EARTHQUAKE, 
    :STOMPINGTANTRUM, :BRUTALSWING, :HIGHHORSEPOWER, :ICEHAMMER, :DRAGONHAMMER, :BLAZEKICK,
    :GRAVAPPLE, :DOUBLEIRONBASH, :HEADLONGRUSH, :CONTINENTALCRUSH]

#===============================================================================
# * Two hashes for Variables and Switch names, in ascending order
#===============================================================================
Switches = {
    Starting_Over:                  1,
    #Gym_1:                          7,
    #Gym_2:                          7,
    #Gym_3:                          7,
    Gym_4:                          7,
    #Gym_5:                          7,
    #Gym_6:                          7,
    #Gym_7:                          7,
    Gym_8:                          11,
    #Gym_9:                          7,
    #Gym_10:                         7,
    #Gym_11:                         7,
    Force_Wild_Shiny:               31,
    No_Money_Loss:                  33,
    AtebitDesire:                   37,
    Aevia:                          95,
    Aevis:                          96,
    VSGraphicOff:                   145,
    Ariana:                         249,
    Axel:                           250,
    No_Catching:                    290,
    Gym_12:                         294,
    #Gym_13:                         7,
    #Gym_14:                         7,
    #Gym_15:                         7,
    Gym_16:                         298,
    #Gym_17:                         7,
    Gym_18:                         300,
    Egg_Trade:                      540,
    Alain:                          586,
    Aero:                           587,
    Field_Notes:                    807,
    Ana:                            991,
    Finished_WLL:                   1062,
    RenegadeRoute:                  1090,
    NameOverwrite:                  1126,
    RiftDex:                        1176,
    CodeFeris:                      1201,
    CodeEvo:                        1202,
    CodeMaterna:                    1203,
    CodeStatia:                     1204,
    CodeSarpa:                      1205,
    CodeCorroso:                    1206,
    CodeBella:                      1207,
    CodeDrifio:                     1209,
    RiftNotes:                      1210,
    CodeAngelus:                    1224,
    NotPlayerCharacter:             1235,
    CodeGarna:                      1285,
    CodeRembrence:                  1286,
    Forced_Daytime:                 1289,
    Forced_Evening:                 1290,
    Forced_Night:                   1291,
    Raid:                           1305,
    Forced_Time_of_Day:             1312,
    PasswordFail:                   1371,
    InterceptorsWish:               1408,
    TM10:                           1460,
    TM47:                           1497,
    TM56:                           1506,
    TM70:                           1520,
    Retain_Surf:					1619,
    FirstUse:                       1643,
    Exp_All_On:                     1646,
    VirtualGirl:                    1647,
    Unreal_Time:                    1667,
    Empty_IVs_And_EVs_Password:     1668,
    Only_Pulse_2:                   1669,
    Full_IVs:                       1670,
    Empty_IVs_Password:             1671,
    Stop_Items_Password:            1672,
    Stop_Ev_Gain:                   1673,
    No_EXP_Gain:                    1674,
    Flat_EV_Password:               1675,
    No_Total_EV_Cap:                1676,
    Moneybags:                      1677,
    Penniless_Mode:                 1678,
    No_Damage_Rolls:                1679,
    Overworld_Poison_Password:      1680,
    Gen_5_Weather:                  1681,
    Offset_Trainer_Levels:          1682,
    Percent_Trainer_Levels:         1683,
    eeveepls:                       1684,
    Free_Remote_PC:                 1691,
    FieldFrenzy:                    1692,
    NoFlyZone:                      1705,
    No_Items_Password:              1766,
}

Variables = {
    PlayerNameBackup:               12,
    KieranName:                     25,
    MultiSwapStorage:               73,
    VirtualLeagueProgress:          79,
    VirtualLeagueStarter:           80,
    BattleResult:                   100,
    DifficultyModes:                200,
    Forced_Field_Effect:            298,
    GDCStory:                       353,
    Z_Cells:                        361,
    Z_Cores:                        362,
    ItsALuckyNumber:                474,
    APPoints:                       526,
    AchievementsCompleted:          535,
    WildMods:                       545,
    Post12thBadge:                  546,
    LabStepLimit:                   595,
    V13Story:                       646,
    EnemyShields:                   704,
    RedEssence:                     705,
    Forced_BaseField:               708,
    PlayerDataBackup:               726,
    Field_Effect_End_Of_Battle:     757,
    Weather_End_Of_Battle:          758,
    AltFieldGraphic:                770,
    DomainShift:                    774,
    LuckMoney:                      789,
    LuckShinies:                    790,
    LuckMoves:                      791,
    VirtualName:                    792,
    SpiritombWisps:                 779,
    Level_Offset_Value:             802,
    Level_Offset_Percent:           803,
    EncounterRateModifier:          805,
}

#===============================================================================
# * Message/Speech Frame location arrays
#===============================================================================
SpeechFrames=[
	"speech hgss 1", # Default: speech hgss 1
    "speech hgss 2",
    "speech hgss 3",
    "speech hgss 4",
    "speech hgss 5",
    "speech hgss 6",
    "speech hgss 7",
    "speech hgss 8",
    "speech hgss 9",
    "speech hgss 10",
    "speech hgss 11",
    "speech hgss 12",
    "speech hgss 13",
    "speech hgss 14",
    "speech hgss 15",
    "speech hgss 16",
    "speech hgss 17",
    "speech hgss 18",
    "speech hgss 19",
    "speech hgss 20",
    "speech hgss 21",
    "speech hgss 29",
    "speech hgss 30",
    "speech hgss 31",
    "speech hgss 32",
    "speech hgss 33",
    "speech hgss 34",
    "speech hgss 35",
    "speech hgss 36",
    "speech hgss 37",
    "speech pl 18"
]

TextFrames=[
	"Graphics/Windowskins/choice 1",
	"Graphics/Windowskins/choice 2",
    "Graphics/Windowskins/choice 3",
    "Graphics/Windowskins/choice 4",
    "Graphics/Windowskins/choice 5",
    "Graphics/Windowskins/choice 6",
    "Graphics/Windowskins/choice 7",
    "Graphics/Windowskins/choice 8",
    "Graphics/Windowskins/choice 9",
    "Graphics/Windowskins/choice 10",
    "Graphics/Windowskins/choice 11",
    "Graphics/Windowskins/choice 12",
    "Graphics/Windowskins/choice 13",
    "Graphics/Windowskins/choice 14",
    "Graphics/Windowskins/choice 15",
    "Graphics/Windowskins/choice 16",
    "Graphics/Windowskins/choice 17",
    "Graphics/Windowskins/choice 18",
    "Graphics/Windowskins/choice 19",
    "Graphics/Windowskins/choice 20",
    "Graphics/Windowskins/choice 21",
    "Graphics/Windowskins/choice 22",
    "Graphics/Windowskins/choice 23",
    "Graphics/Windowskins/choice 24",
    "Graphics/Windowskins/choice 25",
    "Graphics/Windowskins/choice 26",
    "Graphics/Windowskins/choice 27",
    "Graphics/Windowskins/choice 28",
    "Graphics/Windowskins/choice 29",
    "Graphics/Windowskins/choice 30",
    "Graphics/Windowskins/choice 31",
    "Graphics/Windowskins/choice 32",
    "Graphics/Windowskins/choice 33",
    "Graphics/Windowskins/choice 34",
    "Graphics/Windowskins/choice 35",
    "Graphics/Windowskins/choice 36",
    "Graphics/Windowskins/choice 37"
]

VersionStyles=[
	["PokemonEmerald"],#, # Default font style - Power Green/"Pokemon Emerald"
    ["Garufan"],
    ["PKMN RBYGSC"]
	#["Power Red and Blue"],
	#["Power Red and Green"],
	#s["Power Clear"]
]

PickupNormal=[
    :ORANBERRY,
    :GREATBALL,
    :SUPERREPEL,
    :GOURMETTREAT,
    :MOOMOOMILK,
    :MOONBALL,
    :DUSKBALL,
    :HYPERPOTION,
    :MAXREPEL,
    :FULLRESTORE,
    :REVIVE,
    :ETHER,
    :PPUP,
    :HEARTSCALE,
    :ABILITYCAPSULE,
    :HEARTSCALE,
    :BIGNUGGET,
    :SACREDASH
  ]

PickupRare=[
	:NUGGET,
	:STRAWBIC,
	:NUGGET,
	:RARECANDY,
	:BLUEMIC,
	:RARECANDY,
	:BLUEMIC,
	:BIGNUGGET,
	:LEFTOVERS,
	:LUCKYEGG,
	:LEFTOVERS
 ]

 PASSWORD_HASH = {
    #QOL
    "mintyfresh" => 1685, "mintpack" => 1685,
    "freeexpall" => 1686,
    "shinycharm" => 1687, "earlyshiny" => 1687,
    "freemegaz" => 1688,
    "easyhms" => 1689, "nohms" => 1689, "hmitems" => 1689, "notmxneeded" => 1689,
    "powerpack" => 1690,
    "earlyincu" => 1776,
    "freeremotepc" => :Free_Remote_PC,
    "nopoisondam" => :Overworld_Poison_Password, "antidote" => :Overworld_Poison_Password,
    "nodamageroll" => :No_Damage_Rolls, "norolls" => :No_Damage_Rolls, "rolls" => :No_Damage_Rolls,
    "pinata" => 1693,
 
    # Difficulty passwords
    "litemode" => :Empty_IVs_And_EVs_Password, "noevs" => :Empty_IVs_And_EVs_Password, "emptyevs" => :Empty_IVs_And_EVs_Password,
    "nopenny" => :Penniless_Mode,
    "fullevs" => :Only_Pulse_2,
    "noitems" => :No_Items_Password,
    #"nuzlocke" => :Nuzlocke_Mode, "locke" => :Nuzlocke_Mode, "permadeath" => :Nuzlocke_Mode,
    "moneybags" => :Moneybags, "richboy" => :Moneybags, "doublemoney" => :Moneybags,
    "fullivs" => :Full_IVs, "31ivs" => :Full_IVs, "allivs" => :Full_IVs, "mischievous" => :Full_IVs,
    "emptyivs" => :Empty_IVs_Password, "0ivs" => :Empty_IVs_Password, "noivs" => :Empty_IVs_Password,
    "leveloffset" => :Offset_Trainer_Levels, "setlevel" => :Offset_Trainer_Levels, "flatlevel" => :Offset_Trainer_Levels,
    "percentlevel" => :Percent_Trainer_Levels, "levelpercent" => :Percent_Trainer_Levels,
    "stopitems" => :Stop_Items_Password,
    "stopgains" => :Stop_Ev_Gain,
    "noexp" => :No_EXP_Gain, "zeroexp" => :No_EXP_Gain, "0EXP" => :No_EXP_Gain,
    "flatevs" => :Flat_EV_Password, "85evs" => :Flat_EV_Password,
    "noevcap" => :No_Total_EV_Cap, "gen2mode" => :No_Total_EV_Cap,
 
    # Shenanigans
    "gen5weather" => :Gen_5_Weather,
    "unrealtime" => :Unreal_Time,
    "eeveepls" => :eeveepls,
    "fieldfrenzy" => :FieldFrenzy, "morefield" => :FieldFrenzy,
    "nointro" => 1370, "skipintro" => 1370,
    "9494" => 1706, 
    "terajuma" => 1708,
    "hello eizen." => 1763,
 }

 BULK_PASSWORDS = {
    "casspack" => ["noitems", "fullivs", "easyhms", "norolls"], "goodtaste" => ["noitems", "fullivs", "easyhms", "norolls"],
    "easymode" => ["fullivs", "moneybags", "litemode", "stopitems"],
    "hardmode" => ["noitems", "nopenny", "fullevs", "emptyivs"],
    "qol"      => ["easyhms", "nopoisondam", "freeexpall","earlyincu", "pinata","unrealtime","nopoisondam"]
  }