class PBTypes
  def PBTypes.maxValue
    return $cache.types.length
  end

  def PBTypes.isSpecialType?(type)
    return $cache.types[type].specialtype?(type)
  end

  def PBTypes.oneTypeEff(attackType,opponentType)
    return 2 if opponentType.nil?
    return 4 if $cache.types[opponentType].weak?(attackType)
    return 1 if $cache.types[opponentType].resists?(attackType)
    return 0 if $cache.types[opponentType].immune?(attackType)
    return 2
  end

  def PBTypes.twoTypeEff(attackType,opponentType1,opponentType2=nil)
    if opponentType2==nil
      return oneTypeEff(attackType,opponentType1)*2
    else
      mod1=oneTypeEff(attackType,opponentType1)
      mod2=(opponentType1==opponentType2) ? 2 : oneTypeEff(attackType,opponentType2)
      return (mod1*mod2)
    end
  end

  def PBTypes.typeResists(type)
    resists = []
    for i in $cache.types.keys
      resists.push(i) if $cache.types[i].resists?(type) || $cache.types[i].immune?(type)
    end
    return resists
  end

  def PBTypes.isTypeSE?(attackType,opponentType1,opponentType2=nil)
    e=PBTypes.twoTypeEff(attackType,opponentType1,opponentType2)
    return e>4
  end
end