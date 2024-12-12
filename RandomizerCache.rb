class Cache_Randomizer
    attr_reader :misc
    attr_reader :pkmn
    attr_reader :types
    attr_reader :statics
    attr_reader :moves
    attr_reader :trainers
    attr_reader :encounters
    attr_reader :tms
    attr_reader :tutors
    attr_reader :items

    def initialize
        File.exists?("Randomizer/misc.dat") ? @misc = load_data("Randomizer/misc.dat") if !@misc : print "File /Randomizer/misc.dat not found!"
        File.exists?("Randomizer/mons.dat") ? @pkmn = load_data("Randomizer/mons.dat") if !@pkmn : print "File /Randomizer/mons.dat not found!"
        File.exists?("Randomizer/moves.dat") ? @moves = load_data("Randomizer/mons.dat") if !@moves : print "File /Randomizer/moves.dat not found!"
        File.exists?("Randomizer/mons.dat") ? @pkmn = load_data("Randomizer/mons.dat") if !@pkmn : print "File /Randomizer/mods.dat not found!"
        File.exists?("Randomizer/mons.dat") ? @pkmn = load_data("Randomizer/mons.dat") if !@pkmn : print "File /Randomizer/mods.dat not found!"
        
        
    end

end