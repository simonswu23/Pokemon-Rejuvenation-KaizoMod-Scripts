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
  - used Bellibolt

# Progress

- 1/9/25
  - Finally figured out how to make Giga moves break through protect
  - TODO: bug -- changed abilities (like Worry Seed, etc.) do not persist past Giga evolution
  - Fixed giga move priority on turn of giga evolution
  - TODO: backlog AI updates (since 1/8/25 commits)
    - missing:
      - Crests (Cacturne, Corviknight)
      - Crash Landing and Melodramatic code
    - individually log every priority change in the future
  - Terapagos and Ogerpon mega evolution now does not require a mega slot
    - added internal mega blocker item to prevent certain battles from mega evolving them by default
    - can consider reworking to be similar to Giga evolution, requiring an item in bag
  - fully imported all trainer skill logic (runtrainerskills)
  - Corv crest erased (but logic kept as comments for future reference)
  - Defog now clears terrain overlays
    - TODO: actually cause terrains to be separate layer (like weather), and for them to override each other


  - Crawli todos:
    - Vespiquen Crest:
      - Defend Order naturally has increased priority, crested effect additionally applies quick guard, wide guard, and crafty shield
      - Attack Order naturally hits all foes, crested effect additionally gives it +1 priority and breaks through protect
      - Heal Order naturally cures status effects, crested effect additionally heals friendly pokemon's hp by 25% and cures their status
    - Ariados Crest:
      - Make more viable on Swamp field
        - always moves before targets with lowered speed (increased priority)
        - always crits targets with lowered speed (can remove poisoned effect)
    - Barbed Web:
      - copy old swumod implementation
    - Swap field ordering: forest for gym, swamp for jynobi
    - Giga Appletun
      - Bug/Dragon type
      - Honeypot max move (renamed from sweetness): cures ally status conditions
      - Give it recycle (good enough)
      - Un-nerf pinch berries
  - Giga Moves should stick to canon, except:
    - Wind Rage -> defog effect
    - Volcalith -> fire-type stealth rock hazard
    - Depletion -> removes all positive stat changes
    - Meltdown -> badly poisons all targets, regardless of typing
    - Sandblast -> desert's mark effect instead
    - Centiferno -> burn
    - Stun Shock -> paralysis
    - Foam Burst -> frostbite
    - Tartness -> harshly lowers foes evasion
    - Volt Crash -> ignores abilities, immunities when dealing damage
    - Gold Rush -> +1 priority, follow me
    - Cuddlestorm (Cuddle) -> infatuates the target
    - Giant's Drum (Drum Solo) -> normal type attack, spread attack (TODO: fix, also add AI logic here since base is now Drum Beating)
    - Hydrosnipe -> +2 CHR
    - Fireball -> +1 priority
  - TODO: signature abilities for Giga Meowth, Eevee, and Pikachu
    - Meowth: Gold Envy (permanent taunt effect)
    - Eevee: TBD (foes are locked into using a single attack)
    - Pikachu: TBD (all other pokemon are "temporarily" paralyzed, except electric types, ground types, and pokemon with quick feet/limber)


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
- (old) added starter skills for trainer battles
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