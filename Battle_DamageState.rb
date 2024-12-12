class PokeBattle_DamageState
  attr_accessor :critical        # Critical hit flag
  attr_accessor :calcdamage      # Calculated damage
  attr_accessor :typemod         # Type effectiveness
  attr_accessor :substitute      # A substitute took the damage
  attr_accessor :disguise        # Disguise/Ice Face negated the damage
  attr_accessor :focusband       # Focus Band possible
  attr_accessor :focusbandused   # Focus Band actually used
  attr_accessor :focussash       # Focus Sash possible
  attr_accessor :focussashused   # Focus Sash used
  attr_accessor :sturdy          # Sturdy ability used
  attr_accessor :endured         # Damage was endured
  attr_accessor :pawnsturdy      # Focus Sash but for chess field
  attr_accessor :pawnsturdyused  # pawn ability used
  attr_accessor :rampcrest       # Rampardos Crest possible
  attr_accessor :rampcrestused   # Rampardos Crest used
  attr_accessor :stalwart        # Colosseum Stalwart sturdy

  def reset
    @hplost          = 0
    @critical        = false
    @calcdamage      = 0
    @typemod         = 0
    @substitute      = false
    @disguise        = false
    @focusband       = false
    @focusbandused   = false
    @focussash       = false
    @focussashused   = false
    @pawnsturdy      = false
    @sturdy          = false
    @endured         = false
    @rampcrest       = false
    @rampcrestused   = false
    @stalwart        = false
  end

  def initialize
    reset
    @pawnsturdyused = false
  end
end
