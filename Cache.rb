class Cache_Game
    attr_reader :pkmn
    attr_reader :moves
    attr_reader :move2anim
    attr_reader :items
    attr_reader :trainers
    attr_reader :trainertypes
    attr_reader :FEData
    attr_reader :FENotes
    attr_reader :types
    attr_reader :abil
    attr_reader :mapinfos
    attr_reader :mapdata
    attr_reader :regions
    attr_reader :encounters
    attr_reader :metadata
    attr_reader :bosses
    attr_reader :map_conns
    attr_reader :town_map
    attr_reader :animations
    attr_reader :RXsystem
    attr_reader :RXevents
    attr_reader :RXtilesets
    attr_reader :RXanimations
    attr_reader :cachedmaps
    attr_reader :natures
    attr_reader :shadows

    #Caching functions
    def cacheDex
        compileMons if !File.exists?("Data/mons.dat")
        @pkmn               = load_data("Data/mons.dat") if !@pkmn
    end

    def cacheMoves
        compileMoves if !File.exists?("Data/moves.dat")
        @moves          = load_data("Data/moves.dat") if !@moves
        @move2anim          = load_data("Data/move2anim.dat") if !@move2anim
    end

    def cacheItems
        compileItems if !File.exists?("Data/items.dat")
        @items           = load_data("Data/items.dat") if !@items
    end

    def cacheTrainers
        @trainers           = load_data("Data/trainers.dat") if !@trainers
        compileTrainerTypes if !File.exists?("Data/ttypes.dat")
        @trainertypes       = load_data("Data/ttypes.dat") if !@trainertypes
    end

    def cacheAbilities
        compileAbilities if !File.exists?("Data/abil.dat")
        @abil               = load_data("Data/abil.dat") if !@abil
    end

    def cacheBattleData
        compileFields if !File.exists?("Data/fields.dat")
        compileFieldNotes if !File.exists?("Data/fieldnotes.dat") && !Rejuv
        compileBosses if Rejuv && !File.exists?("Data/bossdata.dat") 
        @FEData             = load_data("Data/fields.dat") if !@FEData
        @FENotes            = load_data("Data/fieldnotes.dat") if !@FENotes && !Rejuv
        compileTypes if !File.exists?("Data/types.dat")
        cacheAbilities
        @types              = load_data("Data/types.dat") if !@types
        @bosses             = load_data("Data/bossdata.dat") if !@bosses && Rejuv
    end

    def cacheMapInfos
        @mapinfos           = load_data("Data/MapInfos.rxdata") if !@mapinfos
    end

    def cacheMetadata
        #@regions            = load_data("Data/regionals.dat") if !@regions
        @metadata           = load_data("Data/meta.dat") if !@metadata
        @mapdata            = load_data("Data/maps.dat") if !@mapdata
        @map_conns          = load_data("Data/connections.dat") if !@map_conns
        @town_map           = load_data("Data/townmap.dat") if !@town_map
        @natures            = load_data("Data/natures.dat") if !@natures
        #MessageTypes.loadMessageFile("Data/Messages.dat")
    end
    
    def initialize
        cacheDex
        cacheMoves
        cacheItems
        cacheTrainers
        cacheBattleData
        cacheMetadata
        cacheMapInfos
        cacheAnims
        cacheTilesets
        @RXanimations       = load_data("Data/Animations.rxdata") if !@RXanimations
        @RXevents           = load_data("Data/CommonEvents.rxdata") if !@RXevents
        @RXsystem           = load_data("Data/System.rxdata") if !@RXsystem
    end

    def cacheTilesets
        @RXtilesets         = load_data("Data/Tilesets.rxdata") if !@RXtilesets
    end

    def cacheAnims
        @animations         = load_data("Data/PkmnAnimations.rxdata") if !@animations
    end

    def animations=(value)
        @animations = value
    end

    def map_load(mapid)
        @cachedmaps = [] if !@cachedmaps
        if !@cachedmaps[mapid]
            puts "loading map",mapid
            @cachedmaps[mapid] = load_data(sprintf("Data/Map%03d.rxdata", mapid))
        end
        return @cachedmaps[mapid]
    end
end
$cache = Cache_Game.new if !$cache