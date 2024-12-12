

class Randomizer
    TESTSEED = 279295474045690627731113896522056526725
    TRAPPINGABILS = [:ARENATRAP,:MAGNETPULL,:SHADOWTAG]
    BADABILS = [:DEFEATIST,:TRUANT,:SLOWSTART,:KLUTZ,:STALL]
    def self.randomizePokemon()  
        $followEvo = {
            :stats => {},
            :abilities => {},
            :types => {}
        }
        $randomEvos = randomizeEvos() if $RandomizerSettings.pkmn[:evolutions][:random]
        File.open("Scripts/"+GAMEFOLDER+"/abiltext.rb"){|f|
            eval(f.read)
        }
        exporttext = "MONHASH = {\n"
        for i in $cache.pkmn.keys
            mon = $cache.pkmn[i]

            #print start
            mon = $cache.pkmn[i]
            System.set_window_title("Pokemon line #{i}")
            #print mon.inspect
                exporttext += ":#{i} => {\n"
                for form in 0...mon.forms.length
                    formthing = ""
                    formname = mon.forms[form]
                    exporttext += "\t\"#{mon.forms[form]}#{formthing}\" => {\n"
                    if form == 0
                        basestats = mon.BaseStats
                        abilities = mon.Abilities
                        if $cache.pkmn[i].checkFlag?(:HiddenAbilities)
                            abilities.push($cache.pkmn[i].checkFlag?(:HiddenAbilities))
                        end
                        evos = mon.evolutions
                        preevo = mon.preevo
                        type1 = mon.Type1
                        type2 = mon.Type2
                        moveset = mon.Moveset
                        compat = mon.compatiblemoves
                        itemarr = [$cache.pkmn[i].checkFlag?(:WildItemCommon), $cache.pkmn[i].checkFlag?(:WildItemUncommon), $cache.pkmn[i].checkFlag?(:WildItemRare)]

                        if $RandomizerSettings.pkmn[:stats][:flipped]
                            basestats = basestats.reverse
                        end
                        if $RandomizerSettings.pkmn[:stats][:shuffle]
                            basestats = shuffleBST(i, basestats)
                        end
                        if $RandomizerSettings.pkmn[:stats][:random]
                            basestats = randomizeWithinBST(i, basestats)
                        end
                        abilities = randomizeAbilities(i) if $RandomizerSettings.pkmn[:abilities][:random]
                        type1,type2 = randomizeTypes(i) if $RandomizerSettings.pkmn[:types][:random]
                        if $RandomizerSettings.pkmn[:evolutions][:random]
                            evos = nil
                            preevo = nil
                            level = 0
                            bst = $cache.pkmn[evo].BaseStats.sum
                            if bst >= 600
                                level = 50
                            elsif bst >= 550
                                level = 40
                            elsif bst >= 500
                                level = 38
                            elsif bst >= 450
                                level = 35
                            elsif bst >= 400
                                level = 30
                            else
                                level = 20
                            end
                            temp = $randomEvos[i]
                            evos = [temp,:Level,level] if temp
                            temp = $randomEvos.key(i)
                            preevo = {:species => temp, :form => 0}
                        end

                        exporttext += "\t\t:name => \"#{mon.name}\",\n"
                        exporttext += "\t\t:dexnum => #{mon.dexnum},\n"
                        exporttext += "\t\t:Type1 => :#{type1},\n"
                        exporttext += "\t\t:Type2 => :#{type2},\n" if type2
                        exporttext += "\t\t:BaseStats => #{basestats.inspect},\n"
                        exporttext += "\t\t:EVs => #{mon.EVs.inspect},\n"
                        exporttext += "\t\t:Abilities => #{abilities},\n"
                        exporttext += "\t\t:GrowthRate => :#{mon.GrowthRate},\n"
                        exporttext += "\t\t:GenderRatio => :#{mon.GenderRatio},\n"
                        exporttext += "\t\t:BaseEXP => #{mon.BaseEXP},\n"
                        exporttext += "\t\t:CatchRate => #{mon.CatchRate},\n"
                        exporttext += "\t\t:Happiness => #{mon.Happiness},\n"
                        exporttext += "\t\t:EggSteps => #{mon.EggSteps},\n"
                        if mon.EggMoves
                          exporttext += "\t\t:EggMoves => ["
                          exporttext += "],\n"
                        end
                        if preevo
                          exporttext += "\t\t:preevo => {\n"
                          exporttext += "\t\t\t:species => :#{preevo[0][:species].to_s},\n"
                          exporttext += "\t\t\t:form => #{preevo[0][:form]}\n"
                          exporttext += "\t\t},\n"
                        end
                        check = 1
                        exporttext += "\t\t:Moveset => [\n"
                        for move in moveset
                            exporttext += "\t\t\t[#{move[0]},:#{move[1]}]"
                            exporttext += ",\n" if check != moveset.length
                            check += 1
                        end
                        exporttext += "],\n"
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
                        exporttext += "\t\t:WildItemCommon => :#{itemarr[0]},\n" if itemarr[0]
                        exporttext += "\t\t:WildItemUncommon => :#{itemarr[1]},\n" if itemarr[1]
                        exporttext += "\t\t:WildItemRare => :#{itemarr[2]},\n" if itemarr[2]
                        exporttext += "\t\t:kind => \"#{mon.kind}\",\n"
                        exporttext += "\t\t:dexentry => \"#{mon.dexentry}\",\n"
                        exporttext += "\t\t:BattlerPlayerY => #{mon.BattlerPlayerY},\n"
                        exporttext += "\t\t:BattlerEnemyY => #{mon.BattlerEnemyY},\n"
                        exporttext += "\t\t:BattlerAltitude => #{mon.BattlerAltitude},\n"
                        if evos != nil
                          check = 1
                          exporttext += "\t\t:evolutions => [\n"
                          for evo in evos
                            exporttext+= "\t\t\t[:#{evo[0].to_s},"
                            if $RandomizerSettings.pkmn[:evolutions][:changeImpossibleEvos] && evo[1] == :HasMove && $RandomizerSettings.moves[:movesets][:random]
                                exporttext += ":Level,#{i == :BONSLY || i == :MIMEJR ? 15 : 35}"
                            else
                                exporttext += ":#{evo[1].to_s}"
                                evomethods = ["Item","ItemMale","ItemFemale","TradeItem","DayHoldItem","NightHoldItem"]
                                if evomethods.include?(evo[1].to_s)
                                exporttext += ",:#{evo[2].to_s}"
                                else
                                exporttext += ",#{evo[2].is_a?(Integer) ? "" : ":"}#{evo[2].to_s}" if evo[2]
                                end
                            end
                            exporttext += "],\n" if check != evos.length
                            exporttext += "]\n" if check == evos.length
                            check += 1
                          end
                          exporttext += "\t\t]\n"
                        end
                        exporttext += "\t},\n\n"
                        next
                    end
                    basestats = mon.formData.dig(mon.forms[form],:BaseStats)
                    abilities = mon.formData.dig(mon.forms[form],:Abilities)
                    if abilities
                        abilities.push(mon.formData.dig(mon.forms[form],:HiddenAbilities))
                    end
                    evo = mon.evolutions
                    preevo = mon.formData.dig(mon.forms[form],:preevo)
                    type1 = mon.formData.dig(mon.forms[form],:Type1)
                    type2 = mon.formData.dig(mon.forms[form],:Type2)
                    moveset = mon.formData.dig(mon.forms[form],:Moveset)
                    compat = mon.formData.dig(mon.forms[form],:compatiblemoves)

                    #start form randomization
                    if $RandomizerSettings.pkmn[:stats][:flipped]
                        basestats = basestats.reverse
                    end
                    if $RandomizerSettings.pkmn[:stats][:shuffle]
                        basestats = shuffleBST(i, basestats)
                    end
                    if $RandomizerSettings.pkmn[:stats][:random]
                        basestats = randomizeWithinBST(i, basestats)
                    end
                    abilities = randomizeAbilities(i) if $RandomizerSettings.pkmn[:abilities][:random]
                    #end form randomization

                    exporttext += "\t\t:name => \"#{mon.formData.dig(mon.forms[form],:name)}\",\n" if mon.formData.dig(mon.forms[form],:name)
                    exporttext += "\t\t:dexnum => #{mon.formData.dig(mon.forms[form],:dexnum)},\n" if mon.formData.dig(mon.forms[form],:dexnum)
                    exporttext += "\t\t:Type1 => :#{mon.formData.dig(mon.forms[form],:Type1)},\n" if mon.formData.dig(mon.forms[form],:Type1)
                    exporttext += "\t\t:Type2 => :#{mon.formData.dig(mon.forms[form],:Type2)},\n" if mon.formData.dig(mon.forms[form],:Type2)
                    exporttext += "\t\t:BaseStats => #{mon.formData.dig(mon.forms[form],:BaseStats).inspect},\n" if mon.formData.dig(mon.forms[form],:BaseStats)
                    exporttext += "\t\t:EVs => #{mon.formData.dig(mon.forms[form],:EVs).inspect},\n" if mon.formData.dig(mon.forms[form],:EVs)
                    exporttext += "\t\t:Abilities => #{mon.mon.formData.dig(mon.forms[form],:Abilities)},\n" if mon.formData.dig(mon.forms[form],:Abilities)
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
                        exporttext += "\t\t\t:species => :#{mon.formData.dig(mon.forms[form],:preevo)[0][:species]},\n"
                        exporttext += "\t\t\t:form => #{mon.formData.dig(mon.forms[form],:preevo)[0][:form]}\n"
                        exporttext += "\t\t},\n"
                    end
                    if mon.formData.dig(mon.forms[form],:Moveset)
                        check = 1
                        exporttext += "\t\t:Moveset => [\n"
                        for move in mon.formData.dig(mon.forms[form],:Moveset)
                            exporttext += "\t\t\t[#{move[0]},:#{move[1]}]"
                            exporttext += ",\n" if check != mon.Moveset.length
                            check += 1
                        end
                        exporttext += "],\n"
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
                    if mon.formData.dig(mon.forms[form],:GetEvo)
                    evos = mon.formData.dig(mon.forms[form],:GetEvo)
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
                exporttext += "},\n\n"
            #print end
        end
        exporttext += "}"
        File.open("Randomizer Data/montext.rb","w"){|f|
            f.write(exporttext)
        }
        System.set_window_title("Pokemon Reborn")
    end

    def self.randomizeEvos()
        if $randomEvos.empty?
            evocount = 0
            for sym in $cache.pkmn.keys
                mon = $cache.pkmn[sym]
                if mon.evolutions
                    mon.evolutions.each{|e| evocount += 1}
                end
                next if mon.formData.empty?
                if mon.formData[:evolutions]
                    mon.formData[:evolutions].each{|e| evocount += 1}
                end
            end
            for i in 0..evocount
                base = $cache.pkmn.keys[$RandomizerSettings.random.rand($cache.pkmn.length)]
                while($randomEvos.keys.include?(base))
                    base = $cache.pkmn.keys[$RandomizerSettings.random.rand($cache.pkmn.length)]
                end
                evoList = getEvoList(base)
                evo = evoList[$RandomizerSettings.random.rand(evoList.length)]
                iterationLimit = 10
                while($randomEvos.values.include?(evo))
                    evo = evoList[$RandomizerSettings.random.rand(evoList.length)]
                    evo = nil if iterationLimit == 0
                    iterationLimit -= 1
                end
                $randomEvos.store(
                    base => evo
                )
            end
        end
    end

    def self.getEvoList(species,form = 0)
        limitEvos       = $RandomizerSettings.pkmn[:evolutions][:limitEvos]
        if limitEvos
            tempevo = $randomEvos[species]
            tempevo2 = $randomEvos[tempevo]
            temppreevo = $randomEvos.key(species)
            return [] if tempevo && temppreevo
            return [] if tempevo && tempevo2
        end
        forceTyping     = $RandomizerSettings.pkmn[:evolutions][:forceTyping]
        forceNewEvos    = $RandomizerSettings.pkmn[:evolutions][:forceNewEvos]
        similarTarget   = $RandomizerSettings.pkmn[:evolutions][:similarTarget] #LOWEST PRIO
        
        types = [$cache.pkmn[species].Type1, $cache.pkmn[species].Type2] if form == 0
        if form!= 0
            forms = $cache.pkmn[species].forms
            types = [$cache.pkmn[species].formData[forms[form]][:Type1], $cache.pkmn[species].formData[forms[form]][:Type2]]
        end
        list = $cache.pkmn.keys
        list.delete(species)
        ihateforms = {}
        while(true)
            for i in $cache.pkmn.keys
                next if !list.include?(i)
                mon = $cache.pkmn[i]
                if forceTyping
                    if !(types.include?(mon.Type1) || types.include?(mon.Type2))
                        mon.formData.each{|form|
                            if types.include?(form.Type1) || types.include?(form.Type2)
                                ihateforms.store(i, mon.forms.index(form))
                            end
                        }
                        list.delete(i) if !ihateforms.keys.include?(i)
                    end
                end
                if forceNewEvos
                    mon.evolutions.each{|evo|
                        list.delete(evo[0])
                    }
                end
            end
        end
    end

    def self.randomizeTypes(species)
        return $followEvo[:types][species] if $followEvo[:types].include?(species)
        ret = []
        type1 = $cache.types.keys[$RandomizerSettings.random.rand($cache.types.keys.length)]
        while((type1 == :QMARKS && !$RandomizerSettings.pkmn[:types][:allowQmarks?]) || (Rejuv && (type1 == :SHADOW && !$RandomizerSettings.pkmn[:types][:allowShadow?])))
            type1 = $cache.types.keys[$RandomizerSettings.random.rand($cache.types.keys.length)]
        end
        ret.push(type1)
        type2 = nil
        if $RandomizerSettings.random.rand(100) >= $RandomizerSettings.pkmn[:types][:dualType]
            type2 = $cache.types.keys[$RandomizerSettings.random.rand($cache.types.keys.length)]
            while((type2 == :QMARKS && !$RandomizerSettings.pkmn[:types][:allowQmarks?]) || (Rejuv && (type2 == :SHADOW && !$RandomizerSettings.pkmn[:types][:allowShadow?])))
                type2 = $cache.types.keys[$RandomizerSettings.random.rand($cache.types.keys.length)]
            end
        end
        ret.push(type2)
        if $RandomizerSettings.pkmn[:types][:followEvo]
            checkEvolution(:types, species, ret) 
        end
        return ret
    end

    def self.randomizeAbilities(species)
        if $followEvo[:abilities].include?(species)
            return $followEvo[:abilities][species] 
        end
        abilities = []
        $cache.pkmn[species].Abilities.each{|abil|
            if PBStuff::ABILITYBLACKLIST.include?(abil)
                abilities.push(abil)
            end
        }
        while(abilities.length < 3)
            abil = ABILHASH.keys[$RandomizerSettings.random.rand(ABILHASH.length)]
            if !abilities.include?(abil) && !PBStuff::ABILITYBLACKLIST.include?(abil)
                next if $RandomizerSettings.pkmn[:abilities][:banTraps] && TRAPPINGABILS.include?(abil)
                next if $RandomizerSettings.pkmn[:abilities][:banBad] && BADABILS.include?(abil)
                next if !$RandomizerSettings.pkmn[:abilities][:wonderGuard] && abil == :WONDERGUARD
                abilities.push(abil) 
            end
        end
        if $RandomizerSettings.pkmn[:abilities][:followEvo]
            checkEvolution(:abilities, species, abilities) 
        end
        return abilities
    end

    def self.shuffleBST(species, basestats)
        if $followEvo[:stats].include?(species)
            newstats = applyShuffledStats($followEvo[:stats][species],basestats)
        else
            shuffledStatOrder = [0,1,2,3,4,5]
            shuffledStatOrder.shuffle!(random: $RandomizerSettings.random)
            if $RandomizerSettings.pkmn[:stats][:followEvo]
                checkEvolution(:stats, species, shuffledStatOrder)
            end
            newstats = applyShuffledStats(shuffledStatOrder,basestats)
        end
        return newstats
    end

    def self.checkEvolution(type, species, data)
        return if species == nil || $cache.pkmn[species].evolutions == nil
        for evo in $cache.pkmn[species].evolutions
            mon = evo[0]
            $followEvo[type].store(mon, data)
            checkEvolution(type, mon, data)
        end
    end

    def self.applyShuffledStats(order, stats)
        newstats = []
        newstats.push(stats[order[0]])
        newstats.push(stats[order[1]])
        newstats.push(stats[order[2]])
        newstats.push(stats[order[3]])
        newstats.push(stats[order[4]])
        newstats.push(stats[order[5]])
        return newstats
    end

    def self.randomizeWithinBST(species, basestats)
        bst = basestats.sum - 70 #minimum 20 HP, everything else min 10
        if $followEvo[:stats].keys.include?(species)
            weightArr = $followEvo[:stats][species]
        else 
            hpWeight = $RandomizerSettings.random.rand(); atkWeight = $RandomizerSettings.random.rand(); defWeight = $RandomizerSettings.random.rand()
            spaWeight = $RandomizerSettings.random.rand(); spdWeight = $RandomizerSettings.random.rand(); speWeight = $RandomizerSettings.random.rand()
            weightArr = [hpWeight, atkWeight, defWeight, spaWeight, spdWeight, speWeight]
            if $RandomizerSettings.pkmn[:stats][:followEvo]
                checkEvolution(:stats, species, weightArr)
            end
        end
        totWeight = weightArr.sum

        newstats = []
        newstats[0] = [1, weightArr[0] / totWeight * bst].max.to_i + 20
        newstats[1] = [1, weightArr[1] / totWeight * bst].max.to_i + 10
        newstats[2] = [1, weightArr[2] / totWeight * bst].max.to_i + 10
        newstats[3] = [1, weightArr[3] / totWeight * bst].max.to_i + 10
        newstats[4] = [1, weightArr[4] / totWeight * bst].max.to_i + 10
        newstats[5] = [1, weightArr[5] / totWeight * bst].max.to_i + 10
        return newstats
    end

end