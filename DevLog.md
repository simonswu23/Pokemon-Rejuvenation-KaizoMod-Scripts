# Battle Log

## Intense
- Venam Gym, **UNTESTED**
- Alex + Sam (1), **UNTESTED**
- Valarie (Gym)
- Geara (Terajuma Beach)
- Zetta (Terajuma Falls)
- Neved (Terajuma Falls)
- Ren (Helojak)

## Kaizo
- Venam Gym, **UNTESTED**
- Alex + Sam (1), **UNTESTED**
- Valarie (Gym)
- Geara (Terajuma Beach)
- Tapu Koko (Boss)
- Zetta (Terajuma Falls)
- Neved (Terajuma Falls)
- Ren (Helojak)

# Progress

- 1/9/25
  - Finally figured out how to make Giga moves break through protect
  - TODO: bug -- changed abilities (like Worry Seed, etc.) do not persist past Giga evolution
  - 

- 1/8/25
 - updated Heal Block logic to check for != 0 (to allow -1 to be infinite heal block)
 - improved Magnitude rolls with Loaded Dice (might need to double check this)
 - refactored show_message logic to allow for move use message suppression
 - reverted Moody nerf
 - re-ambiguated crests to allow for use regardless of pokemon form
 - Guardian of Alola rework
  - TODO: add AI here? (default AI always uses Z-move first if possible
  - TODO: add proper Tapu Koko anim (or debug if it exists)
 - TODO: add AI logic for Crash Landing Ability
 - Z-Move side effects can now trigger, and bypass Shield Dust / Sheer Force / Covert Cloak
  - TODO: fix Z-moves so they bypass protect
- reverted Ledian + Cincinno crest nerfs (allow for side effects on subsequent hits)
- added instantmove to boss battles
- (old) added starter skills for trainer battles (TODO: import over logic for additional trainer skills) 
- Darkglare (or whatever Geara's ability will be) not currently implemented
- TODO: Update Giga pokemon in the Changelog (can paste from previous)
- TODO: Update signature pokemon in the Changelog
- temporarily removed terrain destroying effect of Ice Spinner

- 1/2/25
  - retroactively SWUMODDIFY some changes?
    - including move changes (can hard code them in PBMOVE)
  - TODO: fix bug -- Z moves do not trigger side effect chances

- 12/29/24
  - updated Captivate x Attract to work irrespective of gender
  - minor update to AI code for giga moves (Resonance and Snooze)
  - fixed Giga Evolution not properly keeping old ability
  - beach field updates
  - re-ordered pokemon form data so Giga forms use their G-Mega sprites
  - disabled Terajuma password (softlock protection)

- 12/27/2024
  - minor AI giga evolution tweaks 
  - fixed Protect bug? (now counter resets if the last move by the user isn't successful)

- 12/26/2024
  - finally fixed Giga evolution bug (properly registers and checks choice to Giga evolve now)
  - still cannot combine Aurora Veil + Sparkling Aria animation for Resonance
    - FIXED: needed to call pbAnimation from @battle (not the overridden function in the class)
  - AI updates for Giga:
    - discouraged switching giga pokemon

- 12/25/2024
  - updated Z-Moves not breaking through Wide Guard properly
  - migration of Giga Evolution Logic
    - kept old Mega stones intact, along with Mega logic
    - new Giga Core items created, along with Giga Band
    - implemented Lapras (for Valarie), need to update montext.rb for the other Giga forms
  - TODO: fix Urshifu
  - TODO: fix Giga move targeting
    - flagged in Battler.rb
  - TODO: implement Giga AI logic
    - update movelist in pbGiga Evolve
    - add logic to discourage ineffective attacks against Giga pokemon
    - add logic to encourage using moves that would encourage the Giga pokemon to switch out
    - update HP and damage calculation values (ensure it's working properly)
    - add logic to handle Giga moves
    - flagged in Pokemon.rb
  - changed logic so that move relearner is an egg move relearner instantly

- 12/24/24 (batched with previous commits)
  - implemented SWUMOD constant for future changes
  - Gengar + Revavroom line ability updates
  - Paldean Wooper + Clodsire encounterable on Helojak Island (not globally sync-ed in .rxproj file yet)
  - powerpack password now gives you a shit ton of candy
  - reverted nature mapping of macho brace
  - removed PC option to toggle between hail/snow (combined hail is now forced)
    - reverted game defaults for hail/snow since it was crashing the game
    - fixed bug where snow was not properly giving ice types x1.5 defense
  - combined hail/snow implementation (including all AI implementation)
    - TODO: currently called "Snowscape", change back to "Hail" somehow
  - grass pokemon have x1.5 defense in sun and x1.5 special defense in rain
  - replaced freeze with frostbite entirely (including all AI implementations)    
  - forced consumable item restoration (including berries) and the end of each battle
      - TODO: might need to double-check how item stealing works here (patch if it's an issue)
  - improved wild pokemon catch chances
  - Angie and Valarie Gym Battles updated (standard and kaizo)
   - misc bug fixes
    - :PETRIFICATION typo (as :PETRFICATION, preventing it from being cured by attacks)
    - :FROZEN typo (as :FREEZE, for 2-turn attacks and boss battles)

- 12/16/25
  - Added LAWDS macho brace implementation for QoL

- 12/15/24
  - Venam Gym Battle updated (standard and kaizo)
    - TODO: playtest
  - Form data for Venam's signature Seviper added (2 versions, Gearen + Post Gearen)
  - Added bulk passwords: "standardmode" and "kaizomode"
    - includes: fullivs, noitems, freeexpall, easyhms, unrealtime, pinata, powerpack
    - additionally: forces battle to be set mode
  - Reconfigured game defaults:
    - Set Mode
    - All consumable items restored after battle (including berries)
    - Hail and Snow are combined