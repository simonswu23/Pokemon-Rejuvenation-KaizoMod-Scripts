module PBExp
  MAXLEVEL=MAXIMUMLEVEL # See the settings for changing the max level

# Erratic (600000):
#   For levels 0-50: n**3([100-n]/50)
#   For levels 51-68: n**3([150-n]/100)
#   For levels 69-98: n**3(1.274-[1/50][n/3]-p(n mod 3)) 
#     where p(x) = array(0.000,0.008,0.014)[x]
#   For levels 99-100: n**3([160-n]/100)
# Fluctuating (1640000):
#   For levels 0-15: n**3([24+{(n+1)/3}]/50)
#   For levels 16-35: n**3([14+n]/50)
#   For levels 36-100: n**3([32+{n/2}]/50)

  def self.pbGetExpInternal(level,growth) # :nodoc:
    case growth
      when :Erratic
        return (level**3 * ((100-level)/50.0)).floor if level <= 50
        return (level**3 * ((150-level)/100.0)).floor if level <= 68
        return (level**3 * (1.274-(1.0/50.0)*(level/3)-[0.000,0.008,0.014][level%3])).floor if level <= 99
        return ( (level**3)*( (level * 6 / 10.0) / (100*1.0) ) ).floor
      when :Fluctuating
        return (level**3 * (24+((level+1)/3.0))/50.0).floor if level <= 15
        return (level**3 * (14+level)/50.0).floor if level <= 35
        return (level**3 * (32+(level/2))/50.0).floor if level <= 100
        rate = [82 - (level-100)/2.0, 30].max
        return (level**3 * (level / 100.0) * (rate / 50.0)).floor #unnecessary parentheses for clarity
      when :MediumSlow then return ((6*(level**3)/5.0) - 15*(level**2) + 100*level - 140).floor
      when :Fast       then return ( 4*(level**3)/5.0 ).floor
      when :MediumFast then return level**3 
      when :Slow       then return ( 5*(level**3)/4.0 ).floor
    end
  end

# Gets the maximum Exp Points possible for the given growth rate.
# growth -- Growth rate.
  def PBExp.maxExperience(growth)
    finallevelcap = 100 + $game_variables[:Extended_Max_Level]
    return pbGetExpInternal(finallevelcap,growth)
  end

# Gets the number of Exp Points needed to reach the given
# level with the given growth rate.
# growth -- Growth rate.
  def PBExp.startExperience(level,growth)
    level=MAXLEVEL if level>MAXLEVEL
    return [0,pbGetExpInternal(level,growth)].max
  end

# Adds experience points ensuring that the new total doesn't
# exceed the maximum Exp. Points for the given growth rate.
# currexp -- Current Exp Points.
# expgain -- Exp. Points to add
# growth -- Growth rate.
  def PBExp.addExperience(currexp,expgain,growth)
    exp=currexp+expgain
    finallevelcap = 100 + $game_variables[:Extended_Max_Level]
    maxexp = pbGetExpInternal(finallevelcap,growth)
    exp=maxexp if exp>maxexp
    return exp
  end

# Calculates a level given the number of Exp Points and growth rate.
# growth -- Growth rate.
  def PBExp.levelFromExperience(exp,growth)
    maxexp=pbGetExpInternal(MAXLEVEL,growth)
    exp=maxexp if exp>maxexp
    for i in 0..MAXLEVEL
      currentExp=pbGetExpInternal(i,growth)
      return i if exp==currentExp
      return i-1 if exp<currentExp
    end
    return MAXLEVEL
  end
end