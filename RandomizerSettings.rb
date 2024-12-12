GENTHRESHOLDS = [-1,151,251,386,493,649,721,807,898,905]

def saveRandomizerSettings(settings=RandomizerSettings.new(Randomizer::TESTSEED))
    puts settings.random.seed
end

class RandomizerSettings
    attr_accessor :misc
    attr_accessor :pkmn
    attr_accessor :types
    attr_accessor :statics
    attr_accessor :moves
    attr_accessor :trainers
    attr_accessor :encounters
    attr_accessor :tms
    attr_accessor :tutors
    attr_accessor :items
    attr_reader :random
    
    "
        misc:
            limit to gen x
            allow megas?
            allow custom forms?
            allow pulse/rift?

        pokemon traits:
            stats:
                shuffle self stats
                random of allocation of bst
                follow evo?
                    stores shuffled
                    stores ratios
            abilities:
                allow wonder guard? #shedinja retains wonder guard
                follow evo?
                ban trapping abils? #shadow tag, arena trap, magnet pull
                ban useless abils? #truant, defeatist, slow start
            types:
                follow evo?
                dual type percentage. default 50
            evolutions:
                change impossible evos? #move reliant, only move randomizer
                #highest prio to lowest prio
                force new evo?
                limit 3 stage?
                force same type?
                similar str? #match target bst
        types:
            typechart:
                shuffle # efficacies are shuffled i.e. fire has fighting resistances and weaknesses, is physical in glitch
                random # num of res, weak, immu are maintained i.e. normal always has no res, 1 weak, 1 immu
                chaos # any num of res, weak, immu. immu and res may overlap in case of scrappy/ring target
                    % chance of res
                    % chance of weak
                    % chance of immu
        static mons:
            starter:
                select mon, add npc/modify rng machine
                randomize starters?
                similar bst? #start with within 10% and add 5% either direction till we find
                enforce two evos?
            statics:
                force legend to legend, normal to normal
            trades:
                give item?
                randomize given only
                randomize request only
                randomize both
        move data:
            power?
            accuracy?
            pp?
            move types?
            categories?
            movesets:
                prefer type?    # 40 type 60 random
                                # 10 normal 30 type2
                                # 20 type1 20 type2
                completely random?
                only metronome?
                scale damage?
                ban drage/sonic
                force move on evolution?
                force % good damage move
        trainers:
            fill parties?
            rival carries starter?
            randomize trainer class names?
            randomize trainer names?
            force full evo at level? #30-95
            ensure megas?
            ensure zmoves?
            handling for pulse/rifts
            force gym type
        encounters:
            full random?
            1-to-1 area map?    # localized enc1 >> randomenc
            1-to-1 global map?  # global enc1 >> randomenc
            adds:
                similar str? #start with within 10% and add 5% either direction till we find
                type theme? #inaccessible in global mapping
            options:
                disable legends?
                set min catch rate: inc 51
                Held items?
        tms/hms:
            #work around hms
            force % good damage move
            compat:
                random (type) #90% if type share, 50% if move normal pokemon not, 25% regular
                random (full) 
                always
        tutors:
            #no tutor rand, sorry!
            compat:
                random (type) #90% if type share, 50% if move normal pokemon not, 25% regular
                random (full) 
                always
        items:
            field:
                STORY PROGRESSION ITEMS FOOL
                full random
                same item type # based on bag pocket, exceptions evo stones >> evo stones, crests >> crests, z stones >> z stones, megastones >> megastones
            marts:
                full random
                same item type # based on bag pocket, exceptions evo stones >> evo stones, crests >> crests, z stones >> z stones, megastones >> megastones
            pickup
        
    "
    # HEX BIT CONSTANTS
        #takes up x bits in settings string
        MISC        = 2
        PKMN        = 7
        TYPES       = 7
        STATICS     = 3
        MOVES       = 5
        TRAINERS    = 5
        ENCOUNTERS  = 3
        TMS         = 3
        TUTORS      = 1
        ITEMS       = 2
    # HEX BIT CONSTANTS

    def initialize(seed = Random.new().seed())
        Dir.mkdir("Randomizer Data") if !Dir.exist?("Randomizer Data")
        @random = Random.new(seed)
        @misc = {                       #7 bits
            :allowMegas => false,
            :allowForms => false,
            :allowPULSE => false,

            :genlimit => 0,  #4
        }
        @pkmn = {                       #24 bits
            :stats => {                     #4 bits
                :flipped => false, #incompatible with below settings
                :shuffle => false,
                :random => false,
                :followEvo => false,
            },
            :abilities => {                 #5 bits
                :random => false,

                :wonderGuard => false,
                :followEvo => false,
                :banTraps => false,
                :banBad => false
            },
            :evolutions => {                #6 bits
                :random => false,
                :changeImpossibleEvos => false,

                :forceNewEvos => false,
                :limitEvos => false,
                :forceTyping => false,
                :similarTarget => false
            },
            :types => {                     #11 bits
                :random => true,
                :followEvo => true,
                :allowShadow? => false,
                :allowQmarks? => true,

                :dualType => 50                 #7
            },
        }
        @types = {                      #24 bits
            :shuffle => false,
            :random => false,
            :chaos => false,

            :chaosResist => 0,              #7

            :chaosWeak => 0,                #7

            :chaosImmune => 0,              #7
        }
        @statics = {                    #12 bits
            :starters => {                   #7
                :random => true,
                :similarBST => false,
                :forceTwoStage => false,

                :starter => 0,
            },
            :statics => {                   #2
                :random => true, 
                :forceGrouping => false
            },
            :trades => {                    #3
                :given => true,
                :requested => true,
                :addItem => false,
            }
        }
        @moves = {                      #18 bits
            :power => false,
            :accuracy => false,
            :type => false,
            :category => false,

            :movesets => {
                :random => false,
                :preferType => false,

                :metronome => false,
                :scaleMoves => false,
                :banSetDamage => false,
                :newEvoMove => false,

                :forceGoodMoves => 0            #7
            }
        }       
        @trainers = {                   #17 bits
            :random => true,
            :class => false,
            :name => false,
            :fillParties => false,

            :keepStarters => true,
            :ensureMega => false,
            :ensureZMove => false,
            :forceGym => false,

            :similarBST => false,
            :forceFullEvo => false,

            :forceFullEvoLevel => 30,       #7
        }
        @encounters = {                 #10 bits
            :random => false,
            :areamap => true,
            :globalmap => false,
            
            :similarBST => false,
            :typeThemed => false,
            :disableLegends => false,
            :items => false,

            :minCatchRate => 0,             #8
        }
        @tms = {                        #11 bits          
            :random => false,
            :typeCompatibility => false,
            :randomCompatibility => false,
            :fullCompatibility => false,

            :forceGoodMoves => 0,           #7
        }
        @tutors = {                     #3 bits
            :typeCompatibility => false,
            :randomCompatibility => false,
            :fullCompatibility => false,
        }
        @items = {                      #5 bits
            :field => {
                :random => false,
                :typeMatch => false
            },
            :mart => {
                :random => false,
                :typeMatch => false
            },
            
            :pickup => false
        }
    end

    def save
        settings = miscToString+pkmnToString+typesToString+staticsToString+movesToString+trainersToString+encountersToString+tmsToString+tutorsToString+itemsToString
        return settings
    end

    def load(string)
        lower = 0; upper = MISC
        miscFromString(string[lower...upper])
        lower = upper; upper += PKMN
        pkmnFromString(string[lower...upper])
        lower = upper; upper += TYPES
        typesFromString(string[lower...upper])
        lower = upper; upper += STATICS
        staticsFromString(string[lower...upper])
        lower = upper; upper += MOVES
        movesFromString(string[lower...upper])
        lower = upper; upper += TRAINERS
        trainersFromString(string[lower...upper])
        lower = upper; upper += ENCOUNTERS
        encountersFromString(string[lower...upper])
        lower = upper; upper += TMS
        tmsFromString(string[lower...upper])
        lower = upper; upper += TUTORS
        tutorsFromString(string[lower...upper])
        lower = upper; upper += ITEMS
        itemsFromString(string[lower...upper])
    end

    def miscToString()
        ret = ""
        str = "0#{@misc[:allowMegas].to_i}#{@misc[:allowForms].to_i}#{@misc[:allowPULSE].to_i}"
        ret += str.to_i(2).to_s(16)
        ret += @misc[:genlimit].to_s(16)
        return ret
    end

    def pkmnToString()
        ret = ""
        str = "#{@pkmn[:stats][:flipped].to_i}#{@pkmn[:stats][:shuffle].to_i}#{@pkmn[:stats][:random].to_i}#{@pkmn[:stats][:followEvo].to_i}"
        ret += str.to_i(2).to_s(16)
        str = "000#{@pkmn[:abilities][:random].to_i}"
        ret += str.to_i(2).to_s(16)
        str = "#{@pkmn[:abilities][:wonderGuard].to_i}#{@pkmn[:abilities][:followEvo].to_i}#{@pkmn[:abilities][:banTraps].to_i}#{@pkmn[:abilities][:banBad].to_i}"
        ret += str.to_i(2).to_s(16)
        str = "00#{@pkmn[:evolutions][:random].to_i}#{@pkmn[:evolutions][:changeImpossibleEvos].to_i}"
        ret += str.to_i(2).to_s(16)
        str = "#{@pkmn[:evolutions][:forceNewEvos].to_i}#{@pkmn[:evolutions][:limitEvos].to_i}#{@pkmn[:evolutions][:forceTyping].to_i}#{@pkmn[:evolutions][:similarTarget].to_i}"
        ret += str.to_i(2).to_s(16)
        str = "#{@pkmn[:types][:random].to_i}#{@pkmn[:types][:followEvo].to_i}#{@pkmn[:types][:allowShadow?].to_i}#{@pkmn[:types][:allowQmarks?].to_i}"
        ret += str.to_i(2).to_s(16)
        ret += @pkmn[:types][:dualType].to_s(16)
        return ret
    end

    def typesToString()
        ret = ""
        str = "0#{@types[:shuffle]}#{@types[:random]}#{@types[:chaos]}"
        ret += str.to_i(2).to_s(16)
        ret += @types[:chaosResist].to_s(16)
        ret += @types[:chaosWeak].to_s(16)
        ret += @types[:chaosImmune].to_s(16)
        return ret
    end

    def staticsToString()
        ret = ""
        str = "0#{@statics[:starters][:random].to_i}#{@statics[:starters][:similarBST].to_i}#{@statics[:starters][:forceTwoStage].to_i}"
        ret += str.to_i(2).to_s(16)
        ret += @statics[:starters][:starter].to_s(16)
        str = "00#{@statics[:statics][:random].to_i}#{@statics[:statics][:forceGrouping].to_i}"
        ret += str.to_i(2).to_s(16)
        str = "0#{@statics[:trades][:given].to_i}#{@statics[:trades][:requested].to_i}#{@statics[:trades][:addItem].to_i}"
        ret += str.to_i(2).to_s(16)
        return ret
    end

    def movesToString()
        ret = ""
        str = "#{@moves[:power].to_i}#{@moves[:accuracy].to_i}#{@moves[:type].to_i}#{@moves[:category].to_i}"
        ret += str.to_i(2).to_s(16)
        str = "00#{@moves[:movesets][:random].to_i}#{@moves[:movesets][:preferType].to_i}"
        ret += str.to_i(2).to_s(16)
        str = "#{@moves[:movesets][:metronome].to_i}#{@moves[:movesets][:scaleMoves].to_i}#{@moves[:movesets][:banSetDamage].to_i}#{@moves[:movesets][:newEvoMove].to_i}"
        ret += str.to_i(2).to_s(16)
        ret += @moves[:movesets][:forceGoodMoves].to_s(16)
        return ret
    end

    def trainersToString()
        ret = ""
        str = "#{@trainers[:random].to_i}#{@trainers[:class].to_i}#{@trainers[:name].to_i}#{@trainers[:fillParties].to_i}"
        ret += str.to_i(2).to_s(16)
        str = "#{@trainers[:keepStarters].to_i}#{@trainers[:ensureMega].to_i}#{@trainers[:ensureZMove].to_i}#{@trainers[:forceGym].to_i}"
        ret += str.to_i(2).to_s(16)
        str = "00#{@trainers[:similarBST].to_i}#{@trainers[:forceFullEvo].to_i}"
        ret += str.to_i(2).to_s(16)
        ret += @trainers[:forceFullEvoLevel].to_s(16)
        return ret
    end

    def encountersToString()
        ret = ""
        str = "0#{@encounters[:random].to_i}#{@encounters[:areamap].to_i}#{@encounters[:globalmap].to_i}"
        ret += str.to_i(2).to_s(16)
        str = "#{@encounters[:similarBST].to_i}#{@encounters[:typeThemed].to_i}#{@encounters[:disableLegends].to_i}#{@encounters[:items].to_i}"
        ret += str.to_i(2).to_s(16)
        ret += @encounters[:minCatchRate].to_s(16)
        return ret
    end

    def tmsToString()
        ret = ""
        str = "#{@tms[:random].to_i}#{@tms[:typeCompatibility].to_i}#{@tms[:randomCompatibility].to_i}#{@tms[:fullCompatibility].to_i}"
        ret += str.to_i(2).to_s(16)
        ret += @tms[:forceGoodMoves].to_s(16)
        return ret
    end

    def tutorsToString()
        ret = ""
        str = "0#{@tutors[:typeCompatibility].to_i}#{@tutors[:randomCompatibility].to_i}#{@tutors[:fullCompatibility].to_i}"
        ret += str.to_i(2).to_s(16)
        return ret
    end

    def itemsToString()
        ret = ""
        str = "#{@items[:field][:random].to_i}#{@items[:field][:typeMatch].to_i}#{@items[:mart][:random].to_i}#{@items[:mart][:typeMatch].to_i}"
        ret += str.to_i(2).to_s(16)
        str = "000#{@items[:pickup]}"
        ret += str.to_i(2).to_s(16)
        return ret
    end

    def miscFromString(string)
        bin                 = "%0#{4*MISC}d" % string.to_i(16).to_s(2)
        @misc[:allowMegas]  = bin[1] == "1"
        @misc[:allowForms]  = bin[2] == "1"
        @misc[:allowPULSE]  = bin[3] == "1"
        @misc[:genlimit]    = bin[4..].to_i(2)
    end

    def pkmnFromString(string)
        bin                                         = "%0#{4*PKMN}d" % string.to_i(16).to_s(2)
        @pkmn[:stats][:flipped]                     = bin[0] == "1"
        @pkmn[:stats][:shuffle]                     = bin[1] == "1"
        @pkmn[:stats][:random]                      = bin[2] == "1"
        @pkmn[:stats][:followEvo]                   = bin[3] == "1"
        @pkmn[:abilities][:random]                  = bin[7] == "1"
        @pkmn[:abilities][:wonderGuard]             = bin[8] == "1"
        @pkmn[:abilities][:followEvo]               = bin[9] == "1"
        @pkmn[:abilities][:banTraps]                = bin[10] == "1"
        @pkmn[:abilities][:banBad]                  = bin[11] == "1"
        @pkmn[:evolutions][:random]                 = bin[14] == "1"
        @pkmn[:evolutions][:changeImpossibleEvos]   = bin[15] == "1"
        @pkmn[:evolutions][:forceNewEvos]           = bin[16] == "1"
        @pkmn[:evolutions][:limitEvos]              = bin[17] == "1"
        @pkmn[:evolutions][:forceTyping]            = bin[18] == "1"
        @pkmn[:evolutions][:similarTarget]          = bin[19] == "1"
        @pkmn[:types][:random]                      = bin[20] == "1"
        @pkmn[:types][:followEvo]                   = bin[21] == "1"
        @pkmn[:types][:random]                      = bin[22] == "1"
        @pkmn[:types][:followEvo]                   = bin[23] == "1"
        @pkmn[:types][:dualType]                    = bin[24..].to_i(2)
    end

    def typesFromString(string)
        bin                     = "%0#{4*TYPES}d" % string.to_i(16).to_s(2)
        @types[:shuffle]        = bin[1] == "1"
        @types[:random]         = bin[2] == "1"
        @types[:chaos]          = bin[3] == "1"
        @types[:chaosResist]    = bin[4...12].to_i(2)
        @types[:chaosWeak]      = bin[12...20].to_i(2)
        @types[:chaosImmune]    = bin[20...28].to_i(2)
    end

    def staticsFromString(string)
        bin                                     = "%0#{4*STATICS}d" % string.to_i(16).to_s(2)
        @statics[:starters][:random]            = bin[1] == "1"
        @statics[:starters][:similarBST]        = bin[2] == "1"
        @statics[:starters][:forceTwoStage]     = bin[3] == "1"
        @statics[:starters][:starter]           = bin[4...16]
        @statics[:statics][:random]             = bin[19] == "1"
        @statics[:statics][:forceGrouping]      = bin[20] == "1"
        @statics[:trades][:given]               = bin[22] == "1"
        @statics[:trades][:requested]           = bin[23] == "1"
        @statics[:trades][:addItem]             = bin[24] == "1"
    end

    def movesFromString(string)
        bin                                 = "%0#{4*MOVES}d" % string.to_i(16).to_s(2)
        @moves[:power]                      = bin[0] == "1"
        @moves[:accuracy]                   = bin[1] == "1"
        @moves[:type]                       = bin[2] == "1"
        @moves[:category]                   = bin[3] == "1"
        @moves[:movesets][:random]          = bin[6] == "1"
        @moves[:movesets][:preferType]      = bin[7] == "1"
        @moves[:movesets][:metronome]       = bin[8] == "1"
        @moves[:movesets][:scaleMoves]      = bin[9] == "1"
        @moves[:movesets][:banSetDamage]    = bin[10] == "1"
        @moves[:movesets][:newEvoMove]      = bin[11] == "1"
        @moves[:movesets][:forceGoodMoves]  = bin[12..].to_i(2)
    end

    def trainersFromString(string)
        bin                             = "%0#{4*TRAINERS}d" % string.to_i(16).to_s(2)
        @trainers[:random]              = bin[0] == "1"
        @trainers[:class]               = bin[1] == "1"
        @trainers[:name]                = bin[2] == "1"
        @trainers[:fillParties]         = bin[3] == "1"
        @trainers[:keepStarters]        = bin[4] == "1"
        @trainers[:ensureMega]          = bin[5] == "1"
        @trainers[:ensureZMove]         = bin[6] == "1"
        @trainers[:forceGym]            = bin[7] == "1"
        @trainers[:similarBST]          = bin[10] == "1"
        @trainers[:forceFullEvo]        = bin[11] == "1"
        @trainers[:forceFullEvoLevel]   = bin[12..].to_i(2)
    end

    def encountersFromString(string)
        bin                             = "%0#{4*ENCOUNTERS}d" % string.to_i(16).to_s(2)
        @encounters[:random]            = bin[1] == "1"
        @encounters[:areamap]           = bin[2] == "1"
        @encounters[:globalmap]         = bin[3] == "1"
        @encounters[:similarBST]        = bin[4] == "1"
        @encounters[:typeThemed]        = bin[5] == "1"
        @encounters[:disableLegends]    = bin[6] == "1"
        @encounters[:items]             = bin[7] == "1"
        @encounters[:minCatchRate]      = bin[8..].to_i(2)
    end

    def tmsFromString(string)
        bin                         = "%0#{4*TMS}d" % string.to_i(16).to_s(2)
        @tms[:random]               = bin[0] == "1"
        @tms[:typeCompatibility]    = bin[1] == "1"
        @tms[:randomCompatibility]  = bin[2] == "1"
        @tms[:fullCompatibility]    = bin[3] == "1"
        @tms[:forceGoodMoves]       = bin[4..].to_i(2)
    end

    def tutorsFromString(string)
        bin                             = "%0#{4*TUTORS}d" % string.to_i(16).to_s(2)
        @tutors[:typeCompatibility]     = bin[1] == "1"
        @tutors[:randomCompatibility]   = bin[2] == "1"
        @tutors[:fullCompatibility]     = bin[3] == "1"
    end

    def itemsFromString(string)
        bin                         = "%0#{4*ITEMS}d" % string.to_i(16).to_s(2)
        @items[:field][:random]     = bin[0] == "1"
        @items[:field][:typeMatch]  = bin[1] == "1"
        @items[:mart][:random]      = bin[2] == "1"
        @items[:mart][:typeMatch]   = bin[3] == "1"
        @items[:pickup]             = bin[7] == "1"
    end
end

$RandomizerSettings = RandomizerSettings.new(Randomizer::TESTSEED)