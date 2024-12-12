class PBMove
  attr_reader(:move)     # Gets the symbol of the move
  attr_accessor(:pp)     # Gets the number of PP remaining for this move.
  attr_accessor(:ppup)   # Gets the number of PP Ups used for this move.

  def initialize(move=nil)
    @move=move
    @ppup=0
    @pp=totalpp
  end

  def totalpp
    return (maxpp * (1 + 0.2 * @ppup)).floor
  end
  
  #yanking these from PB_Move. might be unnecessary!
  def function
    return $cache.moves[@move].function
  end

  def type
    return $cache.moves[@move].type
  end

  def category
    return $cache.moves[@move].category
  end

  def basedamage
    return $cache.moves[@move].basedamage
  end

  def accuracy
    return $cache.moves[@move].accuracy
  end

  def maxpp
    return $cache.moves[@move].maxpp
  end

  def target
    return $cache.moves[@move].target
  end

  def desc
    return $cache.moves[@move].desc
  end
end