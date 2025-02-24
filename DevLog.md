# Battle Log

## Intense
- Venam Gym, **UNTESTED**
- Alex + Sam (1), **UNTESTED**
- Valarie Gym
- Geara Terajuma Beach
- Zetta Terajuma Falls
- Neved Terajuma Falls
- Ren Helojak

## Kaizo
- Venam Gym, **UNTESTED**
- Alex + Sam (1), **UNTESTED**
- Valarie Gym
- Geara Terajuma Beach
- Tapu Koko Terajuma (Boss)
- Zetta Terajuma Falls
- Neved Terajuma Falls
- Ren Helojak
  - used Bellibolt
- Rorim B. Kakori
- Gothitelle Kakori (Boss)
- Crawli Gym
- Saki x Venam Boom Battle
- Jenner Aquamarine Cave
- Tapu Koko Magrodar (Boss)
- Madelis and Bart Aquamarine
- Neved Teila
- Belial (Boss)
- Angie Gym
- Texen


# TODOs:

  ## Changelog Updates:
    - Giga Pokemon
    - Signature Pokemon

  ## Bug list:
    - Changed abilities (like Worry Seed, etc.) do not persist past Giga evolution
    - Protect rate sharing does not reset after a flinch
    - No anim for Tapu Koko's Guardian of Alola?

  ## Implementation Dump
    - Moves:
      - Chi Strike (+1 to CHR for all allies)
    - Abilities:
      - Anticipation: shuddered pokemon takes 1/2 damage from first instance of SE attack
      - Forewarn: all allies avoid the first instance of the forewarned attack
      - Magician: uses Trick/Switcheroo when switching into battle (instead of normal effect)
      - Aftermath: also explodes for 100 BP upon fainting (matches user's primary stab typing)
      - Gold Envy: permanent Taunt
      - (Giga Pikachu): all other pokemon are "paralyzed" (volatile, can stack with other conditions)
    - Crests
      - Vespiquen Crest:
        - Defend Order naturally has increased priority, crested effect additionally applies quick guard, wide guard, and crafty shield
        - Attack Order naturally hits all foes, crested effect additionally gives it +1 priority and breaks through protect
        - Heal Order naturally cures status effects, crested effect additionally heals friendly pokemon's hp by 25% and cures their status
      - Ariados Crest:
        - Make more viable on Swamp field
          - always moves before targets with lowered speed (increased priority stage)
          - always crits targets with lowered speed (can remove poisoned trigger)

  ## Testing Backlog
    - Chthonic Malady
    - Barbed Web (@Ren)

  ## AI implementation Backlog
    ### Giga Evolution
    - implement giga Evolution knowledge (like Mega -- can see core, know about typing changes, etc.)
    - update movelist in pbGiga Evolve
    - implement proper re-targeting for giga moves (the turn of giga evolution)
    - add logic to discourage ineffective attacks against Giga pokemon
    - add logic to encourage using moves that would encourage the Giga pokemon to switch out
    - update HP and damage calculation values (ensure it's working properly)
    - add logic to handle Giga moves
    - flagged in Pokemon.rb
    - giga Urshifu (yuck)

    ### Moves
    - All giga moves yippee
    - All new moves (including ANIMATIONS)
    - Changed Moves:
      - Dragon Cheer, Focus Energy
      - Chthonic Malady
      - Embargo
      - Barbed Web
      - Guardian of Alola

    ### Abilities
    - Changed Abilities
      - Frisk
      - Damp
      - Aftermath
      - Unnerve
      - Pressure
      - Supersweet Syrup
      - Cursed Body

    - New Abilities
      - Meteor Impactor
      - Melodramatic

    ## Crests
    - Changed Crests
    - New Crests
      - Cacturne
      - Klinklang
      - Emboar

  ## Other
    - Learnset updates for new moves

# Journal

- 2/23/2025
  - updated terrain overlaying effects (fixed on 2/23)
  - small trainer skill bug fix (applying Mean Look)
  - fixed Unburden bug + interaction on Swamp when consuming Telluric Seed
  - overrode Dragon Cheer / Focus Energy incompatibility
  - fixed targeting on Freezing Glare and Fiery Wrath
  - standardized BST buffs for signature pokemon (+50/+100)

- 2/16/25
  - Flurry -> update learnset for pokemon

- 2/7/25 (@SWu)
  - Lowkey I should figure out if/how neutralizing gas works
  - Solar Power bug? (still taking damage)
  - Beat Up x Rage Fist AI code -- needs fixing (increased priorityscore + check to see if beat up has already been used once, also may hardcode for Neved fight?) + also patch for stamina
  - Dragon Darts bug in Doubles (checkType issue) -- I just removed it for now, not sure how relevant the score boost actually is
  - touched the ally Gigaband code check (maybe this fucks things up idk)

- 1/25/25 (@SWu)
  - Embargo update needs more testing
  - Fixed Magnet Rise bug (inconsistency with caps)

- 1/24/25 (@SWu)
  - Fixed minor compilation bugs
  - Updated magnet rise checks to be != 0 instead of > 0
  - Created Pressure and Unnerve onactive handlers (mocked after Intimidate)
  - Implemented Giga Eevee: Debutante, Giga Cuddle
  - Implemented Klinklang Crest
  - Added attributes for Anticipation and Forewarn changes, have not actually implemented those changes yet

- 1/17/25 (@SWu)
  - Ability Updates (Implemented)
    - Pressure, Unnerve -> Intimidate copies (including blocked abilities, adrenaline orb, guard dog etc)
  - Other
    - Embargo: now effects the entire team for 5 turns

- 1/13/25 (@SWu)
  - AI backlog (to implement)
    - updated Unburden to work with boss battles better
    - double-check self-destruct code
    - Barbed Web
    - Pinch Berries
    - Swarm

  - updated Taunt to check for != 0 (allows for infinite Taunt to be applied if negative)
  - commented out runtrainerskills in Battle.rb (causing issues)
  - updated AI for pinch abilities
  - replaced all SWUMOD instances with KAIZOMOD
  - Barbed Web:
    - cursory AI implementation
    - excluded from Shield Dust / Covert Cloak / Sheer Force (like Ceaseless Edge)
  - Giga Moves not documented yet (still not finalized)
  - fixed setweather trainer skill bug, removed double faint handler (unused)


- 1/10/25 (@SWu)
  - Update battle.inspect to work with negative effect counters (like Taunt, Heal Block)

- 1/9/25 (@SWu)
  - Finally figured out how to make Giga moves break through protect
  - Fixed giga move priority on turn of giga evolution
  - Terapagos and Ogerpon mega evolution now does not require a mega slot
    - added internal mega blocker item to prevent certain battles from mega evolving them by default
    - can consider reworking to be similar to Giga evolution, requiring an item in bag
  - fully imported all trainer skill logic (runtrainerskills)
  - Corv crest erased (but logic kept as comments for future reference)
  - Defog now clears terrain overlays

- 1/8/25 (@SWu)
 - updated Heal Block logic to check for != 0 (to allow -1 to be infinite heal block)
 - improved Magnitude rolls with Loaded Dice (might need to double check this)
 - refactored show_message logic to allow for move use message suppression
 - reverted Moody nerf
 - re-ambiguated crests to allow for use regardless of pokemon form
 - Z-Move side effects can now trigger, and bypass Shield Dust / Sheer Force / Covert Cloak
- reverted Ledian + Cincinno crest nerfs (allow for side effects on subsequent hits)
- added instantmove to boss battles
- (old) added starter skills for trainer battles
- Darkglare (or whatever Geara's ability will be) not currently implemented
- temporarily removed terrain destroying effect of Ice Spinner

- 1/2/25 (@SWu)
  - retroactively KAIZOMODDIFY some changes?
    - including move changes (can hard code them in PBMOVE)

- 12/29/24 (@SWu)
  - updated Captivate x Attract to work irrespective of gender
  - minor update to AI code for giga moves (Resonance and Snooze)
  - fixed Giga Evolution not properly keeping old ability
  - beach field updates
  - re-ordered pokemon form data so Giga forms use their G-Mega sprites
  - disabled Terajuma password (softlock protection)

- 12/27/2024 (@SWu)
  - minor AI giga evolution tweaks 
  - fixed Protect bug? (now counter resets if the last move by the user isn't successful)

- 12/26/2024 (@SWu)
  - finally fixed Giga evolution bug (properly registers and checks choice to Giga evolve now)
  - still cannot combine Aurora Veil + Sparkling Aria animation for Resonance
    - FIXED: needed to call pbAnimation from @battle (not the overridden function in the class)
  - AI updates for Giga:
    - discouraged switching giga pokemon

- 12/25/2024 (@SWu)
  - updated Z-Moves not breaking through Wide Guard properly
  - migration of Giga Evolution Logic
    - kept old Mega stones intact, along with Mega logic
    - new Giga Core items created, along with Giga Band
    - implemented Lapras (for Valarie), need to update montext.rb for the other Giga forms

  - changed logic so that move relearner is an egg move relearner instantly

- 12/24/24 (batched with previous commits, @SWu)
  - implemented KAIZOMOD constant for future changes
  - Gengar + Revavroom line ability updates
  - Paldean Wooper + Clodsire encounterable on Helojak Island (not globally sync-ed in .rxproj file yet)
  - powerpack password now gives you a shit ton of candy
  - reverted nature mapping of macho brace
  - removed PC option to toggle between hail/snow (combined hail is now forced)
    - reverted game defaults for hail/snow since it was crashing the game
    - fixed bug where snow was not properly giving ice types x1.5 defense
  - combined hail/snow implementation (including all AI implementation)
  - grass pokemon have x1.5 defense in sun and x1.5 special defense in rain
  - replaced freeze with frostbite entirely (including all AI implementations)    
  - forced consumable item restoration (including berries) and the end of each battle
  - improved wild pokemon catch chances
  - Angie and Valarie Gym Battles updated (standard and kaizo)
   - misc bug fixes
    - :PETRIFICATION typo (as :PETRFICATION, preventing it from being cured by attacks)
    - :FROZEN typo (as :FREEZE, for 2-turn attacks and boss battles)

- 12/16/25 (@SWu)
  - Added LAWDS macho brace implementation for QoL

- 12/15/24 (@SWu)
  - Added bulk passwords: "standardmode" and "kaizomode"
    - includes: fullivs, noitems, freeexpall, easyhms, unrealtime, pinata, powerpack
    - additionally: forces battle to be set mode
  - Reconfigured game defaults:
    - Set Mode
    - All consumable items restored after battle (including berries)
    - Hail and Snow are combined