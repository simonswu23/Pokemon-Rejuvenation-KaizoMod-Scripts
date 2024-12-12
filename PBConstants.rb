# Combined multiple PB[etc] scripts into one.
# Ordered as follows:
# PBStatuses
# PBStats
# PBWeather
# PBEnvironment
# PBEffects
# PBNatures
class PBStatuses
  SLEEP     = 1
  POISON    = 2
  BURN      = 3
  PARALYSIS = 4
  FROZEN    = 5
  FAINTED   = 6
  POKERUS   = 7
end

class PBStats
  HP       = 0
  ATTACK   = 1
  DEFENSE  = 2
  SPATK    = 3
  SPDEF    = 4
  SPEED    = 5
  ACCURACY = 6
  EVASION  = 7

  StageMul = [
    2.0 / 8,
    2.0 / 7,
    2.0 / 6,
    2.0 / 5,
    2.0 / 4,
    2.0 / 3,
    2.0 / 2,
    3.0 / 2,
    4.0 / 2,
    5.0 / 2,
    6.0 / 2,
    7.0 / 2,
    8.0 / 2,
  ]
end

module PBNatures
  HARDY   = 0
  LONELY  = 1
  ADAMANT = 2
  NAUGHTY = 3
  BRAVE   = 4
  BOLD    = 5
  DOCILE  = 6
  IMPISH  = 7 
  LAX     = 8
  RELAXED = 9
  MODEST  = 10 
  MILD    = 11 
  BASHFUL = 12 
  RASH    = 13
  QUIET   = 14  
  CALM    = 15 
  GENTLE  = 16 
  CAREFUL = 17  
  QUIRKY  = 18 
  SASSY   = 19 
  TIMID   = 20
  HASTY   = 21
  SERIOUS = 22
  JOLLY   = 23
  NAIVE   = 24

  def PBNatures.maxValue; 24; end
  def PBNatures.getCount; 25; end

  def PBNatures.getName(id)
    names=[
       _INTL("Hardy"),
       _INTL("Lonely"),
       _INTL("Brave"),
       _INTL("Adamant"),
       _INTL("Naughty"),
       _INTL("Bold"),
       _INTL("Docile"),
       _INTL("Relaxed"),
       _INTL("Impish"),
       _INTL("Lax"),
       _INTL("Timid"),
       _INTL("Hasty"),
       _INTL("Serious"),
       _INTL("Jolly"),
       _INTL("Naive"),
       _INTL("Modest"),
       _INTL("Mild"),
       _INTL("Quiet"),
       _INTL("Bashful"),
       _INTL("Rash"),
       _INTL("Calm"),
       _INTL("Gentle"),
       _INTL("Sassy"),
       _INTL("Careful"),
       _INTL("Quirky")
    ]
    return names[id]
  end
end