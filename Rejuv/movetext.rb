MOVEHASH = {
:MEGAHORN => {
    :ID => 1,
    :name => "Megahorn",
    :function => 0x000,
    :type => :BUG,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 85,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Using its tough and impressive horn, the user rams into the target with no letup."
},

:ATTACKORDER => {
    :ID => 2,
    :name => "Attack Order",
    :function => 0x000,
    :type => :BUG,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 100,
    :target => :AllOpposing,
    :highcrit => true,
    :desc => "The user calls out its underlings to pummel the target. Critical hits land more easily."
},

:BUGBUZZ => {
    :ID => 3,
    :name => "Bug Buzz",
    :function => 0x046,
    :type => :BUG,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 10,
    :target => :SingleNonUser,
    :soundmove => true,
    :desc => "The user vibrates its wings to make a sound wave. It may lower the target's Sp. Def."
},

:XSCISSOR => {
    :ID => 4,
    :name => "X-Scissor",
    :function => 0x000,
    :type => :BUG,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :sharpmove => true,
    :desc => "The user slashes at the target by crossing its claws as if they were a pair of scissors."
},

:SIGNALBEAM => {
    :ID => 5,
    :name => "Signal Beam",
    :function => 0x013,
    :type => :BUG,
    :category => :special,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 10,
    :target => :SingleNonUser,
    :beammove => true,
    :desc => "The user attacks with a sinister beam of light. It may also confuse the target."
},

:UTURN => {
    :ID => 6,
    :name => "U-turn",
    :function => 0x0EE,
    :type => :BUG,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "After making its attack, the user switches places with a party Pokémon in waiting."
},

:STEAMROLLER => {
    :ID => 7,
    :name => "Steamroller",
    :function => 0x010,
    :type => :BUG,
    :category => :physical,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user crushes its targets by rolling over them with its rolled-up body. This attack may make the target flinch."
},

:BUGBITE => {
    :ID => 8,
    :name => "Bug Bite",
    :function => 0x0F4,
    :type => :BUG,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user bites the target. If the target is holding a Berry, the user eats it."
},

:SILVERWIND => {
    :ID => 9,
    :name => "Silver Wind",
    :function => 0x02D,
    :type => :BUG,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 5,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "The target is hit with powdery scales blown by wind. It may raise all the user's stats."
},

:STRUGGLEBUG => {
    :ID => 10,
    :name => "Struggle Bug",
    :function => 0x045,
    :type => :BUG,
    :category => :special,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 100,
    :target => :AllOpposing,
    :desc => "While resisting, the user attacks the opposing Pokémon. The targets' Sp. Atk is reduced."
},

:TWINEEDLE => {
    :ID => 11,
    :name => "Twineedle",
    :function => 0x0BE,
    :type => :BUG,
    :category => :physical,
    :basedamage => 25,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 20,
    :target => :SingleNonUser,
    :desc => "The user damages the target twice by jabbing it with spikes. It may poison the target."
},

:FURYCUTTER => {
    :ID => 12,
    :name => "Fury Cutter",
    :function => 0x091,
    :type => :BUG,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 95,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :sharpmove => true,
    :desc => "The target is slashed with claws. Its power increases if it hits in succession."
},

:LEECHLIFE => {
    :ID => 13,
    :name => "Leech Life",
    :function => 0x0DD,
    :type => :BUG,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user drains the target's blood. The user's HP is restored by half the damage taken."
},

:PINMISSILE => {
    :ID => 14,
    :name => "Pin Missile",
    :function => 0x0C0,
    :type => :BUG,
    :category => :physical,
    :basedamage => 25,
    :accuracy => 95,
    :maxpp => 20,
    :target => :SingleNonUser,
    :desc => "Sharp spikes are shot at the target in succession. They hit two to five times in a row."
},

:DEFENDORDER => {
    :ID => 15,
    :name => "Defend Order",
    :function => 0x02A,
    :type => :BUG,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :priority => 3,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user calls out its underlings to shield its body, raising its Defense and Sp. Def."
},

:HEALORDER => {
    :ID => 16,
    :name => "Heal Order",
    :function => 0x0D5,
    :type => :BUG,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The user calls out its underlings to heal it. The user regains up to half of its max HP."
},

:QUIVERDANCE => {
    :ID => 17,
    :name => "Quiver Dance",
    :function => 0x02B,
    :type => :BUG,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user performs a mystic dance. It boosts the user's Sp. Atk, Sp. Def, and Speed."
},

:RAGEPOWDER => {
    :ID => 18,
    :name => "Rage Powder",
    :function => 0x117,
    :type => :BUG,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :priority => 2,
    :nonmirror => true,
    :desc => "The user scatters irritating powder to draw attention. Opponents aim only at the user."
},

:SPIDERWEB => {
    :ID => 19,
    :name => "Spider Web",
    :function => 0x0EF,
    :type => :BUG,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :magiccoat => true,
    :desc => "The user ensnares the target with thin, gooey silk so it can't flee from battle."
},

:STRINGSHOT => {
    :ID => 20,
    :name => "String Shot",
    :function => 0x04D,
    :type => :BUG,
    :category => :status,
    :basedamage => 0,
    :accuracy => 95,
    :maxpp => 40,
    :target => :AllOpposing,
    :magiccoat => true,
    :desc => "The targets are bound with silk blown from the user. This silk reduces the targets' Speed."
},

:TAILGLOW => {
    :ID => 21,
    :name => "Tail Glow",
    :function => 0x039,
    :type => :BUG,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user stares at flashing lights to focus its mind, drastically raising its Sp. Atk."
},

:FOULPLAY => {
    :ID => 22,
    :name => "Foul Play",
    :function => 0x121,
    :type => :DARK,
    :category => :physical,
    :basedamage => 95,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "This move uses the target's power. The higher the target's Attack, the more damage taken."
},

:NIGHTDAZE => {
    :ID => 23,
    :name => "Night Daze",
    :function => 0x047,
    :type => :DARK,
    :category => :special,
    :basedamage => 85,
    :accuracy => 95,
    :maxpp => 10,
    :effect => 40,
    :target => :SingleNonUser,
    :desc => "The user lets loose a black shock wave. It may also lower the target's accuracy."
},

:CRUNCH => {
    :ID => 24,
    :name => "Crunch",
    :function => 0x043,
    :type => :DARK,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user crunches up the target with sharp fangs. It may lower the target's Defense."
},

:DARKPULSE => {
    :ID => 25,
    :name => "Dark Pulse",
    :function => 0x00F,
    :type => :DARK,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 20,
    :target => :SingleNonUser,
    :desc => "The user releases an aura imbued with dark thoughts. It may make the target flinch."
},

:SUCKERPUNCH => {
    :ID => 26,
    :name => "Sucker Punch",
    :function => 0x116,
    :type => :DARK,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :priority => 1,
    :contact => true,
    :desc => "This move attacks first. It fails if the target is not attacking, however."
},

:NIGHTSLASH => {
    :ID => 27,
    :name => "Night Slash",
    :function => 0x000,
    :type => :DARK,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :highcrit => true,
    :sharpmove => true,
    :desc => "The user slashes the target through darkness. Critical hits land more easily."
},

:BITE => {
    :ID => 28,
    :name => "Bite",
    :function => 0x00F,
    :type => :DARK,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 25,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is bitten with viciously sharp fangs. It may make the target flinch."
},

:FEINTATTACK => {
    :ID => 29,
    :name => "Feint Attack",
    :function => 0x0A5,
    :type => :DARK,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user throws a sucker punch. It hits without fail."
},

:SNARL => {
    :ID => 30,
    :name => "Snarl",
    :function => 0x045,
    :type => :DARK,
    :category => :special,
    :basedamage => 55,
    :accuracy => 95,
    :maxpp => 15,
    :effect => 100,
    :target => :AllOpposing,
    :soundmove => true,
    :desc => "The user yells as if it is ranting about something, making the target's Sp. Atk decrease."
},

:ASSURANCE => {
    :ID => 31,
    :name => "Assurance",
    :function => 0x082,
    :type => :DARK,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "If the target has already taken damage in the same turn, this attack's power is doubled."
},

:PAYBACK => {
    :ID => 32,
    :name => "Payback",
    :function => 0x084,
    :type => :DARK,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "If the user moves after the target, this attack's power will be doubled."
},

:PURSUIT => {
    :ID => 33,
    :name => "Pursuit",
    :function => 0x088,
    :type => :DARK,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "An attack move that inflicts double damage if used on a fleeing target."
},

:THIEF => {
    :ID => 34,
    :name => "Thief",
    :function => 0x0F1,
    :type => :DARK,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 25,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user steals the target's held item. It can't steal if the user holds an item."
},

:KNOCKOFF => {
    :ID => 35,
    :name => "Knock Off",
    :function => 0x0F0,
    :type => :DARK,
    :category => :physical,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user slaps away the target's held item, removing it from the battle."
},

:BEATUP => {
    :ID => 36,
    :name => "Beat Up",
    :function => 0x0C1,
    :type => :DARK,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user gets all party Pokémon to attack. The more party Pokémon, the greater the damage."
},

:FLING => {
    :ID => 37,
    :name => "Fling",
    :function => 0x0F7,
    :type => :DARK,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user flings its held item at the target. Its power and effects depend on the item."
},

:PUNISHMENT => {
    :ID => 38,
    :name => "Punishment",
    :function => 0x08F,
    :type => :DARK,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "This attack's power increases the more the target has powered up with stat changes."
},

:DARKVOID => {
    :ID => 39,
    :name => "Dark Void",
    :function => 0x003,
    :type => :DARK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 50,
    :maxpp => 10,
    :target => :AllOpposing,
    :magiccoat => true,
    :desc => "Opposing Pokémon are dragged into a world of total darkness that makes them sleep."
},

:EMBARGO => {
    :ID => 40,
    :name => "Embargo",
    :function => 0x0F8,
    :type => :DARK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "It prevents the target from using any items."
},

:FAKETEARS => {
    :ID => 41,
    :name => "Fake Tears",
    :function => 0x04F,
    :type => :DARK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user feigns crying to fluster the target, harshly lowering its Sp. Def stat."
},

:FLATTER => {
    :ID => 42,
    :name => "Flatter",
    :function => 0x040,
    :type => :DARK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "Flattery is used to confuse the target. However, it also raises the target's Sp. Atk."
},

:HONECLAWS => {
    :ID => 43,
    :name => "Hone Claws",
    :function => 0x029,
    :type => :DARK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user sharpens its claws to boost its Attack stat and accuracy."
},

:MEMENTO => {
    :ID => 44,
    :name => "Memento",
    :function => 0x0E2,
    :type => :DARK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user faints using this move. It harshly lowers the target's Attack and Sp. Atk."
},

:NASTYPLOT => {
    :ID => 45,
    :name => "Nasty Plot",
    :function => 0x032,
    :type => :DARK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user stimulates its brain with bad thoughts. It sharply raises the user's Sp. Atk."
},

:QUASH => {
    :ID => 46,
    :name => "Quash",
    :function => 0x11E,
    :type => :DARK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "The user suppresses the target and makes its move go last."
},

:SNATCH => {
    :ID => 47,
    :name => "Snatch",
    :function => 0x0B2,
    :type => :DARK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :priority => 4,
    :nonmirror => true,
    :desc => "The user steals the effects of any healing or stat-changing move the opponent uses."
},

:SWITCHEROO => {
    :ID => 48,
    :name => "Switcheroo",
    :function => 0x0F2,
    :type => :DARK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user trades held items with the target faster than the eye can follow."
},

:TAUNT => {
    :ID => 49,
    :name => "Taunt",
    :function => 0x0BA,
    :type => :DARK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The target is taunted into using only attacking moves for three turns."
},

:TORMENT => {
    :ID => 50,
    :name => "Torment",
    :function => 0x0B7,
    :type => :DARK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user torments the target, making it incapable of using the same move twice in a row."
},

:ROAROFTIME => {
    :ID => 51,
    :name => "Roar of Time",
    :function => 0x0C2,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 150,
    :accuracy => 90,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The user blasts with power that distorts even time. The user must rest on the next turn."
},

:DRACOMETEOR => {
    :ID => 52,
    :name => "Draco Meteor",
    :function => 0x03F,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 130,
    :accuracy => 90,
    :maxpp => 5,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "Comets are summoned down from the sky. The attack harshly reduces the user's Sp. Atk."
},

:OUTRAGE => {
    :ID => 53,
    :name => "Outrage",
    :function => 0x0D2,
    :type => :DRAGON,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 10,
    :target => :RandomOpposing,
    :contact => true,
    :desc => "The user rampages and attacks for two to three turns. It then becomes confused, however."
},

:DRAGONRUSH => {
    :ID => 54,
    :name => "Dragon Rush",
    :function => 0x010,
    :type => :DRAGON,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 75,
    :maxpp => 10,
    :effect => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user tackles the target while exhibiting menace. It may make the target flinch."
},

:SPACIALREND => {
    :ID => 55,
    :name => "Spacial Rend",
    :function => 0x000,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 100,
    :accuracy => 95,
    :maxpp => 5,
    :target => :SingleNonUser,
    :highcrit => true,
    :desc => "The user tears the target along with the space around it. Critical hits land more easily."
},

:DRAGONPULSE => {
    :ID => 56,
    :name => "Dragon Pulse",
    :function => 0x000,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 95,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The target is attacked with a shock wave generated by the user's gaping mouth."
},

:DRAGONCLAW => {
    :ID => 57,
    :name => "Dragon Claw",
    :function => 0x000,
    :type => :DRAGON,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user slashes the target with huge, sharp claws."
},

:DRAGONTAIL => {
    :ID => 58,
    :name => "Dragon Tail",
    :function => 0x0EC,
    :type => :DRAGON,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :priority => -6,
    :contact => true,
    :desc => "The user knocks away the target and drags out another Pokémon in its party. In the wild, the battle ends."
},

:DRAGONBREATH => {
    :ID => 59,
    :name => "Dragon Breath",
    :function => 0x007,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 30,
    :target => :SingleNonUser,
    :desc => "The user exhales a mighty gust that inflicts damage. It may leave the target paralyzed."
},

:DUALCHOP => {
    :ID => 60,
    :name => "Dual Chop",
    :function => 0x0BD,
    :type => :DRAGON,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 90,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks its target by hitting it with brutal strikes. The target is hit twice."
},

:TWISTER => {
    :ID => 61,
    :name => "Twister",
    :function => 0x078,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 20,
    :target => :AllOpposing,
    :windmove => true,
    :desc => "The user whips up a tornado to tear at the opposing team. It may make targets flinch."
},

:DRAGONRAGE => {
    :ID => 62,
    :name => "Dragon Rage",
    :function => 0x06B,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "This attack hits with a shock wave of pure rage. This attack always inflicts 40 damage."
},

:DRAGONDANCE => {
    :ID => 63,
    :name => "Dragon Dance",
    :function => 0x026,
    :type => :DRAGON,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user vigorously performs a powerful dance that boosts its Attack and Speed stats."
},

:BOLTSTRIKE => {
    :ID => 64,
    :name => "Bolt Strike",
    :function => 0x007,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 130,
    :accuracy => 85,
    :maxpp => 5,
    :effect => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user charges its target, surrounded with electricity. It may paralyze the target."
},

:THUNDER => {
    :ID => 65,
    :name => "Thunder",
    :function => 0x008,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 110,
    :accuracy => 70,
    :maxpp => 10,
    :effect => 30,
    :target => :SingleNonUser,
    :desc => "A wicked thunderbolt is dropped on the target. It may paralyze the target."
},

:VOLTTACKLE => {
    :ID => 66,
    :name => "Volt Tackle",
    :function => 0x007,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :recoil => 0.33,
    :desc => "The user electrifies itself and charges. It damages the user and may paralyze the target."
},

:ZAPCANNON => {
    :ID => 67,
    :name => "Zap Cannon",
    :function => 0x007,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 120,
    :accuracy => 50,
    :maxpp => 5,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user fires an electric blast like a cannon to inflict damage and cause paralysis."
},

:FUSIONBOLT => {
    :ID => 68,
    :name => "Fusion Bolt",
    :function => 0x079,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "This attack does double damage when used after fusion flare or blue flare."
},

:THUNDERBOLT => {
    :ID => 69,
    :name => "Thunderbolt",
    :function => 0x007,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "A strong electric blast is loosed at the target. It may paralyze the target."
},

:WILDCHARGE => {
    :ID => 70,
    :name => "Wild Charge",
    :function => 0x000,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :recoil => 0.25,
    :desc => "The user shrouds itself in electricity and smashes into its target. It damages the user."
},

:DISCHARGE => {
    :ID => 71,
    :name => "Discharge",
    :function => 0x007,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 30,
    :target => :AllNonUsers,
    :desc => "Electricity is loosed to strike the area around the user. It may also cause paralysis."
},

:THUNDERPUNCH => {
    :ID => 72,
    :name => "Thunder Punch",
    :function => 0x007,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The target is punched with an electrified fist. It may leave the target with paralysis."
},

:VOLTSWITCH => {
    :ID => 73,
    :name => "Volt Switch",
    :function => 0x0EE,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :desc => "After making its attack, the user rushes back to switch places with a party Pokémon."
},

:SPARK => {
    :ID => 74,
    :name => "Spark",
    :function => 0x007,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user electrically tackles at the target. It may also paralyze the target."
},

:THUNDERFANG => {
    :ID => 75,
    :name => "Thunder Fang",
    :function => 0x009,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 65,
    :accuracy => 95,
    :maxpp => 15,
    :effect => 10,
    :moreeffect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user bites with electrified fangs. It may make the target flinch or paralyze it."
},

:SHOCKWAVE => {
    :ID => 76,
    :name => "Shock Wave",
    :function => 0x0A5,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 60,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :desc => "The user strikes the target with a quick jolt of electricity. This attack always hits."
},

:ELECTROWEB => {
    :ID => 77,
    :name => "Electroweb",
    :function => 0x044,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 55,
    :accuracy => 95,
    :maxpp => 15,
    :effect => 100,
    :target => :AllOpposing,
    :desc => "The user attacks opposing Pokémon with an electric net. It reduces the targets' Speed."
},

:CHARGEBEAM => {
    :ID => 78,
    :name => "Charge Beam",
    :function => 0x020,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 50,
    :accuracy => 90,
    :maxpp => 10,
    :effect => 70,
    :target => :SingleNonUser,
    :beammove => true,
    :desc => "The user attacks with an electric charge which may raise its Sp. Atk stat."
},

:THUNDERSHOCK => {
    :ID => 79,
    :name => "Thunder Shock",
    :function => 0x007,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 30,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "A jolt of electricity is hurled at the target. It may also paralyze the target."
},

:ELECTROBALL => {
    :ID => 80,
    :name => "Electro Ball",
    :function => 0x099,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The faster the user is than the target, the greater the damage this move deals."
},

:CHARGE => {
    :ID => 81,
    :name => "Charge",
    :function => 0x021,
    :type => :ELECTRIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user boosts Electric moves it uses next turn. It also raises the user's Sp. Def."
},

:MAGNETRISE => {
    :ID => 82,
    :name => "Magnet Rise",
    :function => 0x119,
    :type => :ELECTRIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :gravityblocked => true,
    :desc => "The user levitates using electrically generated magnetism for five turns."
},

:THUNDERWAVE => {
    :ID => 83,
    :name => "Thunder Wave",
    :function => 0x007,
    :type => :ELECTRIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 90,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "A weak electric charge is launched at the target. It causes paralysis if it hits."
},

:FOCUSPUNCH => {
    :ID => 84,
    :name => "Focus Punch",
    :function => 0x115,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 150,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :priority => -3,
    :contact => true,
    :nonmirror => true,
    :punchmove => true,
    :desc => "The user focuses its mind before punching. It will fail if the user is hit this turn."
},

:HIJUMPKICK => {
    :ID => 85,
    :name => "High Jump Kick",
    :function => 0x10B,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 130,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :gravityblocked => true,
    :desc => "The target is hit with a knee kick from a jump. If it misses, the user is hurt instead."
},

:CLOSECOMBAT => {
    :ID => 86,
    :name => "Close Combat",
    :function => 0x03C,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user fights the target without guarding. It cuts the user's Defense and Sp. Def."
},

:FOCUSBLAST => {
    :ID => 87,
    :name => "Focus Blast",
    :function => 0x046,
    :type => :FIGHTING,
    :category => :special,
    :basedamage => 120,
    :accuracy => 70,
    :maxpp => 5,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "The user mentally focuses and unleashes its power. It may lower the target's Sp. Def."
},

:SUPERPOWER => {
    :ID => 88,
    :name => "Superpower",
    :function => 0x03B,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks the target with great power. It lowers the user's Attack and Defense."
},

:CROSSCHOP => {
    :ID => 89,
    :name => "Cross Chop",
    :function => 0x000,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 80,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :highcrit => true,
    :desc => "The user delivers a double chop with its forearms. Critical hits land more easily."
},

:DYNAMICPUNCH => {
    :ID => 90,
    :name => "Dynamic Punch",
    :function => 0x013,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 50,
    :maxpp => 5,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The user punches the target with full power. It confuses the target if it hits."
},

:HAMMERARM => {
    :ID => 91,
    :name => "Hammer Arm",
    :function => 0x03E,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The user hits with its strong and heavy fist. It lowers the user's Speed, however."
},

:JUMPKICK => {
    :ID => 92,
    :name => "Jump Kick",
    :function => 0x10B,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 95,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :gravityblocked => true,
    :desc => "The user jumps, then strikes with a kick. If the kick misses, the user hurts itself."
},

:AURASPHERE => {
    :ID => 93,
    :name => "Aura Sphere",
    :function => 0x0A5,
    :type => :FIGHTING,
    :category => :special,
    :basedamage => 80,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :desc => "The user looses a blast of aura power at the target. This move always hits."
},

:SACREDSWORD => {
    :ID => 94,
    :name => "Sacred Sword",
    :function => 0x0A9,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :sharpmove => true,
    :desc => "The user attacks by slicing. The target's stat changes don't affect the damage."
},

:SECRETSWORD => {
    :ID => 95,
    :name => "Secret Sword",
    :function => 0x122,
    :type => :FIGHTING,
    :category => :special,
    :basedamage => 85,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user cuts with its long horn. The  horn does physical damage to the target."
},

:SKYUPPERCUT => {
    :ID => 96,
    :name => "Sky Uppercut",
    :function => 0x11B,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 85,
    :accuracy => 90,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The user attacks the target with an uppercut thrown skyward with force."
},

:SUBMISSION => {
    :ID => 97,
    :name => "Submission",
    :function => 0x000,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 80,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :recoil => 0.25,
    :desc => "The user grabs the target and dives for the ground. It also hurts the user slightly."
},

:BRICKBREAK => {
    :ID => 98,
    :name => "Brick Break",
    :function => 0x10A,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks with a chop. It also ends the effect of Light Screen and Reflect."
},

:DRAINPUNCH => {
    :ID => 99,
    :name => "Drain Punch",
    :function => 0x0DD,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "An energy-draining punch. The user's HP is restored by half the damage dealt."
},

:VITALTHROW => {
    :ID => 100,
    :name => "Vital Throw",
    :function => 0x0A5,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :priority => -1,
    :contact => true,
    :desc => "The user attacks last. In return, this throw move is guaranteed not to miss."
},

:CIRCLETHROW => {
    :ID => 101,
    :name => "Circle Throw",
    :function => 0x0EC,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :priority => -6,
    :contact => true,
    :desc => "The user throws the target and drags out another Pokémon. In the wild, the battle ends."
},

:FORCEPALM => {
    :ID => 102,
    :name => "Force Palm",
    :function => 0x007,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is attacked with a shock wave. It may also paralyze the target."
},

:LOWSWEEP => {
    :ID => 103,
    :name => "Low Sweep",
    :function => 0x044,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks the target's legs swiftly, reducing the target's Speed stat."
},

:REVENGE => {
    :ID => 104,
    :name => "Revenge",
    :function => 0x081,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :priority => -4,
    :contact => true,
    :desc => "Inflicts double the damage if the user has been hurt by the opponent in the same turn."
},

:ROLLINGKICK => {
    :ID => 105,
    :name => "Rolling Kick",
    :function => 0x00F,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 85,
    :maxpp => 15,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user lashes out with a quick, spinning kick. It may also make the target flinch."
},

:WAKEUPSLAP => {
    :ID => 106,
    :name => "Wake-Up Slap",
    :function => 0x07D,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "This attack inflicts big damage on a sleeping target. It also wakes the target up."
},

:KARATECHOP => {
    :ID => 107,
    :name => "Karate Chop",
    :function => 0x000,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 25,
    :target => :SingleNonUser,
    :contact => true,
    :highcrit => true,
    :desc => "The target is attacked with a sharp chop. Critical hits land more easily."
},

:MACHPUNCH => {
    :ID => 108,
    :name => "Mach Punch",
    :function => 0x000,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 30,
    :target => :SingleNonUser,
    :priority => 1,
    :contact => true,
    :punchmove => true,
    :desc => "The user throws a punch at blinding speed. It is certain to strike first."
},

:ROCKSMASH => {
    :ID => 109,
    :name => "Rock Smash",
    :function => 0x043,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 50,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Attacks with a rock-shattering punch. It may also lower the target's Defense stat."
},

:STORMTHROW => {
    :ID => 110,
    :name => "Storm Throw",
    :function => 0x0A0,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user strikes the target fiercely. This attack always results in a critical hit."
},

:VACUUMWAVE => {
    :ID => 111,
    :name => "Vacuum Wave",
    :function => 0x000,
    :type => :FIGHTING,
    :category => :special,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 30,
    :target => :SingleNonUser,
    :priority => 1,
    :desc => "The user whirls its fists to send out a wave of pure vacuum. This move always goes first."
},

:DOUBLEKICK => {
    :ID => 112,
    :name => "Double Kick",
    :function => 0x0BD,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 30,
    :accuracy => 100,
    :maxpp => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is quickly kicked twice in succession using both feet."
},

:ARMTHRUST => {
    :ID => 113,
    :name => "Arm Thrust",
    :function => 0x0C0,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 15,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user looses a flurry of open-palmed arm thrusts that hit two to five times in a row."
},

:TRIPLEKICK => {
    :ID => 114,
    :name => "Triple Kick",
    :function => 0x0BF,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 10,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "A consecutive three-kick attack that becomes more powerful with each successive hit."
},

:COUNTER => {
    :ID => 115,
    :name => "Counter",
    :function => 0x071,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 20,
    :target => :NoTarget,
    :priority => -5,
    :contact => true,
    :nonmirror => true,
    :desc => "A retaliation move that counters any physical attack, inflicting double the damage taken."
},

:FINALGAMBIT => {
    :ID => 116,
    :name => "Final Gambit",
    :function => 0x0E1,
    :type => :FIGHTING,
    :category => :special,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :nonmirror => true,
    :desc => "The user sacrifices itself but does damage equal to its current HP."
},

:LOWKICK => {
    :ID => 117,
    :name => "Low Kick",
    :function => 0x09A,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "A powerful kick that inflicts greater damage on heavier targets."
},

:REVERSAL => {
    :ID => 118,
    :name => "Reversal",
    :function => 0x098,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "An all-out attack that becomes more powerful the less HP the user has."
},

:SEISMICTOSS => {
    :ID => 119,
    :name => "Seismic Toss",
    :function => 0x06D,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is thrown using gravity. It inflicts damage equal to the user's level."
},

:BULKUP => {
    :ID => 120,
    :name => "Bulk Up",
    :function => 0x024,
    :type => :FIGHTING,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user tenses its muscles, boosting both its Attack and Defense stats."
},

:DETECT => {
    :ID => 121,
    :name => "Detect",
    :function => 0x0AA,
    :type => :FIGHTING,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :User,
    :priority => 4,
    :nonmirror => true,
    :desc => "The user evades all attacks. Its chance of failing rises if it is used in succession."
},

:QUICKGUARD => {
    :ID => 122,
    :name => "Quick Guard",
    :function => 0x0AB,
    :type => :FIGHTING,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :BothSides,
    :priority => 3,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user protects its team from priority moves. If used in succession, it may fail."
},

:VCREATE => {
    :ID => 123,
    :name => "V-create",
    :function => 0x03D,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 180,
    :accuracy => 95,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "With flames on its head, it hit target. It lowers its Defense, Sp. Def, and Speed stats."
},

:BLASTBURN => {
    :ID => 124,
    :name => "Blast Burn",
    :function => 0x0C2,
    :type => :FIRE,
    :category => :special,
    :basedamage => 150,
    :accuracy => 90,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The target is razed by a fiery explosion. The user must rest on the next turn."
},

:ERUPTION => {
    :ID => 125,
    :name => "Eruption",
    :function => 0x08B,
    :type => :FIRE,
    :category => :special,
    :basedamage => 150,
    :accuracy => 100,
    :maxpp => 5,
    :target => :AllOpposing,
    :desc => "The user hits the opposing team with flames. The more HP, the stronger the attack."
},

:OVERHEAT => {
    :ID => 126,
    :name => "Overheat",
    :function => 0x03F,
    :type => :FIRE,
    :category => :special,
    :basedamage => 130,
    :accuracy => 90,
    :maxpp => 5,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user attacks the target at full power. It sharply reduces the user's Sp. Atk stat."
},

:BLUEFLARE => {
    :ID => 127,
    :name => "Blue Flare",
    :function => 0x00A,
    :type => :FIRE,
    :category => :special,
    :basedamage => 130,
    :accuracy => 85,
    :maxpp => 5,
    :effect => 20,
    :target => :SingleNonUser,
    :desc => "The user attacks by engulfing the target in intense, blue flames. It may burn the target."
},

:FIREBLAST => {
    :ID => 128,
    :name => "Fire Blast",
    :function => 0x00A,
    :type => :FIRE,
    :category => :special,
    :basedamage => 110,
    :accuracy => 85,
    :maxpp => 5,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "The target is attacked with an intense blast of fire. It may burn the target."
},

:FLAREBLITZ => {
    :ID => 129,
    :name => "Flare Blitz",
    :function => 0x00A,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :defrost => true,
    :recoil => 0.33,
    :desc => "The user sets fire and charges. It sustains serious damage and may burn the target."
},

:MAGMASTORM => {
    :ID => 130,
    :name => "Magma Storm",
    :function => 0x0CF,
    :type => :FIRE,
    :category => :special,
    :basedamage => 120,
    :accuracy => 75,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The target is caught in a maelstrom of fire that rages for four to five turns."
},

:FUSIONFLARE => {
    :ID => 131,
    :name => "Fusion Flare",
    :function => 0x07A,
    :type => :FIRE,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :defrost => true,
    :desc => "The user brings down a giant flame. It is more powerful after a large thunderbolt."
},

:HEATWAVE => {
    :ID => 132,
    :name => "Heat Wave",
    :function => 0x00A,
    :type => :FIRE,
    :category => :special,
    :basedamage => 95,
    :accuracy => 90,
    :maxpp => 10,
    :effect => 10,
    :target => :AllOpposing,
    :windmove => true,
    :desc => "The user blasts hot breath on the opposing team. It may burn the targets."
},

:INFERNO => {
    :ID => 133,
    :name => "Inferno",
    :function => 0x00A,
    :type => :FIRE,
    :category => :special,
    :basedamage => 100,
    :accuracy => 50,
    :maxpp => 5,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user engulfs the target in intense fire. It burns the target."
},

:SACREDFIRE => {
    :ID => 134,
    :name => "Sacred Fire",
    :function => 0x00A,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 95,
    :maxpp => 5,
    :effect => 50,
    :target => :SingleNonUser,
    :defrost => true,
    :desc => "The target is razed with a mystical fire of great intensity. It may burn the target."
},

:SEARINGSHOT => {
    :ID => 135,
    :name => "Searing Shot",
    :function => 0x00A,
    :type => :FIRE,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 5,
    :effect => 30,
    :target => :AllNonUsers,
    :desc => "An inferno torches everything around the user. It may burn the targets."
},

:FLAMETHROWER => {
    :ID => 136,
    :name => "Flamethrower",
    :function => 0x00A,
    :type => :FIRE,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "The target is scorched with an intense blast of fire. It may burn the target."
},

:BLAZEKICK => {
    :ID => 137,
    :name => "Blaze Kick",
    :function => 0x00A,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 85,
    :accuracy => 90,
    :maxpp => 10,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :highcrit => true,
    :desc => "The user launches a kick that lands a critical hit more easily. It may burn the target."
},

:FIERYDANCE => {
    :ID => 138,
    :name => "Fiery Dance",
    :function => 0x020,
    :type => :FIRE,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 50,
    :target => :SingleNonUser,
    :desc => "Cloaked in flames, the user dances. It may raise the user's Sp. Atk stat."
},

:LAVAPLUME => {
    :ID => 139,
    :name => "Lava Plume",
    :function => 0x00A,
    :type => :FIRE,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 30,
    :target => :AllNonUsers,
    :desc => "An inferno torches everything around the user. It may burn the targets."
},

:FIREPUNCH => {
    :ID => 140,
    :name => "Fire Punch",
    :function => 0x00A,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The target is punched with a fiery fist. It may leave the target with a burn."
},

:FLAMEBURST => {
    :ID => 141,
    :name => "Flame Burst",
    :function => 0x074,
    :type => :FIRE,
    :category => :special,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "The user attacks the target with big flames. The fire damages adjacent Pokemon also."
},

:FIREFANG => {
    :ID => 142,
    :name => "Fire Fang",
    :function => 0x00B,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 65,
    :accuracy => 95,
    :maxpp => 15,
    :effect => 10,
    :moreeffect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user bites with flaming fangs. It may also burn the target or make it flinch."
},

:FLAMEWHEEL => {
    :ID => 143,
    :name => "Flame Wheel",
    :function => 0x00A,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 25,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :defrost => true,
    :desc => "The user sets fire and charges at the target. It may burn the target."
},

:FIREPLEDGE => {
    :ID => 144,
    :name => "Fire Pledge",
    :function => 0x107,
    :type => :FIRE,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "A fiery column hits the target. When used with Grass Pledge, it causes a sea of fire."
},

:FLAMECHARGE => {
    :ID => 145,
    :name => "Flame Charge",
    :function => 0x01F,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user sets fire and attacks. It raises the user's Speed stat."
},

:EMBER => {
    :ID => 146,
    :name => "Ember",
    :function => 0x00A,
    :type => :FIRE,
    :category => :special,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 25,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "The target is attacked with small flames. It may also burn the target."
},

:FIRESPIN => {
    :ID => 147,
    :name => "Fire Spin",
    :function => 0x0CF,
    :type => :FIRE,
    :category => :special,
    :basedamage => 35,
    :accuracy => 85,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "The target is trapped within a fierce vortex of fire that rages for four to five turns."
},

:INCINERATE => {
    :ID => 148,
    :name => "Incinerate",
    :function => 0x0F5,
    :type => :FIRE,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :AllOpposing,
    :desc => "The user attacks the target with fire. The fire burns up the target's berry."
},

:HEATCRASH => {
    :ID => 149,
    :name => "Heat Crash",
    :function => 0x09B,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user hits the target with its fiery body. The heavier the user, the stronger it is."
},

:SUNNYDAY => {
    :ID => 150,
    :name => "Sunny Day",
    :function => 0x0FF,
    :type => :FIRE,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :UserSide,
    :nonmirror => true,
    :desc => "The user intensifies the sun for five turns, powering up Fire-type moves."
},

:WILLOWISP => {
    :ID => 151,
    :name => "Will-O-Wisp",
    :function => 0x00A,
    :type => :FIRE,
    :category => :status,
    :basedamage => 0,
    :accuracy => 85,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user shoots a sinister, bluish-white flame at the target to inflict a burn."
},

:SKYATTACK => {
    :ID => 152,
    :name => "Sky Attack",
    :function => 0x0C7,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 140,
    :accuracy => 90,
    :maxpp => 5,
    :effect => 30,
    :target => :SingleNonUser,
    :highcrit => true,
    :desc => "A two-turn attack where critical hits land more easily. It may make the target flinch."
},

:BRAVEBIRD => {
    :ID => 153,
    :name => "Brave Bird",
    :function => 0x000,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :recoil => 0.33,
    :desc => "The user tucks in its wings and charges. The user also takes serious damage."
},

:HURRICANE => {
    :ID => 154,
    :name => "Hurricane",
    :function => 0x015,
    :type => :FLYING,
    :category => :special,
    :basedamage => 110,
    :accuracy => 70,
    :maxpp => 10,
    :effect => 30,
    :target => :SingleNonUser,
    :windmove => true,
    :desc => "The user wraps its opponent in a fierce circular wind. It may confuse the target."
},

:AEROBLAST => {
    :ID => 155,
    :name => "Aeroblast",
    :function => 0x000,
    :type => :FLYING,
    :category => :special,
    :basedamage => 100,
    :accuracy => 95,
    :maxpp => 5,
    :target => :SingleNonUser,
    :highcrit => true,
    :windmove => true,
    :desc => "A vortex of air is shot at the target to inflict damage. Critical hits land easily."
},

:FLY => {
    :ID => 156,
    :name => "Fly",
    :function => 0x0C9,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 95,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :gravityblocked => true,
    :desc => "The user soars and strikes its target on turn two. It can be used for transportation."
},

:BOUNCE => {
    :ID => 157,
    :name => "Bounce",
    :function => 0x0CC,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 85,
    :accuracy => 85,
    :maxpp => 5,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :gravityblocked => true,
    :desc => "The user bounces up high, then drops on the target. It may paralyze the target."
},

:DRILLPECK => {
    :ID => 158,
    :name => "Drill Peck",
    :function => 0x000,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "A corkscrewing attack with the sharp beak acting as a drill."
},

:AIRSLASH => {
    :ID => 159,
    :name => "Air Slash",
    :function => 0x00F,
    :type => :FLYING,
    :category => :special,
    :basedamage => 75,
    :accuracy => 95,
    :maxpp => 15,
    :effect => 30,
    :target => :SingleNonUser,
    :sharpmove => true,
    :desc => "The user attacks with a blade of air that slices the sky. It may make the target flinch."
},

:AERIALACE => {
    :ID => 160,
    :name => "Aerial Ace",
    :function => 0x0A5,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :sharpmove => true,
    :desc => "The user confounds the foe with speed, then slashes. The attack lands without fail."
},

:CHATTER => {
    :ID => 161,
    :name => "Chatter",
    :function => 0x013,
    :type => :FLYING,
    :category => :special,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 100,
    :target => :SingleNonUser,
    :soundmove => true,
    :desc => "The user attacks with sound based on words it has learned. It may confuse the target."
},

:PLUCK => {
    :ID => 162,
    :name => "Pluck",
    :function => 0x0F4,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user pecks the target. If the target is holding a Berry, the user gains its effect."
},

:SKYDROP => {
    :ID => 163,
    :name => "Sky Drop",
    :function => 0x0CE,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :gravityblocked => true,
    :desc => "The target is brought to the sky and dropped the next turn. It cannot attack."
},

:WINGATTACK => {
    :ID => 164,
    :name => "Wing Attack",
    :function => 0x000,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 35,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is struck with large, imposing wings spread wide to inflict damage."
},

:ACROBATICS => {
    :ID => 165,
    :name => "Acrobatics",
    :function => 0x086,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 55,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user nimbly hits the target. If there is no held item, it inflicts massive damage."
},

:AIRCUTTER => {
    :ID => 166,
    :name => "Air Cutter",
    :function => 0x000,
    :type => :FLYING,
    :category => :special,
    :basedamage => 60,
    :accuracy => 95,
    :maxpp => 25,
    :target => :AllOpposing,
    :highcrit => true,
    :sharpmove => true,
    :windmove => true,
    :desc => "Razor-like wind is launched to slash the opposing team. Critical hits land more easily."
},

:GUST => {
    :ID => 167,
    :name => "Gust",
    :function => 0x077,
    :type => :FLYING,
    :category => :special,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 35,
    :target => :SingleNonUser,
    :windmove => true,
    :desc => "A gust of wind is whipped up and launched at the target to inflict damage."
},

:PECK => {
    :ID => 168,
    :name => "Peck",
    :function => 0x000,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 35,
    :accuracy => 100,
    :maxpp => 35,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is jabbed with a sharply pointed beak or horn."
},

:DEFOG => {
    :ID => 169,
    :name => "Defog",
    :function => 0x049,
    :type => :FLYING,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "A strong wind blows away obstacles. It also lowers the target's evasiveness."
},

:FEATHERDANCE => {
    :ID => 170,
    :name => "Feather Dance",
    :function => 0x04B,
    :type => :FLYING,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user covers the target with feathers that harshly lowers its Attack stat."
},

:MIRRORMOVE => {
    :ID => 171,
    :name => "Mirror Move",
    :function => 0x0AE,
    :type => :FLYING,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "The user counters the target by mimicking the target's last move."
},

:ROOST => {
    :ID => 172,
    :name => "Roost",
    :function => 0x0D6,
    :type => :FLYING,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The user lands and rests its body. It restores the user's HP by up to half of its max HP."
},

:TAILWIND => {
    :ID => 173,
    :name => "Tailwind",
    :function => 0x05B,
    :type => :FLYING,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :BothSides,
    :snatchable => true,
    :nonmirror => true,
    :windmove => true,
    :desc => "The user whips up a sharp whirlwind that ups the Speed of party Pokemon for four turns."
},

:SHADOWFORCE => {
    :ID => 174,
    :name => "Shadow Force",
    :function => 0x0CD,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 0,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :bypassprotect => true,
    :desc => "The user disappears, then strikes the target on the second turn. It always hits."
},

:SHADOWBALL => {
    :ID => 175,
    :name => "Shadow Ball",
    :function => 0x046,
    :type => :GHOST,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 20,
    :target => :SingleNonUser,
    :desc => "The user hurls a shadowy blob at the target. It may lower the target's Sp. Def stat."
},

:SHADOWCLAW => {
    :ID => 176,
    :name => "Shadow Claw",
    :function => 0x000,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :highcrit => true,
    :desc => "The user slashes with a sharp claw made from shadows. Critical hits land more easily."
},

:OMINOUSWIND => {
    :ID => 177,
    :name => "Ominous Wind",
    :function => 0x02D,
    :type => :GHOST,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 5,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "The user blasts the target with a gust of repulsive wind. It may raise every stat."
},

:SHADOWPUNCH => {
    :ID => 178,
    :name => "Shadow Punch",
    :function => 0x0A5,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The user throws a punch from the shadows. The punch lands without fail."
},

:HEX => {
    :ID => 179,
    :name => "Hex",
    :function => 0x07F,
    :type => :GHOST,
    :category => :special,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "This relentless attack does massive damage to targets affected by status problems."
},

:SHADOWSNEAK => {
    :ID => 180,
    :name => "Shadow Sneak",
    :function => 0x000,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 30,
    :target => :SingleNonUser,
    :priority => 1,
    :contact => true,
    :desc => "The user strikes with its shadow from behind. This move always goes first."
},

:ASTONISH => {
    :ID => 181,
    :name => "Astonish",
    :function => 0x00F,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 30,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks the target in a startling fashion. It may also make the target flinch."
},

:LICK => {
    :ID => 182,
    :name => "Lick",
    :function => 0x007,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 30,
    :accuracy => 100,
    :maxpp => 30,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is licked with a long tongue, causing damage. It may paralyze the target."
},

:NIGHTSHADE => {
    :ID => 183,
    :name => "Night Shade",
    :function => 0x06D,
    :type => :GHOST,
    :category => :special,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "The user makes the target see a horrid mirage. Its damage matches the user's level."
},

:CONFUSERAY => {
    :ID => 184,
    :name => "Confuse Ray",
    :function => 0x013,
    :type => :GHOST,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The target is exposed to a sinister ray that triggers confusion."
},

:CURSE => {
    :ID => 185,
    :name => "Curse",
    :function => 0x10D,
    :type => :GHOST,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :OppositeOpposing,
    :bypassprotect => true,
    :nonmirror => true,
    :desc => "A move that works differently for the Ghost type than for all the other types."
},

:DESTINYBOND => {
    :ID => 186,
    :name => "Destiny Bond",
    :function => 0x0E7,
    :type => :GHOST,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :User,
    :nonmirror => true,
    :desc => "When this move is used, if the user faints, the target also faints."
},

:GRUDGE => {
    :ID => 187,
    :name => "Grudge",
    :function => 0x0E6,
    :type => :GHOST,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :User,
    :nonmirror => true,
    :desc => "If the user faints, the user fully depletes the PP of the opponent's move."
},

:NIGHTMARE => {
    :ID => 188,
    :name => "Nightmare",
    :function => 0x10F,
    :type => :GHOST,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A sleeping target sees a nightmare that inflicts some damage every turn."
},

:SPITE => {
    :ID => 189,
    :name => "Spite",
    :function => 0x10E,
    :type => :GHOST,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user unleashes a grudge on the move last used by the target, cutting 4 PP from it."
},

:FRENZYPLANT => {
    :ID => 190,
    :name => "Frenzy Plant",
    :function => 0x0C2,
    :type => :GRASS,
    :category => :special,
    :basedamage => 150,
    :accuracy => 90,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The user slams the target with an enormous tree. The user can't move on the next turn."
},

:LEAFSTORM => {
    :ID => 191,
    :name => "Leaf Storm",
    :function => 0x03F,
    :type => :GRASS,
    :category => :special,
    :basedamage => 130,
    :accuracy => 90,
    :maxpp => 5,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "A storm of leaves attacks the target. It harshly reduces the user's Sp. Atk stat."
},

:PETALDANCE => {
    :ID => 192,
    :name => "Petal Dance",
    :function => 0x0D2,
    :type => :GRASS,
    :category => :special,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 10,
    :target => :RandomOpposing,
    :contact => true,
    :desc => "The user hits the target with petals for multiple turns. The user then becomes confused."
},

:POWERWHIP => {
    :ID => 193,
    :name => "Power Whip",
    :function => 0x000,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 85,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user violently whirls its vines or tentacles to harshly lash the target."
},

:SEEDFLARE => {
    :ID => 194,
    :name => "Seed Flare",
    :function => 0x04F,
    :type => :GRASS,
    :category => :special,
    :basedamage => 120,
    :accuracy => 85,
    :maxpp => 5,
    :effect => 40,
    :target => :SingleNonUser,
    :desc => "A shock wave slams the target. It may harshly lower the target's Sp. Def."
},

:SOLARBEAM => {
    :ID => 195,
    :name => "Solar Beam",
    :function => 0x0C4,
    :type => :GRASS,
    :category => :special,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :beammove => true,
    :desc => "A two-turn attack. The user gathers light, then blasts a beam on the second turn."
},

:WOODHAMMER => {
    :ID => 196,
    :name => "Wood Hammer",
    :function => 0x000,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :recoil => 0.33,
    :desc => "The user slams its body into the target to attack. The user also sustains serious damage."
},

:LEAFBLADE => {
    :ID => 197,
    :name => "Leaf Blade",
    :function => 0x000,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :highcrit => true,
    :sharpmove => true,
    :desc => "The handles a sharp leaf like a sword. Critical hits land more easily."
},

:ENERGYBALL => {
    :ID => 198,
    :name => "Energy Ball",
    :function => 0x046,
    :type => :GRASS,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "The user draws power from nature and fires it. It may lower the target's Sp. Def."
},

:SEEDBOMB => {
    :ID => 199,
    :name => "Seed Bomb",
    :function => 0x000,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "The user slams a barrage of hard-shelled seeds down on the target from above."
},

:GIGADRAIN => {
    :ID => 200,
    :name => "Giga Drain",
    :function => 0x0DD,
    :type => :GRASS,
    :category => :special,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "A nutrient-draining attack. The user's HP is restored by half the damage taken."
},

:HORNLEECH => {
    :ID => 201,
    :name => "Horn Leech",
    :function => 0x0DD,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Energy is drained by horns. The user's HP is restored by half the damage taken."
},

:LEAFTORNADO => {
    :ID => 202,
    :name => "Leaf Tornado",
    :function => 0x047,
    :type => :GRASS,
    :category => :special,
    :basedamage => 65,
    :accuracy => 90,
    :maxpp => 10,
    :effect => 30,
    :target => :SingleNonUser,
    :desc => "The user attacks its target with sharp leaves. This attack may lower the foe's accuracy."
},

:MAGICALLEAF => {
    :ID => 203,
    :name => "Magical Leaf",
    :function => 0x0A5,
    :type => :GRASS,
    :category => :special,
    :basedamage => 60,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :desc => "The user scatters curious leaves that chase the target. This attack will not miss."
},

:NEEDLEARM => {
    :ID => 204,
    :name => "Needle Arm",
    :function => 0x00F,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks by wildly swinging its thorny arms. It may also make the target flinch."
},

:RAZORLEAF => {
    :ID => 205,
    :name => "Razor Leaf",
    :function => 0x000,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 55,
    :accuracy => 95,
    :maxpp => 25,
    :target => :AllOpposing,
    :highcrit => true,
    :sharpmove => true,
    :desc => "Sharp-edged leaves launch at the opposing team. Critical hits land more easily."
},

:GRASSPLEDGE => {
    :ID => 206,
    :name => "Grass Pledge",
    :function => 0x106,
    :type => :GRASS,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "A grassy column hits the target. When used with Water Pledge, its creates a vast swamp."
},

:MEGADRAIN => {
    :ID => 207,
    :name => "Mega Drain",
    :function => 0x0DD,
    :type => :GRASS,
    :category => :special,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A nutrient-draining attack. The user's HP is restored by half the damage taken."
},

:VINEWHIP => {
    :ID => 208,
    :name => "Vine Whip",
    :function => 0x000,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 45,
    :accuracy => 100,
    :maxpp => 25,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is struck with slender, whiplike vines to inflict damage."
},

:BULLETSEED => {
    :ID => 209,
    :name => "Bullet Seed",
    :function => 0x0C0,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 25,
    :accuracy => 100,
    :maxpp => 30,
    :target => :SingleNonUser,
    :desc => "The user forcefully shoots seeds at the target. Two to five seeds are shot."
},

:ABSORB => {
    :ID => 210,
    :name => "Absorb",
    :function => 0x0DD,
    :type => :GRASS,
    :category => :special,
    :basedamage => 20,
    :accuracy => 100,
    :maxpp => 25,
    :target => :SingleNonUser,
    :desc => "A nutrient-draining attack. The user's HP is restored by half the damage taken."
},

:GRASSKNOT => {
    :ID => 211,
    :name => "Grass Knot",
    :function => 0x09A,
    :type => :GRASS,
    :category => :special,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user snares the target with grass and trips it. Heavier targets take greater damage."
},

:AROMATHERAPY => {
    :ID => 212,
    :name => "Aromatherapy",
    :function => 0x019,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :BothSides,
    :snatchable => true,
    :nonmirror => true,
    :soundmove => true,
    :desc => "The user releases a soothing scent that heals all status problems of the user's party."
},

:COTTONGUARD => {
    :ID => 213,
    :name => "Cotton Guard",
    :function => 0x038,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user wraps its body in cotton, drastically raising its Defense stat."
},

:COTTONSPORE => {
    :ID => 214,
    :name => "Cotton Spore",
    :function => 0x04D,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 40,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user releases cotton-like spores at the target, harshly reducing its Speed stat."
},

:GRASSWHISTLE => {
    :ID => 215,
    :name => "Grass Whistle",
    :function => 0x003,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 55,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :soundmove => true,
    :desc => "The user plays a pleasant melody that lulls the target into a deep sleep."
},

:INGRAIN => {
    :ID => 216,
    :name => "Ingrain",
    :function => 0x0DB,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The user lays roots that restore HP every turn. The user cannot switch out."
},

:LEECHSEED => {
    :ID => 217,
    :name => "Leech Seed",
    :function => 0x0DC,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "A seed is planted on the target. It steals some HP from the target every turn."
},

:SLEEPPOWDER => {
    :ID => 218,
    :name => "Sleep Powder",
    :function => 0x003,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 75,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user scatters a big cloud of sleep-inducing dust around the target."
},

:SPORE => {
    :ID => 219,
    :name => "Spore",
    :function => 0x003,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user scatters bursts of spores that induce sleep."
},

:STUNSPORE => {
    :ID => 220,
    :name => "Stun Spore",
    :function => 0x007,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 75,
    :maxpp => 30,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user scatters a cloud of paralyzing powder. It may cause paralysis."
},

:SYNTHESIS => {
    :ID => 221,
    :name => "Synthesis",
    :function => 0x0D8,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The user restores its own HP. The amount of HP regained varies with the weather."
},

:WORRYSEED => {
    :ID => 222,
    :name => "Worry Seed",
    :function => 0x064,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "Plants a seed that causes worry. It prevents sleep by making its Ability Insomnia."
},

:EARTHQUAKE => {
    :ID => 223,
    :name => "Earthquake",
    :function => 0x076,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :AllNonUsers,
    :desc => "The user sets off an earthquake that strikes every Pokemon around it."
},

:EARTHPOWER => {
    :ID => 224,
    :name => "Earth Power",
    :function => 0x046,
    :type => :GROUND,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "The user makes the ground under the target erupt. It may lower the target's Sp. Def."
},

:DIG => {
    :ID => 225,
    :name => "Dig",
    :function => 0x0CA,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user burrows, then attacks on the second turn. It can also be used to exit dungeons."
},

:DRILLRUN => {
    :ID => 226,
    :name => "Drill Run",
    :function => 0x000,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 95,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :highcrit => true,
    :desc => "The user crashes into its target like a drill. Critical hits land more easily."
},

:BONECLUB => {
    :ID => 227,
    :name => "Bone Club",
    :function => 0x00F,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 65,
    :accuracy => 85,
    :maxpp => 20,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "The user clubs the target with a bone. It may also make the target flinch."
},

:MUDBOMB => {
    :ID => 228,
    :name => "Mud Bomb",
    :function => 0x047,
    :type => :GROUND,
    :category => :special,
    :basedamage => 65,
    :accuracy => 85,
    :maxpp => 10,
    :effect => 30,
    :target => :SingleNonUser,
    :desc => "The user launches a packed mud ball to attack. It may lower the target's accuracy."
},

:BULLDOZE => {
    :ID => 229,
    :name => "Bulldoze",
    :function => 0x044,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 100,
    :target => :AllNonUsers,
    :desc => "The user stomps on the ground in an area. Hit Pokemon's Speed stat is reduced."
},

:MUDSHOT => {
    :ID => 230,
    :name => "Mud Shot",
    :function => 0x044,
    :type => :GROUND,
    :category => :special,
    :basedamage => 55,
    :accuracy => 95,
    :maxpp => 15,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user attacks the target with a blob of mud. It reduces the target's Speed."
},

:BONEMERANG => {
    :ID => 231,
    :name => "Bonemerang",
    :function => 0x0BD,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user throws a bone. The bone loops to hit the target twice, coming and going."
},

:SANDTOMB => {
    :ID => 232,
    :name => "Sand Tomb",
    :function => 0x0CF,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 35,
    :accuracy => 85,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "The user traps the target inside a harshly raging sandstorm for four to five turns."
},

:BONERUSH => {
    :ID => 233,
    :name => "Bone Rush",
    :function => 0x0C0,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 25,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user strikes the target with a hard bone two to five times in a row."
},

:MUDSLAP => {
    :ID => 234,
    :name => "Mud-Slap",
    :function => 0x047,
    :type => :GROUND,
    :category => :special,
    :basedamage => 20,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user hurls mud in the target's face to inflict damage and lower its accuracy."
},

:FISSURE => {
    :ID => 235,
    :name => "Fissure",
    :function => 0x070,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 30,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The user opens up a fissure in the ground. The target instantly faints if it hits."
},

:MAGNITUDE => {
    :ID => 236,
    :name => "Magnitude",
    :function => 0x095,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 30,
    :target => :AllNonUsers,
    :desc => "The user looses a ground-shaking quake around the user. Its power varies."
},

:MUDSPORT => {
    :ID => 237,
    :name => "Mud Sport",
    :function => 0x09D,
    :type => :GROUND,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :BothSides,
    :nonmirror => true,
    :desc => "The user covers itself with mud. It weakens Electric-type moves in battle."
},

:SANDATTACK => {
    :ID => 238,
    :name => "Sand Attack",
    :function => 0x047,
    :type => :GROUND,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "Sand is hurled in the target's face, reducing its accuracy."
},

:SPIKES => {
    :ID => 239,
    :name => "Spikes",
    :function => 0x103,
    :type => :GROUND,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :OpposingSide,
    :magiccoat => true,
    :nonmirror => true,
    :desc => "The user lays spikes at the opponent's feet. They hurt Pokemon that switch in."
},

:FREEZESHOCK => {
    :ID => 240,
    :name => "Freeze Shock",
    :function => 0x0C5,
    :type => :ICE,
    :category => :physical,
    :basedamage => 140,
    :accuracy => 90,
    :maxpp => 5,
    :effect => 30,
    :target => :SingleNonUser,
    :desc => "On the second turn, the target is hit with electrical ice. It may cause paralysis."
},

:ICEBURN => {
    :ID => 241,
    :name => "Ice Burn",
    :function => 0x0C6,
    :type => :ICE,
    :category => :special,
    :basedamage => 140,
    :accuracy => 90,
    :maxpp => 5,
    :effect => 30,
    :target => :SingleNonUser,
    :desc => "On the second turn, a freezing wind surrounds the target. It may burn the target."
},

:BLIZZARD => {
    :ID => 242,
    :name => "Blizzard",
    :function => 0x00D,
    :type => :ICE,
    :category => :special,
    :basedamage => 110,
    :accuracy => 70,
    :maxpp => 5,
    :effect => 10,
    :target => :AllOpposing,
    :windmove => true,
    :desc => "A howling blizzard is blasted at the opposing team. It may also leave them with frostbite."
},

:ICEBEAM => {
    :ID => 243,
    :name => "Ice Beam",
    :function => 0x00C,
    :type => :ICE,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 10,
    :target => :SingleNonUser,
    :beammove => true,
    :desc => "The target is struck with an icy-cold beam of energy. It may also leave them with frostbite."
},

:ICICLECRASH => {
    :ID => 244,
    :name => "Icicle Crash",
    :function => 0x00F,
    :type => :ICE,
    :category => :physical,
    :basedamage => 85,
    :accuracy => 90,
    :maxpp => 10,
    :effect => 30,
    :target => :SingleNonUser,
    :desc => "The user attacks by dropping icicles on the target. It may also make the target flinch."
},

:ICEPUNCH => {
    :ID => 245,
    :name => "Ice Punch",
    :function => 0x00C,
    :type => :ICE,
    :category => :physical,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The target is punched with an icy fist. It may leave the target with frostbite."
},

:AURORABEAM => {
    :ID => 246,
    :name => "Aurora Beam",
    :function => 0x042,
    :type => :ICE,
    :category => :special,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 10,
    :target => :SingleNonUser,
    :beammove => true,
    :desc => "The target is hit by a colored ray. This may lower the target's Atk stat."
},

:GLACIATE => {
    :ID => 247,
    :name => "Glaciate",
    :function => 0x044,
    :type => :ICE,
    :category => :special,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :AllOpposing,
    :desc => "A freezing cold air strikes the foe It may lower the target's Spd stat."
},

:ICEFANG => {
    :ID => 248,
    :name => "Ice Fang",
    :function => 0x00E,
    :type => :ICE,
    :category => :physical,
    :basedamage => 65,
    :accuracy => 95,
    :maxpp => 15,
    :effect => 10,
    :moreeffect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user bites with freezing fangs. It may flinch or frostbite the target."
},

:AVALANCHE => {
    :ID => 249,
    :name => "Avalanche",
    :function => 0x081,
    :type => :ICE,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :priority => -4,
    :contact => true,
    :desc => "This move deals double damage if the user is hurt by the target that turn."
},

:ICYWIND => {
    :ID => 250,
    :name => "Icy Wind",
    :function => 0x044,
    :type => :ICE,
    :category => :special,
    :basedamage => 55,
    :accuracy => 95,
    :maxpp => 15,
    :effect => 100,
    :target => :AllOpposing,
    :windmove => true,
    :desc => "The foe is chilled by a gust of air. It lowers the target's Speed stat."
},

:FROSTBREATH => {
    :ID => 251,
    :name => "Frost Breath",
    :function => 0x0A0,
    :type => :ICE,
    :category => :special,
    :basedamage => 60,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "Cold breath is blown on the target. This attack is always critical."
},

:ICESHARD => {
    :ID => 252,
    :name => "Ice Shard",
    :function => 0x000,
    :type => :ICE,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 30,
    :target => :SingleNonUser,
    :priority => 1,
    :desc => "The user hurls chunks of ice at the target. This move always goes first."
},

:POWDERSNOW => {
    :ID => 253,
    :name => "Powder Snow",
    :function => 0x00C,
    :type => :ICE,
    :category => :special,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 25,
    :effect => 10,
    :target => :AllOpposing,
    :desc => "The user attacks with a chilling snow. It may also leave them with frostbite."
},

:ICEBALL => {
    :ID => 254,
    :name => "Ice Ball",
    :function => 0x0D3,
    :type => :ICE,
    :category => :physical,
    :basedamage => 30,
    :accuracy => 90,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user rolls into the target for 5 turns. It strengthens upon hitting."
},

:ICICLESPEAR => {
    :ID => 255,
    :name => "Icicle Spear",
    :function => 0x0C0,
    :type => :ICE,
    :category => :physical,
    :basedamage => 25,
    :accuracy => 100,
    :maxpp => 30,
    :target => :SingleNonUser,
    :desc => "The user launches icicles at the foe. It strikes 2 to 5 times in a row."
},

:SHEERCOLD => {
    :ID => 256,
    :name => "Sheer Cold",
    :function => 0x070,
    :type => :ICE,
    :category => :special,
    :basedamage => 1,
    :accuracy => 30,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The foe is hit with a blast of zero degree cold. Causes instant fainting."
},

:HAIL => {
    :ID => 257,
    :name => HAILSNOWNAMEMOD,
    :function => 0x102,
    :type => :ICE,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :UserSide,
    :nonmirror => true,
    :desc => "A " + HAILSNOWLOWMOD + " storm lasting 5 turns damages all non-Ice type Pokémon."
},

:HAZE => {
    :ID => 258,
    :name => "Haze",
    :function => 0x051,
    :type => :ICE,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 30,
    :target => :UserSide,
    :nonmirror => true,
    :desc => "A haze eliminates every stat change among all the Pokémon in the battle."
},

:MIST => {
    :ID => 259,
    :name => "Mist",
    :function => 0x056,
    :type => :ICE,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 30,
    :target => :BothSides,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user is cloaked with a mist that prevents stat-lowering for 5 turns."
},

:EXPLOSION => {
    :ID => 260,
    :name => "Explosion",
    :function => 0x0E0,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 500,
    :accuracy => 100,
    :maxpp => 5,
    :target => :AllNonUsers,
    :desc => "The user explodes to damage those around it. The user faints afterwards."
},

:SELFDESTRUCT => {
    :ID => 261,
    :name => "Self-Destruct",
    :function => 0x0E0,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 200,
    :accuracy => 100,
    :maxpp => 5,
    :target => :AllNonUsers,
    :desc => "The user attacks everything around it by exploding. The user faints after."
},

:GIGAIMPACT => {
    :ID => 262,
    :name => "Giga Impact",
    :function => 0x0C2,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 150,
    :accuracy => 90,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks the target using full power. The user must rest after."
},

:HYPERBEAM => {
    :ID => 263,
    :name => "Hyper Beam",
    :function => 0x0C2,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 150,
    :accuracy => 90,
    :maxpp => 5,
    :target => :SingleNonUser,
    :beammove => true,
    :desc => "The target is attacked with a powerful beam. The user must rest after."
},

:LASTRESORT => {
    :ID => 264,
    :name => "Last Resort",
    :function => 0x125,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 140,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "This move can be used only after the user has used all its other moves."
},

:DOUBLEEDGE => {
    :ID => 265,
    :name => "Double-Edge",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :recoil => 0.33,
    :desc => "A reckless, life-risking tackle. It also damages the user."
},

:HEADCHARGE => {
    :ID => 266,
    :name => "Head Charge",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :recoil => 0.25,
    :desc => "The user charges its head into its target. It also damages the user."
},

:MEGAKICK => {
    :ID => 267,
    :name => "Mega Kick",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 75,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is attacked by a kick launched with muscle-packed power."
},

:THRASH => {
    :ID => 268,
    :name => "Thrash",
    :function => 0x0D2,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 10,
    :target => :RandomOpposing,
    :contact => true,
    :desc => "The user attacks for two to three turns. It then becomes confused."
},

:EGGBOMB => {
    :ID => 269,
    :name => "Egg Bomb",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 75,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "A large egg is hurled at the target with maximum force to inflict damage."
},

:JUDGMENT => {
    :ID => 270,
    :name => "Judgment",
    :function => 0x09F,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user shoots light at the target. Its type varies by plate."
},

:SKULLBASH => {
    :ID => 271,
    :name => "Skull Bash",
    :function => 0x0C8,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 130,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user tucks in its head, then rams the target on the next turn."
},

:HYPERVOICE => {
    :ID => 272,
    :name => "Hyper Voice",
    :function => 0x000,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :AllOpposing,
    :soundmove => true,
    :desc => "The user lets loose a horribe shout with the power to inflict damage."
},

:ROCKCLIMB => {
    :ID => 273,
    :name => "Rock Climb",
    :function => 0x013,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 85,
    :maxpp => 20,
    :effect => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks the target, smashing into it, May confuse the target."
},

:TAKEDOWN => {
    :ID => 274,
    :name => "Take Down",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 85,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :recoil => 0.25,
    :desc => "A reckless charge into the target. It also damages the user a little."
},

:UPROAR => {
    :ID => 275,
    :name => "Uproar",
    :function => 0x0D1,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :RandomOpposing,
    :soundmove => true,
    :desc => "The user attacks in an uproar for three turns. No one can fall asleep."
},

:BODYSLAM => {
    :ID => 276,
    :name => "Body Slam",
    :function => 0x007,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 85,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user falls on the target with its full mass. It may cause paralysis."
},

:TECHNOBLAST => {
    :ID => 277,
    :name => "Techno Blast",
    :function => 0x09F,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The user fires a beam of light at its target. The type on the held Drive."
},

:EXTREMESPEED => {
    :ID => 278,
    :name => "Extreme Speed",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :priority => 2,
    :contact => true,
    :desc => "The user charges the foe at blinding speed. This attack always goes first."
},

:HYPERFANG => {
    :ID => 279,
    :name => "Hyper Fang",
    :function => 0x00F,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 90,
    :maxpp => 15,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user bites on the foe with its sharp fangs. It may flinch the target."
},

:MEGAPUNCH => {
    :ID => 280,
    :name => "Mega Punch",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 85,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The target is slugged by a punch thrown with muscle-packed power."
},

:RAZORWIND => {
    :ID => 281,
    :name => "Razor Wind",
    :function => 0x0C3,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :AllOpposing,
    :highcrit => true,
    :desc => "A two-turn attack. Wind hits the foe on the second turn. Critical hits land more often."
},

:SLAM => {
    :ID => 282,
    :name => "Slam",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 75,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is slammed with a long tail, vines, etc., to inflict damage."
},

:STRENGTH => {
    :ID => 283,
    :name => "Strength",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is slugged at maximum power. It can move heavy boulders."
},

:TRIATTACK => {
    :ID => 284,
    :name => "Tri Attack",
    :function => 0x017,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 20,
    :target => :SingleNonUser,
    :desc => "The user strikes with a beam attack. May also burn, frostbite, or paralyze."
},

:CRUSHCLAW => {
    :ID => 285,
    :name => "Crush Claw",
    :function => 0x043,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 75,
    :accuracy => 95,
    :maxpp => 10,
    :effect => 50,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user slashes the foe with claws. It may lower the target's Defense."
},

:RELICSONG => {
    :ID => 286,
    :name => "Relic Song",
    :function => 0x003,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 10,
    :target => :AllOpposing,
    :soundmove => true,
    :desc => "The user sings a song, attacking the foe's heart. It may induce sleep."
},

:CHIPAWAY => {
    :ID => 287,
    :name => "Chip Away",
    :function => 0x0A9,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user strikes continually. The foe's stat changes don't affect damage."
},

:DIZZYPUNCH => {
    :ID => 288,
    :name => "Dizzy Punch",
    :function => 0x013,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 20,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The foe is hit with rhythmic punches that may also leave it confused."
},

:FACADE => {
    :ID => 289,
    :name => "Facade",
    :function => 0x07E,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "An attack that doubles in power if the user has a major status effect."
},

:HEADBUTT => {
    :ID => 290,
    :name => "Headbutt",
    :function => 0x00F,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user sticks out its head and charges. It may make the foe flinch."
},

:RETALIATE => {
    :ID => 291,
    :name => "Retaliate",
    :function => 0x085,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user avenges an ally. If an ally fainted the prior turn, the damage increases."
},

:SECRETPOWER => {
    :ID => 292,
    :name => "Secret Power",
    :function => 0x0A4,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 30,
    :target => :SingleNonUser,
    :desc => "A secret power is used to attack. Effects vary among environment."
},

:SLASH => {
    :ID => 293,
    :name => "Slash",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :highcrit => true,
    :sharpmove => true,
    :desc => "The target is attacked with a slash. Critical hits land more easily."
},

:HORNATTACK => {
    :ID => 294,
    :name => "Horn Attack",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 25,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is jabbed with a sharply pointed horn to inflict damage."
},

:STOMP => {
    :ID => 295,
    :name => "Stomp",
    :function => 0x010,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is stomped with a big foot. It may make the foe flinch."
},

:COVET => {
    :ID => 296,
    :name => "Covet",
    :function => 0x0F1,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 25,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user approaches the target, then steals the target's held item."
},

:ROUND => {
    :ID => 297,
    :name => "Round",
    :function => 0x083,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :soundmove => true,
    :desc => "The user attacks the target with a song. Others can join for more damage."
},

:SMELLINGSALTS => {
    :ID => 298,
    :name => "Smelling Salts",
    :function => 0x07C,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "This attack does double damage on a paralyzed target. It cures the target's paralysis."
},

:SWIFT => {
    :ID => 299,
    :name => "Swift",
    :function => 0x0A5,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 60,
    :accuracy => 0,
    :maxpp => 20,
    :target => :AllOpposing,
    :desc => "Star-shaped rays are shot at the opposing team. This attack never misses."
},

:VICEGRIP => {
    :ID => 300,
    :name => "Vice Grip",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 55,
    :accuracy => 100,
    :maxpp => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is gripped and squeezed from both sides to inflict damage."
},

:CUT => {
    :ID => 301,
    :name => "Cut",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 95,
    :maxpp => 30,
    :target => :SingleNonUser,
    :contact => true,
    :sharpmove => true,
    :desc => "The target is cut with a scythe or a claw. It can also be used to cut down thin trees."
},

:STRUGGLE => {
    :ID => 302,
    :name => "Struggle",
    :function => 0x002,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 0,
    :maxpp => 1,
    :target => :SingleNonUser,
    :contact => true,
    :nonmirror => true,
    :desc => "An attack that is used in desperation if the user has no PP. It also hurts the user."
},

:TACKLE => {
    :ID => 303,
    :name => "Tackle",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 35,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "A physical attack in which the user charges and slams into the target with its body."
},

:WEATHERBALL => {
    :ID => 304,
    :name => "Weather Ball",
    :function => 0x087,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "An attack move that varies in power and type depending on the weather."
},

:ECHOEDVOICE => {
    :ID => 305,
    :name => "Echoed Voice",
    :function => 0x092,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :soundmove => true,
    :desc => "The user hits the target with an echoing voice. If used every turn, it is more powerful."
},

:FAKEOUT => {
    :ID => 306,
    :name => "Fake Out",
    :function => 0x012,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :priority => 3,
    :contact => true,
    :desc => "This attack hits first and makes targets flinch. It only works on the user's first turn."
},

:FALSESWIPE => {
    :ID => 307,
    :name => "False Swipe",
    :function => 0x0E9,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 40,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "A restrained attack that leaves the target with at least 1 HP."
},

:PAYDAY => {
    :ID => 308,
    :name => "Pay Day",
    :function => 0x109,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :desc => "Numerous coins are hurled at the target to inflict damage. Money is earned after battle."
},

:POUND => {
    :ID => 309,
    :name => "Pound",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 35,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is physically pounded with a long tail or a foreleg, etc."
},

:QUICKATTACK => {
    :ID => 310,
    :name => "Quick Attack",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 30,
    :target => :SingleNonUser,
    :priority => 1,
    :contact => true,
    :desc => "The user slams the target at a tremendous speed. It is sure to strike first."
},

:SCRATCH => {
    :ID => 311,
    :name => "Scratch",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 35,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Hard, pointed, and sharp claws rake the target to inflict damage."
},

:SNORE => {
    :ID => 312,
    :name => "Snore",
    :function => 0x011,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 30,
    :target => :SingleNonUser,
    :soundmove => true,
    :desc => "An attack that can be used only if the user is asleep. It may also make the target flinch."
},

:DOUBLEHIT => {
    :ID => 313,
    :name => "Double Hit",
    :function => 0x0BD,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 35,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user slams the target with a tail, vine, or tentacle. The target is hit twice."
},

:FEINT => {
    :ID => 314,
    :name => "Feint",
    :function => 0x0AD,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 30,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :priority => 2,
    :bypassprotect => true,
    :desc => "An attack that hits a target using Protect or Detect. It lifts the effects of said moves."
},

:TAILSLAP => {
    :ID => 315,
    :name => "Tail Slap",
    :function => 0x0C0,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 25,
    :accuracy => 85,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user strikes the target with its tail. It hits the Pokémon two to five times in a row."
},

:RAGE => {
    :ID => 316,
    :name => "Rage",
    :function => 0x093,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 20,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "While the move is in use, the user's rage raises the Attack stat when the user is hit."
},

:RAPIDSPIN => {
    :ID => 317,
    :name => "Rapid Spin",
    :function => 0x110,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 40,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "A spin attack that can also eliminate such moves as Bind, Wrap, Leech Seed, and Spikes."
},

:SPIKECANNON => {
    :ID => 318,
    :name => "Spike Cannon",
    :function => 0x0C0,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 20,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "Sharp spikes are shot at the target in rapid succession. They hit two to five times."
},

:COMETPUNCH => {
    :ID => 319,
    :name => "Comet Punch",
    :function => 0x0C0,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 18,
    :accuracy => 85,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The target is hit with a flurry of punches that strike two to five times in a row."
},

:FURYSWIPES => {
    :ID => 320,
    :name => "Fury Swipes",
    :function => 0x0C0,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 18,
    :accuracy => 80,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is raked with sharp claws or scythes for two to five times in quick succession."
},

:BARRAGE => {
    :ID => 321,
    :name => "Barrage",
    :function => 0x0C0,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 15,
    :accuracy => 85,
    :maxpp => 20,
    :target => :SingleNonUser,
    :desc => "Round objects are hurled at the target to strike two to five times in a row."
},

:BIND => {
    :ID => 322,
    :name => "Bind",
    :function => 0x0CF,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 15,
    :accuracy => 85,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Things such as long bodies or tentacles are used to bind the foe for four to five turns."
},

:DOUBLESLAP => {
    :ID => 323,
    :name => "Double Slap",
    :function => 0x0C0,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 15,
    :accuracy => 85,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is slapped repeatedly, back and forth, two to five times in a row."
},

:FURYATTACK => {
    :ID => 324,
    :name => "Fury Attack",
    :function => 0x0C0,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 15,
    :accuracy => 85,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is jabbed repeatedly with a horn or beak two to five times in a row."
},

:WRAP => {
    :ID => 325,
    :name => "Wrap",
    :function => 0x0CF,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 15,
    :accuracy => 90,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "A long body or vines are used to wrap and squeeze the target for four to five turns."
},

:CONSTRICT => {
    :ID => 326,
    :name => "Constrict",
    :function => 0x044,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 10,
    :accuracy => 100,
    :maxpp => 35,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is attacked with creeping tentacles or vines. It can lower the target's Speed."
},

:BIDE => {
    :ID => 327,
    :name => "Bide",
    :function => 0x0D4,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :priority => 1,
    :contact => true,
    :nonmirror => true,
    :desc => "The user endures for two turns, then strikes back to cause double the damage taken."
},

:CRUSHGRIP => {
    :ID => 328,
    :name => "Crush Grip",
    :function => 0x08C,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is crushed. The greater the target's HP, the more powerful the attack."
},

:ENDEAVOR => {
    :ID => 329,
    :name => "Endeavor",
    :function => 0x06E,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "An attack move that cuts down the target's HP to equal the user's HP."
},

:FLAIL => {
    :ID => 330,
    :name => "Flail",
    :function => 0x098,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user flails about to attack. It becomes more powerful the less HP the user has."
},

:FRUSTRATION => {
    :ID => 331,
    :name => "Frustration",
    :function => 0x08A,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "A full-power attack that grows more powerful the less the user likes its Trainer."
},

:GUILLOTINE => {
    :ID => 332,
    :name => "Guillotine",
    :function => 0x070,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 30,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "A vicious attack with big pincers. The target will faint instantly if this attack hits."
},

:HIDDENPOWER => {
    :ID => 333,
    :name => "Hidden Power",
    :function => 0x090,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HORNDRILL => {
    :ID => 334,
    :name => "Horn Drill",
    :function => 0x070,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 30,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user stabs the target with a rotating horn. If it hits, the target faints instantly."
},

:NATURALGIFT => {
    :ID => 335,
    :name => "Natural Gift",
    :function => 0x096,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "The user draws power from its held Berry. The Berry determines the type and power."
},

:PRESENT => {
    :ID => 336,
    :name => "Present",
    :function => 0x094,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 90,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "The user attacks by giving the target a gift with a hidden trap. It restores HP sometimes."
},

:RETURN => {
    :ID => 337,
    :name => "Return",
    :function => 0x089,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "A full-power attack that grows more powerful the more the user likes its Trainer."
},

:SONICBOOM => {
    :ID => 338,
    :name => "Sonic Boom",
    :function => 0x06A,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 1,
    :accuracy => 90,
    :maxpp => 20,
    :target => :SingleNonUser,
    :desc => "The target is hit with a destructive shock wave that always inflicts 20 HP damage."
},

:SPITUP => {
    :ID => 339,
    :name => "Spit Up",
    :function => 0x113,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "The power stored by Stockpile is released. The more power stored, the greater the damage."
},

:SUPERFANG => {
    :ID => 340,
    :name => "Super Fang",
    :function => 0x06C,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user bites hard on the target with sharp front fangs. It cuts the target's HP to half."
},

:TRUMPCARD => {
    :ID => 341,
    :name => "Trump Card",
    :function => 0x097,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 1,
    :accuracy => 0,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The fewer PP this move has, the greater its attack power."
},

:WRINGOUT => {
    :ID => 342,
    :name => "Wring Out",
    :function => 0x08C,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user wrings the target. The more HP the target has, the greater this attack's power."
},

:ACUPRESSURE => {
    :ID => 343,
    :name => "Acupressure",
    :function => 0x037,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 30,
    :target => :UserOrPartner,
    :bypassprotect => true,
    :nonmirror => true,
    :desc => "The user applies pressure to stress points, sharply boosting one of its stats."
},

:AFTERYOU => {
    :ID => 344,
    :name => "After You",
    :function => 0x11D,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "The user helps the target and makes it use its move right after the user."
},

:ASSIST => {
    :ID => 345,
    :name => "Assist",
    :function => 0x0B5,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :nonmirror => true,
    :desc => "The user randomly uses a move among those known by other Pokémon in the party."
},

:ATTRACT => {
    :ID => 346,
    :name => "Attract",
    :function => 0x016,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "If it is the opposite gender of the user, the target becomes infatuated."
},

:BATONPASS => {
    :ID => 347,
    :name => "Baton Pass",
    :function => 0x0ED,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 40,
    :target => :User,
    :nonmirror => true,
    :desc => "The user switches places with a party Pokémon in waiting, passing along any stat changes."
},

:BELLYDRUM => {
    :ID => 348,
    :name => "Belly Drum",
    :function => 0x03A,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user maximizes its Attack stat in exchange for HP equal to half its max HP."
},

:BESTOW => {
    :ID => 349,
    :name => "Bestow",
    :function => 0x0F3,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :desc => "The user passes its held item to the target when the target isn't holding an item."
},

:BLOCK => {
    :ID => 350,
    :name => "Block",
    :function => 0x0EF,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :magiccoat => true,
    :desc => "The user blocks the target's way with arms spread wide to prevent escape."
},

:CAMOUFLAGE => {
    :ID => 351,
    :name => "Camouflage",
    :function => 0x060,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user's type is changed depending on its environment."
},

:CAPTIVATE => {
    :ID => 352,
    :name => "Captivate",
    :function => 0x04E,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :AllOpposing,
    :magiccoat => true,
    :desc => "If it is the opposite gender of the user, the target's Sp. Atk stat is lowered."
},

:CHARM => {
    :ID => 353,
    :name => "Charm",
    :function => 0x04B,
    :type => :FAIRY,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user gazes at the target, making it less wary. The target's Attack is harshly lowered."
},

:CONVERSION => {
    :ID => 354,
    :name => "Conversion",
    :function => 0x05E,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 30,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user changes its type to become the same type as one of its moves."
},

:CONVERSION2 => {
    :ID => 355,
    :name => "Conversion 2",
    :function => 0x05F,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 30,
    :target => :SingleNonUser,
    :nonmirror => true,
    :bypassprotect => true,
    :desc => "The user changes to a resistant type of the attack the opponent used last."
},

:COPYCAT => {
    :ID => 356,
    :name => "Copycat",
    :function => 0x0AF,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :NoTarget,
    :nonmirror => true,
    :desc => "The user mimics the move used immediately before it."
},

:DEFENSECURL => {
    :ID => 357,
    :name => "Defense Curl",
    :function => 0x01E,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 40,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user curls up to conceal weak spots and raise its Defense stat."
},

:DISABLE => {
    :ID => 358,
    :name => "Disable",
    :function => 0x0B9,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "For four turns, this move prevents the target from using the move it last used."
},

:DOUBLETEAM => {
    :ID => 359,
    :name => "Double Team",
    :function => 0x022,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "By moving rapidly, the user makes illusory copies of itself to raise its evasiveness."
},

:ENCORE => {
    :ID => 360,
    :name => "Encore",
    :function => 0x0BC,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user compels the target to keep using only the move it last used for three turns."
},

:ENDURE => {
    :ID => 361,
    :name => "Endure",
    :function => 0x0E8,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :priority => 4,
    :nonmirror => true,
    :desc => "The user endures any attack. Its chance of failing is greater if used in succession."
},

:ENTRAINMENT => {
    :ID => 362,
    :name => "Entrainment",
    :function => 0x066,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user dances and compels the target to mimic it, making the target's Ability identical."
},

:FLASH => {
    :ID => 363,
    :name => "Flash",
    :function => 0x047,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user's flashing light cuts the target's accuracy. It can be used to illuminate caves."
},

:FOCUSENERGY => {
    :ID => 364,
    :name => "Focus Energy",
    :function => 0x023,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 30,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user takes a deep breath and focuses so that critical hits land more easily."
},

:FOLLOWME => {
    :ID => 365,
    :name => "Follow Me",
    :function => 0x117,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :priority => 2,
    :nonmirror => true,
    :desc => "The user draws attention to itself, making all targets take aim only at the user."
},

:FORESIGHT => {
    :ID => 366,
    :name => "Foresight",
    :function => 0x0A7,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 40,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "Identifies an evasive or Ghost-type target."
},

:GLARE => {
    :ID => 367,
    :name => "Glare",
    :function => 0x007,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 30,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user intimidates the target with the pattern on its belly to cause paralysis."
},

:GROWL => {
    :ID => 368,
    :name => "Growl",
    :function => 0x042,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 40,
    :target => :AllOpposing,
    :magiccoat => true,
    :soundmove => true,
    :desc => "The user growls, making the opposing team less wary. The foes' Attack stats are lowered."
},

:GROWTH => {
    :ID => 369,
    :name => "Growth",
    :function => 0x028,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user's body grows all at once, raising the Atk and Sp. Atk stats."
},

:HARDEN => {
    :ID => 370,
    :name => "Harden",
    :function => 0x01D,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 30,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user stiffens all the muscles in its body to raise its Defense stat."
},

:HEALBELL => {
    :ID => 371,
    :name => "Heal Bell",
    :function => 0x019,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :BothSides,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user makes a soothing bell chime to heal the status problems of all party Pokémon."
},

:HELPINGHAND => {
    :ID => 372,
    :name => "Helping Hand",
    :function => 0x09C,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :Partner,
    :priority => 5,
    :nonmirror => true,
    :desc => "The user assists an ally by boosting the power of its attack."
},

:HOWL => {
    :ID => 373,
    :name => "Howl",
    :function => 0x01C,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 40,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user howls loudly to raise its spirit, boosting its Attack stat."
},

:LEER => {
    :ID => 374,
    :name => "Leer",
    :function => 0x043,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 30,
    :target => :AllOpposing,
    :magiccoat => true,
    :desc => "Leers with sharp eyes. The opposing team's Defense stats are reduced."
},

:LOCKON => {
    :ID => 375,
    :name => "Lock-On",
    :function => 0x0A6,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The user takes sure aim at the target. It ensures the next attack does not miss."
},

:LOVELYKISS => {
    :ID => 376,
    :name => "Lovely Kiss",
    :function => 0x003,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 75,
    :maxpp => 10,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user tries to force a kiss on the target. If it suceeds, the target falls asleep."
},

:LUCKYCHANT => {
    :ID => 377,
    :name => "Lucky Chant",
    :function => 0x0A1,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 30,
    :target => :BothSides,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user chants toward the sky, preventing opposing Pokémon from landing critical hits."
},

:MEFIRST => {
    :ID => 378,
    :name => "Me First",
    :function => 0x0B0,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleOpposing,
    :nonmirror => true,
    :desc => "The user cuts ahead of the target to use its intended move with greater power."
},

:MEANLOOK => {
    :ID => 379,
    :name => "Mean Look",
    :function => 0x0EF,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :magiccoat => true,
    :desc => "The user pins the target with a dark, arresting look. The target becomes unable to flee."
},

:METRONOME => {
    :ID => 380,
    :name => "Metronome",
    :function => 0x0B6,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :NoTarget,
    :nonmirror => true,
    :desc => "The user waggles a finger and stimulates its brain into randomly using nearly any move."
},

:MILKDRINK => {
    :ID => 381,
    :name => "Milk Drink",
    :function => 0x0D5,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The user restores its HP by up to half of its maximum. May be used in the field to heal."
},

:MIMIC => {
    :ID => 382,
    :name => "Mimic",
    :function => 0x05C,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "The user copies the target's last move and adds it to its move-set until it is switched out."
},

:MINDREADER => {
    :ID => 383,
    :name => "Mind Reader",
    :function => 0x0A6,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The user senses the target's movements with its mind to ensure its next attack hits."
},

:MINIMIZE => {
    :ID => 384,
    :name => "Minimize",
    :function => 0x034,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user compresses its body to look smaller, which sharply raises its evasiveness."
},

:MOONLIGHT => {
    :ID => 385,
    :name => "Moonlight",
    :function => 0x0D8,
    :type => :FAIRY,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The user restores its own HP. The amount of HP regained varies with the weather."
},

:MORNINGSUN => {
    :ID => 386,
    :name => "Morning Sun",
    :function => 0x0D8,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The user restores its own HP. The amount of HP regained varies with the weather."
},

:NATUREPOWER => {
    :ID => 387,
    :name => "Nature Power",
    :function => 0x0B3,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "An attack that makes use of the user's environment."
},

:ODORSLEUTH => {
    :ID => 388,
    :name => "Odor Sleuth",
    :function => 0x0A7,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 40,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "Enables Ghost-types  to be hit by Normal and Fighting-type moves."
},

:PAINSPLIT => {
    :ID => 389,
    :name => "Pain Split",
    :function => 0x05A,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :desc => "The user adds its HP to the target's HP, then shares the combined HP with the target."
},

:PERISHSONG => {
    :ID => 390,
    :name => "Perish Song",
    :function => 0x0E5,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :UserSide,
    :bypassprotect => true,
    :nonmirror => true,
    :soundmove => true,
    :desc => "Any Pokémon that hears this song faints in three turns, unless it switches out of battle."
},

:PROTECT => {
    :ID => 391,
    :name => "Protect",
    :function => 0x0AA,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :priority => 4,
    :nonmirror => true,
    :desc => "It lets the user evade a move. Its chance of failing rises if used in succession."
},

:PSYCHUP => {
    :ID => 392,
    :name => "Psych Up",
    :function => 0x055,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :nonmirror => true,
    :desc => "The user hypnotizes itself into copying any stat change made by the target."
},

:RECOVER => {
    :ID => 393,
    :name => "Recover",
    :function => 0x0D5,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "Restoring its own cells, the user restores its own HP by half of its max HP."
},

:RECYCLE => {
    :ID => 394,
    :name => "Recycle",
    :function => 0x0F6,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user recycles a held item that has been used in battle so it can be used again."
},

:REFLECTTYPE => {
    :ID => 395,
    :name => "Reflect Type",
    :function => 0x062,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "The user reflects the target's type, making it the same type as the target."
},

:REFRESH => {
    :ID => 396,
    :name => "Refresh",
    :function => 0x018,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user rests to cure itself of a poisoning, burn, or paralysis."
},

:ROAR => {
    :ID => 397,
    :name => "Roar",
    :function => 0x0EB,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :priority => -6,
    :bypassprotect => true,
    :magiccoat => true,
    :soundmove => true,
    :desc => "The target is replaced by another Pokémon in its party. In the wild, the battle ends."
},

:SAFEGUARD => {
    :ID => 398,
    :name => "Safeguard",
    :function => 0x01A,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 25,
    :target => :BothSides,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user creates a protective field that prevents status problems for five turns."
},

:SCARYFACE => {
    :ID => 399,
    :name => "Scary Face",
    :function => 0x04D,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user frightens the target with a scary face to harshly reduce its Speed stat."
},

:SCREECH => {
    :ID => 400,
    :name => "Screech",
    :function => 0x04C,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 85,
    :maxpp => 40,
    :target => :SingleNonUser,
    :magiccoat => true,
    :soundmove => true,
    :desc => "An earsplitting screech harshly reduces the target's Defense stat."
},

:SHARPEN => {
    :ID => 401,
    :name => "Sharpen",
    :function => 0x01C,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 30,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user reduces its polygon count to make itself more jagged, raising the Attack stat."
},

:SHELLSMASH => {
    :ID => 402,
    :name => "Shell Smash",
    :function => 0x035,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user's defensive stats are lowered but its offensive stats are sharply raised."
},

:SIMPLEBEAM => {
    :ID => 403,
    :name => "Simple Beam",
    :function => 0x063,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user's mysterious psychic wave changes the target's Ability to Simple."
},

:SING => {
    :ID => 404,
    :name => "Sing",
    :function => 0x003,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 55,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :soundmove => true,
    :desc => "A soothing lullaby is sung in a calming voice that puts the target into a deep slumber."
},

:SKETCH => {
    :ID => 405,
    :name => "Sketch",
    :function => 0x05D,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 1,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :nonmirror => true,
    :desc => "It enables the user to permanently learn the move last used by the target."
},

:SLACKOFF => {
    :ID => 406,
    :name => "Slack Off",
    :function => 0x0D5,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The user slacks off, restoring its own HP by up to half of its maximum HP."
},

:SLEEPTALK => {
    :ID => 407,
    :name => "Sleep Talk",
    :function => 0x0B4,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :NoTarget,
    :nonmirror => true,
    :desc => "While it is asleep, the user randomly uses one of the moves it knows."
},

:SMOKESCREEN => {
    :ID => 408,
    :name => "Smoke Screen",
    :function => 0x047,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user releases an obscuring cloud of smoke or ink. It reduces the target's accuracy."
},

:SOFTBOILED => {
    :ID => 409,
    :name => "Soft-Boiled",
    :function => 0x0D5,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The user restores its own HP by half of its maximum. May be used in the field to heal."
},

:SPLASH => {
    :ID => 410,
    :name => "Splash",
    :function => 0x001,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 40,
    :target => :User,
    :nonmirror => true,
    :gravityblocked => true,
    :desc => "The user just flops and splashes around to no effect at all."
},

:STOCKPILE => {
    :ID => 411,
    :name => "Stockpile",
    :function => 0x112,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user stores power and raises its Defense and Sp. Def. The move can be used thrice."
},

:SUBSTITUTE => {
    :ID => 412,
    :name => "Substitute",
    :function => 0x10C,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user makes a copy of itself using some of its HP. The copy serves as the user's decoy."
},

:SUPERSONIC => {
    :ID => 413,
    :name => "Supersonic",
    :function => 0x013,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 55,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :soundmove => true,
    :desc => "The user generates odd sound waves from its body. It may confuse the target."
},

:SWAGGER => {
    :ID => 414,
    :name => "Swagger",
    :function => 0x041,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 85,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user confuses the target. It also sharply raises the target's Attack stat."
},

:SWALLOW => {
    :ID => 415,
    :name => "Swallow",
    :function => 0x114,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The power stored using Stockpile is absorbed to heal HP. Storing more heals more HP."
},

:SWEETKISS => {
    :ID => 416,
    :name => "Sweet Kiss",
    :function => 0x013,
    :type => :FAIRY,
    :category => :status,
    :basedamage => 0,
    :accuracy => 75,
    :maxpp => 10,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user kisses the target with a sweet, angelic cuteness that causes confusion."
},

:SWEETSCENT => {
    :ID => 417,
    :name => "Sweet Scent",
    :function => 0x048,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :AllOpposing,
    :magiccoat => true,
    :desc => "A sweet scent that lowers the opposing team's evasiveness. It also lures wild Pokémon."
},

:SWORDSDANCE => {
    :ID => 418,
    :name => "Swords Dance",
    :function => 0x02E,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "A frenetic dance to uplift the fighting spirit. It sharply raises the user's Attack stat."
},

:TAILWHIP => {
    :ID => 419,
    :name => "Tail Whip",
    :function => 0x043,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 30,
    :target => :AllOpposing,
    :magiccoat => true,
    :desc => "The user wags its tail cutely, lowering foes' Defense stat."
},

:TEETERDANCE => {
    :ID => 420,
    :name => "Teeter Dance",
    :function => 0x013,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :AllNonUsers,
    :desc => "The user performs a wobbly dance that confuses the Pokémon around it."
},

:TICKLE => {
    :ID => 421,
    :name => "Tickle",
    :function => 0x04A,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user tickles the target into laughing, reducing its Attack and Defense stats."
},

:TRANSFORM => {
    :ID => 422,
    :name => "Transform",
    :function => 0x069,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :nonmirror => true,
    :desc => "The user transforms into a clone of its target."
},

:WHIRLWIND => {
    :ID => 423,
    :name => "Whirlwind",
    :function => 0x0EB,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :priority => -6,
    :bypassprotect => true,
    :magiccoat => true,
    :windmove => true,
    :desc => "The foe is blown away to be replaced by another Pokémon or flee."
},

:WISH => {
    :ID => 424,
    :name => "Wish",
    :function => 0x0D7,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "One turn after it is used, the target's HP is restored by half of its maximum HP."
},

:WORKUP => {
    :ID => 425,
    :name => "Work Up",
    :function => 0x027,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 30,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user is roused, and its Attack and Sp. Atk stats increase."
},

:YAWN => {
    :ID => 426,
    :name => "Yawn",
    :function => 0x004,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user lets loose a yawn that lulls the target into falling asleep on the next turn."
},

:GUNKSHOT => {
    :ID => 427,
    :name => "Gunk Shot",
    :function => 0x005,
    :type => :POISON,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 80,
    :maxpp => 5,
    :effect => 30,
    :target => :SingleNonUser,
    :desc => "The user shoots filthy garbage at the target to attack. It may poison the target."
},

:SLUDGEWAVE => {
    :ID => 428,
    :name => "Sludge Wave",
    :function => 0x005,
    :type => :POISON,
    :category => :special,
    :basedamage => 95,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 10,
    :target => :AllNonUsers,
    :desc => "It swamps the area near the user with giant sludge waves. It may also poison those hit."
},

:SLUDGEBOMB => {
    :ID => 429,
    :name => "Sludge Bomb",
    :function => 0x005,
    :type => :POISON,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 30,
    :target => :SingleNonUser,
    :desc => "Unsanitary sludge is hurled at the target. It may also poison the target."
},

:POISONJAB => {
    :ID => 430,
    :name => "Poison Jab",
    :function => 0x005,
    :type => :POISON,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is jabbed with a tentacle or arm covered in poison. It may poison the target."
},

:CROSSPOISON => {
    :ID => 431,
    :name => "Cross Poison",
    :function => 0x005,
    :type => :POISON,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :highcrit => true,
    :sharpmove => true,
    :desc => "A slash with poisonous blades that can leave targets poisoned. Critical hits land easier."
},

:SLUDGE => {
    :ID => 432,
    :name => "Sludge",
    :function => 0x005,
    :type => :POISON,
    :category => :special,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 30,
    :target => :SingleNonUser,
    :desc => "Unsanitary sludge is hurled at the target. It may also poison the target."
},

:VENOSHOCK => {
    :ID => 433,
    :name => "Venoshock",
    :function => 0x07B,
    :type => :POISON,
    :category => :special,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user drenches the target in a poison. Its power doubles if the target is poisoned."
},

:CLEARSMOG => {
    :ID => 434,
    :name => "Clear Smog",
    :function => 0x050,
    :type => :POISON,
    :category => :special,
    :basedamage => 50,
    :accuracy => 0,
    :maxpp => 15,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user throws a clump of special mud. All status changes are returned to normal."
},

:POISONFANG => {
    :ID => 435,
    :name => "Poison Fang",
    :function => 0x006,
    :type => :POISON,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 50,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user bites the target with toxic fangs. It may also leave the target badly poisoned."
},

:POISONTAIL => {
    :ID => 436,
    :name => "Poison Tail",
    :function => 0x005,
    :type => :POISON,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 25,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :highcrit => true,
    :desc => "The user attacks with its tail. It may poison the target. Critical hits land easier."
},

:ACID => {
    :ID => 437,
    :name => "Acid",
    :function => 0x046,
    :type => :POISON,
    :category => :special,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 30,
    :effect => 10,
    :target => :AllOpposing,
    :desc => "The opposing team is attacked with acid and may also lower the targets' Sp.Def stats."
},

:ACIDSPRAY => {
    :ID => 438,
    :name => "Acid Spray",
    :function => 0x04F,
    :type => :POISON,
    :category => :special,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user spits fluid thats melts the target. It harshly reduces the target's Sp. Def."
},

:SMOG => {
    :ID => 439,
    :name => "Smog",
    :function => 0x005,
    :type => :POISON,
    :category => :special,
    :basedamage => 30,
    :accuracy => 85,
    :maxpp => 20,
    :effect => 40,
    :target => :SingleNonUser,
    :desc => "The target is attacked with a discharge of filthy gases. It may also poison the target."
},

:POISONSTING => {
    :ID => 440,
    :name => "Poison Sting",
    :function => 0x005,
    :type => :POISON,
    :category => :physical,
    :basedamage => 15,
    :accuracy => 100,
    :maxpp => 35,
    :effect => 30,
    :target => :SingleNonUser,
    :desc => "The user stabs the target with a poisonous stinger. This may also poison the target."
},

:ACIDARMOR => {
    :ID => 441,
    :name => "Acid Armor",
    :function => 0x02F,
    :type => :POISON,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user alters its cell structure to liquefy itself, sharply raising its Defense."
},

:COIL => {
    :ID => 442,
    :name => "Coil",
    :function => 0x025,
    :type => :POISON,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user coils up and concentrates. This raises its Attack, Defense, and Accuracy."
},

:GASTROACID => {
    :ID => 443,
    :name => "Gastro Acid",
    :function => 0x068,
    :type => :POISON,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user hurls up its stomach acids on the target. This eliminates the target's Ability."
},

:POISONGAS => {
    :ID => 444,
    :name => "Poison Gas",
    :function => 0x005,
    :type => :POISON,
    :category => :status,
    :basedamage => 0,
    :accuracy => 90,
    :maxpp => 40,
    :target => :AllOpposing,
    :magiccoat => true,
    :desc => "A cloud of poison gas is sprayed on opposing Pokémon. It may poison those hit."
},

:POISONPOWDER => {
    :ID => 445,
    :name => "Poison Powder",
    :function => 0x005,
    :type => :POISON,
    :category => :status,
    :basedamage => 0,
    :accuracy => 75,
    :maxpp => 35,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user scatters a cloud of poisonous dust on the target. It may poison the target."
},

:TOXIC => {
    :ID => 446,
    :name => "Toxic",
    :function => 0x006,
    :type => :POISON,
    :category => :status,
    :basedamage => 0,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "A move that leaves the target badly poisoned. Its poison damage worsens every turn."
},

:TOXICSPIKES => {
    :ID => 447,
    :name => "Toxic Spikes",
    :function => 0x104,
    :type => :POISON,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :OpposingSide,
    :magiccoat => true,
    :nonmirror => true,
    :desc => "The user lays a trap of poison spikes. They poison opponents that switch into battle."
},

:PSYCHOBOOST => {
    :ID => 448,
    :name => "Psycho Boost",
    :function => 0x03F,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 140,
    :accuracy => 90,
    :maxpp => 5,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user hits the target at full power. The attack harshly reduces the user's Sp. Atk stat."
},

:DREAMEATER => {
    :ID => 449,
    :name => "Dream Eater",
    :function => 0x0DE,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "The user eats the dreams of a sleeping target. It absorbs half the damage caused."
},

:FUTURESIGHT => {
    :ID => 450,
    :name => "Future Sight",
    :function => 0x111,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :nonmirror => true,
    :desc => "Two turns after this move is used, a hunk of psychic energy attacks the target."
},

:PSYSTRIKE => {
    :ID => 451,
    :name => "Psystrike",
    :function => 0x122,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user creates an odd psychic wave to hit the target. This attack does physical damage."
},

:PSYCHIC => {
    :ID => 452,
    :name => "Psychic",
    :function => 0x046,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "The target is hit by a strong telekinetic force. It may reduce the target's Sp. Def stat."
},

:EXTRASENSORY => {
    :ID => 453,
    :name => "Extrasensory",
    :function => 0x00F,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "The user attacks with an odd, unseeable power. It may also make the target flinch."
},

:PSYSHOCK => {
    :ID => 454,
    :name => "Psyshock",
    :function => 0x122,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user creates an odd psychic wave to hit the target. This attack does physical damage."
},

:ZENHEADBUTT => {
    :ID => 455,
    :name => "Zen Headbutt",
    :function => 0x00F,
    :type => :PSYCHIC,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 90,
    :maxpp => 15,
    :effect => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user focuses power to its head and hits the target. It may make the target flinch."
},

:LUSTERPURGE => {
    :ID => 456,
    :name => "Luster Purge",
    :function => 0x046,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 5,
    :effect => 50,
    :target => :SingleNonUser,
    :desc => "The user lets loose a damaging burst of light. It may reduce the target's Sp. Def stat."
},

:MISTBALL => {
    :ID => 457,
    :name => "Mist Ball",
    :function => 0x045,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 5,
    :effect => 50,
    :target => :SingleNonUser,
    :desc => "A mistlike flurry of down envelops and damages the target. It may lower the target's Sp. Atk."
},

:PSYCHOCUT => {
    :ID => 458,
    :name => "Psycho Cut",
    :function => 0x000,
    :type => :PSYCHIC,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :highcrit => true,
    :sharpmove => true,
    :desc => "The user tears at the target with blades formed by psychic power. Critical hits land easier."
},

:SYNCHRONOISE => {
    :ID => 459,
    :name => "Synchronoise",
    :function => 0x123,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 15,
    :target => :AllNonUsers,
    :desc => "Using a shock wave, the user inflicts damage on Pokémon of the same type."
},

:PSYBEAM => {
    :ID => 460,
    :name => "Psybeam",
    :function => 0x013,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 10,
    :target => :SingleNonUser,
    :beammove => true,
    :desc => "The target is attacked with a peculiar ray. It may also cause confusion."
},

:HEARTSTAMP => {
    :ID => 461,
    :name => "Heart Stamp",
    :function => 0x00F,
    :type => :PSYCHIC,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 25,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user unleashes a vicious blow after its cute act. It may make the target flinch."
},

:CONFUSION => {
    :ID => 462,
    :name => "Confusion",
    :function => 0x013,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 25,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "The target is hit by a weak telekinetic force. It may also leave the target confused."
},

:MIRRORCOAT => {
    :ID => 463,
    :name => "Mirror Coat",
    :function => 0x072,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 20,
    :target => :NoTarget,
    :priority => -5,
    :nonmirror => true,
    :desc => "A retaliation move that counters any special attack, inflicting double the damage."
},

:PSYWAVE => {
    :ID => 464,
    :name => "Psywave",
    :function => 0x06F,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "The target is attacked with an odd psychic wave. The attack varies in intensity."
},

:STOREDPOWER => {
    :ID => 465,
    :name => "Stored Power",
    :function => 0x08E,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user attacks the target. The more the user's stats are raised, the greater the damage."
},

:AGILITY => {
    :ID => 466,
    :name => "Agility",
    :function => 0x030,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 30,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user lightens its body to move faster. It sharply boosts the Speed stat."
},

:ALLYSWITCH => {
    :ID => 467,
    :name => "Ally Switch",
    :function => 0x120,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :User,
    :priority => -2,
    :nonmirror => true,
    :desc => "The user teleports and switches its place with one of its allies."
},

:AMNESIA => {
    :ID => 468,
    :name => "Amnesia",
    :function => 0x033,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user temporarily empties its mind. It sharply raises the user's Sp. Def stat."
},

:BARRIER => {
    :ID => 469,
    :name => "Barrier",
    :function => 0x02F,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user throws up a sturdy wall that sharply raises its Defense stat."
},

:CALMMIND => {
    :ID => 470,
    :name => "Calm Mind",
    :function => 0x02C,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user quietly focuses its mind and calms its spirit to raise its Sp. Atk and Sp. Def stats."
},

:COSMICPOWER => {
    :ID => 471,
    :name => "Cosmic Power",
    :function => 0x02A,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user absorbs a mystical power from space to raise its Defense and Sp. Def stats."
},

:GRAVITY => {
    :ID => 472,
    :name => "Gravity",
    :function => 0x118,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :UserSide,
    :nonmirror => true,
    :desc => "Gravity is intensified for five turns, making moves involving flying unusable and negating Levitation."
},

:GUARDSPLIT => {
    :ID => 473,
    :name => "Guard Split",
    :function => 0x059,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "The user employs its psychic power to average its Defense and Sp. Def stats with those of its target's."
},

:GUARDSWAP => {
    :ID => 474,
    :name => "Guard Swap",
    :function => 0x053,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user employs its psychic power to switch changes to its Defense and Sp. Def with the target."
},

:HEALBLOCK => {
    :ID => 475,
    :name => "Heal Block",
    :function => 0x0BB,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 15,
    :target => :AllOpposing,
    :magiccoat => true,
    :desc => "For five turns, the user prevents the opposing team from using anything that recovers HP."
},

:HEALPULSE => {
    :ID => 476,
    :name => "Heal Pulse",
    :function => 0x0DF,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :magiccoat => true,
    :nonmirror => true,
    :healingmove => true,
    :bypassprotect => true,
    :desc => "The user emits a healing pulse which restores the target's HP by up to half of its max HP."
},

:HEALINGWISH => {
    :ID => 477,
    :name => "Healing Wish",
    :function => 0x0E3,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The user faints. In return, the Pokémon taking its place will have its HP restored and status cured."
},

:HEARTSWAP => {
    :ID => 478,
    :name => "Heart Swap",
    :function => 0x054,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user employs its psychic power to switch stat changes with the target."
},

:HYPNOSIS => {
    :ID => 479,
    :name => "Hypnosis",
    :function => 0x003,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 60,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user employs hypnotic suggestion to make the target fall into a deep sleep."
},

:IMPRISON => {
    :ID => 480,
    :name => "Imprison",
    :function => 0x0B8,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user prevents the opponent from using moves known by the user."
},

:KINESIS => {
    :ID => 481,
    :name => "Kinesis",
    :function => 0x047,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 80,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user distracts the target by bending a spoon. It lowers the target's accuracy."
},

:LIGHTSCREEN => {
    :ID => 482,
    :name => "Light Screen",
    :function => 0x0A3,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 30,
    :target => :BothSides,
    :snatchable => true,
    :nonmirror => true,
    :desc => "A wondrous wall of light is put up to suppress damage from special attacks for five turns."
},

:LUNARDANCE => {
    :ID => 483,
    :name => "Lunar Dance",
    :function => 0x0E4,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The user faints. In return, the Pokémon taking its place will have its status and HP fully restored."
},

:MAGICCOAT => {
    :ID => 484,
    :name => "Magic Coat",
    :function => 0x0B1,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :User,
    :priority => 4,
    :nonmirror => true,
    :desc => "A barrier reflects back to the target moves like Leech Seed and moves that damage status."
},

:MAGICROOM => {
    :ID => 485,
    :name => "Magic Room",
    :function => 0x0F9,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :UserSide,
    :desc => "The user creates a bizarre area in which Pokémon's held items lose their effects for five turns."
},

:MEDITATE => {
    :ID => 486,
    :name => "Meditate",
    :function => 0x01C,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 40,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user meditates to awaken the power deep within its body and raise its Attack stat."
},

:MIRACLEEYE => {
    :ID => 487,
    :name => "Miracle Eye",
    :function => 0x0A8,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 40,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "Enables a Dark-type target to be hit by Psychic-type attacks. Ignores evasion."
},

:POWERSPLIT => {
    :ID => 488,
    :name => "Power Split",
    :function => 0x058,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "The user employs its psychic power to average its Attack and Sp. Atk stats with those of the target's."
},

:POWERSWAP => {
    :ID => 489,
    :name => "Power Swap",
    :function => 0x052,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user employs its psychic power to switch changes to its Attack and Sp. Atk with the target."
},

:POWERTRICK => {
    :ID => 490,
    :name => "Power Trick",
    :function => 0x057,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user employs its psychic power to switch its Attack with its Defense stat."
},

:PSYCHOSHIFT => {
    :ID => 491,
    :name => "Psycho Shift",
    :function => 0x01B,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "Using its psychic power of suggestion, the user transfers its status problems to the target."
},

:REFLECT => {
    :ID => 492,
    :name => "Reflect",
    :function => 0x0A2,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :BothSides,
    :snatchable => true,
    :nonmirror => true,
    :desc => "A wondrous wall of light is put up to suppress damage from physical attacks for five turns."
},

:REST => {
    :ID => 493,
    :name => "Rest",
    :function => 0x0D9,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The user goes to sleep for two turns. It fully restores the user's HP and heals any status problem."
},

:ROLEPLAY => {
    :ID => 494,
    :name => "Role Play",
    :function => 0x065,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :nonmirror => true,
    :desc => "The user mimics the target completely, copying the target's natural Ability."
},

:SKILLSWAP => {
    :ID => 495,
    :name => "Skill Swap",
    :function => 0x067,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user employs its psychic power to exchange Abilities with the target."
},

:TELEKINESIS => {
    :ID => 496,
    :name => "Telekinesis",
    :function => 0x11A,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :gravityblocked => true,
    :desc => "The user makes the target float with its psychic power. The target is easier to hit for three turns."
},

:TELEPORT => {
    :ID => 497,
    :name => "Teleport",
    :function => 0x0EA,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :nonmirror => true,
    :desc => "Use it to flee from any wild Pokémon. It can also warp to the last Pokémon Center visited."
},

:TRICK => {
    :ID => 498,
    :name => "Trick",
    :function => 0x0F2,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user catches the target off guard and swaps its held item with its own."
},

:TRICKROOM => {
    :ID => 499,
    :name => "Trick Room",
    :function => 0x11F,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :UserSide,
    :priority => -7,
    :desc => "The user creates a bizarre area in which slower Pokémon get to move first for five turns."
},

:WONDERROOM => {
    :ID => 500,
    :name => "Wonder Room",
    :function => 0x124,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :UserSide,
    :desc => "For five turns, Pokémon's Def and Sp. Def stats are swapped."
},

:HEADSMASH => {
    :ID => 501,
    :name => "Head Smash",
    :function => 0x000,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 150,
    :accuracy => 80,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :recoil => 0.5,
    :desc => "The user attacks the target with a full-power headbutt. The user takes terrible damage."
},

:ROCKWRECKER => {
    :ID => 502,
    :name => "Rock Wrecker",
    :function => 0x0C2,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 150,
    :accuracy => 90,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The user launches a huge boulder at the target to attack. It must rest on the next turn, however."
},

:STONEEDGE => {
    :ID => 503,
    :name => "Stone Edge",
    :function => 0x000,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 80,
    :maxpp => 5,
    :target => :SingleNonUser,
    :highcrit => true,
    :desc => "The user stabs the foe with sharpened stones from below. It has a high critical-hit ratio."
},

:ROCKSLIDE => {
    :ID => 504,
    :name => "Rock Slide",
    :function => 0x00F,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 75,
    :accuracy => 90,
    :maxpp => 10,
    :effect => 30,
    :target => :AllOpposing,
    :desc => "Boulders are hurled at the opposing team. The targets may flinch."
},

:POWERGEM => {
    :ID => 505,
    :name => "Power Gem",
    :function => 0x000,
    :type => :ROCK,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :desc => "The user attacks with a ray of light that sparkles as if it were made of gemstones."
},

:ANCIENTPOWER => {
    :ID => 506,
    :name => "Ancient Power",
    :function => 0x02D,
    :type => :ROCK,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 5,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "The user attacks with a prehistoric power. It may also raise all the user's stats at once."
},

:ROCKTHROW => {
    :ID => 507,
    :name => "Rock Throw",
    :function => 0x000,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 90,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "The user picks up and throws a small rock at the target to attack."
},

:ROCKTOMB => {
    :ID => 508,
    :name => "Rock Tomb",
    :function => 0x044,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 95,
    :maxpp => 15,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "Boulders are hurled at the target. It also lowers the target's Speed by preventing its movement."
},

:SMACKDOWN => {
    :ID => 509,
    :name => "Smack Down",
    :function => 0x11C,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user throws a stone or projectile at the opponent. Flying Pokémons will fall to the ground."
},

:ROLLOUT => {
    :ID => 510,
    :name => "Rollout",
    :function => 0x0D3,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 30,
    :accuracy => 90,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user continually rolls into the target over five turns. It becomes stronger each time it hits."
},

:ROCKBLAST => {
    :ID => 511,
    :name => "Rock Blast",
    :function => 0x0C0,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 25,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user hurls hard rocks at the target. Two to five rocks are launched in quick succession."
},

:ROCKPOLISH => {
    :ID => 512,
    :name => "Rock Polish",
    :function => 0x030,
    :type => :ROCK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user polishes its body to reduce drag. It can sharply raise the Speed stat."
},

:SANDSTORM => {
    :ID => 513,
    :name => "Sandstorm",
    :function => 0x101,
    :type => :ROCK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :UserSide,
    :nonmirror => true,
    :windmove => true,
    :desc => "A sandstorm is summoned to hurt all combatants except the Rock, Ground, and Steel types."
},

:STEALTHROCK => {
    :ID => 514,
    :name => "Stealth Rock",
    :function => 0x105,
    :type => :ROCK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :OpposingSide,
    :magiccoat => true,
    :nonmirror => true,
    :desc => "A trap of levitating stones is layed around the opponent. It hurts pokémons on the switch."
},

:WIDEGUARD => {
    :ID => 515,
    :name => "Wide Guard",
    :function => 0x0AC,
    :type => :ROCK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :BothSides,
    :priority => 3,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user and its allies are protected from wide-ranging attacks for one turn."
},

:DOOMDESIRE => {
    :ID => 516,
    :name => "Doom Desire",
    :function => 0x111,
    :type => :STEEL,
    :category => :special,
    :basedamage => 140,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :nonmirror => true,
    :desc => "Two turns after this move is used, the user blasts the target with a concentrated bundle of light."
},

:IRONTAIL => {
    :ID => 517,
    :name => "Iron Tail",
    :function => 0x043,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 75,
    :maxpp => 15,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is slammed with a steel-hard tail. It may also lower the target's Defense stat."
},

:METEORMASH => {
    :ID => 518,
    :name => "Meteor Mash",
    :function => 0x01C,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 90,
    :maxpp => 10,
    :effect => 20,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The target is hit with a hard punch fired like a meteor. It may also raise the user's Attack."
},

:FLASHCANNON => {
    :ID => 519,
    :name => "Flash Cannon",
    :function => 0x046,
    :type => :STEEL,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 10,
    :target => :SingleNonUser,
    :beammove => true,
    :desc => "The user gathers all its light energy and releases it at once. It may also lower the target's Sp. Def stat."
},

:IRONHEAD => {
    :ID => 520,
    :name => "Iron Head",
    :function => 0x00F,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The foe slams the target with its steel-hard head. It may also make the target flinch."
},

:STEELWING => {
    :ID => 521,
    :name => "Steel Wing",
    :function => 0x01D,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 90,
    :maxpp => 25,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is hit with wings of steel. It may also raise the user's Defense stat."
},

:MIRRORSHOT => {
    :ID => 522,
    :name => "Mirror Shot",
    :function => 0x047,
    :type => :STEEL,
    :category => :special,
    :basedamage => 65,
    :accuracy => 85,
    :maxpp => 10,
    :effect => 30,
    :target => :SingleNonUser,
    :desc => "The user looses a flash of energy at the target. It might lower the target's accuracy."
},

:MAGNETBOMB => {
    :ID => 523,
    :name => "Magnet Bomb",
    :function => 0x0A5,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :desc => "The user launches steel bombs that stick to the target. This attack will not miss."
},

:GEARGRIND => {
    :ID => 524,
    :name => "Gear Grind",
    :function => 0x0BD,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 85,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks by throwing two steel gears at its target."
},

:METALCLAW => {
    :ID => 525,
    :name => "Metal Claw",
    :function => 0x01C,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 95,
    :maxpp => 35,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is raked with steel claws. It may also raise the user's Attack stat."
},

:BULLETPUNCH => {
    :ID => 526,
    :name => "Bullet Punch",
    :function => 0x000,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 30,
    :target => :SingleNonUser,
    :priority => 1,
    :contact => true,
    :punchmove => true,
    :desc => "The user strikes the target with tough punches as fast as bullets. This move always goes first."
},

:GYROBALL => {
    :ID => 527,
    :name => "Gyro Ball",
    :function => 0x08D,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user tackles the target with a high-speed spin. The slower the user, the greater the damage."
},

:HEAVYSLAM => {
    :ID => 528,
    :name => "Heavy Slam",
    :function => 0x09B,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user slams into the target with its heavy body. Damage varies with the user's weight."
},

:METALBURST => {
    :ID => 529,
    :name => "Metal Burst",
    :function => 0x073,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 10,
    :target => :NoTarget,
    :desc => "The user retaliates with much greater power against the target that last inflicted damage on it."
},

:AUTOTOMIZE => {
    :ID => 530,
    :name => "Autotomize",
    :function => 0x031,
    :type => :STEEL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user sheds part of its body to make itself lighter and sharply raise its Speed stat."
},

:IRONDEFENSE => {
    :ID => 531,
    :name => "Iron Defense",
    :function => 0x02F,
    :type => :STEEL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user hardens its body's surface like iron, sharply raising its Defense stat."
},

:METALSOUND => {
    :ID => 532,
    :name => "Metal Sound",
    :function => 0x04F,
    :type => :STEEL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 85,
    :maxpp => 40,
    :target => :SingleNonUser,
    :magiccoat => true,
    :soundmove => true,
    :desc => "A horrible sound like scraping metal harshly reduces the target's Sp. Def stat."
},

:SHIFTGEAR => {
    :ID => 533,
    :name => "Shift Gear",
    :function => 0x036,
    :type => :STEEL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user rotates its gears, raising its Attack and sharply raising its Speed."
},

:HYDROCANNON => {
    :ID => 534,
    :name => "Hydro Cannon",
    :function => 0x0C2,
    :type => :WATER,
    :category => :special,
    :basedamage => 150,
    :accuracy => 90,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The target is hit with a watery blast. The user must rest on the next turn, however."
},

:WATERSPOUT => {
    :ID => 535,
    :name => "Water Spout",
    :function => 0x08B,
    :type => :WATER,
    :category => :special,
    :basedamage => 150,
    :accuracy => 100,
    :maxpp => 5,
    :target => :AllOpposing,
    :desc => "The user spouts water to damage the opposing team. Damage varies with the user's HP."
},

:HYDROPUMP => {
    :ID => 536,
    :name => "Hydro Pump",
    :function => 0x000,
    :type => :WATER,
    :category => :special,
    :basedamage => 110,
    :accuracy => 80,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The target is blasted by a huge volume of water launched under great pressure."
},

:MUDDYWATER => {
    :ID => 537,
    :name => "Muddy Water",
    :function => 0x047,
    :type => :WATER,
    :category => :special,
    :basedamage => 90,
    :accuracy => 85,
    :maxpp => 10,
    :effect => 30,
    :target => :AllOpposing,
    :desc => "The user attacks by shooting muddy water at the opposing team. It may also lower the target's accuracy."
},

:SURF => {
    :ID => 538,
    :name => "Surf",
    :function => 0x075,
    :type => :WATER,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 15,
    :target => :AllNonUsers,
    :desc => "It swamps the area around the user with a giant wave. It can also be used for crossing water."
},

:AQUATAIL => {
    :ID => 539,
    :name => "Aqua Tail",
    :function => 0x000,
    :type => :WATER,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks by swinging its tail as if it were a vicious wave in a raging storm."
},

:CRABHAMMER => {
    :ID => 540,
    :name => "Crabhammer",
    :function => 0x000,
    :type => :WATER,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :highcrit => true,
    :desc => "The target is hammered with a large pincer. Critical hits land more easily."
},

:DIVE => {
    :ID => 541,
    :name => "Dive",
    :function => 0x0CB,
    :type => :WATER,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Dives on the first turn and attacks on the second. It can be used to dive deep in the ocean."
},

:SCALD => {
    :ID => 542,
    :name => "Scald",
    :function => 0x00A,
    :type => :WATER,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 30,
    :target => :SingleNonUser,
    :defrost => true,
    :desc => "The user shoots boiling hot water at its target. It may also leave the target with a burn."
},

:WATERFALL => {
    :ID => 543,
    :name => "Waterfall",
    :function => 0x00F,
    :type => :WATER,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user charges at the target and may make it flinch. It can also be used to climb a waterfall."
},

:RAZORSHELL => {
    :ID => 544,
    :name => "Razor Shell",
    :function => 0x043,
    :type => :WATER,
    :category => :physical,
    :basedamage => 75,
    :accuracy => 95,
    :maxpp => 10,
    :effect => 50,
    :target => :SingleNonUser,
    :contact => true,
    :sharpmove => true,
    :desc => "The user cuts its target with sharp shells. This might lower the target's Def. stat."
},

:BRINE => {
    :ID => 545,
    :name => "Brine",
    :function => 0x080,
    :type => :WATER,
    :category => :special,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "If the target's HP is down to about half, this attack will hit with double the power."
},

:BUBBLEBEAM => {
    :ID => 546,
    :name => "Bubble Beam",
    :function => 0x044,
    :type => :WATER,
    :category => :special,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 10,
    :target => :SingleNonUser,
    :beammove => true,
    :desc => "A spray of bubbles is launched at the target. It may also lower its Speed stat."
},

:OCTAZOOKA => {
    :ID => 547,
    :name => "Octazooka",
    :function => 0x047,
    :type => :WATER,
    :category => :special,
    :basedamage => 65,
    :accuracy => 85,
    :maxpp => 10,
    :effect => 50,
    :target => :SingleNonUser,
    :desc => "The user attacks by spraying ink in the target. It might lower the target's accuracy."
},

:WATERPULSE => {
    :ID => 548,
    :name => "Water Pulse",
    :function => 0x013,
    :type => :WATER,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 20,
    :target => :SingleNonUser,
    :desc => "The user attacks the target with a pulsing blast of water. It may also confuse the target."
},

:WATERPLEDGE => {
    :ID => 549,
    :name => "Water Pledge",
    :function => 0x108,
    :type => :WATER,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "A column of water strikes the target. It can be combined with its fire equivalent."
},

:AQUAJET => {
    :ID => 550,
    :name => "Aqua Jet",
    :function => 0x000,
    :type => :WATER,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :priority => 1,
    :contact => true,
    :desc => "The user lunges at the target at a speed that makes it almost invisible. It is sure to strike first."
},

:WATERGUN => {
    :ID => 551,
    :name => "Water Gun",
    :function => 0x000,
    :type => :WATER,
    :category => :special,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 25,
    :target => :SingleNonUser,
    :desc => "The target is blasted with a forceful shot of water."
},

:CLAMP => {
    :ID => 552,
    :name => "Clamp",
    :function => 0x0CF,
    :type => :WATER,
    :category => :physical,
    :basedamage => 35,
    :accuracy => 85,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is clamped and squeezed by the user's very thick and sturdy shell for four to five turns."
},

:WHIRLPOOL => {
    :ID => 553,
    :name => "Whirlpool",
    :function => 0x0D0,
    :type => :WATER,
    :category => :special,
    :basedamage => 35,
    :accuracy => 85,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "Traps foes in a violent swirling whirlpool for four to five turns."
},

:BUBBLE => {
    :ID => 554,
    :name => "Bubble",
    :function => 0x044,
    :type => :WATER,
    :category => :special,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 30,
    :effect => 10,
    :target => :AllOpposing,
    :desc => "A spray of countless bubbles is jetted at the opposing team. It may also lower the targets' Speed stats."
},

:AQUARING => {
    :ID => 555,
    :name => "Aqua Ring",
    :function => 0x0DA,
    :type => :WATER,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The user envelops itself in a veil made of water. It regains some HP on every turn."
},

:RAINDANCE => {
    :ID => 556,
    :name => "Rain Dance",
    :function => 0x100,
    :type => :WATER,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :UserSide,
    :nonmirror => true,
    :desc => "The user summons a heavy rain that falls for five turns, powering up Water-type moves."
},

:SOAK => {
    :ID => 557,
    :name => "Soak",
    :function => 0x061,
    :type => :WATER,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user shoots a torrent of water at the target and changes the target's type to Water."
},

:WATERSPORT => {
    :ID => 558,
    :name => "Water Sport",
    :function => 0x09E,
    :type => :WATER,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :UserSide,
    :nonmirror => true,
    :desc => "The user soaks itself with water. The move weakens Fire-type moves while the user is in the battle."
},

:WITHDRAW => {
    :ID => 559,
    :name => "Withdraw",
    :function => 0x01D,
    :type => :WATER,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 40,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user withdraws its body into its hard shell, raising its Defense stat."
},

:AROMATICMIST => {
    :ID => 560,
    :name => "Aromatic Mist",
    :function => 0x13A,
    :type => :FAIRY,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :BothSides,
    :bypassprotect => true,
    :nonmirror => true,
    :desc => "The user raises the Sp. Def stat of ally Pokémon with a mysterious aroma."
},

:BABYDOLLEYES => {
    :ID => 561,
    :name => "Baby-Doll Eyes",
    :function => 0x042,
    :type => :FAIRY,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 30,
    :target => :SingleNonUser,
    :priority => 1,
    :magiccoat => true,
    :desc => "Using its baby-doll eyes, the user lowers the opponent Atk stat. It always goes first."
},

:BELCH => {
    :ID => 562,
    :name => "Belch",
    :function => 0x13C,
    :type => :POISON,
    :category => :special,
    :basedamage => 120,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user lets out a damaging belch on the target. The user must eat a Berry to use this move."
},

:BOOMBURST => {
    :ID => 563,
    :name => "Boomburst",
    :function => 0x000,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 140,
    :accuracy => 100,
    :maxpp => 10,
    :target => :AllNonUsers,
    :soundmove => true,
    :desc => "The user attacks everything around it with the power of a terrible, explosive sound."
},

:CONFIDE => {
    :ID => 564,
    :name => "Confide",
    :function => 0x045,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :soundmove => true,
    :desc => "The user tells the target a secret, and lowers its Sp. Atk stat."
},

:CRAFTYSHIELD => {
    :ID => 565,
    :name => "Crafty Shield",
    :function => 0x149,
    :type => :FAIRY,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :BothSides,
    :priority => 3,
    :nonmirror => true,
    :desc => "The user protects itself and its allies from status moves with a mysterious power."
},

:DAZZLINGGLEAM => {
    :ID => 566,
    :name => "Dazzling Gleam",
    :function => 0x000,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :AllOpposing,
    :desc => "The user damages opposing Pokémon by emitting a powerful flash."
},

:DISARMINGVOICE => {
    :ID => 567,
    :name => "Disarming Voice",
    :function => 0x0A5,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 40,
    :accuracy => 0,
    :maxpp => 15,
    :target => :AllOpposing,
    :soundmove => true,
    :desc => "Letting out a charming cry, the user does emotional damage to opposing Pokémon. It never misses."
},

:DRAININGKISS => {
    :ID => 568,
    :name => "Draining Kiss",
    :function => 0x139,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user steals the target's energy with a kiss. Over half of the damage goes to the user's HP."
},

:EERIEIMPULSE => {
    :ID => 570,
    :name => "Eerie Impulse",
    :function => 0x13B,
    :type => :ELECTRIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user's body generates an eerie impulse. This harshly lowers the target's Sp. Atk stat."
},

:ELECTRICTERRAIN => {
    :ID => 571,
    :name => "Electric Terrain",
    :function => 0x134,
    :type => :ELECTRIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :NoTarget,
    :nonmirror => true,
    :desc => "The user electrifies the ground for five turns. Grounded Pokémon can't fall asleep."
},

:ELECTRIFY => {
    :ID => 572,
    :name => "Electrify",
    :function => 0x153,
    :type => :ELECTRIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :desc => "If the target is electrified before it uses a move during that turn, the target's move becomes Electric type."
},

:FAIRYLOCK => {
    :ID => 573,
    :name => "Fairy Lock",
    :function => 0x145,
    :type => :FAIRY,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :UserSide,
    :desc => "By locking down the battlefield, the user keeps all Pokémon from fleeing during the next turn."
},

:FAIRYWIND => {
    :ID => 574,
    :name => "Fairy Wind",
    :function => 0x000,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 30,
    :target => :SingleNonUser,
    :windmove => true,
    :desc => "The user stirs up a fairy wind and strikes the target with it."
},

:FELLSTINGER => {
    :ID => 575,
    :name => "Fell Stinger",
    :function => 0x147,
    :type => :BUG,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 25,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "When the user knocks out a target with this move, the user's Attack stat rises sharply."
},

:FLOWERSHIELD => {
    :ID => 576,
    :name => "Flower Shield",
    :function => 0x150,
    :type => :FAIRY,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :UserSide,
    :bypassprotect => true,
    :nonmirror => true,
    :desc => "The user raises the Defense stat of all Grass-type Pokémon in battle with a mysterious power."
},

:FLYINGPRESS => {
    :ID => 577,
    :name => "Flying Press",
    :function => 0x000,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 95,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user dives down onto the target from the sky. This move is Fighting and Flying type simultaneously."
},

:FORESTSCURSE => {
    :ID => 578,
    :name => "Forest's Curse",
    :function => 0x143,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user puts a forest curse on the target. Afflicted targets are now Grass type as well."
},

:FREEZEDRY => {
    :ID => 579,
    :name => "Freeze-Dry",
    :function => 0x00C,
    :type => :ICE,
    :category => :special,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "The user rapidly cools the target, which might leave the target with frostbite. Its SE on Water types."
},

:GEOMANCY => {
    :ID => 580,
    :name => "Geomancy",
    :function => 0x13E,
    :type => :FAIRY,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :nonmirror => true,
    :desc => "The user absorbs energy and sharply raises its Sp. Atk, Sp. Def, and Speed stats on the next turn."
},

:GRASSYTERRAIN => {
    :ID => 581,
    :name => "Grassy Terrain",
    :function => 0x135,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :NoTarget,
    :nonmirror => true,
    :desc => "The user turns the ground to grass for five turns. Grounded pokémon restore HP every turn."
},

:INFESTATION => {
    :ID => 582,
    :name => "Infestation",
    :function => 0x0CF,
    :type => :BUG,
    :category => :special,
    :basedamage => 20,
    :accuracy => 100,
    :maxpp => 35,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is infested for four to five turns. It can't flee during this time."
},

:IONDELUGE => {
    :ID => 583,
    :name => "Ion Deluge",
    :function => 0x148,
    :type => :ELECTRIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 25,
    :target => :NoTarget,
    :priority => 1,
    :nonmirror => true,
    :desc => "The user disperses electrically charged particles, which changes Normal-type moves to Electric-type moves."
},

:KINGSSHIELD => {
    :ID => 584,
    :name => "King's Shield",
    :function => 0x133,
    :type => :STEEL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :priority => 4,
    :nonmirror => true,
    :desc => "The user takes a defensive stance. It harshly lowers the Atk. after contact moves."
},

:LANDSWRATH => {
    :ID => 585,
    :name => "Land's Wrath",
    :function => 0x000,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :AllOpposing,
    :desc => "The user gathers the energy of the land and focuses that power on opposing Pokémon to damage them."
},

:MAGNETICFLUX => {
    :ID => 586,
    :name => "Magnetic Flux",
    :function => 0x146,
    :type => :ELECTRIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :BothSides,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user manipulates magnetic fields. This raises the Def and Sp. Def stats of allies with Plus or Minus."
},

:MATBLOCK => {
    :ID => 587,
    :name => "Mat Block",
    :function => 0x154,
    :type => :FIGHTING,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :BothSides,
    :snatchable => true,
    :nonmirror => true,
    :desc => "Using a pulled-up mat as a shield, the user protects itself and its allies from damaging moves. "
},

:MISTYTERRAIN => {
    :ID => 588,
    :name => "Misty Terrain",
    :function => 0x136,
    :type => :FAIRY,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :UserSide,
    :nonmirror => true,
    :desc => "The user covers the ground with mist for five turns. Grounded pokémon are protected from status conditions. "
},

:MOONBLAST => {
    :ID => 589,
    :name => "Moonblast",
    :function => 0x045,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 95,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 30,
    :target => :SingleNonUser,
    :desc => "The user attacks with moon power. It might lower the target's Sp. Atk. "
},

:MYSTICALFIRE => {
    :ID => 590,
    :name => "Mystical Fire",
    :function => 0x045,
    :type => :FIRE,
    :category => :special,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user attacks by breathing a special, hot fire. It lowers the target's Sp. Atk. "
},

:NOBLEROAR => {
    :ID => 591,
    :name => "Noble Roar",
    :function => 0x138,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 30,
    :target => :SingleNonUser,
    :magiccoat => true,
    :soundmove => true,
    :desc => "Letting out a noble roar, the user intimidates the target and lowers its Atk. and Sp. Atk. "
},

:NUZZLE => {
    :ID => 592,
    :name => "Nuzzle",
    :function => 0x007,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 20,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks by nuzzling its electrified cheeks. It paralyzes the target."
},

:OBLIVIONWING => {
    :ID => 593,
    :name => "Oblivion Wing",
    :function => 0x139,
    :type => :FLYING,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user absorbs its target's HP. The HP is restored by over half of the damage."
},

:PARABOLICCHARGE => {
    :ID => 594,
    :name => "Parabolic Charge",
    :function => 0x0DD,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 20,
    :target => :AllNonUsers,
    :desc => "The user attacks everything around it. HP is restored by half of the damage."
},

:PARTINGSHOT => {
    :ID => 595,
    :name => "Parting Shot",
    :function => 0x13D,
    :type => :DARK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :soundmove => true,
    :desc => "With a parting threat, the user lowers the target's Atk and Sp. Atk. Then it switches out."
},

:PETALBLIZZARD => {
    :ID => 596,
    :name => "Petal Blizzard",
    :function => 0x000,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 15,
    :target => :AllNonUsers,
    :windmove => true,
    :desc => "The user stirs up a violent petal blizzard and attacks everything around it."
},

:PHANTOMFORCE => {
    :ID => 597,
    :name => "Phantom Force",
    :function => 0x0CD,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :bypassprotect => true,
    :desc => "The user vanishes, then strikes the target on the next turn. It always hits."
},

:PLAYNICE => {
    :ID => 598,
    :name => "Play Nice",
    :function => 0x042,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :magiccoat => true,
    :desc => "The user and the target become friends. This lowers the target's Atk."
},

:PLAYROUGH => {
    :ID => 599,
    :name => "Play Rough",
    :function => 0x042,
    :type => :FAIRY,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 90,
    :maxpp => 10,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user plays rough and attacks. This may also lower the target's Attack stat."
},

:POWDER => {
    :ID => 600,
    :name => "Powder",
    :function => 0x152,
    :type => :BUG,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :priority => 1,
    :magiccoat => true,
    :desc => "The user covers the target in a powder that explodes if it uses a Fire-type move."
},

:POWERUPPUNCH => {
    :ID => 601,
    :name => "Power-Up Punch",
    :function => 0x01C,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 30,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "Striking opponents makes the user's fists harder. Hitting a target raises the Atk."
},

:ROTOTILLER => {
    :ID => 602,
    :name => "Rototiller",
    :function => 0x151,
    :type => :GROUND,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :UserSide,
    :nonmirror => true,
    :desc => "The user changes the soil, raising the Atk and Sp. Atk of Grass-type Pokémon."
},

:SPIKYSHIELD => {
    :ID => 603,
    :name => "Spiky Shield",
    :function => 0x140,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :priority => 4,
    :nonmirror => true,
    :desc => "It protects the user from attacks, while damaging any attacker who makes direct contact."
},

:STICKYWEB => {
    :ID => 604,
    :name => "Sticky Web",
    :function => 0x141,
    :type => :BUG,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :OpposingSide,
    :magiccoat => true,
    :nonmirror => true,
    :desc => "The user weaves a sticky net around the opposing team, which lowers their Speed upon switching."
},

:TOPSYTURVY => {
    :ID => 605,
    :name => "Topsy-Turvy",
    :function => 0x142,
    :type => :DARK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "All stat changes affecting the target turn topsy-turvy and become the opposite of what they were."
},

:TRICKORTREAT => {
    :ID => 606,
    :name => "Trick-or-Treat",
    :function => 0x144,
    :type => :GHOST,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user adds Ghost type to the target's type."
},

:VENOMDRENCH => {
    :ID => 607,
    :name => "Venom Drench",
    :function => 0x13F,
    :type => :POISON,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :AllOpposing,
    :magiccoat => true,
    :desc => "Opposing Pokémon are drenched in an odd liquid. It lowers the Atk, Sp. Atk and Speed of a poisoned target."
},

:WATERSHURIKEN => {
    :ID => 608,
    :name => "Water Shuriken",
    :function => 0x0C0,
    :type => :WATER,
    :category => :special,
    :basedamage => 15,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :priority => 1,
    :desc => "The target is hit with throwing stars two to five times. It always goes first."
},

:SHADOWEND => {
    :ID => 613,
    :name => "Shadow End",
    :function => 0x130,
    :type => :SHADOW,
    :category => :special,
    :basedamage => 120,
    :accuracy => 60,
    :maxpp => 0,
    :target => :SingleNonUser,
    :contact => true,
    :nonmirror => true,
    :desc => "A shadowy aura ram attack that also rebounds on the user."
},

:SHADOWSTORM => {
    :ID => 614,
    :name => "Shadow Storm",
    :function => 0x12D,
    :type => :SHADOW,
    :category => :special,
    :basedamage => 95,
    :accuracy => 100,
    :maxpp => 0,
    :target => :AllOpposing,
    :nonmirror => true,
    :desc => "A shadowy aura is used to whip up a vicious tornado."
},

:SHADOWBLAST => {
    :ID => 615,
    :name => "Shadow Blast",
    :function => 0x126,
    :type => :SHADOW,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 0,
    :target => :SingleNonUser,
    :nonmirror => true,
    :highcrit => true,
    :desc => "A wicked blade of air is formed using a shadowy aura."
},

:SHADOWBOLT => {
    :ID => 616,
    :name => "Shadow Bolt",
    :function => 0x127,
    :type => :SHADOW,
    :category => :special,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 0,
    :effect => 10,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "A shadowy thunder attack that may paralyze."
},

:SHADOWBREAK => {
    :ID => 617,
    :name => "Shadow Break",
    :function => 0x126,
    :type => :SHADOW,
    :category => :physical,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 0,
    :target => :SingleNonUser,
    :contact => true,
    :nonmirror => true,
    :desc => "A shattering ram attack with a shadowy aura."
},

:SHADOWCHILL => {
    :ID => 618,
    :name => "Shadow Chill",
    :function => 0x129,
    :type => :SHADOW,
    :category => :special,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 0,
    :effect => 10,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "A shadowy ice attack that may leave the target with frostbite."
},

:SHADOWFIRE => {
    :ID => 619,
    :name => "Shadow Fire",
    :function => 0x128,
    :type => :SHADOW,
    :category => :special,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 0,
    :effect => 10,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "A shadowy fireball attack that may inflict a burn."
},

:SHADOWRAVE => {
    :ID => 620,
    :name => "Shadow Rave",
    :function => 0x126,
    :type => :SHADOW,
    :category => :special,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 0,
    :target => :AllOpposing,
    :nonmirror => true,
    :desc => "A shadowy aura in the ground is used to launch spikes."
},

:SHADOWRUSH => {
    :ID => 621,
    :name => "Shadow Rush",
    :function => 0x126,
    :type => :SHADOW,
    :category => :physical,
    :basedamage => 55,
    :accuracy => 100,
    :maxpp => 0,
    :target => :SingleNonUser,
    :contact => true,
    :nonmirror => true,
    :desc => "A reckless move that also hurts the user."
},

:SHADOWWAVE => {
    :ID => 622,
    :name => "Shadow Wave",
    :function => 0x126,
    :type => :SHADOW,
    :category => :special,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 0,
    :target => :AllOpposing,
    :nonmirror => true,
    :desc => "Shadowy aura waves are loosed to inflict damage."
},

:SHADOWBLITZ => {
    :ID => 623,
    :name => "Shadow Blitz",
    :function => 0x126,
    :type => :SHADOW,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 0,
    :target => :SingleNonUser,
    :contact => true,
    :nonmirror => true,
    :desc => "A Pokémon throws this tackle while casting a shadowy aura."
},

:SHADOWDOWN => {
    :ID => 624,
    :name => "Shadow Down",
    :function => 0x12B,
    :type => :SHADOW,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 0,
    :target => :AllOpposing,
    :nonmirror => true,
    :desc => "A shadowy aura sharply cuts the foe's Defense."
},

:SHADOWHALF => {
    :ID => 625,
    :name => "Shadow Half",
    :function => 0x12E,
    :type => :SHADOW,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 0,
    :target => :UserSide,
    :nonmirror => true,
    :desc => "A shadowy aura's energy cuts everyone's HP by half."
},

:SHADOWHOLD => {
    :ID => 626,
    :name => "Shadow Hold",
    :function => 0x12F,
    :type => :SHADOW,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 0,
    :target => :AllOpposing,
    :nonmirror => true,
    :desc => "The opponent Pokémon cannot escape."
},

:SHADOWMIST => {
    :ID => 627,
    :name => "Shadow Mist",
    :function => 0x12C,
    :type => :SHADOW,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 0,
    :target => :AllOpposing,
    :nonmirror => true,
    :desc => "A shadowy aura sharply cuts the foe's evasiveness."
},

:SHADOWPANIC => {
    :ID => 628,
    :name => "Shadow Panic",
    :function => 0x12A,
    :type => :SHADOW,
    :category => :status,
    :basedamage => 0,
    :accuracy => 90,
    :maxpp => 0,
    :target => :AllOpposing,
    :nonmirror => true,
    :soundmove => true,
    :desc => "A shadowy aura emanates to confuse the foe."
},

:SHADOWSHED => {
    :ID => 629,
    :name => "Shadow Shed",
    :function => 0x132,
    :type => :SHADOW,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 0,
    :target => :UserSide,
    :nonmirror => true,
    :desc => "A shadowy aura eliminates Reflect and similar moves."
},

:SHADOWSKY => {
    :ID => 630,
    :name => "Shadow Sky",
    :function => 0x131,
    :type => :SHADOW,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 0,
    :target => :UserSide,
    :nonmirror => true,
    :desc => "Darkness hurts all but Shadow Pokémon for 5 turns."
},

:HIDDENPOWERNOR => {
    :ID => 641,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERFIR => {
    :ID => 642,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :FIRE,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERFIG => {
    :ID => 643,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :FIGHTING,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERWAT => {
    :ID => 644,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :WATER,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERFLY => {
    :ID => 645,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :FLYING,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERGRA => {
    :ID => 646,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :GRASS,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERPOI => {
    :ID => 647,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :POISON,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERELE => {
    :ID => 648,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERGRO => {
    :ID => 649,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :GROUND,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERPSY => {
    :ID => 650,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERROC => {
    :ID => 651,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :ROCK,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERICE => {
    :ID => 652,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :ICE,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERBUG => {
    :ID => 653,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :BUG,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERDRA => {
    :ID => 654,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERGHO => {
    :ID => 655,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :GHOST,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERDAR => {
    :ID => 656,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :DARK,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERSTE => {
    :ID => 657,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :STEEL,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HIDDENPOWERFAI => {
    :ID => 658,
    :name => "Hidden Power",
    :function => 0x000,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "A unique attack that varies in type depending on the Pokémon using it."
},

:HYPERSPACEHOLE => {
    :ID => 667,
    :name => "Hyperspace Hole",
    :function => 0x157,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 80,
    :accuracy => 0,
    :maxpp => 5,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :desc => "Using a hyperspace hole, the user appears and strikes, hitting a target using Protect or Detect."
},

:ORIGINPULSE => {
    :ID => 671,
    :name => "Origin Pulse",
    :function => 0x000,
    :type => :WATER,
    :category => :special,
    :basedamage => 110,
    :accuracy => 85,
    :maxpp => 10,
    :target => :AllOpposing,
    :desc => "The user attacks opponents with countless beams of deep blue light."
},

:PRECIPICEBLADES => {
    :ID => 672,
    :name => "Precipice Blades",
    :function => 0x000,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 85,
    :maxpp => 10,
    :target => :AllOpposing,
    :desc => "The user attacks opponents by manifesting fearsome blades of stone."
},

:DRAGONASCENT => {
    :ID => 673,
    :name => "Dragon Ascent",
    :function => 0x03C,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user soars up, then quickly drops down onto the opponent, lowering its defenses."
},

:THOUSANDARROWS => {
    :ID => 674,
    :name => "Thousand Arrows",
    :function => 0x11C,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :AllOpposing,
    :desc => "This move hits opposing Pokémon that are in the air, knocking them to the ground."
},

:THOUSANDWAVES => {
    :ID => 675,
    :name => "Thousand Waves",
    :function => 0x155,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :AllOpposing,
    :desc => "The user attacks with a wave that crawls along the ground. Those hit can't flee from battle."
},

:DIAMONDSTORM => {
    :ID => 676,
    :name => "Diamond Storm",
    :function => 0x02F,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 95,
    :maxpp => 5,
    :effect => 50,
    :target => :AllOpposing,
    :desc => "The user whips up a storm of diamonds. This may also sharply raise the user's Defense stat."
},

:HYPERSPACEFURY => {
    :ID => 677,
    :name => "Hyperspace Fury",
    :function => 0x159,
    :type => :DARK,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 0,
    :maxpp => 5,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :desc => "Using its many arms, user unleashes a barrages of attack, hitting a target using Protect or Detect."
},

:STEAMERUPTION => {
    :ID => 678,
    :name => "Steam Eruption",
    :function => 0x00A,
    :type => :WATER,
    :category => :special,
    :basedamage => 110,
    :accuracy => 95,
    :maxpp => 5,
    :effect => 30,
    :target => :SingleNonUser,
    :defrost => true,
    :desc => "The user immerses the target in superheated steam. This may also leave the target with a burn."
},

:ACCELEROCK => {
    :ID => 690,
    :name => "Accelerock",
    :function => 0x000,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :priority => 1,
    :contact => true,
    :desc => "The user smashes into the target at high speed. This move always goes first."
},

:ANCHORSHOT => {
    :ID => 691,
    :name => "Anchor Shot",
    :function => 0x155,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Entangles the target with its anchor chain while attacking. The target becomes unable to flee."
},

:AURORAVEIL => {
    :ID => 692,
    :name => "Aurora Veil",
    :function => 0x15B,
    :type => :ICE,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :BothSides,
    :snatchable => true,
    :nonmirror => true,
    :desc => "Reduces damage from physical and special moves for five turns. Can be used only in a " + HAILSNOWLOWMOD + "storm."
},

:BANEFULBUNKER => {
    :ID => 693,
    :name => "Baneful Bunker",
    :function => 0x15C,
    :type => :POISON,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :priority => 4,
    :nonmirror => true,
    :desc => "It protects the user from attacks, while poisoning any attacker who makes direct contact."
},

:BEAKBLAST => {
    :ID => 694,
    :name => "Beak Blast",
    :function => 0x15D,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :priority => -3,
    :nonmirror => true,
    :desc => "The user heats its beak before attacking, burning any attacker who makes direct contact."
},

:BRUTALSWING => {
    :ID => 695,
    :name => "Brutal Swing",
    :function => 0x000,
    :type => :DARK,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 20,
    :target => :AllNonUsers,
    :contact => true,
    :desc => "The user swings its body around violently to inflict damage on everything in its vicinity."
},

:BURNUP => {
    :ID => 696,
    :name => "Burn Up",
    :function => 0x15E,
    :type => :FIRE,
    :category => :special,
    :basedamage => 130,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :defrost => true,
    :desc => "To inflict massive damage, the user burns itself out, losing its Fire type."
},

:CLANGINGSCALES => {
    :ID => 697,
    :name => "Clanging Scales",
    :function => 0x15F,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 110,
    :accuracy => 100,
    :maxpp => 5,
    :target => :AllOpposing,
    :soundmove => true,
    :desc => "The user rubs the scales on its entire body and makes a huge noise, lowering its defense."
},

:COREENFORCER => {
    :ID => 698,
    :name => "Core Enforcer",
    :function => 0x160,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :AllOpposing,
    :desc => "If the targets have already moved, this move eliminates the effect of their Ability."
},

:DARKESTLARIAT => {
    :ID => 699,
    :name => "Darkest Lariat",
    :function => 0x0A9,
    :type => :DARK,
    :category => :physical,
    :basedamage => 85,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user swings both arms and hits the target. The target's stat changes don't affect the damage."
},

:DRAGONHAMMER => {
    :ID => 700,
    :name => "Dragon Hammer",
    :function => 0x000,
    :type => :DRAGON,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user uses its body like a hammer to attack the target and inflict damage."
},

:FIRELASH => {
    :ID => 701,
    :name => "Fire Lash",
    :function => 0x043,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user strikes the target with a burning lash. This also lowers the target's Defense stat."
},

:FIRSTIMPRESSION => {
    :ID => 702,
    :name => "First Impression",
    :function => 0x161,
    :type => :BUG,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :priority => 2,
    :contact => true,
    :desc => "Although this move has great power, it only works the first turn the user is in battle."
},

:FLEURCANNON => {
    :ID => 703,
    :name => "Fleur Cannon",
    :function => 0x03F,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 130,
    :accuracy => 90,
    :maxpp => 5,
    :effect => 100,
    :target => :SingleNonUser,
    :beammove => true,
    :desc => "The user unleashes a strong beam. The attack's recoil harshly lowers the user's Sp. Atk stat."
},

:FLORALHEALING => {
    :ID => 704,
    :name => "Floral Healing",
    :function => 0x162,
    :type => :FAIRY,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The user restores the target's HP by up to half of its max HP. It restores more HP when the terrain is grassy."
},

:GEARUP => {
    :ID => 705,
    :name => "Gear Up",
    :function => 0x163,
    :type => :STEEL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :BothSides,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user engages its gears to raise the Attack and Sp. Atk stats of ally Pokémon with the Plus or Minus Ability."
},

:HIGHHORSEPOWER => {
    :ID => 706,
    :name => "High Horsepower",
    :function => 0x000,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 95,
    :accuracy => 95,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user fiercely attacks the target using its entire body."
},

:ICEHAMMER => {
    :ID => 707,
    :name => "Ice Hammer",
    :function => 0x03E,
    :type => :ICE,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The user swings and hits with its strong, heavy fist. It lowers the user's Speed, however."
},

:INSTRUCT => {
    :ID => 708,
    :name => "Instruct",
    :function => 0x164,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "The user instructs the target to use the target's last move again."
},

:LASERFOCUS => {
    :ID => 709,
    :name => "Laser Focus",
    :function => 0x165,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 30,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user concentrates intensely. The attack on the next turn always results in a critical hit."
},

:LEAFAGE => {
    :ID => 710,
    :name => "Leafage",
    :function => 0x000,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 40,
    :target => :SingleNonUser,
    :desc => "The user attacks by pelting the target with leaves."
},

:LIQUIDATION => {
    :ID => 711,
    :name => "Liquidation",
    :function => 0x043,
    :type => :WATER,
    :category => :physical,
    :basedamage => 85,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Slams into the target using a full-force blast of water. This may also lower the target's Defense."
},

:LUNGE => {
    :ID => 712,
    :name => "Lunge",
    :function => 0x042,
    :type => :BUG,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user makes a full force lunge at the target. This also lowers the target's Attack stat."
},

:MOONGEISTBEAM => {
    :ID => 713,
    :name => "Moongeist Beam",
    :function => 0x166,
    :type => :GHOST,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :beammove => true,
    :desc => "The user emits a sinister ray to attack the target, ignoring its ability."
},

:NATURESMADNESS => {
    :ID => 714,
    :name => "Nature Madness",
    :function => 0x06C,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 1,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user hits the target with the force of nature. It halves the target's HP."
},

:POLLENPUFF => {
    :ID => 715,
    :name => "Pollen Puff",
    :function => 0x167,
    :type => :BUG,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "Uses a pollen puff that explodes when given to enemies, but heals allies."
},

:POWERTRIP => {
    :ID => 716,
    :name => "Power Trip",
    :function => 0x08E,
    :type => :DARK,
    :category => :physical,
    :basedamage => 20,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user boasts its strength and attacks, getting more powerful the more their stats are raised."
},

:PRISMATICLASER => {
    :ID => 717,
    :name => "Prismatic Laser",
    :function => 0x0C2,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 160,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "Shoots powerful lasers using the power of a prism. The user can't move on the next turn."
},

:PSYCHICFANGS => {
    :ID => 718,
    :name => "Psychic Fangs",
    :function => 0x10A,
    :type => :PSYCHIC,
    :category => :physical,
    :basedamage => 85,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user bites with its psychic capabilities. This can also destroy Light Screen and Reflect."
},

:PSYCHICTERRAIN => {
    :ID => 719,
    :name => "Psychic Terrain",
    :function => 0x168,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :UserSide,
    :nonmirror => true,
    :desc => "This protects Pokémon on the ground from priority moves and powers up Psychic-type moves for five turns."
},

:PURIFY => {
    :ID => 720,
    :name => "Purify",
    :function => 0x169,
    :type => :POISON,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The user heals the target's status condition, restoring their own HP if succesful."
},

:REVELATIONDANCE => {
    :ID => 721,
    :name => "Revelation Dance",
    :function => 0x16A,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user attacks the target by dancing very hard. The user's type determines the type of this move."
},

:SHADOWBONE => {
    :ID => 722,
    :name => "Shadow Bone",
    :function => 0x043,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 85,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 20,
    :target => :SingleNonUser,
    :desc => "Beats the target with a bone that contains a spirit. This may also lower the target's Defense stat."
},

:SHELLTRAP => {
    :ID => 723,
    :name => "Shell Trap",
    :function => 0x16B,
    :type => :FIRE,
    :category => :special,
    :basedamage => 150,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :priority => -3,
    :nonmirror => true,
    :desc => "The user sets a shell trap, which will explode if hit by a physical move."
},

:SHOREUP => {
    :ID => 724,
    :name => "Shore Up",
    :function => 0x16C,
    :type => :GROUND,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :healingmove => true,
    :desc => "The user regains up to half of its max HP. It restores more HP in a sandstorm."
},

:SMARTSTRIKE => {
    :ID => 725,
    :name => "Smart Strike",
    :function => 0x0A5,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user stabs the target with a sharp horn. This attack never misses."
},

:SOLARBLADE => {
    :ID => 726,
    :name => "Solar Blade",
    :function => 0x0C4,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 125,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :sharpmove => true,
    :desc => "A two-turn attack. The user gathers light into a blade, attacking on the next turn."
},

:SPARKLINGARIA => {
    :ID => 727,
    :name => "Sparkling Aria",
    :function => 0x16D,
    :type => :WATER,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :AllNonUsers,
    :soundmove => true,
    :desc => "The user bursts into song, emitting many bubbles which can heal burns."
},

:SPECTRALTHIEF => {
    :ID => 728,
    :name => "Spectral Thief",
    :function => 0x16E,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user hides in the target's shadow, steals the target's stat boosts, and then attacks."
},

:SPEEDSWAP => {
    :ID => 729,
    :name => "Speed Swap",
    :function => 0x16F,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user exchanges Speed stats with the target."
},

:SPOTLIGHT => {
    :ID => 730,
    :name => "Spotlight",
    :function => 0x170,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :SingleNonUser,
    :priority => 3,
    :magiccoat => true,
    :nonmirror => true,
    :desc => "The user shines a spotlight on the target so that only they will be attacked this turn. "
},

:STOMPINGTANTRUM => {
    :ID => 731,
    :name => "Stomp Tantrum",
    :longname => "Stomping Tantrum",
    :function => 0x171,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Driven by frustration, the user attacks, doubling in power if their previous move failed."
},

:STRENGTHSAP => {
    :ID => 732,
    :name => "Strength Sap",
    :function => 0x172,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :magiccoat => true,
    :healingmove => true,
    :desc => "Restores the user's HP by the same amount as the target's Attack stat and lowers it."
},

:SUNSTEELSTRIKE => {
    :ID => 733,
    :name => "Sunsteel Strike",
    :function => 0x166,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user slams into the target with the force of a meteor, ignoring its ability."
},

:TEARFULLOOK => {
    :ID => 734,
    :name => "Tearful Look",
    :function => 0x138,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :magiccoat => true,
    :desc => "The user gets teary eyed, lowering the target's Attack and Sp. Atk."
},

:THROATCHOP => {
    :ID => 735,
    :name => "Throat Chop",
    :function => 0x173,
    :type => :DARK,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks the target's throat, preventing sound-based moves for two turns."
},

:TOXICTHREAD => {
    :ID => 736,
    :name => "Toxic Thread",
    :function => 0x174,
    :type => :POISON,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user shoots poisonous threads to poison the target and lower their Speed stat."
},

:TROPKICK => {
    :ID => 737,
    :name => "Trop Kick",
    :function => 0x042,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user lands an intense kick of tropical origins on the target, lowering their Attack."
},

:ZINGZAP => {
    :ID => 738,
    :name => "Zing Zap",
    :function => 0x00F,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "A strong electric blast crashes down on the target. This may also make the target flinch. "
},

:MULTIATTACK => {
    :ID => 739,
    :name => "Multi-Attack",
    :function => 0x09F,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user slams into the target, cloaked in energy. The memory held determines the move's type."
},

:FUTUREDUMMY => {
    :ID => 740,
    :name => "Future Sight",
    :function => 0x15A,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :nonmirror => true,
    :desc => "Two turns after this move is used, a hunk of psychic energy attacks the target."
},

:DOOMDUMMY => {
    :ID => 741,
    :name => "Doom Desire",
    :function => 0x15A,
    :type => :STEEL,
    :category => :special,
    :basedamage => 140,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :nonmirror => true,
    :desc => "Two turns after this move is used, the user blasts the target with a concentrated bundle of light."
},

:SPIRITSHACKLE => {
    :ID => 743,
    :name => "Spirit Shackle",
    :function => 0x155,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user attacks while stitching the target's shadow to the ground, preventing escape."
},

:PHOTONGEYSER => {
    :ID => 745,
    :name => "Photon Geyser",
    :function => 0x176,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The user attacks a target with a pillar of light. Uses the higher of either Attack or Sp. Attack stats."
},

:MINDBLOWN => {
    :ID => 746,
    :name => "Mind Blown",
    :function => 0x175,
    :type => :FIRE,
    :category => :special,
    :basedamage => 150,
    :accuracy => 100,
    :maxpp => 5,
    :target => :AllNonUsers,
    :desc => "The user attacks everything around it by causing its own head to explode. Also damages the user."
},

:PLASMAFISTS => {
    :ID => 747,
    :name => "Plasma Fists",
    :function => 0x177,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The user attacks with electrically charged fists. Normal-type moves become Electric-type."
},

:DOUBLEIRONBASH => {
    :ID => 753,
    :name => "Double Iron Bash",
    :function => 0x00A,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 0,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The user rotates, centering the hex nut in its chest, and then strikes with its arms twice in a row. This may also make the target flinch."
},

:HEXDUMMY => {
    :ID => 754,
    :name => "Hex",
    :function => 0x15A,
    :type => :GHOST,
    :category => :special,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "This relentless attack does massive damage to targets affected by status problems."
},

:DYNAMAXCANNON => {
    :ID => 755,
    :name => "Dynamax Cannon",
    :function => 0x178,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :beammove => true,
    :desc => "The user unleashes a strong beam from its core. This move deals twice the damage if the target is Dynamaxed."
},

:SNIPESHOT => {
    :ID => 756,
    :name => "Snipe Shot",
    :function => 0x179,
    :type => :WATER,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :highcrit => true,
    :desc => "The user ignores the effects of opposing Pokémon's moves and Abilities that draw in moves, allowing this move to hit the chosen target."
},

:JAWLOCK => {
    :ID => 757,
    :name => "Jaw Lock",
    :function => 0x189,
    :type => :DARK,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "This move prevents the user and the target from switching out until either of them faints. The effect goes away if either of the Pokémon leaves the field."
},

:STUFFCHEEKS => {
    :ID => 758,
    :name => "Stuff Cheeks",
    :function => 0x17A,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user eats its held Berry, then sharply raises its Defense stat."
},

:NORETREAT => {
    :ID => 759,
    :name => "No Retreat",
    :function => 0x17B,
    :type => :FIGHTING,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "This move raises all the user's stats but prevents the user from switching out or fleeing."
},

:TARSHOT => {
    :ID => 760,
    :name => "Tar Shot",
    :function => 0x17C,
    :type => :ROCK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user pours sticky tar over the target, lowering the target's Speed stat. The target becomes weaker to Fire-type moves."
},

:MAGICPOWDER => {
    :ID => 761,
    :name => "Magic Powder",
    :function => 0x17D,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user scatters a cloud of magic powder that changes the target to Psychic type."
},

:DRAGONDARTS => {
    :ID => 762,
    :name => "Dragon Darts",
    :function => 0x17E,
    :type => :DRAGON,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 10,
    :target => :DragonDarts,
    :desc => "The user attacks twice using Dreepy. If there are two targets, this move hits each target once."
},

:TEATIME => {
    :ID => 763,
    :name => "Teatime",
    :function => 0x17F,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :UserSide,
    :nonmirror => true,
    :desc => "The user has teatime with all the Pokémon in the battle. Each Pokémon eats its held Berry."
},

:OCTOLOCK => {
    :ID => 764,
    :name => "Octolock",
    :function => 0x180,
    :type => :FIGHTING,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "The user locks the target in and prevents it from fleeing. This move also lowers the target's Defense and Sp. Def every turn."
},

:BOLTBEAK => {
    :ID => 765,
    :name => "Bolt Beak",
    :function => 0x181,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 85,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user stabs the target with its electrified beak. If the user attacks before the target, the power of this move is doubled."
},

:FISHIOUSREND => {
    :ID => 767,
    :name => "Fishious Rend",
    :function => 0x181,
    :type => :WATER,
    :category => :physical,
    :basedamage => 85,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user rends the target with its hard gills. If the user attacks before the target, the power of this move is doubled."
},

:COURTCHANGE => {
    :ID => 768,
    :name => "Court Change",
    :function => 0x182,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :UserSide,
    :desc => "With its mysterious power, the user swaps the effects on either side of the field."
},

:CLANGOROUSSOUL => {
    :ID => 769,
    :name => "Clangorous Soul",
    :function => 0x183,
    :type => :DRAGON,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :soundmove => true,
    :desc => "The user raises all its stats by using some of its HP."
},

:BODYPRESS => {
    :ID => 770,
    :name => "Body Press",
    :function => 0x184,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks by slamming its body into the target. The higher the user's Defense, the more damage it can inflict on the target."
},

:DECORATE => {
    :ID => 771,
    :name => "Decorate",
    :function => 0x185,
    :type => :FAIRY,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :nonmirror => true,
    :desc => "The user sharply raises the target's Attack and Sp. Atk stats by decorating the target."
},

:DRUMBEATING => {
    :ID => 772,
    :name => "Drum Beating",
    :function => 0x044,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user plays its drum, controlling the drum's roots to attack the target. This also lowers the target's Speed stat."
},

:SNAPTRAP => {
    :ID => 773,
    :name => "Snap Trap",
    :function => 0x0CF,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 35,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user snares the target in a snap trap for four to five turns."
},

:PYROBALL => {
    :ID => 774,
    :name => "Pyro Ball",
    :function => 0x00A,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 90,
    :maxpp => 5,
    :effect => 10,
    :target => :SingleNonUser,
    :desc => "The user attacks by igniting a small stone and launching it as a fiery ball at the target. This may also leave the target with a burn."
},

:BEHEMOTHBLADE => {
    :ID => 775,
    :name => "Behemoth Blade",
    :function => 0x178,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :sharpmove => true,
    :desc => "The user becomes a gigantic sword and cuts the target. This move deals twice the damage if the target is Dynamaxed."
},

:BEHEMOTHBASH => {
    :ID => 776,
    :name => "Behemoth Bash",
    :function => 0x178,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user becomes a gigantic shield and cuts the target. This move deals twice the damage if the target is Dynamaxed."
},

:AURAWHEEL => {
    :ID => 777,
    :name => "Aura Wheel",
    :function => 0x186,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 110,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Morpeko attacks and raises its Speed with the energy stored in its cheeks. This move's type changes depending on the user's form."
},

:BREAKINGSWIPE => {
    :ID => 778,
    :name => "Breaking Swipe",
    :function => 0x042,
    :type => :DRAGON,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 100,
    :target => :AllOpposing,
    :contact => true,
    :desc => "The user swings its tough tail wildly and attacks opposing Pokémon. This also lowers their Attack stats."
},

:BRANCHPOKE => {
    :ID => 779,
    :name => "Branch Poke",
    :function => 0x000,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 40,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks the target by poking it with a sharply pointed branch."
},

:OVERDRIVE => {
    :ID => 780,
    :name => "Overdrive",
    :function => 0x000,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :AllOpposing,
    :soundmove => true,
    :desc => "The user attacks opposing Pokémon by twanging a guitar or bass guitar, causing a huge echo and strong vibration."
},

:APPLEACID => {
    :ID => 781,
    :name => "Apple Acid",
    :function => 0x046,
    :type => :GRASS,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user attacks the target with an acidic liquid created from tart apples. This also lowers the target's Sp. Def stat."
},

:GRAVAPPLE => {
    :ID => 782,
    :name => "Grav Apple",
    :function => 0x18B,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user attacks the target with an acidic liquid created from tart apples. This also lowers the target's Defense stat."
},

:SPIRITBREAK => {
    :ID => 783,
    :name => "Spirit Break",
    :function => 0x045,
    :type => :FAIRY,
    :category => :physical,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks the target with so much force that it could break the target's spirit. This also lowers the target's Sp. Atk stat."
},

:STRANGESTEAM => {
    :ID => 784,
    :name => "Strange Steam",
    :function => 0x013,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 90,
    :accuracy => 95,
    :maxpp => 10,
    :effect => 20,
    :target => :SingleNonUser,
    :desc => "The user attacks the target by emitting steam. This may also confuse the target."
},

:LIFEDEW => {
    :ID => 785,
    :name => "Life Dew",
    :function => 0x187,
    :type => :WATER,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :BothSides,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user scatters mysterious water around and restores the HP of itself and its ally Pokémon in the battle."
},

:OBSTRUCT => {
    :ID => 786,
    :name => "Obstruct",
    :function => 0x188,
    :type => :DARK,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :UserSide,
    :priority => 4,
    :nonmirror => true,
    :desc => "Protects the user from all attacks. Direct contact harshly lowers the attacker's Defense stat."
},

:FALSESURRENDER => {
    :ID => 787,
    :name => "False Surrender",
    :function => 0x0A5,
    :type => :DARK,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user pretends to bow its head, but then it stabs the target with its disheveled hair. This attack never misses."
},

:METEORASSAULT => {
    :ID => 788,
    :name => "Meteor Assault",
    :function => 0x0C2,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 150,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The user attacks wildly with its thick leek. The user can't move on the next turn, because the force of this move makes it stagger."
},

:ETERNABEAM => {
    :ID => 789,
    :name => "Eternabeam",
    :function => 0x0C2,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 500,
    :accuracy => 90,
    :maxpp => 5,
    :target => :SingleNonUser,
    :beammove => true,
    :desc => "This is Eternatus's most powerful attack in its original form. The user can't move on the next turn."
},

:STEELBEAM => {
    :ID => 790,
    :name => "Steel Beam",
    :function => 0x175,
    :type => :STEEL,
    :category => :special,
    :basedamage => 140,
    :accuracy => 95,
    :maxpp => 5,
    :target => :SingleNonUser,
    :beammove => true,
    :desc => "The user fires a beam of steel that it collected from its entire body. This also damages the user."
},

:CELEBRATE => {
    :ID => 794,
    :name => "Celebrate",
    :function => 0x001,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 40,
    :target => :User,
    :nonmirror => true,
    :gravityblocked => true,
    :desc => "The Pokémon congratulates you on your special day!"
},

:HAPPYHOUR => {
    :ID => 795,
    :name => "Happy Hour",
    :function => 0x001,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 40,
    :target => :SingleNonUser,
    :nonmirror => true,
    :gravityblocked => true,
    :desc => "Using Happy Hour doubles the amount of prize money received after battle!"
},

:HOLDHANDS => {
    :ID => 796,
    :name => "Hold Hands",
    :function => 0x001,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 40,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :nonmirror => true,
    :gravityblocked => true,
    :desc => "The user and an ally hold hands. This makes them very happy."
},

:SCORCHINGSANDS => {
    :ID => 800,
    :name => "Scorching Sands",
    :function => 0x00A,
    :type => :GROUND,
    :category => :special,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 30,
    :target => :SingleNonUser,
    :defrost => true,
    :desc => "The user throws scorching sand at the target to attack. This may also leave the target with a burn."
},

:DUALWINGBEAT => {
    :ID => 801,
    :name => "Dual Wingbeat",
    :function => 0x0BD,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user slams the target with its wings. The target is hit twice in a row."

},

:EXPANDINGFORCE => {
    :ID => 802,
    :name => "Expanding Force",
    :function => 0x321,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user attacks the target with its psychic power. This move's power goes up and damages all opposing Pokémon on Psychic Terrain."

},

:STEELROLLER => {
    :ID => 803,
    :name => "Steel Roller",
    :function => 0x306,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 130,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks while destroying the terrain. This move fails when the ground hasn't turned into a terrain."

},

:SCALESHOT => {
    :ID => 804,
    :name => "Scale Shot",
    :function => 0x307,
    :type => :DRAGON,
    :category => :physical,
    :basedamage => 25,
    :accuracy => 90,
    :maxpp => 20,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user attacks by shooting scales two to five times in a row. This move boosts the user's Speed stat but lowers its Defense stat."

},

:METEORBEAM => {
    :ID => 805,
    :name => "Meteor Beam",
    :function => 0x308,
    :type => :ROCK,
    :category => :special,
    :basedamage => 120,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :beammove => true,
    :desc => "In this two-turn attack, the user gathers space power and boosts its Sp. Atk stat, then attacks the target on the next turn."

},

:SHELLSIDEARM => {
    :ID => 806,
    :name => "Shell Side Arm",
    :function => 0x309,
    :type => :POISON,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 20,
    :target => :SingleNonUser,
    :desc => "This move inflicts physical or special damage, whichever will be more effective. This may also poison the target."

},

:MISTYEXPLOSION => {
    :ID => 807,
    :name => "Misty Explosion",
    :function => 0x30A,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 250,
    :accuracy => 100,
    :maxpp => 5,
    :target => :AllNonUsers,
    :desc => "The user attacks everything around it and faints upon using this move. This move's power is increased on Misty Terrain."

},

:GRASSYGLIDE => {
    :ID => 808,
    :name => "Grassy Glide",
    :function => 0x310,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Gliding on the ground, the user attacks the target. This move always goes first on Grassy Terrain."

},

:RISINGVOLTAGE => {
    :ID => 809,
    :name => "Rising Voltage",
    :function => 0x311,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :desc => "The user attacks with electric voltage rising from the ground. This move's power doubles when the target is on Electric Terrain."

},

:TERRAINPULSE => {
    :ID => 810,
    :name => "Terrain Pulse",
    :function => 0x312,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user utilizes the power of the terrain to attack. This move's type and power changes depending on the terrain when it's used."

},

:SKITTERSMACK => {
    :ID => 811,
    :name => "Skitter Smack",
    :function => 0x2001,
    :type => :BUG,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user skitters behind the target to attack. This also lowers the target's Sp. Atk stat."

},

:BURNINGJEALOUSY => {
    :ID => 812,
    :name => "Burning Jealousy",
    :function => 0x313,
    :type => :FIRE,
    :category => :special,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 5,
    :effect => 100,
    :target => :AllOpposing,
    :desc => "The user attacks with energy from jealousy. This leaves all opposing Pokémon that have had their stats boosted during the turn with a burn."

},

:LASHOUT => {
    :ID => 813,
    :name => "Lash Out",
    :function => 0x314,
    :type => :DARK,
    :category => :physical,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user lashes out to vent its frustration toward the target. If its stats were lowered during the turn, the power of this move is doubled."

},

:POLTERGEIST => {
    :ID => 814,
    :name => "Poltergeist",
    :function => 0x315,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 110,
    :accuracy => 90,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The user attacks by controlling the target's item. The move fails if the target doesn't have an item."

},

:CORROSIVEGAS => {
    :ID => 815,
    :name => "Corrosive Gas",
    :function => 0x316,
    :type => :POISON,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 40,
    :target => :AllOpposing,
    :desc => "The user surrounds everything around it with highly acidic gas and melts away items they hold."

},

:COACHING => {
    :ID => 816,
    :name => "Coaching",
    :function => 0x317,
    :type => :FIGHTING,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :bypassprotect => true,
    :target => :SingleNonUser,
    :desc => "The user properly coaches its ally Pokémon, boosting their Attack and Defense stats."

},

:FLIPTURN => {
    :ID => 817,
    :name => "Flip Turn",
    :function => 0x0EE,
    :type => :WATER,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "After making its attack, the user rushes back to switch places with a party Pokémon in waiting."

},

:TRIPLEAXEL => {
    :ID => 818,
    :name => "Triple Axel",
    :function => 0x0BF,
    :type => :ICE,
    :category => :physical,
    :basedamage => 20,
    :accuracy => 90,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "A consecutive three-kick attack that becomes more powerful with each successful hit."

},

:JUNGLEHEALING => {
    :ID => 819,
    :name => "Jungle Healing",
    :function => 0x318,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :UserSide,
    :desc => "The user becomes one with the jungle, restoring HP and healing any status conditions of itself and its ally Pokémon in battle."
},

:SURGINGSTRIKES => {
    :ID => 820,
    :name => "Surging Strikes",
    :function => 0x319,
    :type => :WATER,
    :category => :physical,
    :basedamage => 25,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The user, having mastered the Water style, strikes the target with a flowing motion three times in a row. This attack always results in a critical hit."

},

:WICKEDBLOW => {
    :ID => 821,
    :name => "Wicked Blow",
    :function => 0x0A0,
    :type => :DARK,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The user, having mastered the Dark style, strikes the target with a fierce blow. This attack always results in a critical hit."

},

:THUNDERCAGE => {
    :ID => 822,
    :name => "Thunder Cage",
    :function => 0x0CF,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 80,
    :accuracy => 90,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "The user traps the target in a cage of sparking electricity for four to five turns."

},

:DRAGONENERGY => {
    :ID => 823,
    :name => "Dragon Energy",
    :function => 0x08B,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 150,
    :accuracy => 100,
    :maxpp => 5,
    :target => :AllOpposing,
    :desc => "The user converts its life-force into power to damage opponents. Damage varies with the user's HP."

},

:FREEZINGGLARE => {
    :ID => 824,
    :name => "Freezing Glare",
    :function => 0x00C,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 30,
    :target => :AllOpposing,
    :desc => "The user shoots its psychic power from its eyes to attack. This may also leave the target with frostbite."

},

:FIERYWRATH => {
    :ID => 825,
    :name => "Fiery Wrath",
    :function => 0x00F,
    :type => :DARK,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 20,
    :target => :AllOpposing,
    :desc => "The user transforms its wrath into a fire-like aura to attack. This may also make opposing Pokémon flinch."

},

:THUNDEROUSKICK => {
    :ID => 826,
    :name => "Thunderous Kick",
    :function => 0x043,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user overwhelms the target with lightning-like movement before delivering a kick. This also lowers the target's Defense stat."

},

:GLACIALLANCE => {
    :ID => 827,
    :name => "Glacial Lance",
    :function => 0x000,
    :type => :ICE,
    :category => :physical,
    :basedamage => 130,
    :accuracy => 100,
    :maxpp => 5,
    :target => :AllOpposing,
    :desc => "The user attacks by hurling a blizzard-cloaked icicle lance at opposing Pokémon."

},

:ASTRALBARRAGE => {
    :ID => 828,
    :name => "Astral Barrage",
    :function => 0x000,
    :type => :GHOST,
    :category => :special,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 5,
    :target => :AllOpposing,
    :desc => "The user attacks by sending a frightful amount of small ghosts at opposing Pokémon."

},

:EERIESPELL => {
    :ID => 829,
    :name => "Eerie Spell",
    :function => 0x320,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user attacks with its tremendous psychic power. This also removes 3 PP from the target's last move."

},


# Gen 9

:CEASELESSEDGE => {
    :ID => 877,
    :name => "Ceaseless Edge",
    :function => 0x103,
    :type => :DARK,
    :category => :physical,
    :basedamage => 65,
    :accuracy => 90,
    :maxpp => 15,
    :effect => 100,
    :target => :SingleNonUser,
      :contact => :true,
      :sharpmove => true,
      :desc => "The user slashes its shell blade at the target. This also leaves a layer of spikes around the target."
},

:INFERNALPARADE => {
    :ID => 878,
    :name => "Infernal Parade",
    :function => 0x504,
    :type => :GHOST,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
      :effect => 30,
    :target => :SingleNonUser,
      :desc => "The user attacks with myriad fireballs. This may also leave the target with a burn. This move's power is doubled if the target has a status condition."
},

:SHELTER => {
    :ID => 879,
    :name => "Shelter",
    :function => 0x02F,
    :type => :STEEL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
      :nonmirror => true,
    :desc => "The user makes its skin as hard as an iron shield, sharply boosting its Defense stat."
},

:VICTORYDANCE => {
    :ID => 880,
    :name => "Victory Dance",
    :function => 0x501,
    :type => :FIGHTING,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
    :desc => "The user performs an intense dance to usher in victory, boosting its Attack, Defense, and Speed stats."
},

:POWERSHIFT => {
    :ID => 881,
    :name => "Power Shift",
    :function => 0x057,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :snatchable => true,
      :nonmirror => true,
      :desc => "The user swaps its Attack and Defense stats."
},

:STONEAXE => {
    :ID => 882,
    :name => "Stone Axe",
    :function => 0x105,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 65,
    :accuracy => 90,
    :maxpp => 15,
    :effect => 100,
    :target => :SingleNonUser,
      :contact => :true,
      :highcrit => true,
      :sharpmove => true,
      :desc => "The user swings its stone axes at the target, aiming to land a critical hit. Stone splinters left behind by this attack float around the target."
},

:PSYSHIELDBASH => {
    :ID => 883,
    :name => "Psyshield Bash",
    :function => 0x01D,
    :type => :PSYCHIC,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 90,
    :maxpp => 10,
      :effect => 100,
    :target => :SingleNonUser,
      :contact => :true,
    :desc => "Cloaking itself in psychic energy, the user slams into the target. This also boosts the user's Defense stat."
},

:MYSTICALPOWER => {
    :ID => 884,
    :name => "Mystical Power",
    :function => 0x020,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 70,
    :accuracy => 90,
    :maxpp => 10,
      :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user attacks by emitting a mysterious power. This also boosts the user's Sp. Atk stat. "
},

:DIRECLAW => {
    :ID => 885,
    :name => "Dire Claw",
    :function => 0x500,
    :type => :POISON,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 50,
    :target => :SingleNonUser,
      :contact => :true,
    :desc => "The user lashes out with ruinous claws, aiming to land a critical hit. It may leave the target poisoned, paralyzed, or asleep."
},

:SPRINGTIDESTORM => {
    :ID => 886,
    :name => "Springtide Storm",
    :function => 0x042,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 100,
    :accuracy => 80,
    :maxpp => 5,
    :target => :AllNonUsers,
      :windmove => true,
      :desc => "Shoots its own armor out as blazing projectiles. Lowers user's Def and SpDef."
},

:RAGINGFURY => {
    :ID => 887,
    :name => "Raging Fury",
    :function => 0x0D2,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
      :desc => "The user rampages around spewing flames for two to three turns. The user then becomes confused."
},

:WAVECRASH => {
    :ID => 888,
    :name => "Wave Crash",
    :function => 0x000,
    :type => :WATER,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
      :contact => :true,
    :recoil => 0.33,
      :desc => "The user shrouds itself in water and slams into the target with its whole body to inflict damage. This also damages the user quite a lot."
},

:CHLOROBLAST => {
    :ID => 889,
    :name => "Chloroblast",
    :function => 0x175,
    :type => :GRASS,
    :category => :special,
    :basedamage => 150,
    :accuracy => 95,
    :maxpp => 5,
    :target => :SingleNonUser,
      :desc => "The user launches its amassed chlorophyll to inflict damage on the target. This also damages the user."
},

:MOUNTAINGALE => {
    :ID => 890,
    :name => "Mountain Gale",
    :function => 0x00F,
    :type => :ICE,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 85,
    :maxpp => 10,
      :effect => 30,
    :target => :SingleNonUser,
    :desc => "The user hurls giant chunks of ice at the target to inflict damage. This may also make the target flinch."
},

:HEADLONGRUSH => {
    :ID => 891,
    :name => "Headlong Rush",
    :function => 0x03C,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
      :contact => :true,
    :punchmove => true,
      :desc => "The user smashes into the target in a full-body tackle. This also lowers the user's Defense and Sp. Def stats."
},

:BARBBARRAGE => {
    :ID => 892,
    :name => "Barb Barrage",
    :function => 0x502,
    :type => :POISON,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 10,
      :effect => 30,
    :target => :SingleNonUser,
    :desc => "The user launches countless toxic barbs to inflict damage. This may also poison the target. This move's power is doubled if the target is already poisoned."
},

:ESPERWING => {
    :ID => 893,
    :name => "Esper Wing",
    :function => 0x01F,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
      :effect => 100,
    :target => :SingleNonUser,
      :highcrit => true,
    :desc => "The user slashes the target with aura-enriched wings. This also boosts the user's Speed stat. This move has a heightened chance of landing a critical hit."
},

:BITTERMALICE => {
    :ID => 894,
    :name => "Bitter Malice",
    :function => 0x042,
    :type => :GHOST,
    :category => :special,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user attacks the target with spine-chilling resentment. This also lowers the target's Attack stat."
},

:TRIPLEARROWS => {
    :ID => 895,
    :name => "Triple Arrows",
    :function => 0x503,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 50,
    :moreeffect => 30,
    :target => :SingleNonUser,
      :highcrit => true,
    :desc => "The user kicks, then fires three arrows. This move has a heightened chance of landing a critical hit and may also lower the target's Defense stat or make it flinch."
},

:BLEAKWINDSTORM => {
    :ID => 896,
    :name => "Bleakwind Storm",
    :function => 0x044,
    :type => :FLYING,
    :category => :special,
    :basedamage => 100,
    :accuracy => 80,
    :maxpp => 10,
    :effect => 30,
    :target => :AllNonUsers,
      :windmove => true,
      :desc => "The user attacks with savagely cold winds that cause both body and spirit to tremble. This may also lower the Speed stats of opposing Pokémon."
},

:WILDBOLTSTORM => {
    :ID => 897,
    :name => "Wildbolt Storm",
    :function => 0x007,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 100,
    :accuracy => 80,
    :maxpp => 10,
    :effect => 20,
    :target => :AllNonUsers,
      :windmove => true,
      :desc => "The user summons a thunderous tempest and savagely attacks with lightning and wind. This may also leave opposing Pokémon with paralysis."
},

:SANDSEARSTORM => {
    :ID => 898,
    :name => "Sandsear Storm",
    :function => 0x00A,
    :type => :GROUND,
    :category => :special,
    :basedamage => 100,
    :accuracy => 80,
    :maxpp => 10,
    :effect => 20,
    :target => :AllNonUsers,
      :windmove => true,
      :desc => "The user attacks by wrapping opposing Pokémon in fierce winds and searingly hot sand. This may also leave them with a burn."
},

:LUNARBLESSING => {
    :ID => 899,
    :name => "Lunar Blessing",
    :function => 0x318,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 5,
    :target => :UserSide,
    :magiccoat => true,
    :desc => "The user receives a blessing from the crescent moon, restoring HP and curing status conditions for itself and its ally Pokémon currently in the battle."
},

:TAKEHEART => {
    :ID => 900,
    :name => "Take Heart",
    :function => 0x505,
    :type => :PSYCHIC,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user quietly focuses its mind and calms its spirit to raise its Sp. Atk and Sp. Def stats."
},

:AXEKICK => {
    :ID => 901,
    :name => "Axe Kick",
    :function => 0x506,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 90,
    :maxpp => 10,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :gravityblocked => true,
    :desc => "The user attacks by kicking up into the air and slamming its heel down upon the target. This may also confuse the target. If it misses, the user takes damage instead."
  },

  :COMEUPPANCE => {
    :ID => 902,
    :name => "Comeuppance",
    :function => 0x073,
    :type => :DARK,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 10,
    :target => :NoTarget,
    :desc => "The user retaliates with much greater force against the opponent that last inflicted damage on it."
},

:AQUACUTTER => {
    :ID => 903,
    :name => "Aqua Cutter",
    :function => 0x000,
    :type => :WATER,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 20,
    :target => :SingleNonUser,
    :contact => true,
    :highcrit => true,
    :sharpmove => true,
    :desc => "The user expels pressurized water to cut at the target like a blade. This move has a heightened chance of landing a critical hit."
},

# Gen 9 Mod - Move Additions

:ALLURINGVOICE => {
    :ID => 904,
    :name => "Alluring Voice",
    :function => 0x507,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :soundmove => true,
    :desc => "The user attacks the target using its angelic voice. This also confuses the target if its stats have been boosted during the turn."
},

:AQUASTEP => {
    :ID => 905,
    :name => "Aqua Step",
    :function => 0x01F,
    :type => :WATER,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks the target using light and fluid dance steps. This also boosts the user's Speed stat."
},

:ARMORCANNON => {
    :ID => 906,
    :name => "Armor Cannon",
    :function => 0x03C,
    :type => :FIRE,
    :category => :special,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 5,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user shoots its own armor out as blazing projectiles. This lowers the user's Defense and Sp. Def."
},

:BITTERBLADE => {
    :ID => 907,
    :name => "Bitter Blade",
    :function => 0x0DD,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :sharpmove => true,
    :healingmove => true,
    :desc => "A spiteful slashing attack. The user's HP is restored by up to half the damage taken by the target."
},

:BLAZINGTORQUE => {
    :ID => 908,
    :name => "Blazing Torque",
    :function => 0x00A,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 30,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "This move is only used by a Starmobile. It may leave the target with a burn."
},

:BLOODMOON => {
    :ID => 909,
    :name => "Blood Moon",
    :function => 0x000,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 140,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :cooldown => true,
    :desc => "The user unleashes the full brunt of its spirit from a blood moon. This move can't be used twice in a row."
},

:BURNINGBULWARK => {
    :ID => 910,
    :name => "Burning Bulwark",
    :function => 0x902,
    :type => :FIRE,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :UserSide,
    :priority => 4,
    :nonmirror => true,
    :desc => "User protects itself from attacks. Contact burns the target."
},

:CHILLINGWATER => {
    :ID => 911,
    :name => "Chilling Water",
    :function => 0x00D,
    :type => :WATER,
    :category => :special,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 30,
    :target => :SingleNonUser,
    :desc => "The user showers the target with frigid water. This may leave them with frostbite."
},

:CHILLYRECEPTION => {
    :ID => 912,
    :name => "Chilly Reception",
    :function => 0x903,
    :type => :ICE,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :UserSide,
    :nonmirror => true,
    :desc => "The user tells a chillingly bad joke and switches out. This summons a " + HAILSNOWLOWMOD + "storm lasting five turns."
},

:COLLISIONCOURSE => {
    :ID => 913,
    :name => "Collision Course",
    :function => 0x904,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 5,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user transforms and crashes to the ground, causing a massive prehistoric explosion. Stronger if super-effective."
},

:COMBATTORQUE => {
    :ID => 914,
    :name => "Combat Torque",
    :function => 0x007,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 30,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "This move is only used by a Starmobile. It may paralyze the target."
},

:DOODLE => {
    :ID => 915,
    :name => "Doodle",
    :function => 0x905,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleOpposing,
    :nonmirror => true,
    :desc => "The user captures the very essence of the target in a sketch. User and ally copy target's ability."
},

:DOUBLESHOCK => {
    :ID => 916,
    :name => "Double Shock",
    :function => 0x906,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks by discharging all of its electricity. The user will no longer be Electric type."
},

:DRAGONCHEER => {
    :ID => 917,
    :name => "Dragon Cheer",
    :function => 0x907,
    :type => :DRAGON,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :Partner,
    :nonmirror => true,
    :desc => "Encourages ally Pokémon, boosting their Critical Strike chance. More effective if the ally is Dragon type."
},

:ELECTRODRIFT => {
    :ID => 918,
    :name => "Electro Drift",
    :function => 0x904,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 5,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user races forward at ultrafast speeds, piercing its target with futuristic electricity. Stronger if super-effective."
},

:ELECTROSHOT => {
    :ID => 919,
    :name => "Electro Shot",
    :function => 0x908,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 130,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "First turn boost Sp.Atk, second turn attack the target. No charge during rain."
},

:FICKLEBEAM => {
    :ID => 920,
    :name => "Fickle Beam",
    :function => 0x909,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "Deals damage that has a 30% chance to double in power."
},

:FILLETAWAY => {
    :ID => 921,
    :name => "Fillet Away",
    :function => 0x90A,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :nonmirror => true,
    :snatchable => true,
    :desc => "The user sharply boosts its Attack, Sp. Atk, and Speed stats by using its own HP."
},

:FLOWERTRICK => {
    :ID => 922,
    :name => "Flower Trick",
    :function => 0x90B,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 70,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => false,
    :desc => "The user throws a rigged bouquet of flowers at the target, which always hits and lands a critical hit."
},

:GIGATONHAMMER => {
    :ID => 923,
    :name => "Gigaton Hammer",
    :function => 0x000,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 160,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :cooldown => true,
    :desc => "The user attacks with its huge hammer. This move can't be used twice in a row."
},

:GLAIVERUSH => {
    :ID => 924,
    :name => "Glaive Rush",
    :function => 0x90C,
    :type => :DRAGON,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user becomes highly vulnerable to attacks until its next turn after using this move."
},

:HARDPRESS => {
    :ID => 925,
    :name => "Hard Press",
    :function => 0x08C,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The target is crushed with great force. The more HP the target has left, the greater this move's power."
},

:HYDROSTEAM => {
    :ID => 926,
    :name => "Hydro Steam",
    :function => 0x90D,
    :type => :WATER,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :defrost => true,
    :desc => "The user blasts the target with boiling-hot water whose power is boosted in harsh sunlight."
},

:HYPERDRILL => {
    :ID => 927,
    :name => "Hyper Drill",
    :function => 0x90E,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :contact => true,
    :desc => "The user spins the pointed part of its body at high speed to pierce the target, ignoring protecting moves."
},

:ICESPINNER => {
    :ID => 928,
    :name => "Ice Spinner",
    :function => 0x000, # KAIZOMOD temp fix
    :type => :ICE,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user spins into the target with feet covered in thin ice. This also destroys the terrain."
},

:IVYCUDGEL => {
    :ID => 929,
    :name => "Ivy Cudgel",
    :function => 0x90F,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "Strike with an ivy-wrapped cudgel, type depends on the user's mask."
},

:JETPUNCH => {
    :ID => 930,
    :name => "Jet Punch",
    :function => 0x000,
    :type => :WATER,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :priority => 1,
    :contact => true,
    :punchmove => true,
    :desc => "The user summons a torrent around its fist and punches at blinding speed. Always goes first."
},

:KOWTOWCLEAVE => {
    :ID => 931,
    :name => "Kowtow Cleave",
    :function => 0x0A5,
    :type => :DARK,
    :category => :physical,
    :basedamage => 85,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :sharpmove => true,
    :contact => true,
    :desc => "The user kowtows to make the target lower its guard, then slashes. This attack never misses."
},

:LASTRESPECTS => {
    :ID => 932,
    :name => "Last Respects",
    :function => 0x910,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user attacks to avenge its allies. The move's power increases for each defeated ally."
},

:LUMINACRASH => {
    :ID => 933,
    :name => "Lumina Crash",
    :function => 0x04F,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user attacks by unleashing a peculiar, mind-bending light that harshly lowers the target's Sp. Def."
},

:MAGICALTORQUE => {
    :ID => 934,
    :name => "Magical Torque",
    :function => 0x013,
    :type => :FAIRY,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 30,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "This move is only used by a Starmobile. It may confuse the target."
},

:MAKEITRAIN => {
    :ID => 935,
    :name => "Make It Rain",
    :function => 0x911,
    :type => :STEEL,
    :category => :special,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 5,
    :target => :AllOpposing,
    :desc => "The user throws out a huge mass of coins, lowering its Sp. Atk stat. Money is earned after the battle."
},

:MALIGNANTCHAIN => {
    :ID => 936,
    :name => "Malignant Chain",
    :function => 0x006,
    :type => :POISON,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 5,
    :effect => 50,
    :target => :SingleNonUser,
    :desc => "The user pours toxins into the target with chains. May leave the target badly poisoned."
},

:MATCHAGOTCHA => {
    :ID => 937,
    :name => "Matcha Gotcha",
    :function => 0x912,
    :type => :GRASS,
    :category => :special,
    :basedamage => 80,
    :accuracy => 90,
    :maxpp => 15,
    :effect => 20,
    :target => :AllOpposing,
    :defrost => true,
    :healingmove => true,
    :desc => "Blasts opponents with hot tea. Heals the user by half the damage dealt and may also burn targets."
},

:MIGHTYCLEAVE => {
    :ID => 938,
    :name => "Mighty Cleave",
    :function => 0x90E,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 95,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :bypassprotect => true,
    :sharpmove => true,
    :desc => "Cleaves the target. Ignores protecting moves."
},

:MORTALSPIN => {
    :ID => 939,
    :name => "Mortal Spin",
    :function => 0x110,
    :type => :POISON,
    :category => :physical,
    :basedamage => 30,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 100,
    :target => :AllOpposing,
    :contact => true,
    :desc => "Performs a spin that eliminates certain traps and hazards. This also poisons opposing Pokémon."
},

:NOXIOUSTORQUE => {
    :ID => 940,
    :name => "Noxious Torque",
    :function => 0x005,
    :type => :POISON,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 30,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "This move is only used by a Starmobile. It may poison the target."
},

:ORDERUP => {
    :ID => 941,
    :name => "Order Up",
    :function => 0x913,
    :type => :DRAGON,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => false,
    :desc => "The user attacks with elegant poise. If the user has a Tatsugiri in its mouth, boosts user's stats based on its form."
},

:POPULATIONBOMB => {
    :ID => 942,
    :name => "Population Bomb",
    :function => 0x914,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 20,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :sharpmove => true,
    :desc => "The user's fellows gather in droves to perform a combo attack that hits one to ten times in a row."
},

:POUNCE => {
    :ID => 943,
    :name => "Pounce",
    :function => 0x044,
    :type => :BUG,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks by pouncing on the target. This also lowers the target's Speed stat."
},

:PSYBLADE => {
    :ID => 944,
    :name => "Psyblade",
    :function => 0x311,
    :type => :PSYCHIC,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :sharpmove => true,
    :desc => "The user rends the target with an ethereal blade whose power is boosted on Electric Terrain."
},

:PSYCHICNOISE => {
    :ID => 945,
    :name => "Psychic Noise",
    :function => 0x0BB,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :soundmove => true,
    :desc => "Damages the target and prevents it from healing for two turns."
},

:RAGEFIST => {
    :ID => 946,
    :name => "Rage Fist",
    :function => 0x915,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The user converts its rage into energy to attack. The move's power increases every time the user is hit."
},

:RAGINGBULL => {
    :ID => 947,
    :name => "Raging Bull",
    :function => 0x916,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user performs a tackle like a raging bull. Type depends on form. Can also break barriers."
},

:REVIVALBLESSING => {
    :ID => 948,
    :name => "Revival Blessing",
    :function => 0x917,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 1,
    :target => :User,
    :nonmirror => true,
    :desc => "The user revives a party Pokémon that has fainted and restores half their max HP."
},

:RUINATION => {
    :ID => 949,
    :name => "Ruination",
    :function => 0x06C,
    :type => :DARK,
    :category => :special,
    :basedamage => 1,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user summons a ruinous disaster. This cuts the target's HP in half."
},

:SALTCURE => {
    :ID => 950,
    :name => "Salt Cure",
    :function => 0x918,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user salt cures the target, inflicting damage every turn. Steel and Water types take more damage."
},

:SHEDTAIL => {
    :ID => 951,
    :name => "Shed Tail",
    :function => 0x919,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :nonmirror => true,
    :desc => "The user creates a substitute for itself using its own HP before switching places with a party Pokémon in waiting."
},

:SILKTRAP => {
    :ID => 952,
    :name => "Silk Trap",
    :function => 0x91A,
    :type => :BUG,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :target => :User,
    :priority => 4,
    :nonmirror => true,
    :desc => "User spins a silken trap to protect itself. Lowers the Speed of any that make direct contact."
},

:SPICYEXTRACT => {
    :ID => 954,
    :name => "Spicy Extract",
    :function => 0x91C,
    :type => :GRASS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "Emits a spicy extract which raises the target's Attack and lowers Defense by two stages each."
},

:SPINOUT => {
    :ID => 955,
    :name => "Spin Out",
    :function => 0x91D,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user inflicts damage on the target with a furious spin. This harshly lowers the user's Speed."
},

:SUPERCELLSLAM => {
    :ID => 956,
    :name => "Supercell Slam",
    :function => 0x10B,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 95,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user slams down on the target. If it misses, the user is hurt instead."
},

:SYRUPBOMB => {
    :ID => 957,
    :name => "Syrup Bomb",
    :function => 0x91E,
    :type => :GRASS,
    :category => :special,
    :basedamage => 60,
    :accuracy => 85,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "An explosion of sticky candy syrup, which drop the target's Speed stat each turn for three turns."
},

:TACHYONCUTTER => {
    :ID => 958,
    :name => "Tachyon Cutter",
    :function => 0x91F,
    :type => :STEEL,
    :category => :special,
    :basedamage => 50,
    :accuracy => 0,
    :maxpp => 10,
    :target => :SingleNonUser,
    :sharpmove => true,
    :desc => "The user launches particle blades at the target twice. This attack never misses."
},

:TEMPERFLARE => {
    :ID => 959,
    :name => "Temper Flare",
    :function => 0x171,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Spurred by desperation, the user attacks. If the user's previous move failed, the power of this move doubles."
},

:TERASTARSTORM => {
    :ID => 960,
    :name => "Tera Starstorm",
    :function => 0x920,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "Attacks the target with crystals. Hits all opposing Pokémon in Stellar Form."
},

:THUNDERCLAP => {
    :ID => 961,
    :name => "Thunder Clap",
    :function => 0x116,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 70,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :priority => 1,
    :desc => "User attacks first. It fails if the target is not readying a damaging move."
},

:TIDYUP => {
    :ID => 962,
    :name => "Tidy Up",
    :function => 0x921,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 10,
    :effect => 100,
    :target => :User,
    :nonmirror => true,
    :desc => "Clears hazards and substitutes from the field. This also boosts the user's Attack and Speed."
},

:TORCHSONG => {
    :ID => 963,
    :name => "Torch Song",
    :function => 0x020,
    :type => :FIRE,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
      :effect => 100,
    :target => :SingleNonUser,
    :soundmove => true,
    :desc => "The user blows out raging flames as if singing a song. This also boosts the user's Sp. Atk stat."
},

:TRAILBLAZE => {
    :ID => 964,
    :name => "Trailblaze",
    :function => 0x01F,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user attacks suddenly as if leaping out from tall grass. This boosts the user's Speed stat."
},

:TRIPLEDIVE => {
    :ID => 965,
    :name => "Triple Dive",
    :function => 0x922,
    :type => :WATER,
    :category => :physical,
    :basedamage => 30,
    :accuracy => 95,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user performs a perfectly timed triple dive, hitting the target three times in a row."
},

:TWINBEAM => {
    :ID => 966,
    :name => "Twin Beam",
    :function => 0x0BD,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user shoots mystical beams from its eyes to inflict damage. The target is hit twice in a row."
},

:UPPERHAND => {
    :ID => 967,
    :name => "Upper Hand",
    :function => 0x923,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 100,
    :target => :SingleNonUser,
    :priority => 3,
    :contact => true,
    :desc => "Only works when target uses priority move. Flinches the target."
},

:WICKEDTORQUE => {
    :ID => 968,
    :name => "Wicked Torque",
    :function => 0x003,
    :type => :DARK,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 10,
    :target => :SingleNonUser,
    :nonmirror => true,
    :desc => "This move is only used by a Starmobile. It may put the target to sleep."
},

# GEN 9 MOD MOVE DUMMIES FOR ANIMATION COMPILATION, PLEASE DEFINE REAL GEN 9 MOVES ABOVE HERE

:IVYCUDGELWATER => {
    :name => "Ivy Cudgel ANIMATION",
    :function => 0x910,
    :type => :WATER,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "Strike with an ivy-wrapped cudgel, type depends on the user's mask."
},

:IVYCUDGELFIRE => {
    :name => "Ivy Cudgel ANIMATION",
    :function => 0x910,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "Strike with an ivy-wrapped cudgel, type depends on the user's mask."
},

:IVYCUDGELROCK => {
    :name => "Ivy Cudgel ANIMATION",
    :function => 0x910,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "Strike with an ivy-wrapped cudgel, type depends on the user's mask."
},

:ORDERUPCURLY => {
    :name => "Order Up ANIMATION",
    :function => 0x919,
    :type => :DRAGON,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "Attack with elegant poise. If Tatsugiri is in its mouth, boosts a specific stat."
},

:ORDERUPDROOPY => {
    :name => "Order Up ANIMATION",
    :function => 0x919,
    :type => :DRAGON,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "Attack with elegant poise. If Tatsugiri is in its mouth, boosts a specific stat."
},

:ORDERUPSTRETCHY => {
    :name => "Order Up ANIMATION",
    :function => 0x919,
    :type => :DRAGON,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "Attack with elegant poise. If Tatsugiri is in its mouth, boosts a specific stat."
},

:RAGINGBULLFIGHTING => {
    :name => "Raging Bull ANIMATION",
    :function => 0x922,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user performs a tackle like a raging bull. Type depends on form. Can also break barriers."
},

:RAGINGBULLFIRE => {
    :name => "Raging Bull ANIMATION",
    :function => 0x922,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user performs a tackle like a raging bull. Type depends on form. Can also break barriers."
},

:RAGINGBULLWATER => {
    :name => "Raging Bull ANIMATION",
    :function => 0x922,
    :type => :WATER,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user performs a tackle like a raging bull. Type depends on form. Can also break barriers."
},

:POPULATIONBOMBNEXTHIT => {
    :ID => 942,
    :name => "Population Bomb",
    :function => 0x914,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 20,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :sharpmove => true,
    :desc => "The user's fellows gather in droves to perform a combo attack that hits one to ten times in a row."
},

:SYRUPBOMBSHINY => {
    :ID => 957,
    :name => "Syrup Bomb ANIMATION",
    :function => 0x91E,
    :type => :GRASS,
    :category => :special,
    :basedamage => 60,
    :accuracy => 85,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "An explosion of sticky candy syrup, which drop the target's Speed stat each turn for three turns."
},

:FICKLEBEAMMAX => {
    :ID => 920,
    :name => "Fickle Beam ANIMATION",
    :function => 0x909,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "Deals damage that has a 30% chance to double in power."
},

###MODDED###

## REJUV CUSTOM MOVES
# Character Signature Moves

:VENAMSKISS => {
    :ID => 612,
    :name => "Venam's Kiss",
    :function => 0x005,
    :type => :POISON,
    :category => :physical,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user kisses with corrosive acid that may leave the target poisoned. It is Super Effective against Steel-types."
},

:GALESTRIKE => {
    :ID => 631,
    :name => "Gale Strike",
    :function => 0x201,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 35,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user summons power when they are against the odds."
},

:MULTIPULSE => {
    :ID => 632,
    :name => "Multipulse",
    :function => 0x09F,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "The uses shoots holy energy at the target, changing type depending on plate held."
},

:SPECTRALSCREAM => {
    :ID => 633,
    :name => "Spectral Scream",
    :function => 0x20B,
    :type => :GHOST,
    :category => :special,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 60,
    :target => :SingleNonUser,
    :soundmove => true,
    :desc => "The users makes a spine-chilling scream, with a chance of raising defense."
},

:AQUABATICS => {
    :ID => 634,
    :name => "Aquabatics",
    :function => 0x207,
    :type => :WATER,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 15,
    :target => :User,
    :snatchable => true,
    :nonmirror => true,
    :desc => "The user loosens up with aquabatics, raising its Sp. Atk and Speed."
},

:BARBEDWEB => {
    :ID => 635,
    :name => "Barbed Web",
    :function => 0x900,
    :type => :BUG,
    :category => :physical,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :AllOpposing,
    :highcrit => true,
    :desc => "The user spreads spiked silk across the opposing battlefield."
},

:COLDTRUTH => {
    :ID => 636,
    :name => "Cold Truth",
    :function => 0x0B7,
    :type => :ICE,
    :category => :special,
    :basedamage => 95,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :AllOpposing,
    :desc => "A strong disturbing chill hits adjacent opponents, inflicting Torment upon them."
},

:FEVERPITCH => {
    :ID => 638,
    :name => "Fever Pitch",
    :function => 0x202,
    :type => :FIRE,
    :category => :special,
    :basedamage => 1,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 10,
    :target => :SingleNonUser,
    :soundmove => true,
    :desc => "The user emits a rocking hot sound, getting stronger with more hype."
},

:POWERSURGE => {
    :ID => 639,
    :name => "Power Surge",
    :function => 0x311,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 100,
    :recoil => 0.33,
    :target => :SingleNonUser,
    :desc => "Erick's signature move. Boosted by electric terrain."
},

:UPROOT => {
    :ID => 659,
    :name => "Uproot",
    :function => 0x04F,
    :type => :GRASS,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user attacks the target like uprooting a plant, lowering the target's Sp. Def harshly."
},

:BUNRAKUBEATDOWN => {
    :ID => 793,
    :name => "Bunraku Beatdown",
    :function => 0x209,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 75,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user attacks the opponent, controlling knocked out ally Pokémon with strings for extra damage."
},

:HEAVENLYWING => {
    :ID => 744,
    :name => "Heavenly Wing",
    :function => 0x050,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 0,
    :maxpp => 15,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "A shining wing strikes the target, removing stat changes."
},

:MATRIXSHOT => {
    :ID => 749,
    :name => "Matrix Shot",
    :function => 0x204,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "A rock clumped with gems is fired at the target, targetting its special defense."
},

:DESERTSMARK => {
    :ID => 751,
    :name => "Desert's Mark",
    :function => 0x205,
    :type => :GROUND,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :SingleNonUser,
    :desc => "Applies a sinister mark on the target, damaging over time and changing its type to Ground."
},

:ULTRAMEGADEATH => {
    :ID => 660,
    :name => "Super U.M.D. Move",
    :longname => "Super Ultra Mega Death Move",
    :function => 0x20D,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 20,
    :target => :SingleNonUser,
    :desc => "This attack will be Physical or Special, depending on which would do more damage."
},

:DECIMATION => {
    :ID => 689,
    :name => "Decimation",
    :function => 0x200,
    :type => :DARK,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 100,
    :target => :SingleNonUser,
    :priority => 1,
    :cooldown => true,
    :desc => "The user absorbs the life energy from the target, leaving them completely lifeless."
},

:PYROKINESIS => {
    :ID => 742,
    :name => "Pyrokinesis",
    :function => 0x00A,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 30,
    :target => :SingleNonUser,
    :defrost => true,
    :desc => "The user lobs a ball of fire at the target formed from psychic energy. It may also leave the target with a burn."
},

:ALPHASHOT => {
    :ID => 797,
    :name => "Alpha Shot",
    :function => 0x000,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user fires a golden ball of energy at the target."
},

:GILDEDARROW => {
    :ID => 798,
    :name => "Gilded Arrow",
    :function => 0x20C,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :highcrit => true,
    :desc => "The user fires a golden arrow of energy at the target. Critical hits land more easily."
},

:GILDEDHELIX => {
    :ID => 799,
    :name => "Gilded Helix",
    :function => 0x20C,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :highcrit => true,
    :desc => "Two golden arrows matching the user's type are fired. Critical hits land more easily."
},

# Custom TM/Tutor Moves

:POISONSWEEP => {
    :ID => 669,
    :name => "Poison Sweep",
    :function => 0x044,
    :type => :POISON,
    :category => :physical,
    :basedamage => 65,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 100,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "The user engulfs their foot with poison and proceeds to knock over their opponent. It may lower speed."
},

:STACKINGSHOT => {
    :ID => 670,
    :name => "Stacking Shot",
    :function => 0x091,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 40,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :punchmove => true,
    :desc => "The user attacks in quick jabs. It becomes stronger the more it's used. "
},

:IRRITATION => {
    :ID => 683,
    :name => "Irritation",
    :function => 0x07F,
    :type => :BUG,
    :category => :special,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "Does massive damage if the opponent is inflicted with a status."
},

:MAGMADRIFT => {
    :ID => 684,
    :name => "Magma Drift",
    :function => 0x075,
    :type => :FIRE,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 15,
    :target => :AllNonUsers,
    :defrost => true,
    :desc => "It swamps the area around the user with a giant wave of molten rock. It can also be used for crossing lava."
},

:DELUGE=> {
    :ID => 685,
    :name => "Deluge",
    :function => 0x081,
    :type => :WATER,
    :category => :physical,
    :basedamage => 60,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :priority => -4,
    :contact => true,
    :desc => "The power of this move is doubled if the user has been hurt by the target in the same turn."
},

:MUDBARRAGE => {
    :ID => 687,
    :name => "Mud Barrage",
    :function => 0x0C0,
    :type => :GROUND,
    :category => :special,
    :basedamage => 25,
    :accuracy => 95,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "The user pelts the opponent with large amounts of mud, hitting two to five times in a row."
},

:SLASHANDBURN => {
    :ID => 688,
    :name => "Slash and Burn",
    :function => 0x00A,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 90,
    :maxpp => 10,
    :effect => 10,
    :target => :SingleNonUser,
    :contact => true,
    :sharpmove => true,
    :desc => "The user slashes the opponent harshly. It may leave the target with a burn."
},

:ARENITEWALL => {
    :ID => 750,
    :name => "Arenite Wall",
    :function => 0x203,
    :type => :GROUND,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 20,
    :target => :BothSides,
    :snatchable => true,
    :nonmirror => true,
    :desc => "Puts up a wall of sand that reduces the power of super-effective moves."
},

:QUICKSILVERSPEAR => {
    :ID => 679,
    :name => "Quicksilver Spear",
    :function => 0x20A,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 75,
    :maxpp => 5,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "The user hurls a spear of quicksilver to pin the target. Drops speed and deals constant damage on Shadows/Rifts."
},

:SPARKLEON => {
    :ID => 680,
    :name => "Sparkle On",
    :function => 0x000,
    :type => :FAIRY,
    :category => :physical,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :recoil => 0.33,
    :desc => "A reckless, dazzling tackle. It also damages the user."
},

# Custom Mon Sigs

:SOLARFLARE => {
    :ID => 686,
    :name => "Solar Flare",
    :function => 0x01C,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 100,
    :accuracy => 95,
    :maxpp => 10,
    :effect => 50,
    :target => :SingleNonUser,
    :desc => "The user tackles the opponent, engulfed in incredible flames. It may raise the user's Attack."
},

:HOARFROSTMOON => {
    :name => "Hoarfrost Moon",
    :function => 0x020,
    :type => :ICE,
    :category => :special,
    :basedamage => 90,
    :accuracy => 90,
    :maxpp => 10,
    :effect => 50,
    :target => :AllOpposing,
    :desc => "The user releases an icy, crescent burst at the opponents. It may raise the user's Special Attack."
},

:HEXINGSLASH => {
    :ID => 791,
    :name => "Hexing Slash",
    :function => 0x208,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 30,
    :target => :SingleNonUser,
    :contact => true,
    :healingmove => true,
    :sharpmove => true,
    :desc => "A relentless attack using cursed tendrils. Drains HP and has a chance to poison."
},

:WAKEUPSHOCK => {
    :ID => 830,
    :name => "Wake-Up Shock",
    :function => 0x07D,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "This attack inflicts big damage on a sleeping target. It also wakes the target up."
},

:VILEASSAULT => {
    :ID => 831,
    :name => "Vile Assault",
    :function => 0x088,
    :type => :POISON,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "A relentless attack that cuts off a target's escape."
},

:ETHEREALTEMPEST => {
    :ID => 832,
    :name => "Ether Tempest",
    :longname => "Ethereal Tempest",
    :function => 0x007,
    :type => :FLYING,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 15,
    :effect => 20,
    :target => :SingleNonUser,
    :desc => "The target is hit with unearthly wind. It may paralyze the target."
},

:MIRRORBEAM => {
    :ID => 833,
    :name => "Mirror Beam",
    :longname => "Mirror Beam",
    :function => 0x20E,
    :type => :STEEL,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 20,
    :target => :SingleNonUser,
    :desc => "The user shoots a reflective beam that matches its secondary typing."
},

# Others

:PROBOPOG => {
    :ID => 792,
    :name => "Probopass PogChampion",
    :function => 0x206,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 20,
    :accuracy => 100,
    :maxpp => 15,
    :target => :SingleNonUser,
    :desc => "Please don't hack it in, it's a bad move on its own, don't be weirdchamp"
},

# END REJUV CUSTOM MOVES

# Z- Moves

:BREAKNECKBLITZ => {
    :name => "Breakneck Blitz",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user builds up its momentum using its Z-Power and crashes into the target at full speed. The power varies, depending on the original move."
},

:ALLOUTPUMMELING => {
    :name => "All-Out Pummel",
    :longname => "All-Out Pummeling",
    :function => 0x000,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user rams an energy orb created by its Z-Power into the target with full force. The power varies, depending on the original move."
},

:SUPERSONICSKYSTRIKE => {
    :name => "Sonic Skystrike",
    :longname => "Supersonic Skystrike",
    :function => 0x000,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user soars up with its Z-Power and plummets toward the target at full speed. The power varies, depending on the original move."
},

:ACIDDOWNPOUR => {
    :name => "Acid Downpour",
    :function => 0x800,
    :type => :POISON,
    :category => :special,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user creates a poisonous swamp using its Z-Power and sinks the target into it at full force. The power varies, depending on the original move."
},

:TECTONICRAGE => {
    :name => "Tectonic Rage",
    :function => 0x000,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user burrows deep into the ground and slams into the target with the full force of its Z-Power. The power varies, depending on the original move."
},

:CONTINENTALCRUSH => {
    :name => "Continent Crush",
    :longname => "Continental Crush",
    :function => 0x000,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user summons a huge rock mountain using its Z-Power and drops it onto the target with full force. The power varies, depending on the original move."
},

:SAVAGESPINOUT => {
    :name => "Savage Spin-Out",
    :function => 0x000,
    :type => :BUG,
    :category => :physical,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user binds the target with full force with threads of silk that the user spits using its Z-Power. The power varies, depending on the original move."
},

:NEVERENDINGNIGHTMARE => {
    :name => "NE. Nightmare",
    :longname => "Never-Ending Nightmare",
    :function => 0x000,
    :type => :GHOST,
    :category => :special,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "Deep-seated grudges summoned by the user's Z-Power trap the target. The power varies, depending on the original move."
},

:CORKSCREWCRASH => {
    :name => "Corkscrew Crash",
    :function => 0x000,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user spins very fast and rams into the target with the full force of its Z-Power. The power varies, depending on the original move."
},

:INFERNOOVERDRIVE => {
    :name => "Inf. Overdrive",
    :longname => "Inferno Overdrive",
    :function => 0x000,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user breathes a stream of intense fire toward the target with the full force of its Z-Power. The power varies depending on the original move."
},

:HYDROVORTEX => {
    :name => "Hydro Vortex",
    :function => 0x3000,
    :type => :WATER,
    :category => :special,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user creates a huge whirling current using its Z-Power to swallow the target with full force. The power varies, depending on the original move."
},

:BLOOMDOOM => {
    :name => "Bloom Doom",
    :function => 0x801,
    :type => :GRASS,
    :category => :special,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user collects energy from plants using its Z-Power and attacks the target with full force. The power varies, depending on the original move."
},

:GIGAVOLTHAVOC => {
    :name => "Gigavolt Havoc",
    :function => 0x000,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user hits the target with a powerful electric current collected by its Z-Power. The power varies, depending on the original move."
},

:SHATTEREDPSYCHE => {
    :name => "Shatter Psyche",
    :longname => "Shattered Psyche",
    :function => 0x802,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user controls the target with its Z-Power and hurts the target with full force. The power varies, depending on the original move."
},

:SUBZEROSLAMMER => {
    :name => "Subzero Slammer",
    :function => 0x000,
    :type => :ICE,
    :category => :physical,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user dramatically drops the temperature using its Z-Power and freezes the target with full force. The power varies, depending on the original move."
},

:DEVASTATINGDRAKE => {
    :name => "Dev. Drake",
    :longname => "Devastating Drake",
    :function => 0x000,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user materializes its aura using its Z-Power and attacks the target with full force. The power varies, depending on the original move."
},

:BLACKHOLEECLIPSE => {
    :name => "Black Hole",
    :longname => "Black Hole Eclipse",
    :function => 0x000,
    :type => :DARK,
    :category => :special,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user gathers dark energy using its Z-Power and sucks the target into it. The power varies, depending on the original move."
},

:TWINKLETACKLE => {
    :name => "Twinkle Tackle",
    :function => 0x000,
    :type => :FAIRY,
    :category => :physical,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user creates a very charming space using its Z-Power and totally toys with the target. The power varies, depending on the original move."
},

:STOKEDSPARKSURFER => {
    :name => "S. Sparksurfer",
    :longname => "Stoked Sparksurfer",
    :function => 0x803,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 175,
    :accuracy => 0,
    :maxpp => 0,
    :effect => 100,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "After obtaining Z-Power, the user, Alolan Raichu, attacks the target with full force. This move leaves the target with paralysis."
},

:SINISTERARROWRAID => {
    :name => "S. Arrow Raid",
    :longname => "Sinister Arrow Raid",
    :function => 0x000,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user, Decidueye, creates countless arrows using its Z-Power and shoots the target with full force."
},

:MALICIOUSMOONSAULT => {
    :name => "Mal. Moonsault",
    :longname => "Malicious Moonsault",
    :function => 0x806,
    :type => :DARK,
    :category => :physical,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :contact => true,
    :zmove => true,
    :desc => "The user, Incineroar, strengthens its body using its Z-Power and crashes into the target with full force."
},

:OCEANICOPERETTA => {
    :name => "Ocean Operetta",
    :longname => "Oceanic Operetta",
    :function => 0x000,
    :type => :WATER,
    :category => :special,
    :basedamage => 195,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user, Primarina, summons a massive amount of water using its Z-Power and attacks the target with full force."
},

:EXTREMEEVOBOOST => {
    :name => "Ex. Evoboost",
    :longname => "Extreme Evoboost",
    :function => 0x804,
    :type => :NORMAL,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 0,
    :target => :User,
    :zmove => true,
    :desc => "After obtaining Z-Power, the user, Eevee, gets energy from its evolved friends and boosts its stats sharply."
},

:CATASTROPIKA => {
    :name => "Catastropika",
    :function => 0x000,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 210,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :contact => true,
    :zmove => true,
    :desc => "The user, Pikachu, surrounds itself with the maximum amount of electricity using its Z-Power and pounces on its target with full force."
},

:PULVERIZINGPANCAKE => {
    :name => "Pulv. Pancake",
    :longname => "Pulverizing Pancake",
    :function => 0x000,
    :type => :NORMAL,
    :category => :physical,
    :basedamage => 210,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :contact => true,
    :zmove => true,
    :desc => "     Z-Power brings out the true capabilities of the user, Snorlax. The Pokémon moves its enormous body energetically and attacks the target with full force."
},

:GENESISSUPERNOVA => {
    :name => "Gen. Supernova",
    :longname => "Genesis Supernova",
    :function => 0x805,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 185,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "After obtaining Z-Power, the user, Mew, attacks the target with full force. The terrain will be charged with psychic energy."
},

:GUARDIANOFALOLA => {
    :name => "Guardian of Alola",
    :function => 0x809,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 1,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :effect => 100,
    :desc => "The user, the Land Spirit Pokémon, obtains Alola's energy using its Z-Power and attacks the target with full force. This reduces the target's HP greatly."
},

:SOULSTEALING7STARSTRIKE => {
    :name => "7-Star Strike",
    :longname => "Soul-Stealing 7-Star Strike",
    :function => 0x000,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 195,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :contact => true,
    :zmove => true,
    :desc => "After obtaining Z-Power, the user, Marshadow, punches and kicks the target consecutively with full force."
},

:LETSSNUGGLEFOREVER  => {
    :name => "Snuggle Forever",
    :longname => "Let's Snuggle Forever",
    :function => 0x000,
    :type => :FAIRY,
    :category => :physical,
    :basedamage => 190,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :contact => true,
    :zmove => true,
    :desc => "After obtaining Z-Power, the user, Mimikyu, punches the target with full force."
},

:CLANGOROUSSOULBLAZE => {
    :name => "Clang. Soulblaze",
    :longname => "Clangorous Soulblaze",
    :function => 0x808,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 185,
    :accuracy => 0,
    :maxpp => 0,
    :target => :AllOpposing,
    :soundmove => true,
    :zmove => true,
    :desc => "After obtaining Z-Power, the user, Kommo-o, attacks the opposing Pokémon with full force. This move boosts the user's stats."
},

:SPLINTEREDSTORMSHARDS => {
    :name => "S. Stormshards",
    :longname => "Splintered Stormshards",
    :function => 0x807,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 190,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "     After obtaining Z-Power, the user, Lycanroc, attacks the target with full force. This move negates the effect on the battlefield."
},

:SEARINGSUNRAZESMASH => {
    :name => "S. Sunraze Smash",
    :longname => "Searing Sunraze Smash",
    :function => 0x166,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 200,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :contact => true,
    :zmove => true,
    :desc => "After obtaining Z-Power, the user, Solgaleo, attacks the target with full force. This move can ignore the effect of the target's Ability."
},

:MENACINGMOONRAZEMAELSTROM => {
    :name => "M. M. Maelstrom",
    :longname => "Menacing Moonraze Maelstrom",
    :function => 0x166,
    :type => :GHOST,
    :category => :special,
    :basedamage => 200,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "After obtaining Z-Power, the user, Lunala, attacks the target with full force. This move can ignore the effect of the target's Ability."
},

:LIGHTTHATBURNSTHESKY => {
    :name => "Burning Light",
    :longname => "Light That Burns The Sky",
    :function => 0x176,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 200,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "This attack inflicts Attack or Sp. Atk damage—whichever stat is higher for the user, Necrozma. This move ignores the target's Ability."
},

# Interceptium- Z
:UNLEASHEDPOWER  => {
    :name => "Unleashed Power",
    :function => 0x80A,
    :type => :QMARKS,
    :category => :special,
    :basedamage => 150,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :zmove => true,
    :intercept => true,
    :desc => "Filler"
},

:BLINDINGSPEED => {
    :name => "Blinding Speed",
    :function => 0x80B,
    :type => :QMARKS,
    :category => :physical,
    :basedamage => 80,
    :accuracy => 0,
    :priority => 2,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :intercept => true,
    :desc => "Filler"
},

:ELYSIANSHIELD => {
    :name => "Elysian Shield",
    :function => 0x80C,
    :type => :FAIRY,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 0,
    :target => :User,
    :zmove => true,
    :intercept => true,
    :desc => "Filler"
},

:CHTHONICMALADY => {
    :name => "Chthonic Malady",
    :function => 0x80E,
    :type => :SHADOW,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :bypassprotect => true,
    :zmove => true,
    :intercept => true,
    :desc => "Filler"
},

:DOMAINSHIFT => {
    :name => "Domain Shift",
    :function => 0x80D,
    :type => :QMARKS,
    :category => :status,
    :basedamage => 0,
    :accuracy => 0,
    :maxpp => 0,
    :target => :User,
    :zmove => true,
    :intercept => true,
    :desc => "Filler"
},

# MOVE DUMMIES FOR ANIMATION COMPILATION, PLEASE DEFINE REAL MOVES ABOVE HERE - SINCERELY FAL
:AURAWHEELMINUS => {
    :name => "Aura Wheel ANIMATION",
    :function => 0x186,
    :type => :DARK,
    :category => :physical,
    :basedamage => 110,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Morpeko attacks and raises its Speed with the energy stored in its cheeks. This move's type changes depending on the user's form."
},

:TECHNOBLASTELECTRIC => {
    :name => "Techno Blast ANIMATION",
    :function => 0x09F,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The user fires a beam of light. The move's type changes depending on the Drive the user holds."
},

:TECHNOBLASTFIRE => {
    :name => "Techno Blast ANIMATION",
    :function => 0x09F,
    :type => :FIRE,
    :category => :special,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The user fires a beam of light. The move's type changes depending on the Drive the user holds."
},

:TECHNOBLASTICE => {
    :name => "Techno Blast ANIMATION",
    :function => 0x09F,
    :type => :ICE,
    :category => :special,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The user fires a beam of light. The move's type changes depending on the Drive the user holds."
},

:TECHNOBLASTWATER => {
    :name => "Techno Blast ANIMATION",
    :function => 0x09F,
    :type => :WATER,
    :category => :special,
    :basedamage => 120,
    :accuracy => 100,
    :maxpp => 5,
    :target => :SingleNonUser,
    :desc => "The user fires a beam of light. The move's type changes depending on the Drive the user holds."
},

:MULTIATTACKFIRE => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :FIRE,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKWATER => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :WATER,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKELECTRIC => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKGRASS => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKICE => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :ICE,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKFIGHTING => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :FIGHTING,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKPOISON => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :POISON,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKGROUND => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :GROUND,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKFLYING => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKPSYCHIC => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :PSYCHIC,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKBUG => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :BUG,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKROCK => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :ROCK,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKGHOST => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :GHOST,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKDRAGON => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :DRAGON,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKDARK => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :DARK,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKSTEEL => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKFAIRY => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :FAIRY,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:MULTIATTACKGLITCH => {
    :name => "Multi-Attack ANIMATION",
    :function => 0x09F,
    :type => :QMARKS,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Cloaked in high energy, the user slams the target. The held Memory defines the move's type."
},

:JUDGMENTFIRE => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :FIRE,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTWATER => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :WATER,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTELECTRIC => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :ELECTRIC,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTGRASS => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :GRASS,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTICE => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :ICE,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTFIGHTING => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :FIGHTING,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTPOISON => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :POISON,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTGROUND => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :GROUND,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTFLYING => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :FLYING,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTPSYCHIC => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :PSYCHIC,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTBUG => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :BUG,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTROCK => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :ROCK,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTGHOST => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :GHOST,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTDRAGON => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :DRAGON,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTDARK => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :DARK,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTSTEEL => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :STEEL,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTFAIRY => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:JUDGMENTQMARKS => {
    :name => "Judgment ANIMATION",
    :function => 0x09F,
    :type => :QMARKS,
    :category => :special,
    :basedamage => 100,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "The user releases countless shots of light. This move's type varies depending on the held Plate."
},

:WEATHERBALLSUN => {
    :name => "Weather Ball ANIMATION",
    :function => 0x087,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "An attack move that varies in power and type depending on the weather."
},

:WEATHERBALLRAIN => {
    :name => "Weather Ball ANIMATION",
    :function => 0x087,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "An attack move that varies in power and type depending on the weather."
},

:WEATHERBALLHAIL => {
    :name => "Weather Ball ANIMATION",
    :function => 0x087,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "An attack move that varies in power and type depending on the weather."
},

:WEATHERBALLSAND => {
    :name => "Weather Ball ANIMATION",
    :function => 0x087,
    :type => :NORMAL,
    :category => :special,
    :basedamage => 50,
    :accuracy => 100,
    :maxpp => 10,
    :target => :SingleNonUser,
    :desc => "An attack move that varies in power and type depending on the weather."
},

:ULTRAMEGAHAMMER => {
    :name => "Super U.M.D. Move ANIMATION",
    :longname => "Super Ultra Mega Death Move",
    :function => 0x20D,
    :type => :STEEL,
    :category => :physical,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 20,
    :target => :SingleNonUser,
    :contact => true,
    :desc => "Spicy move"
},

:GUARDIANOFALOLALELE => {
    :name => "Guardian of Alola ANIMATION",
    :function => 0x809,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 1,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user, the Land Spirit Pokémon, obtains Alola's energy using its Z-Power and attacks the target with full force. This reduces the target's HP greatly."
},

:GUARDIANOFALOLABULU => {
    :name => "Guardian of Alola ANIMATION",
    :function => 0x809,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 1,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user, the Land Spirit Pokémon, obtains Alola's energy using its Z-Power and attacks the target with full force. This reduces the target's HP greatly."
},

:GUARDIANOFALOLAFINI => {
    :name => "Guardian of Alola ANIMATION",
    :function => 0x809,
    :type => :FAIRY,
    :category => :special,
    :basedamage => 1,
    :accuracy => 0,
    :maxpp => 0,
    :target => :SingleNonUser,
    :zmove => true,
    :desc => "The user, the Land Spirit Pokémon, obtains Alola's energy using its Z-Power and attacks the target with full force. This reduces the target's HP greatly."
},

:THUNDERRAID2 => {
    :ID => 639,
    :name => "Thunder Raid ANIMATION",
    :function => 0x0BF,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 20,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "Quickly strikes the target up to three times, each hit increasing in power."
},

:THUNDERRAID3 => {
    :ID => 639,
    :name => "Thunder Raid ANIMATION",
    :function => 0x0BF,
    :type => :ELECTRIC,
    :category => :physical,
    :basedamage => 20,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 100,
    :target => :SingleNonUser,
    :desc => "Quickly strikes the target up to three times, each hit increasing in power."
},

### SWU's Moves

# General Moves

:CHAINDRAIN => {
	:ID => 1500,
	:name => "Chain Drain",
	:function => 0x901,
	:type => :FAIRY,
	:category => :special,
	:basedamage => 75,
	:accuracy => 100,
	:maxpp => 10,
	:target => :SingleNonUser,
	:healingmove => true,
	:desc => "The user attacks the target with a life-draining magic, healing itself and all allies."
},

:FLURRY => {
    :ID => 1501,
    :name => "Flurry",
    :function => 0x00C,
    :type => :ICE,
    :category => :status,
    :basedamage => 0,
    :accuracy => 85,
    :maxpp => 15,
    :target => :SingleNonUser,
    :magiccoat => true,
    :desc => "The user sends a flurry of cold at the target, inflicting frostbite."
},

:SUNDAE => {
    :ID => 1502,
    :name => "Sundae",
    :function => 0x00D,
    :type => :ICE,
    :category => :special,
    :basedamage => 90,
    :accuracy => 100,
    :maxpp => 10,
    :effect => 30,
    :target => :AllOpposing,
    :kingrock => true,
    :windmove => true,
	:desc => "The user attacks targets by engulfing them in frozen swirls, which may inflict frostbite."
},

:SQUALL => {
	:ID => 1503,
	:name => "Squall",
	:function => 0x000,
	:type => :FLYING,
	:category => :special,
	:basedamage => 80,
	:accuracy => 100,
	:maxpp => 10,
	:effect => 20,
	:target => :SingleNonUser,
	:kingrock => true,
    :windmove => true,
	:desc => "The user attacks targets with a sheer gust of wind. This move always goes first in the Hail."
},

:SKYDIVE => {
    :ID => 1504,
    :name => "Sky Dive",
    :function => 0x10B,
    :type => :FLYING,
    :category => :physical,
    :basedamage => 130,
    :accuracy => 90,
    :maxpp => 10,
    :target => :SingleNonUser,
    :contact => true,
    :gravityblocked => true,
    :desc => "The target crashes down at the target from the sky. If it misses, the user is hurt instead."
},

:BLOSSOMSTORM => {
	:ID => 1505,
	:name => "Blossom Storm",
	:function => 0x2000,
	:type => :FAIRY,
	:category => :physical,
	:basedamage => 140,
	:accuracy => 100,
	:maxpp => 10,
	:target => :AllOpposing,
	:desc => "Attacks with a torrent of cherry blossom petals at foes. Lowers attack and special defense outside of sun."
},

# NPC Signature Moves 

:ESCAPEROOT => {
    :ID => 1900,
    :name => "Escape Root",
    :function => 0x0EE,
    :type => :GRASS,
    :category => :physical,
    :basedamage => 95,
    :accuracy => 100,
    :maxpp => 20,
    :effect => 100,
    :target => :SingleNonUser,
    :priority => 1,
    :desc => "After making its attack, the user switches places with a party Pokémon in waiting."
},


# Giga Moves

:RESONANCE => {
	:ID => 2000,
	:name => "Resonance",
	:function => 0x1000,
	:type => :ICE,
	:category => :special,
	:basedamage => 110,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
	:target => :SingleNonUser,
	:soundmove => true,
	:desc => "Summons Aurora Veil"
},

:SNOOZE => {
	:ID => 2001,
	:name => "Snooze",
	:function => 0x1001,
	:type => :DARK,
	:category => :physical,
	:basedamage => 110,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
	:target => :SingleNonUser,
	:desc => "Makes target drowsy"
},

:HYDROSNIPE => {
	:ID => 2002,
	:name => "Hydrosnipe",
	:function => 0x179,
	:type => :WATER,
	:category => :special,
	:basedamage => 110,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
	:target => :SingleNonUser,
    # high crit rate handled directly elsewhere
	:desc => "+2 CHR, cannot be redirected. Ignores Abilities"
},

:GIANTSDRUM => {
	:ID => 2003,
	:name => "Giant's Drum",
	:function => 0x000,
	:type => :NORMAL,
	:category => :physical,
	:basedamage => 165,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
	:target => :AllOpposing,
	:soundmove => true,
	:desc => "Ignores Abilities."
},

:WINDRAGE => {
	:ID => 2004,
	:name => "Wind Rage",
	:function => 0x1002,
	:type => :FLYING,
	:category => :physical,
	:basedamage => 130,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
	:target => :AllOpposing,
	:desc => "Clears haards and screens."
},

:HONEYPOT => {
	:ID => 2005,
	:name => "Honeypot",
	:function => 0x1003,
	:type => :BUG,
	:category => :special,
	:basedamage => 140,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
    :effect => 100,
	:target => :SingleNonUser,
	:desc => "Lowers all foes evasion by 1 and cures friendly status."
},

:ACIDROCK => {
	:ID => 2006,
	:name => "Acid Rock",
	:function => 0x007,
	:type => :POISON,
	:category => :special,
	:basedamage => 150,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
    :effect => 100,
    :soundmove => true,
	:target => :AllOpposing,
	:desc => "Paralyzes targets. NVE against steel."
},

:MELTDOWN => {
	:ID => 2007,
	:name => "Meltdown",
	:function => 0x006,
	:type => :STEEL,
	:category => :physical,
	:basedamage => 200,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
    :effect => 100,
	:target => :AllNonUsers,
	:desc => "Badly poisons targets, regardless of typing."
},

:GIGACHARM => {
	:ID => 2008,
	:name => "Giga Charm",
	:function => 0x016,
	:type => :FAIRY,
	:category => :special,
	:basedamage => 150,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
    :effect => 100,
    :soundmove => true,
	:target => :AllOpposing,
	:desc => "Infatuates the target."
},

:WILDFIRE => {
	:ID => 2009,
	:name => "Wildfire",
	:function => 0x1004,
	:type => :FIRE,
	:category => :special,
	:basedamage => 150,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
    :effect => 30,
	:target => :AllOpposing,
	:desc => "Damages opposing team, may burn."
},

:FLAMESTRIKE => {
	:ID => 2010,
	:name => "Flame Strike",
	:function => 0x0AD,
	:type => :FIRE,
	:category => :physical,
	:basedamage => 165,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
	:target => :SingleNonUser,
	:desc => "Ignores Abilities, fully breaks through protect."
},

:GOURMANDIZE => {
	:ID => 2011,
	:name => "Gourmandize",
	:function => 0x112,
	:type => :NORMAL,
	:category => :physical,
	:basedamage => 140,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
    :effect => 100,
	:target => :SingleNonUser,
	:desc => "Gains +1 stockpile after use."
},

:CHISTRIKE => {
	:ID => 2012,
	:name => "Chi Strike",
    # NEED TO UPDATE
	:function => 0x023,
	:type => :FIGHTING,
	:category => :physical,
	:basedamage => 140,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
    :effect => 100,
	:target => :SingleNonUser,
    :highcrit => true,
    :contact => true,
	:desc => "Raises all friendly CHR by +1 after use."
},

:VOLCALITH => {
	:ID => 2013,
	:name => "Volcalith",
	:function => 0x105,
	:type => :ROCK,
	:category => :physical,
	:basedamage => 150,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
    :effect => 100,
	:target => :SingleNonUser,
	:desc => "Summons Volcalith entry hazard."
},

:GRAVITAS => {
	:ID => 2014,
	:name => "Gravitas",
	:function => 0x118,
	:type => :PSYCHIC,
	:category => :special,
	:basedamage => 140,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
    :effect => 100,
	:target => :SingleNonUser,
	:desc => "Summons or extends gravity by 5 turns."
},

:APPLEFALL => {
	:ID => 2015,
	:name => "Applefall",
	:function => 0x1003,
	:type => :BUG,
	:category => :physical,
	:basedamage => 140,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
    :effect => 100,
	:target => :SingleNonUser,
	:desc => "Summons or extends gravity by 5 turns."
},

:STONESURGE => {
	:ID => 2016,
	:name => "Stonesurge",
	:function => 0x105,
	:type => :WATER,
	:category => :physical,
	:basedamage => 150,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
    :effect => 100,
	:target => :SingleNonUser,
	:desc => "Summons Stealth Rock entry hazard."
},

:GOLDRUSH => {
	:ID => 2017,
	:name => "Gold Rush",
	:function => 0x117,
	:type => :STEEL,
	:category => :physical,
	:basedamage => 130,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
	:target => :SingleNonUser,
	:priority => 2,
	:desc => "It's not about the money money money"
},

:CENTIFERNO => {
	:ID => 2018,
	:name => "Centiferno",
	:function => 0x00A,
	:type => :FIRE,
	:category => :special,
	:basedamage => 200,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
    :effect => 100,
	:target => :AllOpposing,
	:desc => "Burns targets."
},

:KINGTIDE => {
	:ID => 2019,
	:name => "King Tide",
	:function => 0x00D,
	:type => :WATER,
	:category => :special,
	:basedamage => 200,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
    :effect => 100,
	:target => :AllOpposing,
	:desc => "Frostbites targets."
},

:SMITE => {
	:ID => 2020,
	:name => "Smite",
	:function => 0x013,
	:type => :FAIRY,
	:category => :special,
	:basedamage => 120,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
    :effect => 100,
	:target => :AllOpposing,
	:desc => "Confuses targets. Power doubles against confused targets."
},

:OVERGROWTH => {
	:ID => 2021,
	:name => "Overgrowth",
	:function => 0x0DC,
	:type => :GRASS,
	:category => :physical,
	:basedamage => 150,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
    :effect => 100,
	:target => :AllOpposing,
	:desc => "Inflicts leech seed on the targets."
},

:VINELASH => {
	:ID => 2022,
	:name => "Vine Lash",
	:function => 0x1006,
	:type => :GRASS,
	:category => :special,
	:basedamage => 150,
	:accuracy => 0,
	:maxpp => 10,
	:giga => true,
    :effect => 30,
	:target => :AllOpposing,
	:desc => "Damages opposing team, may paralyze."
},


# Handlers
:METEORIMPACTOR => {
	:ID => 9999,
	:name => "Meteor Impactor",
	:function => 0x175,
	:type => :ROCK,
	:category => :physical,
	:basedamage => 150,
	:accuracy => 100,
	:maxpp => 16,
	:target => :AllNonUsers,
	:desc => "called for ability" 
},

:ACIDDOWNPOUR2 => {
    :name => "Acid Downpour",
    :function => 0x800,
    :type => :POISON,
    :category => :special,
    :basedamage => 180,
    :accuracy => 0,
    :maxpp => 0,
    :target => :AllOpposing,
    :zmove => true,
    :desc => "The user creates a poisonous swamp using its Z-Power and sinks the target into it at full force. The power varies, depending on the original move."
},

}
