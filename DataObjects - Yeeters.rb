
def dumpDataHashes
  File.open("Scripts/"+GAMEFOLDER+"/PBSpecies.rb"){|f| eval(f.read) }
  File.open("Scripts/"+GAMEFOLDER+"/PBTrainers.rb"){|f| eval(f.read) }
  File.open("Scripts/"+GAMEFOLDER+"/PBAbilities.rb"){|f| eval(f.read) }
  File.open("Scripts/"+GAMEFOLDER+"/PBItems.rb"){|f| eval(f.read) }
  File.open("Scripts/"+GAMEFOLDER+"/PBTypes.rb"){|f| eval(f.read) }
  File.open("Scripts/"+GAMEFOLDER+"/PBMoves.rb"){|f| eval(f.read) }
  itemDump
  moveDump
  encDump
  abilDump
  metaConvert
  trainTypesDump
  monDump
  pbCompileTrainers
  dumpTeams
end

def abilDump
  exporttext = "ABILHASH = {\n"
  for i in 1...234
    exporttext += ":#{getConstantName(PBAbilities,i)} => {\n"
    exporttext += "\t:ID => #{i},\n"
    exporttext += "\t:name => \"#{pbGetMessage(MessageTypes::Abilities,i)}\",\n" #kill this
    exporttext += "\t:desc => \"#{pbGetMessage(MessageTypes::AbilityDescs,i)}\"\n" #kill this
    exporttext += "},\n\n"
  end
  exporttext += "}"
  File.open("Scripts/"+GAMEFOLDER+"/abiltext.rb","w"){|f|
    f.write(exporttext)
  }
end


def metaDump
  metadata = $cache.metadata
  exporttext = "METAHASH = {\n"
  exporttext += ":home => #{metadata[:home].inspect},\n"
  exporttext += ":TrainerVictory => \"#{metadata[:TrainerVictory]}\",\n"
  exporttext += ":WildVictory => \"#{metadata[:WildVictory]}\",\n"
  exporttext += ":TrainerBattle => \"#{metadata[:TrainerBattle]}\",\n"
  exporttext += ":WildBattle => \"#{metadata[:WildBattle]}\",\n"
  exporttext += ":Surf => \"#{metadata[:Surf]}\",\n"
  exporttext += ":LavaSurf => \"#{metadata[:LavaSurf]}\",\n"
  exporttext += ":Bicycle => \"#{metadata[:Bicycle]}\",\n\n"
  for i in 0...$cache.metadata[:Players].length
    player = $cache.metadata[:Players][i]
    exporttext += ":player#{i+1} => {\n"
    exporttext += "\t:tclass => :#{player[:tclass]},\n"
    exporttext += "\t#sprites,\n"
    exporttext += "\t:walk => \"#{player[:walk]}\",\n" if player[:walk] != ""
    exporttext += "\t:run => \"#{player[:run]}\",\n" if player[:run] != ""
    exporttext += "\t:bike => \"#{player[:bike]}\",\n" if player[:bike] != ""
    exporttext += "\t:surf => \"#{player[:surf]}\",\n" if player[:surf] != ""
    exporttext += "\t:dive => \"#{player[:dive]}\",\n" if player[:dive] != ""
    exporttext += "\t:fishing => \"#{player[:fishing]}\",\n" if player[:fishing] != ""
    exporttext += "\t:surffish => \"#{player[:surffish]}\",\n" if player[:surffish] != ""
    exporttext += "},\n\n"
  end
  for i in 1...$cache.mapdata.length
    puts "Dumping map ##{i}"
    map = $cache.mapdata[i]
    if map.nil?
      exporttext += "\##{$cache.mapinfos[i].name}\n"
      exporttext += "#{i} => {}, \n\n"
      next
    end
    exporttext += "\##{$cache.mapinfos[i].name}\n"
    exporttext += "#{i} => { \n"
    exporttext += "\t:HealingSpot => #{map.HealingSpot.inspect},\n" if map.HealingSpot
    exporttext += "\t:MapPosition => #{convertMapPos(map.MapPosition).inspect},\n" if map.MapPosition
    exporttext += "\t:Outdoor => #{map.Outdoor},\n" if map.Outdoor
    exporttext += "\t:ShowArea => #{map.ShowArea},\n" if map.ShowArea
    exporttext += "\t:Bicycle => #{map.Bicycle},\n" if map.Bicycle
    #exporttext += "\t:BicycleAlways => #{map.BicycleAlways},\n" if map.BicycleAlways
    exporttext += "\t:Weather => #{map.Weather},\n" if map.Weather
    exporttext += "\t:DiveMap => #{map.DiveMap},\n" if map.DiveMap
    exporttext += "\t:DarkMap => #{map.DarkMap},\n" if map.DarkMap
    exporttext += "\t:SafariMap => #{map.SafariMap},\n" if map.SafariMap
    exporttext += "\t:SnapEdges => #{map.SnapEdges},\n" if map.SnapEdges
    #exporttext += "\t:Dungeon => #{map.Dungeon},\n" if map.Dungeon
    exporttext += "\t:BattleBack => \"#{map.BattleBack}\",\n" if map.BattleBack
    exporttext += "\t:WildBattleBGM => \"#{map.WildBattleBGM}\",\n" if map.WildBattleBGM
    exporttext += "\t:TrainerBattleBGM => \"#{map.TrainerBattleBGM}\",\n" if map.TrainerBattleBGM
    exporttext += "\t:WildVictoryME => \"#{map.WildVictoryME}\",\n" if map.WildVictoryME
    exporttext += "\t:TrainerVictoryME => \"#{map.TrainerVictoryME}\",\n" if map.TrainerVictoryME
    exporttext += "\t:MapSize => #{map.MapSize},\n" if map.MapSize
    exporttext += "},\n\n"
  end
  exporttext += "}"
  File.open("Scripts/"+GAMEFOLDER+"/metatext.rb","w"){|f|
    f.write(exporttext)
  }
end

def metaConvert
  metadata = $cache.metadata
  exporttext = "METAHASH = {\n"
  exporttext += ":home => #{metadata[0][1].inspect},\n"
  exporttext += ":TrainerVictory => \"#{metadata[0][5]}\",\n"
  exporttext += ":WildVictory => \"#{metadata[0][4]}\",\n"
  exporttext += ":TrainerBattle => \"#{metadata[0][3]}\",\n"
  exporttext += ":WildBattle => \"#{metadata[0][2]}\",\n"
  exporttext += ":Surf => \"#{metadata[0][6]}\",\n"
  exporttext += ":Bicycle => \"#{metadata[0][7]}\",\n\n"
  for i in 8...$cache.metadata[0].length
    exporttext += ":player#{i-7} => {\n"
    exporttext += "\t:tclass => :#{getConstantName(PBTrainers,metadata[0][i][0])},\n"
    exporttext += "\t#sprites,\n"
    exporttext += "\t:walk => \"#{metadata[0][i][1]}\",\n" if metadata[0][i][1] != ""
    exporttext += "\t:run => \"#{metadata[0][i][4]}\",\n" if metadata[0][i][4] != ""
    exporttext += "\t:bike => \"#{metadata[0][i][2]}\",\n" if metadata[0][i][2] != ""
    exporttext += "\t:surf => \"#{metadata[0][i][3]}\",\n" if metadata[0][i][3] != ""
    exporttext += "\t:dive => \"#{metadata[0][i][5]}\",\n" if metadata[0][i][5] != ""
    exporttext += "\t:fishing => \"#{metadata[0][i][6]}\",\n" if metadata[0][i][6] != ""
    exporttext += "\t:surffish => \"#{metadata[0][i][7]}\",\n" if metadata[0][i][7] != ""
    exporttext += "},\n\n"
  end
  for i in 1...$cache.metadata.length
    if metadata[i].nil?
      exporttext += "\##{$cache.mapinfos[i].name}\n"
      exporttext += "#{i} => {}, \n\n"
      next
    end
    exporttext += "\##{$cache.mapinfos[i].name}\n"
    exporttext += "#{i} => { \n"
    exporttext += "\t:HealingSpot => #{metadata[i][MetadataHealingSpot].inspect},\n" if metadata[i][MetadataHealingSpot]
    exporttext += "\t:MapPosition => #{metadata[i][MetadataMapPosition].inspect},\n" if metadata[i][MetadataMapPosition]
    exporttext += "\t:Outdoor => #{metadata[i][MetadataOutdoor]},\n" if metadata[i][MetadataOutdoor]
    exporttext += "\t:ShowArea => #{metadata[i][MetadataShowArea]},\n" if metadata[i][MetadataShowArea]
    exporttext += "\t:Bicycle => #{metadata[i][MetadataBicycle]},\n" if metadata[i][MetadataBicycle]
    exporttext += "\t:BicycleAlways => #{metadata[i][MetadataBicycleAlways]},\n" if metadata[i][MetadataBicycleAlways]
    exporttext += "\t:Weather => #{metadata[i][MetadataWeather]},\n" if metadata[i][MetadataWeather]
    exporttext += "\t:DiveMap => #{metadata[i][MetadataDiveMap]},\n" if metadata[i][MetadataDiveMap]
    exporttext += "\t:DarkMap => #{metadata[i][MetadataDarkMap]},\n" if metadata[i][MetadataDarkMap]
    exporttext += "\t:SafariMap => #{metadata[i][MetadataSafariMap]},\n" if metadata[i][MetadataSafariMap]
    exporttext += "\t:SnapEdges => #{metadata[i][MetadataSnapEdges]},\n" if metadata[i][MetadataSnapEdges]
    exporttext += "\t:Dungeon => #{metadata[i][MetadataDungeon]},\n" if metadata[i][MetadataDungeon]
    exporttext += "\t:BattleBack => \"#{metadata[i][MetadataBattleBack]}\",\n" if metadata[i][MetadataBattleBack]
    exporttext += "\t:WildBattleBGM => \"#{metadata[i][MetadataMapWildBattleBGM]}\",\n" if metadata[i][MetadataMapWildBattleBGM]
    exporttext += "\t:TrainerBattleBGM => \"#{metadata[i][MetadataMapTrainerBattleBGM]}\",\n" if metadata[i][MetadataMapTrainerBattleBGM]
    exporttext += "\t:WildVictoryME => \"#{metadata[i][MetadataMapWildVictoryME]}\",\n" if metadata[i][MetadataMapWildVictoryME]
    exporttext += "\t:TrainerVictoryME => \"#{metadata[i][MetadataMapTrainerVictoryME]}\",\n" if metadata[i][MetadataMapTrainerVictoryME]
    exporttext += "\t:MapSize => #{metadata[i][MetadataMapSize]},\n" if metadata[i][MetadataMapSize]
    exporttext += "},\n\n"
  end
  exporttext += "}"
  File.open("Scripts/"+GAMEFOLDER+"/metatext.rb","w"){|f|
    f.write(exporttext)
  }
end

def trainTypesDump
  exporttext = "TTYPEHASH = {\n"
  for ttype in $cache.trainertypes
    next if !ttype || ttype.empty?
    exporttext += ":#{getConstantName(PBTrainers,ttype[0])} => {\n"
    exporttext += "\t:ID => #{ttype[0]},\n"
    exporttext += "\t:title => \"#{ttype[2]}\",\n"
    exporttext += "\t:skill => #{ttype[8]},\n"
    exporttext += "\t:moneymult => #{ttype[3]},\n" if ttype[3] != 0
    exporttext += "\t:battleBGM => \"#{ttype[4]}\",\n" if ttype[4]
    exporttext += "\t:winBGM => \"#{ttype[5]}\",\n" if ttype[5]
    exporttext += "},\n\n"
  end
  exporttext += "}"
  File.open("Scripts/"+GAMEFOLDER+"/ttypetext.rb","w"){|f|
    f.write(exporttext)
  }
end

def itemDump
  exclusions = (21..27).to_a + (454..464).to_a + (493..496).to_a + [50,513]
  overworld = (1..11).to_a + [49, 690]
  evoitem = (12..20).to_a + (202..211).to_a + [692,520,580,572,193,194,109,110,105,808,809,810,811]
  utilityhold = (75..79).to_a + (120..126).to_a + [873, 70]
  battlehold = (80..94).to_a + (100..108).to_a - [105] + (111..119).to_a + [ 68, 71,543, 573, 693, 648,74, 67, 69,849, 852]
  consumehold = (95..99).to_a + (774..777).to_a + [114, 579, 850, 66, 72, 73, 560, 576,818, 819, 851]
  incense = (127..135).to_a
  typehold = (136..152).to_a
  plate = (153..168).to_a + [570]
  memory = (694..710).to_a
  gem = (169..185).to_a + [660]
  questitem = [ 40, 50,59, 60, 61, 62, 65, 592, 594, 595, 597, 598, 604,607, 611, 614]
  application = (669..682).to_a
  fossil = (28..36).to_a + [ 556, 574, 814, 815, 816, 817]
  nectar = (713..716).to_a
  justsell = (37..58).to_a - [40,49,50] + [ 63, 64, 212, 213, 214, 215, 216, 846]
  pokehold = (186..191).to_a
  legendhold = (195..201).to_a + [192,812,813]
  healing =  [ 217, 218, 219, 612, 220, 221, 234, 237, 238, 239, 711, 240, 857, 241, 242, 533, 523, 524, 605, 236, 593]
  revival = [ 532, 232, 233, 244, 222]
  status = [ 228, 243, 235, 229, 230, 231, 561, 691, 223, 224, 225, 226, 227, 527, 528, 529, 530, 531]
  pprestore = [ 245, 246, 247, 248]
  levelup = [ 526, 820, 821, 822, 823, 824, 263, 581]
  evup = (249..262).to_a + (642..647).to_a + [ 865, 863, 806, 848, 872, 861]
  mint = (825..845).to_a
  general = [ 606, 566, 516, 503, 507, 508, 509, 510, 517, 518, 504, 505, 506, 799, 866]
  important = [ 514, 512, 804, 807, 589, 590, 847, 869, 870, 871]
  niche = [ 511, 513, 608, 687, 688, 689]
  story = [ 525, 535, 778, 805, 534, 609, 616, 641, 800, 801, 802, 803, 856, 868]
  sidequest = [ 555, 596, 613, 599, 661, 683, 684, 685, 665, 666, 667, 668, 795, 796, 798]
  keys = [515, 521, 522, 536, 591, 600, 601, 602, 603, 615, 640, 686, 662, 663, 664, 794, 797, 862, 858, 859, 860]
  lakekey = [649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659]
  legendary = [854, 855, 519, 587, 588, 638, 779, 780]
  crest = (823..835).to_a + [861,893,894,1039] + (864..877).to_a + (879..882).to_a + (1025..1035).to_a
  exporttext = "ITEMHASH = {\n"
  for item in $cache.items
    next if item.nil? || item.empty? || (21..27).to_a.include?(item[ITEMID]) || item[ITEMID] == 515 || item[ITEMID] == 560
    begin
      exporttext += ":#{getConstantName(PBItems,item[ITEMID])} => {\n"
    rescue
      next
    end
    exporttext += "\t:ID => #{item[ITEMID]},\n"
    exporttext += "\t:name => \"#{item[ITEMNAME]}\",\n"
    exporttext += "\t:desc => \"#{item[ITEMDESC]}\",\n"
    exporttext += "\t:price => #{item[ITEMPRICE]},\n"
    case item[ITEMPOCKET]
      when 2 then pocket = "\t:medicine => true,\n"
      when 7 then exporttext += "\t:battleitem => true,\n"
    end
    case item[ITEMTYPE]
      when 2 then exporttext += "\t:mail => true,\n"
      when 4 then exporttext += "\t:ball => true,\n"
      when 5 then exporttext += "\t:berry => true,\n"
      when 6 then exporttext += "\t:keyitem => true,\n"
      when 7,8 then exporttext += "\t:crystal => true,\n"
    end
    exporttext += "\t:tm => :#{getConstantName(PBMoves,item[ITEMMACHINE])}\n" if item[ITEMMACHINE] != 0
    if Reborn
      exporttext += "\t:overworld => true,\n" if overworld.include?(item[ITEMID])
      exporttext += "\t:evoitem => true,\n" if evoitem.include?(item[ITEMID])
      exporttext += "\t:utilityhold => true,\n" if utilityhold.include?(item[ITEMID])
      exporttext += "\t:battlehold => true,\n" if battlehold.include?(item[ITEMID])
      exporttext += "\t:consumehold => true,\n" if consumehold.include?(item[ITEMID])
      exporttext += "\t:incense => true,\n" if incense.include?(item[ITEMID])
      exporttext += "\t:typehold => true,\n" if typehold.include?(item[ITEMID])
      exporttext += "\t:plate => true,\n" if plate.include?(item[ITEMID])
      exporttext += "\t:memory => true,\n" if memory.include?(item[ITEMID])
      exporttext += "\t:gem => true,\n" if gem.include?(item[ITEMID])
      exporttext += "\t:questitem => true,\n" if questitem.include?(item[ITEMID])
      exporttext += "\t:application => true,\n" if application.include?(item[ITEMID])
      exporttext += "\t:image => \"application\",\n" if application.include?(item[ITEMID])
      exporttext += "\t:fossil => true,\n" if fossil.include?(item[ITEMID])
      exporttext += "\t:nectar => true,\n" if nectar.include?(item[ITEMID])
      exporttext += "\t:justsell => true,\n" if justsell.include?(item[ITEMID])
      exporttext += "\t:pokehold => true,\n" if pokehold.include?(item[ITEMID])
      exporttext += "\t:legendhold => true,\n" if legendhold.include?(item[ITEMID])
      exporttext += "\t:healing => true,\n" if healing.include?(item[ITEMID])
      exporttext += "\t:revival => true,\n" if revival.include?(item[ITEMID])
      exporttext += "\t:status => true,\n" if status.include?(item[ITEMID])
      exporttext += "\t:pprestore => true,\n" if pprestore.include?(item[ITEMID])
      exporttext += "\t:levelup => true,\n" if levelup.include?(item[ITEMID])
      exporttext += "\t:evup => true,\n" if evup.include?(item[ITEMID])
      exporttext += "\t:mint => true,\n" if mint.include?(item[ITEMID])
      exporttext += "\t:general => true,\n" if general.include?(item[ITEMID])
      exporttext += "\t:important => true,\n" if important.include?(item[ITEMID])
      exporttext += "\t:niche => true,\n" if niche.include?(item[ITEMID])
      exporttext += "\t:story => true,\n" if story.include?(item[ITEMID])
      exporttext += "\t:sidequest => true,\n" if sidequest.include?(item[ITEMID])
      exporttext += "\t:keys => true,\n" if keys.include?(item[ITEMID])
      exporttext += "\t:image => \"key\",\n" if (649..659).to_a.include?(item[ITEMID])
      exporttext += "\t:legendary => true,\n" if legendary.include?(item[ITEMID])
    end
    if Rejuv
      exporttext += "\t:crest => true,\n" if crest.include?(item[ITEMID])
    end
    exporttext += "},\n\n"
  end
  exporttext += "}"
  File.open("Scripts/"+GAMEFOLDER+"/itemtext.rb","w"){|f|
    f.write(exporttext)
  }
end

def itemDumpCurrent
  exclusions, memory, mint, fossil, evup, gem, utilityhold, levelup, nectar, extramegastones, zcrystals, crest, legendhold, application, pokehold, megastones, pprestore, consumehold, keys, story, legendary, questitem, important, incense, plate, evoitem, justsell, niche, overworld, revival, status, general, battlehold, sidequest, healing, resistberries, pinchberries = Array.new(36){[]}
  if Reborn
    exclusions = (21..27).to_a + (454..464).to_a + (493..496).to_a + [50,513]
    memory = (694..710).to_a
    mint = (825..845).to_a
    fossil = (28..36).to_a + [556, 574] + [814, 815, 816, 817]
    evup = (249..262).to_a  + (642..647).to_a + [ 865, 863, 806, 848, 872, 861]
    levelup = [263, 526, 581, 820, 821, 822, 823, 824]
    utilityhold = (75..79).to_a + (120..126).to_a + [70,873]
    gem = (169..185).to_a + [660]
    legendhold = (195..201).to_a + [192,812,813]
    application = (669..682).to_a
    pokehold = (186..191).to_a
    megastones = (537..542).to_a + (544..554).to_a + [557,559,562,564,566,567,568,569,575,577,578] + (617..635).to_a
    pprestore = (245..248).to_a
    consumehold = (95..99).to_a + (774..777).to_a + [114, 579, 850, 66, 72, 73, 560, 576,818, 819, 851]
    keys = [515, 521, 522, 536, 591, 600, 601, 602, 603, 615, 640, 649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659, 686, 662, 663, 664, 794, 797, 862, 858, 859, 860]
    story = [ 525, 535, 778, 805, 534, 609, 616, 641, 800, 801, 802, 803, 856, 868]
    legendary = [854, 855, 519, 587, 588, 638, 779, 780]
    questitem = [ 40, 50,59, 60, 61, 62, 65, 592, 594, 595, 597, 598, 604,607, 611, 614]
    important = [ 514, 512, 804, 807, 589, 590, 847, 869, 870, 871]
    incense = (127..135).to_a
    plate = (153..168).to_a + [570]
    evoitem = (12..20).to_a + (202..211).to_a + [692,520,580,572,193,194,109,110,105,808,809,810,811]
    justsell = (37..58).to_a - [40,49,50] + [ 63, 64, 212, 213, 214, 215, 216, 846]
    niche = [ 511, 513, 608, 687, 688, 689]
    overworld = (1..11).to_a + [49, 690]
    revival = [ 532, 232, 233, 244, 222]
    status = [ 228, 243, 235, 229, 230, 231, 561, 691, 223, 224, 225, 226, 227, 527, 528, 529, 530, 531]
    general = [ 606, 566, 516, 503, 507, 508, 509, 510, 517, 518, 504, 505, 506, 799, 866]
    battlehold = (80..94).to_a + (100..108).to_a - [105] + (111..119).to_a + [ 68, 71,543, 573, 693, 648,74, 67, 69,849, 852]
    sidequest = [ 555, 596, 613, 599, 661, 683, 684, 685, 665, 666, 667, 668, 795, 796, 798]
    healing =  [ 217, 218, 219, 612, 220, 221, 234, 237, 238, 239, 711, 240, 857, 241, 242, 533, 523, 524, 605, 236, 593]
    resistberries = (424..440).to_a + [571]
    pinchberries = (399..403).to_a + (441..450).to_a - [448]
  elsif Rejuv
    exclusions = (21..27).to_a + (493..496).to_a + [50,513,515,560]
    memory = (694..710).to_a
    mint = (917..937).to_a
    fossil =  (28..36).to_a + [556, 574] + [902, 903, 904, 905]
    evup = (249..262).to_a  + (1057..1066).to_a
    utilityhold = (75..79).to_a + (120..126).to_a + [70,1056]
    levelup = (912..916).to_a + [263, 526, 581]
    gem = (169..185).to_a + [660]
    extramegastones = (989..1019).to_a + (537..542).to_a + (544..554).to_a + [557] + [559] + [562] + (564..565).to_a + (568..569).to_a + [575] + (577..578).to_a + [616] + [661] + (781..782).to_a + (805..819).to_a + [1036]
    zcrystals = (718..772).to_a + (842..852).to_a + [1036]
    crest = (823..835).to_a + [861,893,894,1039] + (864..877).to_a + (879..882).to_a + (1025..1035).to_a
    legendhold = (195..201).to_a + [192,900,901]
    pokehold = (186..191).to_a
    pprestore = (245..248).to_a
    consumehold = (95..99).to_a + (774..777).to_a + [114, 579, 909, 66, 72, 73, 560, 576, 906, 907, 910]
    legendary = [519, 522, 523, 1067, 840, 841]
    incense = (127..135).to_a
    plate = (153..168).to_a + [570]
    evoitem = (12..20).to_a + (202..211).to_a + [692,535,580,572,193,194,109,110,105,896,897,898,899]
    justsell = (37..58).to_a - [40,49,50] + [ 63, 64, 212, 213, 214, 215, 216]
    overworld = (1..11).to_a + [49, 690]
    revival = [ 649, 232, 233, 244, 222]
    status = [228, 243, 235, 229, 230, 231, 561, 691, 223, 224, 225, 226, 227]
    battlehold = (80..94).to_a + (100..108).to_a - [105] + (111..119).to_a + [ 68, 71,543, 573, 693, 648,74, 67, 69,908, 911]
    healing =  [ 217, 218, 219, 680, 220, 221, 234, 237, 238, 239, 240, 241, 242, 533, 523, 524, 629, 236, 536]
    resistberries = (424..440).to_a + [571]
    pinchberries = (399..403).to_a + (441..450).to_a - [448]
  elsif Desolation
    exclusions = [49]
    memory = (655..670).to_a
    mint = (781..801).to_a
    fossil = (21..35).to_a
    evup = (251..264).to_a  + (756..762).to_a
    gem = (169..186).to_a
    utilityhold = (74..78).to_a + (119..125).to_a + [69,775]
    levelup = (776..780).to_a + [265, 532, 593]
    nectar = (673..676).to_a
    legendhold = (196..202).to_a + [193,767,768]
    pokehold = (186..191).to_a
    pprestore = (247..250).to_a
    consumehold = (94..98).to_a + (733..736).to_a + [113, 591, 772, 65, 71, 72, 753, 590 ,769, 770, 773]
    legendary = [527, 528, 529, 755, 737, 738]
    incense = (126..134).to_a
    plate = (152..168).to_a
    evoitem = (12..20).to_a + (203..212).to_a + [653,592,588,572,194,195,110,111,106,763,764,765,767]
    justsell = (36..57).to_a - [39,48,49] + [62, 63, 212, 213, 214, 215, 216]
    overworld = (1..11).to_a + [49, 651]
    revival = [234, 235, 246, 224]
    status = [230, 245, 237, 231, 232, 231, 587, 652, 225, 226, 227, 228, 229]
    battlehold = (79..93).to_a + (99..107).to_a - [104] + (110..118).to_a + [ 67, 70, 535, 589, 654, 648, 73, 66, 68, 771, 774]
    healing =  [ 218, 219, 220, 612, 221, 222, 236, 239, 240, 241, 672, 242, 857, 243, 244, 238, 534]
    resistberries = (435..451).to_a + [466]
    pinchberries = (410..414).to_a + (452..460).to_a - [459]
  end
  typeboost = {
    :ELECTRIC => [:ELECTRICGEM,:MAGNET,:ZAPPLATE],
    :NORMAL => [:NORMALGEM,:SILKSCARF,:BLANKPLATE],
    :FIRE => [:FIREGEM,:CHARCOAL,:FLAMEPLATE],
    :WATER => [:WATERGEM,:SPLASHPLATE,:SEAINCENSE,:WAVEINCENSE,:MYSTICWATER],
    :GRASS => [:GRASSGEM,:MIRACLESEED,:MEADOWPLATE,:ROSEINCENSE],
    :FIGHTING => [:FIGHTINGGEM,:FISTPLATE,:BLACKBELT],
    :ROCK => [:ROCKGEM,:ROCKINCENSE,:STONEPLATE,:HARDSTONE],
    :PSYCHIC => [:PSYCHICGEM,:MINDPLATE,:TWISTEDSPOON],
    :GHOST => [:GHOSTGEM,:SPOOKYPLATE,:SPELLTAG],
    :STEEL => [:STEELGEM,:IRONPLATE,:METALCOAT],
    :FLYING => [:FLYINGGEM,:SKYPLATE,:SHARPBEAK],
    :GROUND => [:GROUNDGEM,:EARTHPLATE,:SOFTSAND],
    :DRAGON => [:DRAGONGEM,:DRACOPLATE,:DRAGONFANG],
    :POISON => [:POISONGEM,:TOXICPLATE,:POISONBARB],
    :BUG => [:BUGGEM,:INSECTPLATE,:SILVERPOWDER],
    :FAIRY => [:FAIRYGEM,:FAIRYFEATHER,:PIXIEPLATE],
    :DARK => [:DARKGEM,:DREADPLATE,:BLACKGLASSES],
    :ICE => [:ICEGEM,:ICICLEPLATE,:NEVERMELTICE],
  }
  megadescrip = "Have %s hold it, and this stone will enable it to Mega Evolve during battle."
  exporttext = "ITEMHASH = {\n"
  for i in $cache.items.keys
    item = $cache.items[i]
    next if item.nil? || exclusions.include?(item.checkFlag?(:ID))
    exporttext += ":#{i} => {\n"
    exporttext += "\t:ID => #{item.checkFlag?(:ID)},\n"
    exporttext += "\t:name => \"#{item.name}\",\n"
    exporttext += "\t:desc => \"#{item.desc}\",\n"
    exporttext += "\t:price => #{item.price},\n"
    exporttext += "\t:medicine => true,\n" if item.checkFlag?(:medicine) || (healing.include?(item.checkFlag?(:ID)) || levelup.include?(item.checkFlag?(:ID)) || pprestore.include?(item.checkFlag?(:ID)) || status.include?(item.checkFlag?(:ID)) || mint.include?(item.checkFlag?(:ID)) || evup.include?(item.checkFlag?(:ID)) || revival.include?(item.checkFlag?(:ID)))
    exporttext += "\t:battleitem => true,\n" if item.checkFlag?(:battleitem)
    exporttext += "\t:mail => true,\n" if item.checkFlag?(:mail)
    exporttext += "\t:ball => true,\n" if item.checkFlag?(:ball)
    exporttext += "\t:berry => true,\n" if item.checkFlag?(:berry)
    exporttext += "\t:keyitem => true,\n" if item.checkFlag?(:keyitem)
    exporttext += "\t:crystal => true,\n" if item.checkFlag?(:crystal) || megastones.include?(item.checkFlag?(:ID))
    exporttext += "\t:zcrystal => true,\n" if item.checkFlag?(:zcrystal)
    exporttext += "\t:tm => :#{item.checkFlag?(:tm)},\n" if item.checkFlag?(:tm) != false
    exporttext += "\t:overworld => true,\n" if item.checkFlag?(:overworld) || overworld.include?(item.checkFlag?(:ID))
    exporttext += "\t:evoitem => true,\n" if item.checkFlag?(:evoitem) || evoitem.include?(item.checkFlag?(:ID))
    exporttext += "\t:crest => true,\n" if item.checkFlag?(:crest)
    exporttext += "\t:noUseInBattle => true,\n" if !(ItemHandlers.hasBattleUseOnBattler(i) || ItemHandlers.hasBattleUseOnPokemon(i) || ItemHandlers.hasBattleUseOnPokemon(i))
    exporttext += "\t:noUse => true,\n" if !(ItemHandlers.hasOutHandler(i) || (pbIsTM?(i)))
    exporttext += "\t:utilityhold => true,\n" if item.checkFlag?(:utilityhold)
    exporttext += "\t:battlehold => true,\n" if item.checkFlag?(:battlehold) || battlehold.include?(item.checkFlag?(:ID))
    exporttext += "\t:consumehold => true,\n" if item.checkFlag?(:consumehold) || consumehold.include?(item.checkFlag?(:ID))
    exporttext += "\t:resistberry => true,\n" if item.checkFlag?(:resistberry) || resistberries.include?(item.checkFlag?(:ID))
    exporttext += "\t:pinchberry => true,\n" if item.checkFlag?(:pinchberry) || pinchberries.include?(item.checkFlag?(:ID))
    exporttext += "\t:incense => true,\n" if item.checkFlag?(:incense) || incense.include?(item.checkFlag?(:ID))
    if item.checkFlag?(:typeboost)
      exporttext += "\t:typeboost => \:#{item.checkFlag?(:typeboost)}\,\n"
    else
      typeboost.each_pair { |typeboost,typeboostitems|
        exporttext += "\t:typeboost => \:#{typeboost}\,\n" if typeboostitems.include?(i)
      }
    end
    exporttext += "\t:plate => true,\n" if item.checkFlag?(:plate) || plate.include?(item.checkFlag?(:ID))
    exporttext += "\t:memory => true,\n" if  item.checkFlag?(:memory) || memory.include?(item.checkFlag?(:ID))
    exporttext += "\t:gem => true,\n" if item.checkFlag?(:gem) || gem.include?(item.checkFlag?(:ID))
    exporttext += "\t:questitem => true,\n" if item.checkFlag?(:questitem) || questitem.include?(item.checkFlag?(:ID))
    exporttext += "\t:application => true,\n" if item.checkFlag?(:application) || application.include?(item.checkFlag?(:ID))
    exporttext += "\t:image => \"application\",\n" if item.checkFlag?(:application) || application.include?(item.checkFlag?(:ID))
    exporttext += "\t:fossil => true,\n" if item.checkFlag?(:fossil) || fossil.include?(item.checkFlag?(:ID))
    exporttext += "\t:nectar => true,\n" if item.checkFlag?(:nectar) || nectar.include?(item.checkFlag?(:ID))
    exporttext += "\t:justsell => true,\n" if item.checkFlag?(:justsell) || justsell.include?(item.checkFlag?(:ID))
    exporttext += "\t:pokehold => true,\n" if item.checkFlag?(:pokehold) || pokehold.include?(item.checkFlag?(:ID))
    exporttext += "\t:legendhold => true,\n" if item.checkFlag?(:legendhold) || legendhold.include?(item.checkFlag?(:ID))
    exporttext += "\t:healing => true,\n" if item.checkFlag?(:healing) || healing.include?(item.checkFlag?(:ID))
    exporttext += "\t:revival => true,\n" if item.checkFlag?(:revival) || revival.include?(item.checkFlag?(:ID))
    exporttext += "\t:status => true,\n" if item.checkFlag?(:status) || status.include?(item.checkFlag?(:ID))
    exporttext += "\t:pprestore => true,\n" if item.checkFlag?(:pprestore) || pprestore.include?(item.checkFlag?(:ID))
    exporttext += "\t:levelup => true,\n" if item.checkFlag?(:levelup) || levelup.include?(item.checkFlag?(:ID))
    exporttext += "\t:evup => true,\n" if item.checkFlag?(:evup) || evup.include?(item.checkFlag?(:ID))
    exporttext += "\t:mint => true,\n" if item.checkFlag?(:mint) || mint.include?(item.checkFlag?(:ID))
    exporttext += "\t:general => true,\n" if item.checkFlag?(:general) || general.include?(item.checkFlag?(:ID))
    exporttext += "\t:important => true,\n" if item.checkFlag?(:important) || important.include?(item.checkFlag?(:ID))
    exporttext += "\t:niche => true,\n" if item.checkFlag?(:niche) || niche.include?(item.checkFlag?(:ID))
    exporttext += "\t:story => true,\n" if item.checkFlag?(:story) || story.include?(item.checkFlag?(:ID))
    exporttext += "\t:sidequest => true,\n" if item.checkFlag?(:sidequest) || sidequest.include?(item.checkFlag?(:ID))
    exporttext += "\t:keys => true,\n" if item.checkFlag?(:keys) || keys.include?(item.checkFlag?(:ID))
    exporttext += "\t:image => \"keys\",\n" if item.checkFlag?(:keys) || keys.include?(item.checkFlag?(:ID))
    exporttext += "\t:legendary => true,\n" if item.checkFlag?(:legendary) || legendary.include?(item.checkFlag?(:ID))
    exporttext += "},\n\n"
  end
  exporttext += "}"
  File.open("Scripts/"+GAMEFOLDER+"/itemtext.rb","w"){|f|
    f.write(exporttext)
  }
end

def monDump
  exporttext = "MONHASH = {\n"
  for i in $cache.pkmn.keys
    mon = $cache.pkmn[i]
    $stdout.flush
    cprint "Pokemon line #{i}             \r"
    #print mon.inspect
    exporttext += ":#{i} => {\n"
    if mon.forms.empty?
        exporttext += "\t\"Normal Form\" => {\n"
        exporttext += getMonOutput(mon)
    else
        for form in 0...mon.forms.length
            formthing = ""
            formname = mon.forms[form]
            if formname == "Normal" || formname == "Galarian" || formname == "Alolan" || formname == "PULSE" || formname == "Mega" || formname == "Dev" || formname == "Rift" || formname == "Aevian " || i == :MIMIKYU || i == :PALAFIN || i == :TERAPAGOS # Gen 9 Mod - Added Palafin, Terapagos
                formthing += " Form" if i != :ARCEUS && i != :SILVALLY
            end
            exporttext += "\t\"#{mon.forms[form]}#{formthing}\" => {\n"
            if form == 0
                exporttext += getMonOutput(mon)
                next
            end
            if i == :ARCEUS && Reborn && formname.include?("PULSE")
                exporttext += "\t\t:Weight => 9084,\n\t\t:BaseStats => [255,125,155,125,155,160]\n"
                exporttext += "\t},\n\n"
                next
            end
            exporttext += "\t\t:name => \"#{mon.formData.dig(mon.forms[form],:name)}\",\n" if mon.formData.dig(mon.forms[form],:name)
            exporttext += "\t\t:dexnum => #{mon.formData.dig(mon.forms[form],:dexnum)},\n" if mon.formData.dig(mon.forms[form],:dexnum)
            exporttext += "\t\t:Type1 => :#{mon.formData.dig(mon.forms[form],:Type1)},\n" if mon.formData.dig(mon.forms[form],:Type1)
            exporttext += "\t\t:Type2 => :#{mon.formData.dig(mon.forms[form],:Type2)},\n" if mon.formData.dig(mon.forms[form],:Type2)
            exporttext += "\t\t:BaseStats => #{mon.formData.dig(mon.forms[form],:BaseStats).inspect},\n" if mon.formData.dig(mon.forms[form],:BaseStats)
            exporttext += "\t\t:EVs => #{mon.formData.dig(mon.forms[form],:EVs).inspect},\n" if mon.formData.dig(mon.forms[form],:EVs)
            exporttext += "\t\t:Abilities => #{mon.formData.dig(mon.forms[form],:Abilities)},\n" if mon.formData.dig(mon.forms[form],:Abilities)
            exporttext += "\t\t:HiddenAbilities => :#{mon.formData.dig(mon.forms[form],:HiddenAbilities)},\n" if mon.formData.dig(mon.forms[form],:HiddenAbilities)
            exporttext += "\t\t:GrowthRate => :#{mon.formData.dig(mon.forms[form],:GrowthRate)},\n" if mon.formData.dig(mon.forms[form],:GrowthRate)
            exporttext += "\t\t:GenderRatio => :#{mon.formData.dig(mon.forms[form],:GenderRatio)},\n" if mon.formData.dig(mon.forms[form],:GenderRatio)
            exporttext += "\t\t:BaseEXP => #{mon.formData.dig(mon.forms[form],:BaseEXP)},\n" if mon.formData.dig(mon.forms[form],:BaseEXP)
            exporttext += "\t\t:CatchRate => #{mon.formData.dig(mon.forms[form],:CatchRate)},\n" if mon.formData.dig(mon.forms[form],:CatchRate)
            exporttext += "\t\t:Happiness => #{mon.formData.dig(mon.forms[form],:Happiness)},\n" if mon.formData.dig(mon.forms[form],:Happiness)
            exporttext += "\t\t:EggSteps => #{mon.formData.dig(mon.forms[form],:EggSteps)},\n" if mon.formData.dig(mon.forms[form],:EggSteps)
            if mon.formData.dig(mon.forms[form],:EggMoves)
              exporttext += "\t\t:EggMoves => ["
              for eggmove in mon.formData.dig(mon.forms[form],:EggMoves)
                exporttext += ":#{eggmove},"
              end
              exporttext += "],\n"
            end
            if mon.formData.dig(mon.forms[form],:preevo)
              exporttext += "\t\t:preevo => {\n"
              exporttext += "\t\t\t:species => :#{mon.formData.dig(mon.forms[form],:preevo)[:species]},\n"
              exporttext += "\t\t\t:form => #{mon.formData.dig(mon.forms[form],:preevo)[:form]}\n"
              exporttext += "\t\t},\n"
            end
            if mon.formData.dig(mon.forms[form],:Moveset)
              exporttext += "\t\t:Moveset => [\n"
              for move in mon.formData.dig(mon.forms[form],:Moveset)
                exporttext += "\t\t\t[#{move[0]},:#{move[1]}]"
                exporttext += ",\n"
              end
              exporttext += "\t\t],\n"
            end
            if mon.formData.dig(mon.forms[form],:compatiblemoves)
                exporttext += "\t\t:compatiblemoves => ["
                for j in mon.formData.dig(mon.forms[form],:compatiblemoves)
                    next if PBStuff::UNIVERSALTMS.include?(j)
                    exporttext += ":#{j},"
                end
                exporttext += "],\n"
            end
            if mon.formData.dig(mon.forms[form],:moveexceptions)
                exporttext += "\t\t:moveexceptions => ["
                for j in mon.formData.dig(mon.forms[form],:moveexceptions)
                    exporttext += ":#{j},"
                end
                exporttext += "],\n"
            end
            if mon.formData.dig(mon.forms[form],:shadowmoves)
              exporttext += "\t\t:shadowmoves => ["
              for shadowmove in mon.formData.dig(mon.forms[form],:shadowmoves)
                exporttext += ":#{shadowmove},"
              end
              exporttext += "],\n"
            end
            exporttext += "\t\t:Color => \"#{mon.formData.dig(mon.forms[form],:Color)}\",\n" if mon.formData.dig(mon.forms[form],:Color)
            exporttext += "\t\t:Habitat => \"#{mon.formData.dig(mon.forms[form],:Habitat)}\",\n" if mon.formData.dig(mon.forms[form],:Habitat)
            exporttext += "\t\t:EggGroups => #{mon.formData.dig(mon.forms[form],:EggGroups)},\n" if mon.formData.dig(mon.forms[form],:EggGroups)
            exporttext += "\t\t:Height => #{mon.formData.dig(mon.forms[form],:Height)},\n" if mon.formData.dig(mon.forms[form],:Height)
            exporttext += "\t\t:Weight => #{mon.formData.dig(mon.forms[form],:Weight)},\n" if mon.formData.dig(mon.forms[form],:Weight)
            exporttext += "\t\t:WildItemCommon => :#{mon.formData.dig(mon.forms[form],:WildItemCommon)},\n" if mon.formData.dig(mon.forms[form],:WildItemCommon)
            exporttext += "\t\t:WildItemUncommon => :#{mon.formData.dig(mon.forms[form],:WildItemUncommon)},\n" if mon.formData.dig(mon.forms[form],:WildItemUncommon)
            exporttext += "\t\t:WildItemRare => :#{mon.formData.dig(mon.forms[form],:WildItemRare)},\n" if mon.formData.dig(mon.forms[form],:WildItemRare)
            exporttext += "\t\t:kind => \"#{mon.formData.dig(mon.forms[form],:kind)}\",\n" if mon.formData.dig(mon.forms[form],:kind)
            exporttext += "\t\t:dexentry => \"#{mon.formData.dig(mon.forms[form],:dexentry)}\",\n" if mon.formData.dig(mon.forms[form],:dexentry)
            exporttext += "\t\t:BattlerPlayerY => #{mon.formData.dig(mon.forms[form],:BattlerPlayerY)},\n" if mon.formData.dig(mon.forms[form],:BattlerPlayerY)
            exporttext += "\t\t:BattlerEnemyY => #{mon.formData.dig(mon.forms[form],:BattlerEnemyY)},\n" if mon.formData.dig(mon.forms[form],:BattlerEnemyY)
            exporttext += "\t\t:BattlerAltitude => #{mon.formData.dig(mon.forms[form],:BattlerAltitude)},\n" if mon.formData.dig(mon.forms[form],:BattlerAltitude)
            if mon.formData.dig(mon.forms[form],:evolutions)
              evos = mon.formData.dig(mon.forms[form],:evolutions)
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
        end
        exporttext += "\t:OnCreation => #{mon.formInit},\n" if mon.formInit
    end
    exporttext += "},\n\n"

  end
  exporttext += "}"
  cprint "Successfully dumped Pokemon data        \n"
  File.open("Scripts/"+GAMEFOLDER+"/montext.rb","w"){|f|
    f.write(exporttext)
  }
end

def moveDump
  # updated to work with the new cache set up
  exporttext = "MOVEHASH = {\n"
  for i in $cache.moves.keys
    #next if i == 569
    move = $cache.moves[i]
    exporttext += ":#{i} => {\n"
    exporttext += "\t:ID => #{move.checkFlag?(:ID)},\n"
    exporttext += "\t:name => \"#{move.name}\",\n"
    exporttext += sprintf("\t:function => 0x%03X,\n",move.function)
    exporttext += "\t:type => :#{move.type},\n"
    exporttext += "\t:category => :#{move.category},\n"
    exporttext += "\t:basedamage => #{move.basedamage},\n"
    exporttext += "\t:accuracy => #{move.accuracy},\n"
    exporttext += "\t:maxpp => #{move.maxpp},\n"
    exporttext += "\t:effect => #{move.checkFlag?(:effect)},\n" if move.checkFlag?(:effect) != false
    exporttext += "\t:effect => #{move.checkFlag?(:moreeffect)},\n" if move.checkFlag?(:moreeffect) != false
    exporttext += "\t:target => :#{move.target},\n"
    exporttext += "\t:priority => #{move.priority},\n" if move.priority && move.priority != 0
    exporttext += "\t:contact => true,\n" if move.checkFlag?(:contact)
    exporttext += "\t:bypassprotect => true,\n" if move.checkFlag?(:bypassprotect)
    exporttext += "\t:magiccoat => true,\n" if move.checkFlag?(:magiccoat)
    exporttext += "\t:snatchable => true,\n" if move.checkFlag?(:snatchable)
    exporttext += "\t:nonmirror => true,\n" if move.checkFlag?(:nonmirror)
    exporttext += "\t:kingrock => true,\n" if move.checkFlag?(:kingrock)
    exporttext += "\t:defrost => true,\n" if move.checkFlag?(:defrost)
    exporttext += "\t:highcrit => true,\n" if move.checkFlag?(:highcrit)
    exporttext += "\t:healingmove => true,\n" if move.checkFlag?(:healingmove)
    exporttext += "\t:punchmove => true,\n" if move.checkFlag?(:punchmove)
    exporttext += "\t:soundmove => true,\n" if move.checkFlag?(:soundmove)
    exporttext += "\t:gravityblocked => true,\n" if move.checkFlag?(:gravityblocked)
    exporttext += "\t:beammove => true,\n" if move.checkFlag?(:beammove)
    case move.function #function code flag additions
      when 0xFA then exporttext += "\t:recoil => 0.25,\n"
      when 0xFB,0xFD,0xFE then exporttext += "\t:recoil => 0.33,\n"
      when 0xFC then exporttext += "\t:recoil => 0.5,\n"
    end
    exporttext += "\t:desc => \"#{move.desc}\"\n"
    exporttext += "},\n\n"
    System.set_window_title("Move line #{i}")
  end
  exporttext += "}"
  File.open("Scripts/"+GAMEFOLDER+"/movetext.rb","w"){|f|
    f.write(exporttext)
  }
end

def encDump
  enctypeChances=[
    [20,15,12,10,10,10,5,5,5,4,2,2],
    [20,15,12,10,10,10,5,5,5,4,2,2],
    [50,25,15,7,3],
    [50,25,15,7,3],
    [70,30],
    [60,20,20],
    [40,35,15,7,3],
    [30,25,20,10,5,5,4,1],
    [30,25,20,10,5,5,4,1],
    [20,15,12,10,10,10,5,5,5,4,2,2],
    [20,15,12,10,10,10,5,5,5,4,2,2],
    [20,15,12,10,10,10,5,5,5,4,2,2],
    [20,15,12,10,10,10,5,5,5,4,2,2]
  ]
  exporttext = "ENCHASH = {\n"
  $cache.encounters.each{|id, map|
    exporttext += "#{id} => { \##{$cache.mapinfos[id].name}\n"
    exporttext += "\t:landrate => #{map[0][0]},\n" if map[0][0] != 0
    exporttext += "\t:caverate => #{map[0][1]},\n" if map[0][1] != 0
    exporttext += "\t:waterrate => #{map[0][2]},\n" if map[0][2] != 0
    encounterdata = map[1]
    for enc in 0...encounterdata.length
      sectiontext = ""
      next if !encounterdata[enc]
      case enc
        when 0 then exporttext += "\t:Land => [\n"
        when 1 then exporttext += "\t:Cave => [\n"
        when 2 then exporttext += "\t:Water => [\n"
        when 3 then exporttext += "\t:RockSmash => [\n"
        when 4 then exporttext += "\t:OldRod => [\n"
        when 5 then exporttext += "\t:GoodRod => [\n"
        when 6 then exporttext += "\t:SuperRod => [\n"
        when 7 then exporttext += "\t:Headbutt => [\n"
        when 9 then sectiontext = "\t:LandMorning => [\n"
        when 10 then sectiontext = "\t:LandDay => [\n"
        when 11 then sectiontext = "\t:LandNight => [\n"
        when 8 then next
      end
      if [9,10,11].include?(enc) #skip this section if it's no different than the standard land encounters
        next if encounterdata[0] == encounterdata[enc]
        exporttext += sectiontext
      end
      #now get the mons with their weight, species, and level range
      for index in 0...encounterdata[enc].length
        monname = getConstantName(PBSpecies,encounterdata[enc][index][0])
        exporttext += "\t\t[:#{monname},#{enctypeChances[enc][index]},#{encounterdata[enc][index][1]},#{encounterdata[enc][index][2]}]"
        if index != encounterdata[enc].length-1
          exporttext += ","
        end
        exporttext += "\n"
      end
      exporttext += "\t],\n"
    end
    exporttext += "},\n"
  }
  exporttext += "}"
  File.open("Scripts/"+GAMEFOLDER+"/enctext.rb","w"){|f|
    f.write(exporttext)
  }
  fixEncountersSeveralSameMon
end


def fixEncountersSeveralSameMon
  if File.exists?("Scripts/"+GAMEFOLDER+"/enctext.rb")
    file = File.open("Scripts/"+GAMEFOLDER+"/enctext.rb", "r+")
    file_data = file.read
    currentarray=[]
    blackjack="" #and hookers
	  file_data.each_line {|line|
      if line.include?("},") && currentarray.length>0
        line2=""
        currentarray.each { |x|
          x=x.insert(x.index('['),'[')
          if x[-2]==','
            x=x[0...-3]+']]'+x[-2]+x[-1]
          else
            x=x[0...-2]+']],'+x[-1]
          end
          line2 += x
        }
        currentarray=[]
        line2 += line
        blackjack += line2
      elsif line.include?(" => [")
        index = currentarray.index{|s| s.include?(line.split(" => ")[0])}
        if !index.nil?
          currentarray[index]=currentarray[index][0...-1] + line.split(" => ")[1]
        else
          currentarray.push(line)
        end
      else
        blackjack+=line
      end
    }
    file.truncate(0)
    file.rewind
    file.write(blackjack)
    file.close
  else
    puts "uuuh why is there no enctext.rb file found"
  end
end

def getConstantName(mod,value)
  for c in mod.constants
    return c if mod.const_get(c.to_sym)==value
  end
  raise _INTL("Value {1} not defined by a constant in {2}",value,mod.name)
end
def dumpTeams
  exporttext = "TEAMARRAY = ["
  for trainer in $cache.trainers
    next if trainer.empty?
    exporttext += "{\n"
    exporttext += ":teamid => [\"#{trainer[1]}\",:#{getConstantName(PBTrainers,trainer[0])},#{trainer[4]}],\n"
    if !trainer[2].empty?
      exporttext += ":items => ["
      check = 1
      for item in trainer[2]
        exporttext += ":#{getConstantName(PBItems,item)}"
        exporttext += "," if check != trainer[2].length
        check += 1
      end
      exporttext += "],\n"
    end
    exporttext += ":mons => ["
    check = 1
    for mon in trainer[3]
      exporttext += "{\n"
      exporttext += "\t:species => :#{getConstantName(PBSpecies,mon[0])},\n"
      exporttext += "\t:level => #{mon[1]},\n"
      exporttext += "\t:item => :#{getConstantName(PBItems,mon[2])},\n" if mon[2] != 0
      if mon[3] != 0
        exporttext += "\t:moves => [:#{getConstantName(PBMoves,mon[3])},"
        exporttext += ":#{getConstantName(PBMoves,mon[4])}" if mon[4] != 0
        exporttext += ","
        exporttext += ":#{getConstantName(PBMoves,mon[5])}" if mon[5] != 0
        exporttext += ","
        exporttext += ":#{getConstantName(PBMoves,mon[6])}" if mon[6] != 0
        exporttext += "],\n"
      end
      abilities = [$cache.pkmn[mon[0]][:Abilities][0],$cache.pkmn[mon[0]][:Abilities][1],$cache.pkmn[mon[0]][:HiddenAbilities]]
      formnames = $PokemonForms.dig(mon[0],:FormName)
      name = formnames[mon[9]] if formnames
      name = "Female" if mon[0] == :MEOWSTIC && mon[8] == 1
      v = $PokemonForms.dig(mon[0],name,:Abilities)
      abilities = v if v
      abilities = [abilities,abilities,abilities] if !abilities.is_a?(Array)
      abilities[2] = abilities[0] if abilities[2] == 0 || abilities[2].nil?
      abilities[1] = abilities[2] if abilities[1] == 0 || abilities[1].nil?
      ability = mon[7] ? mon[7] : 0
      begin
        exporttext += "\t:ability => :#{getConstantName(PBAbilities,abilities[ability])},\n"
      rescue
        puts trainer,ttype,partyid,getConstantName(PBSpecies,mon[0]),abilities.inspect
      end
      if mon[8]
        case mon[8]
        when 0 then exporttext += "\t:gender => \"M\",\n"
        when 1 then exporttext += "\t:gender => \"F\",\n"
        when 2 then exporttext += "\t:gender => \"N\",\n"
        end
      end
      exporttext += "\t:form => #{mon[9]},\n" if mon[9] != 0
      exporttext += "\t:shiny => true,\n" if mon[10]
      exporttext += "\t:nature => :#{getConstantName(PBNatures,mon[11])},\n" if mon[11] != PBNatures::HARDY
      exporttext += "\t:iv => #{mon[12]},\n" if mon[12] != 10
      exporttext += "\t:happiness => #{mon[13]},\n" if mon[13] != 70
      exporttext += "\t:name => \"#{mon[14]}\",\n" if mon[14]
      exporttext += "\t:shadow => true,\n" if mon[15]
      evtotal = mon[18] + mon[19] + mon[20] + mon[21] + mon[22] + mon[23]
      if evtotal > 0 && evtotal != ([(mon[1]*1.5).floor,85].max * 6)
        exporttext += "\t:ev => [#{mon[18]},#{mon[19]},#{mon[23]},#{mon[21]},#{mon[22]},#{mon[20]}]"
      end
      if check != trainer[3].length
        exporttext += "},\n"
      else
        exporttext += "}"
      end
      check += 1
    end
    exporttext += "]},\n"
  end
  exporttext += "]"
  File.open("Scripts/"+GAMEFOLDER+"/trainertext.rb","w"){|f|
    f.write(exporttext)
  }
end

def connectionsConvert
  exporttext = "MAPCONNECTIONSHASH = {\n"
  mapdata = load_data("Data/connections.dat")
  mapdata.each { |connection|
    case connection[1]
    when "N"
      connection[1] = "North"
    when "E"
      connection[1] = "East"
    when "S"
      connection[1] = "South"
    when "W"
      connection[1] = "West"
    end
    case connection[4]
    when "N"
      connection[4] = "North"
    when "E"
      connection[4] = "East"
    when "S"
      connection[4] = "South"
    when "W"
      connection[4] = "West"
    end
    exporttext += "#{connection[0]} => { \##{$cache.mapinfos[connection[0]].name}\n"
    exporttext += "\t:connections => [#{connection}"
    $cache.map_conns.each { |connection2|
      case connection2[1]
      when "N"
        connection2[1] = "North"
      when "E"
        connection2[1] = "East"
      when "S"
        connection2[1] = "South"
      when "W"
        connection2[1] = "West"
      end
      case connection2[4]
      when "N"
        connection2[4] = "North"
      when "E"
        connection2[4] = "East"
      when "S"
        connection2[4] = "South"
      when "W"
        connection2[4] = "West"
      end
      exporttext += ",\t#{connection2}" if (connection2[0] == connection[0]) && (connection[3] != connection2[3])
    }
    exporttext += "],\n"
    exporttext += "},\n"
  }
  exporttext += "}"
  File.open("Scripts/"+GAMEFOLDER+"/mapconnections.rb","w"){|f|
    f.write(exporttext)
  }
end

def connectionsDump
  exporttext = "MAPCONNECTIONSHASH = {\n"
  mapdata = load_data("Data/connections.dat")
  mapdata.each_pair { |key, value|
    exporttext += "#{key} => {  \##{$cache.mapinfos[key].name}\n "
    exporttext += "\t:connections => [\n\t"
    for i in 0...value[:connections].length
      conn=value[:connections][i]
      exporttext += "#{conn}"
      if conn != value[:connections][-1]
        exporttext += ", \# to #{$cache.mapinfos[conn[3]].name}\n\t"
      else
        exporttext += " \# to #{$cache.mapinfos[conn[3]].name}\n"
      end
    end
    exporttext += "\t],\n"
    exporttext += "},\n"
  }
  exporttext += "}"
  File.open("Scripts/"+GAMEFOLDER+"/mapconnections.rb","w"){|f|
    f.write(exporttext)
  }
end

def bttDump
  File.open("Scripts/"+GAMEFOLDER+"/PBSpecies.rb"){|f|
    eval(f.read)
  }
  File.open("Scripts/"+GAMEFOLDER+"/PBTrainers.rb"){|f|
    eval(f.read)
  }
  exporttext = "BTTARRAY = [\n"
  for trainer in load_data("Data/trainerlists.dat")[0][0]
    exporttext += "{\n"
    exporttext += "\t:type => :#{getConstantName(PBTrainers,trainer[0])},\n"
    exporttext += "\t:name => \"#{trainer[1]}\",\n"
    exporttext += "\t:quote => \"#{trainer[2]}\",\n"
    exporttext += "\t:win => \"#{trainer[3]}\",\n"
    exporttext += "\t:loss => \"#{trainer[4]}\",\n"
    exporttext += "\t:mons => ["
    check = 1
    for mon in trainer[5]
      exporttext += ":#{getConstantName(PBSpecies,mon)}"
      exporttext += "," if check != trainer[5].length
      check += 1
    end
    exporttext += "],\n"
    exporttext += "},\n"
  end
  exporttext += "]"
  File.open("Scripts/"+GAMEFOLDER+"/btttext.rb","w"){|f|
    f.write(exporttext)
  }
end

def dumpDefeatAceLines
  globaltext =""
  for n in 1..999
    map_name = sprintf("Data/Map%03d.rxdata", n)
    next if !(File.open(map_name,"rb") { true } rescue false)
    next if $cache.mapinfos[n].name == "REMOVED"
    map = load_data(map_name)
    for i in map.events.keys.sort
      event = map.events[i]
      for j in 0...event.pages.length
        page = event.pages[j]
        list = page.list
        index = 0
        while index < list.length - 1
          params = list[index].parameters
          for l in 0..params.length
            text =params[l].to_s
            if (text.include? "pbTrainerBattle" )||(text.include? "pbDoubleTrainerBattle")
              globaltext << text + "\n"
            end
          end
          index += 1
        end
      end
    end
  end
  file = File.open("output.txt", "w+")
  file.puts(globaltext)
  file.rewind
  file_data = file.read
  lossLines ={}
  file_data.each_line {|line|
    if line.strip.start_with?("pbTrainerBattle") && !line.include?("pbGet(602)")
      line = line.split(":")[1]
      numbattle=0
      if !line.split(")")[1][/\d+/].nil?
        numbattle= line.split(")")[1][/\d+/]
      end
      line=line.split(")")[0]
      line=line.gsub! "_I(",(numbattle.to_s+",")
      string = line.split(",")[1]+",:"+line.split(",")[0]+","+line.split(",")[2]
      lossLines[string] = line.partition(/(?:[^,]*,){3}/).last.delete("\n")
    elsif line.start_with?("pbDoubleTrainerBattle")&& !line.include?("pbGet(602)")
      line1= line.split(":")[1].split("),")[0]
      line2= line.split(":")[2].split(")")[0]
      line1.gsub!("_I(","")
      line2.gsub!("_I(","")
      string = line1.split(",")[1]+",:"+line1.split(",")[0]+","+line1.split(",")[2]
      lossLines[string] = line1.partition(/(?:[^,]*,){3}/).last.delete("\n")
      string = line2.split(",")[1]+",:"+line2.split(",")[0]+","+line2.split(",")[2]
      lossLines[string] = line2.partition(/(?:[^,]*,){3}/).last.delete("\n")
    end
  }
  file.close

  aceLines = {}
  if File.exists?("Scripts/"+GAMEFOLDER+"/toconvert.txt")
    file = File.open("Scripts/"+GAMEFOLDER+"/toconvert.txt", "r")
    file_data = file.read
    key =""
    text =""
    num = 0
    file_data.each_line {|line|
		if line.strip.start_with?("when :")
			key =""
			text =""
			key = line.split("when ")[1].strip
		elsif line.strip.start_with?("when")
			key = key +","+ line.strip.split(" then ace_text")[0].split("when ")[1]
			text= line.strip.split("= _INTL(")[1][0...-1]
			aceLines[key]=text
    elsif line.strip.include?("if isConst?(trainertext")
      key =""
      num =""
      text =""
      key = line.split("PBTrainers,")[1].strip.delete("\n")[0...-1]
    elsif line.strip.start_with?("if $game_variables[192]") || line.strip.start_with?("if $game_variables[226]")
      num = line.split("==")[1].strip.delete("\n")
    elsif line.strip.start_with?("pbDisplayPaused")
      key = key +","+ num
			text= line.strip.split("_INTL(")[1][0...-2]
			aceLines[key]=text
		end
	}
	file.close
  end

  if File.exists?("Scripts/"+GAMEFOLDER+"/trainertext.rb")
    file = File.open("Scripts/"+GAMEFOLDER+"/trainertext.rb", "r+")
    file_data = file.read
    file2 = File.open("Scripts/"+GAMEFOLDER+"/trainertext - Backup.rb", "w")
    file2.write(file_data)
    file2.close
	  file_data.each_line {|line|
      if line.include?(":teamid =>")
        id = line.split(":teamid => [")[1][0...-3]
        if lossLines.key?(id)
          string = ":defeat => "+lossLines[id].to_s
          if !file_data.include?(string)
            file_data[line]=line+ string +",\n"
          end
        end
        idace = id.partition(/(?:[^,]*,){1}/).last
        if aceLines.key?(idace)
          string = ":ace => "+aceLines[idace].to_s
          if  !file_data.include?(string)
            file_data[line]=line+ string +",\n"
          end
        end
      end
    }
    file.truncate(0)
    file.rewind
    file.write(file_data)
    file.close
  else
    puts "uuuh why is there no trainertext.rb file found"
  end
  File.delete("output.txt") if File.exist?("output.txt")
end

def evLineFixer
  aceLines = {}
  if File.exists?("Scripts/"+GAMEFOLDER+"/trainertext.rb")
      file = File.open("Scripts/"+GAMEFOLDER+"/trainertext.rb", "r")
      file_data = file.read
      key =""
      text =""
      num = 0
      file_data.each_line {|line|
      if line.strip.start_with?(":ev =>")
        key = ""
        key = line.split(":ev =>")[1].strip
        front = key.split("}")[0]
        back = line.split(/\d+[]]/)[1].strip
        evarray = eval(front)
        speed = evarray.delete_at(3)
        evarray.push(speed)
        evline = ""
        evline += "\t:ev => #{evarray}#{back}\n"
        file_data[line] = evline
      end
    }
    File.open("Scripts/"+GAMEFOLDER+"/trainertext.rb","w"){|f|
      f.write(file_data)
    }
    file.close
  else
    puts "uuuh why is there no trainertext.rb file found"
  end
end

# Mass Fixes event constants
def removeDefeatText
  for n in 0...999
      savemap = false
      map_name = sprintf("Data/Map%03d.rxdata", n)
      next if !(File.open(map_name,"rb") { true } rescue false)
      map = load_data(map_name)
      for i in map.events.keys.sort
          event = map.events[i]
          for j in 0...event.pages.length
              page = event.pages[j]
              list = page.list
              index = 0
              while index < list.length - 1
                case list[index].code # checks for event codes. here those are scripts(355), additional lines of scripts(655) and conditional branches(111)
                when 355, 655
                      text = list[index].parameters[0]
                      if text.include?("pbTrainerBattle")
                        savemap = true
                        map.events[i].pages[j].list[index].parameters[0].gsub!(/_I\((.*)\),/,"")
                      elsif text.include?("pbDoubleTrainerBattle")
                        front = text.split(/\),:/)[0].strip + ")"
                        back = ":" + text.split(/\),:/)[1].strip
                        newfront = front.gsub!(/_I\((.*)\)/,"")
                        newback = back.gsub!(/_I\((.*)\),/,"")
                        newtext = newfront + newback
                        savemap = true
                        map.events[i].pages[j].list[index].parameters[0] = newtext
                      end
                when 111
                  if list[index].parameters[0]==12 # if conditional branch holds scripts in it
                      text = list[index].parameters[1] # for conditional branches, the script text is stored in index 1 as opposed to index 0
                      if text.include?("pbTrainerBattle")
                        savemap = true
                        map.events[i].pages[j].list[index].parameters[1].gsub!(/_I\((.*)\),/,"")
                      elsif text.include?("pbDoubleTrainerBattle")
                        front = text.split(/\),:/)[0].strip + ")"
                        back = ":" + text.split(/\),:/)[1].strip
                        newfront = front.gsub!(/_I\((.*)\)/,"")
                        newback = back.gsub!(/_I\((.*)\),/,"")
                        newtext = newfront + newback
                        savemap = true
                        map.events[i].pages[j].list[index].parameters[1] = newtext
                      end
                  end
                end
                index += 1
              end
          end
      end
      if savemap
          save_data(map,sprintf("Data/Map%03d.rxdata", n))
      end
  end
end

# Mass Fixes event constants
def pbEventConstantFixer
  for n in 0...999
      savemap = false
      map_name = sprintf("Data/Map%03d.rxdata", n)
      next if !(File.open(map_name,"rb") { true } rescue false)
      map = load_data(map_name)
      for i in map.events.keys.sort
          event = map.events[i]
          for j in 0...event.pages.length
              page = event.pages[j]
              list = page.list
              index = 0
              trainerlinestring = "_I(".*")"
              constantlinks = ["PBTrainers::","PBSpecies::","PBItems::","PBMoves::"] # list of constants that need to be changed
              while index < list.length - 1
                case list[index].code # checks for event codes. here those are scripts(355), additional lines of scripts(655) and conditional branches(111)
                when 355, 655
                      text = list[index].parameters[0]
                      constantlinks.each do |constant|
                        if text.include?(constant)
                          savemap = true
                          map.events[i].pages[j].list[index].parameters[0].gsub! constant, ':'
                        end
                      end
                when 111
                  if list[index].parameters[0]==12 # if conditional branch holds scripts in it
                      text = list[index].parameters[1] # for conditional branches, the script text is stored in index 1 as opposed to index 0
                      constantlinks.each do |constant|
                        if text.include?(constant)
                          savemap = true
                          map.events[i].pages[j].list[index].parameters[1].gsub! constant, ':'
                        end
                      end
                  end
                end
                index += 1
              end
          end
      end
      if savemap
          save_data(map,sprintf("Data/Map%03d.rxdata", n))
      end
  end
end

def fieldrewrite

  output = "FIELDEFFECTS = {\n"
  FIELDEFFECTS.each {|key, data|

    name = data[:FIELDGRAPHICS]
    output += ":#{name.strip.upcase.gsub(/\d/, '')} => {\n"

    output += "\t:name => \"#{data.dig(:FIELDNAME)}\",\n"
    messagetext = ""
    if data.dig(:INTROMESSAGE).is_a?(Array)
      messagetext = "[\n"
      data.dig(:INTROMESSAGE).each{|msg|
        messagetext += "\t\t\"#{msg}\",\n"
      }
      messagetext += "\t]"
    else
      messagetext = "[\n\t\t\"#{data.dig(:INTROMESSAGE)}\"\n\t]"
    end
    output += "\t:fieldMessage => #{messagetext},\n"
    output += "\t:graphic => \"#{data.dig(:FIELDGRAPHICS)}\",\n"
    output += "\t:secretPower => \"#{data.dig(:SECRETPOWERANIM)}\",\n"
    output += "\t:naturePower => \"#{data.dig(:NATUREMOVES)}\",\n"
    output += "\t:mimicry => \"#{data.dig(:MIMICRY)}\",\n"

    output += "\t:damageMods => "
    if data.dig(:MOVEDAMAGEBOOST)
      output += "{\n"
      data.dig(:MOVEDAMAGEBOOST).each{|mult, moves|
        output += "\t\t#{mult} => #{moves},\n"
      }
      output += "\t},\n"
    else
      output += "{},\n"
    end

    output += "\t:accuracyMods => "
    if data.dig(:MOVEACCURACYBOOST)
      output += "{\n"
      data.dig(:MOVEACCURACYBOOST).each{|acc, moves|
        output += "\t\t#{acc} => #{moves},\n"
      }
      output += "\t},\n"
    else
      output += "{},\n"
    end

    output += "\t:moveMessages => "
    if data.dig(:MOVEMESSAGES)
      output += "{\n"
      data.dig(:MOVEMESSAGES).each{|msg, moves|
        output += "\t\t\"#{msg}\" => #{moves},\n"
      }
      output += "\t},\n"
    else
      output += "{},\n"
    end

    output += "\t:typeMods => "
    if data.dig(:MOVETYPEMOD)
      output += "{\n"
      data.dig(:MOVETYPEMOD).each{|type, moves|
        output += "\t\t:#{type} => #{moves},\n"
      }
      output += "\t},\n"
    else
      output += "{},\n"
    end

    output += "\t:typeAddOns => "
    if data.dig(:TYPETYPEMOD)
      output += "{\n"
      data.dig(:TYPETYPEMOD).each{|type, type2|
        output += "\t\t:#{type} => #{type2},\n"
      }
      output += "\t},\n"
    else
      output += "{},\n"
    end

    output += "\t:typeBoosts => "
    if data.dig(:TYPEDAMAGEBOOST)
      output += "{\n"
      data.dig(:TYPEDAMAGEBOOST).each{|boost, types|
        output += "\t\t#{boost} => #{types},\n"
      }
      output += "\t},\n"
    else
      output += "{},\n"
    end

    output += "\t:typeMessages => "
    if data.dig(:TYPEMESSAGES)
      output += "{\n"
      data.dig(:TYPEMESSAGES).each{|msg, type|
        output += "\t\t\"#{msg}\" => #{type},\n"
      }
      output += "\t},\n"
    else
      output += "{},\n"
    end

    output += "\t:typeCondition => "
    if data.dig(:TYPECONDITION)
      output += "{\n"
      data.dig(:TYPECONDITION).each{|type, condition|
        output += "\t\t:#{type} => \"#{condition}\",\n"
      }
      output += "\t},\n"
    else
      output += "{},\n"
    end

    output += "\t:changeCondition => "
    if data.dig(:CHANGECONDITION)
      output += "{\n"
      data.dig(:CHANGECONDITION).each{|fieldid, condition|
        fieldsym = FIELDEFFECTS[fieldid][:FIELDGRAPHICS].strip.upcase
        output += "\t\t:#{fieldsym} => \"#{condition}\",\n"
      }
      output += "\t},\n"
    else
      output += "{},\n"
    end

    output += "\t:fieldChange => "
    if data.dig(:FIELDCHANGE)
      output += "{\n"
      data.dig(:FIELDCHANGE).each{|fieldid, condition|
        fieldsym = FIELDEFFECTS[fieldid][:FIELDGRAPHICS].strip.upcase
        output += "\t\t:#{fieldsym} => #{condition},\n"
      }
      output += "\t},\n"
    else
      output += "{},\n"
    end

    output += "\t:dontChangeBackup => #{data.dig(:DONTCHANGEBACKUP) ? data.dig(:DONTCHANGEBACKUP) : "[]"},\n"

    output += "\t:changeMessage => "
    if data.dig(:CHANGEMESSAGE)
      output += "{\n"
      data.dig(:CHANGEMESSAGE).each{|msg, moves|
        output += "\t\t \"#{msg}\" => #{moves},\n"
      }
      output += "\t},\n"
    else
      output += "{},\n"
    end

    output += "\t:statusMods => #{data.dig(:STATUSMOVEBOOST) ? data.dig(:STATUSMOVEBOOST) : "[]"},\n"
    output += "\t:changeEffects => {},\n"
    output += "\t:seed => {\n"

    seedtext = ""
    if data.dig(:SEED).is_a?(Hash) || data.dig(:SEED).nil?
      seedtext = "nil"
    else
      seedtext = ":#{data.dig(:SEED)}"
    end

    output += "\t\t:seedtype => #{seedtext},\n"

    effecttext = ""
    if data.dig(:SEEDEFFECT)
      if data.dig(:SEEDEFFECT).is_a?(Symbol)
        effecttext = ":"
      end
      effecttext += data.dig(:SEEDEFFECT).to_s
    else
      effecttext = "nil"
    end
    output += "\t\t:effect => #{effecttext},\n"

    durtext = ""
    if data.dig(:SEEDEFFECTVAL)
      if data.dig(:SEEDEFFECTVAL).is_a?(Symbol)
        durtext = ":"
      end
      durtext += data.dig(:SEEDEFFECTVAL).to_s
    else
      durtext = "nil"
    end
    output += "\t\t:duration => #{durtext},\n"

    output += "\t\t:message => #{data.dig(:SEEDEFFECTSTR) ? "\"" + data.dig(:SEEDEFFECTSTR).to_s + "\"" : "nil"},\n"

    anitext = ""
    if data.dig(:SEEDANIM)
      if data.dig(:SEEDANIM).is_a?(Symbol)
        anitext = ":"
      end
      anitext += data.dig(:SEEDANIM).to_s
    else
      anitext = "nil"
    end
    output += "\t\t:animation => #{anitext},\n"

    output += "\t\t:stats => "

    if data.dig(:SEEDSTATS)
      output += "{\n"
      hash = {
        :HP       => 0,
        :ATTACK   => 1,
        :DEFENSE  => 2,
        :SPATK    => 3,
        :SPDEF    => 4,
        :SPEED    => 5,
        :ACCURACY => 6,
        :EVASION  => 7}
      data.dig(:SEEDSTATS).each{|stat,val|

        output += "\t\t\tPBStats::#{hash.keys[stat]} => #{val},\n"
      }
      output += "\t\t},\n"
    else
      output += "{}\n"
    end

    output += "\t},\n},\n"


  }
  output += "}"

  File.open("Scripts/"+GAMEFOLDER+"/fieldtxt.rb", "w"){|f|
    f.write(output)
  }
  compileFields
end

def dumpNatures
  dumpstupidstats = [
    ["PBStats::ATTACK","\"spicy\""],
    ["PBStats::DEFENSE","\"sour\""],
    ["PBStats::SPEED","\"sweet\""],
    ["PBStats::SPATK","\"dry\""],
    ["PBStats::SPDEF","\"bitter\""]
  ]
  output = "NATUREHASH = {\n"
  for nature in 0..PBNatures.maxValue
    incStat = (nature / 5).floor
    decStat = (nature % 5).floor
    output += ":#{PBNatures.getName(nature).upcase} => {\n"
    output += "\t\t:name => \"#{PBNatures.getName(nature)}\",\n"
    output += "\t\t:incStat => #{dumpstupidstats[incStat][0]},\n"
    output += "\t\t:decStat => #{dumpstupidstats[decStat][0]},\n"
    output += "\t\t:like => #{dumpstupidstats[incStat][1]},\n"
    output += "\t\t:dislike => #{dumpstupidstats[decStat][1]},\n"
    output += "\t},\n"
  end
  output += "}"


  File.open("Scripts/"+GAMEFOLDER+"/naturetxt.rb", "w"){|f|
    f.write(output)
  }
end
