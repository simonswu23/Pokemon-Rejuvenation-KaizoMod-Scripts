FIELDEFFECTS = {
:INDOOR => {
	:name => "",
	:fieldMessage => [
		""
	],
	:graphic => ["Indoor","IndoorA","IndoorB","IndoorC","IndoorD","IndoorE","IndoorVenam","AxisHigh","NightmareSchool"],
	:secretPower => "TRIATTACK",
	:naturePower => :TRIATTACK,
	:mimicry => :NORMAL,	
	:damageMods => { #damage modifiers for specific moves, written as multipliers (e.g. 1.5 => [:TACKLE])
	},				# a damage mod of 0 denotes the move failing on this field
	:accuracyMods => { #accuracy chance for specific moves, written as percent chance to hit (e.g. 80 => [:TOXIC])
	},				# a accuracy mod of 0 denotes the move always hitting on this field
	:moveMessages => {	# the field message displayed when using a move (written as "message" => [move1,move2....] )
	},
	:typeMods => {	# secondary types applied to moves (written as "type" => [move1,move2,....])
	},
	:typeAddOns => { # secondary types applied to entire types (written as SecondaryTypeSymbol => [typesymbol1,typesymbol2,...])
	},
	:moveEffects => { # arbitrary commands that are evaled after a move executes but before fieldchanges are checked
	},	#evaled in "fieldEffectAfterMove" method in the battle class
	:typeBoosts => { # damage multipliers applied to all moves of a specific type (e.g. 1.3 => [:FIRE,:WATER])
	},
	:typeMessages => {	# field message shown when using a move of the denoted type ("message" => [type1,type2,....])
	},
	:typeCondition => {	# conditions for the type boost written as a string of conditions that are evaled later
	},	#evaled as a function on the move class
	:typeEffects => { # arbitrary commands attached to all moves of a type that are evaled after a move executes but before fieldchanges are checked
	},	#evaled in "fieldEffectAfterMove" method in the battle class
	:changeCondition => { # conditions for a field change written as a string of conditions that are evaled later
	},	#evaled as a function on the move class
	:fieldChange => {  # moves that change this field to a different field (Fieldsymbol => [move1,move2,....])
	},
	:dontChangeBackup => [],	#list of moves which store the current field as backup when changing the field
	:changeMessage => {	# message displayed when changing a field to a different one ("message" => [move1,move2,....])
	},
	:statusMods => [],	#list of non-damaging moves boosted by the field in different ways, for field highlighting
	:changeEffects => {#additional effects that happen when specific moves change a field (such as corrisive mist explosion)
	},	#evaled in "fieldEffectAfterMove" method in the battle class
	:seed => {		# the seed effects on this field
		:seedtype => nil,	# which seed is activated
		:effect => nil,		# which battler effect is being changed if any
		:duration => nil,	# duration of the extra effect
		:message => nil,	# message shown with the seeds boost
		:animation => nil,	# animation associated with the effect
		:stats => {			# statchanges caused by the seed
		},
	},
	:overlay => {		# effects of this field as an overlay instead of a full field #Rejuv
		:damageMods => { #damage modifiers for specific moves, written as multipliers (e.g. 1.5 => [:TACKLE])
		},				# a damage mod of 0 denotes the move failing on this field
		:typeMods => {	# secondary types applied to moves (written as "type" => [move1,move2,....])
		},
		:moveMessages => {	# the field message displayed when using a move (written as "message" => [move1,move2....] )
		},
		:typeBoosts => { # damage multipliers applied to all moves of a specific type (e.g. 1.3 => [:FIRE,:WATER])
		},
		:typeMessages => {	# field message shown when using a move of the denoted type ("message" => [type1,type2,....])
		},
		:typeCondition => {	# conditions for the type boost written as a string of conditions that are evaled later
		},	#evaled as a function on the move class
		:statusMods => [],	#list of non-damaging moves boosted by the field in different ways, for field highlighting
	},
},
:ELECTERRAIN => {
	:name => "Electric Terrain",
	:fieldMessage => [
		"The field is hyper-charged!"
	],
	:graphic => ["Electric"],
	:secretPower => "SHOCKWAVE",
	:naturePower => :THUNDERBOLT,
	:mimicry => :ELECTRIC,
	:damageMods => {
		1.5 => [:EXPLOSION, :SELFDESTRUCT, :HURRICANE, :SURF, :SMACKDOWN, :MUDDYWATER, :THOUSANDARROWS, :WINDBOLTSTORM, :PSYBLADE],
		2.0 => [:MAGNETBOMB],
	},
	:accuracyMods => {
	},
	:moveMessages => {
		"The explosion became hyper-charged!" => [:EXPLOSION, :SELFDESTRUCT],
		"The attack became hyper-charged!" => [:HURRICANE, :SURF, :SMACKDOWN, :MUDDYWATER, :THOUSANDARROWS, :WINDBOLTSTORM, :PSYBLADE],
		"The attack powered up!" => [:MAGNETBOMB],
	},
	:typeMods => {
		:ELECTRIC => [:EXPLOSION, :SELFDESTRUCT, :SMACKDOWN, :SURF, :MUDDYWATER, :HURRICANE, :THOUSANDARROWS, :HYDROVORTEX],
	},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:ELECTRIC],
	},
	:typeMessages => {
		"The Electric Terrain strengthened the attack!" => [:ELECTRIC],
	},
	:typeCondition => {
		:ELECTRIC => "!attacker.isAirborne?",
	},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:INDOOR => [:MUDSPORT, :TECTONICRAGE],
	},
	:dontChangeBackup => [:MUDSPORT],
	:changeMessage => {
		 "The hyper-charged terrain shorted out!" => [:MUDSPORT, :TECTONICRAGE],
	},
	:statusMods => [:CHARGE, :EERIEIMPULSE, :MAGNETRISE, :SPIKES, :ELECTRIFY],
	:changeEffects => {},
	:seed => {
		:seedtype => :ELEMENTALSEED,
		:effect => :Charge,
		:duration => 2,
		:message => "{1} began charging power!",
		:animation => :CHARGE,
		:stats => {
			PBStats::SPEED => 1,
		},
	},
	:overlay => {
		:damageMods => {
			1.5 => [:EXPLOSION, :SELFDESTRUCT, :HURRICANE, :SURF, :SMACKDOWN, :MUDDYWATER, :THOUSANDARROWS, :PSYBLADE],
			2.0 => [:MAGNETBOMB],
		},
		:typeMods => {
			:ELECTRIC => [:EXPLOSION, :SELFDESTRUCT, :SMACKDOWN, :SURF, :MUDDYWATER, :HURRICANE, :THOUSANDARROWS],
		},
		:moveMessages => {
			"The explosion became hyper-charged!" => [:EXPLOSION, :SELFDESTRUCT],
			"The attack became hyper-charged!" => [:HURRICANE, :SURF, :SMACKDOWN, :MUDDYWATER, :THOUSANDARROWS, :PSYBLADE],
			"The attack powered up!" => [:MAGNETBOMB],
		},
		:typeBoosts => {
			1.5 => [:ELECTRIC],
		},
		:typeMessages => {
			"The Electric Terrain strengthened the attack!" => [:ELECTRIC],
		},
		:typeCondition => {
			:ELECTRIC => "!attacker.isAirborne?",
		},
		:statusMods => [:MAGNETRISE],
	},
},
:GRASSY => {
	:name => "Grassy Terrain",
	:fieldMessage => [
		"The field is in full bloom."
	],
	:graphic => ["Grassy"],
	:secretPower => "SEEDBOMB",
	:naturePower => :ENERGYBALL,
	:mimicry => :GRASS,
	:damageMods => {
		1.5 => [:FAIRYWIND, :SILVERWIND, :OMINOUSWIND, :ICYWIND, :RAZORWIND, :GUST, :TWISTER, :GRASSKNOT],
		0.5 => [:MUDDYWATER, :SURF, :EARTHQUAKE, :MAGNITUDE, :BULLDOZE],
	},
	:accuracyMods => {
		85 => [:GRASSWHISTLE],
	},
	:moveMessages => {
		"The wind picked up strength from the field!" => [:FAIRYWIND, :SILVERWIND, :OMINOUSWIND, :ICYWIND, :RAZORWIND, :GUST, :TWISTER],
		"The grass strengthened the attack!" => [:GRASSKNOT],
		"The grass softened the attack..." => [:MUDDYWATER, :SURF, :EARTHQUAKE, :MAGNITUDE, :BULLDOZE],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {
		"@battle.field.counter += 1" => [:SURF],
		"@battle.field.counter += 2" => [:MUDDYWATER],
	},
	:typeBoosts => {
		1.5 => [:GRASS, :FIRE],
	},
	:typeMessages => {
		"The Grassy Terrain strengthened the attack!" => [:GRASS],
		"The grass below caught flame!" => [:FIRE],
	},
	:typeCondition => {
		:GRASS => "!attacker.isAirborne?",
		:FIRE => "!opponent.isAirborne?",
	},
	:typeEffects => {},
	:changeCondition => {
		:SWAMP => "@battle.field.counter > 2",
	},
	:fieldChange => {
		:CORROSIVE => [:SLUDGEWAVE, :ACIDDOWNPOUR],
		:SWAMP => [:SURF, :MUDDYWATER],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "The grassy terrain was corroded!" => [:SLUDGEWAVE, :ACIDDOWNPOUR],
		 "The grassy terrain became marshy!" => [:SURF, :MUDDYWATER],
	},
	:statusMods => [:COIL, :GROWTH, :FLORALHEALING, :SYNTHESIS, :WORRYSEED, :INGRAIN, :GRASSWHISTLE, :LEECHSEED, :COTTONSPORE],
	:changeEffects => {},
	:seed => {
		:seedtype => :ELEMENTALSEED,
		:effect => :Ingrain,
		:duration => true,
		:message => "{1} planted its roots!",
		:animation => :INGRAIN,
		:stats => {
			PBStats::DEFENSE => 1,
		},
	},
	:overlay => {
		:damageMods => {
			1.5 => [:FAIRYWIND, :SILVERWIND, :OMINOUSWIND, :ICYWIND, :RAZORWIND, :GUST, :TWISTER],
		},
		:typeMods => {
		},
		:moveMessages => {
			"The wind picked up strength from the field!" => [:FAIRYWIND, :SILVERWIND, :OMINOUSWIND, :ICYWIND, :RAZORWIND, :GUST, :TWISTER],
		},
		:typeBoosts => {
			1.5 => [:GRASS],
		},
		:typeMessages => {
			"The Grassy Terrain strengthened the attack!" => [:GRASS],
		},
		:typeCondition => {
			:GRASS => "!attacker.isAirborne?",
		},
		:statusMods => [],
	},
},
:MISTY => {
	:name => "Misty Terrain",
	:fieldMessage => [
		"Mist settles on the field."
	],
	:graphic => ["Misty"],
	:secretPower => "MISTBALL",
	:naturePower => :MISTBALL,
	:mimicry => :FAIRY,
	:damageMods => {
		1.5 => [:MYSTICALFIRE, :MAGICALLEAF, :DOOMDUMMY, :ICYWIND, :MISTBALL, :AURASPHERE, :STEAMERUPTION, :SILVERWIND, :MOONGEISTBEAM, :SMOG, :CLEARSMOG, :STRANGESTEAM, :SPRINGTIDESTORM],
		0.5 => [:DARKPULSE, :SHADOWBALL, :NIGHTDAZE],
		0 => [:SELFDESTRUCT, :EXPLOSION, :MINDBLOWN],
	},
	:accuracyMods => {
		100 => [:SWEETKISS],
	},
	:moveMessages => {
		"The mist's energy strengthened the attack!" => [:MYSTICALFIRE, :MAGICALLEAF, :DOOMDUMMY, :ICYWIND, :MISTBALL, :AURASPHERE, :STEAMERUPTION, :SILVERWIND, :MOONGEISTBEAM, :SMOG, :CLEARSMOG, :STRANGESTEAM, :SPRINGTIDESTORM],
		"The mist softened the attack..." => [:DARKPULSE, :SHADOWBALL, :NIGHTDAZE],
		"The damp mist prevented the explosion..." => [:SELFDESTRUCT, :EXPLOSION, :MINDBLOWN],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {
		"@battle.field.counter += 1" => [:CLEARSMOG, :SMOG, :POISONGAS],
		"@battle.field.counter = 2" => [:ACIDDOWNPOUR],
	},
	:typeBoosts => {
		1.5 => [:FAIRY],
		0.5 => [:DRAGON],
	},
	:typeMessages => {
		"The Misty Terrain strengthened the attack!" => [:FAIRY],
		"The Misty Terrain weakened the attack!" => [:DRAGON],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {
		:CORROSIVEMIST => "@battle.field.counter > 1",
	},
	:fieldChange => {
		:INDOOR => [:WHIRLWIND, :GUST, :RAZORWIND, :DEFOG, :HURRICANE, :TWISTER, :TAILWIND, :SUPERSONICSKYSTRIKE],
		:CORROSIVEMIST => [:CLEARSMOG, :SMOG, :POISONGAS, :ACIDDOWNPOUR]
	},
	:dontChangeBackup => [:CLEARSMOG, :SMOG, :POISONGAS, :ACIDDOWNPOUR],
	:changeMessage => {
		 "The mist was blown away!" => [:WHIRLWIND, :GUST, :RAZORWIND, :DEFOG, :HURRICANE, :TWISTER, :TAILWIND, :SUPERSONICSKYSTRIKE],
		 "The mist was corroded!" => [:CLEARSMOG, :SMOG, :POISONGAS, :ACIDDOWNPOUR],
	},
	:statusMods => [:COSMICPOWER, :AROMATICMIST, :SWEETSCENT, :WISH, :AQUARING],
	:changeEffects => {},
	:seed => {
		:seedtype => :ELEMENTALSEED,
		:effect => nil,
		:duration => 0,
		:message => nil,
		:animation => nil,
		:stats => {
			PBStats::SPDEF => 1,
		},
	},
	:overlay => {
		:damageMods => {
			1.5 => [:MYSTICALFIRE, :MAGICALLEAF, :DOOMDUMMY, :ICYWIND, :MISTBALL, :AURASPHERE, :STEAMERUPTION, :SILVERWIND, :MOONGEISTBEAM, :SMOG, :CLEARSMOG, :STRANGESTEAM],
		},
		:typeMods => {
		},
		:moveMessages => {
			"The mist's energy strengthened the attack!" => [:MYSTICALFIRE, :MAGICALLEAF, :DOOMDUMMY, :ICYWIND, :MISTBALL, :AURASPHERE, :STEAMERUPTION, :SILVERWIND, :MOONGEISTBEAM, :SMOG, :CLEARSMOG, :STRANGESTEAM],
		},
		:typeBoosts => {
			1.5 => [:FAIRY],
		},
		:typeMessages => {
			"The Misty Terrain strengthened the attack!" => [:FAIRY],
		},
		:typeCondition => {
		},
		:statusMods => [],
	},
},
:DARKCRYSTALCAVERN => {
	:name => "Dark Crystal Cavern",
	:fieldMessage => [
		"Darkness is gathering..."
	],
	:graphic => ["DarkCrystalCavern"],
	:secretPower => "DARKPULSE",
	:naturePower => :DARKPULSE,
	:mimicry => :DARK,
	:damageMods => {
		1.5 => [:DARKPULSE, :NIGHTDAZE, :NIGHTSLASH, :SHADOWBALL, :SHADOWPUNCH, :SHADOWCLAW, :SHADOWSNEAK, :SHADOWFORCE, :SHADOWBONE, :AURORABEAM, :SIGNALBEAM, :FLASHCANNON, :LUSTERPURGE, :DAZZLINGGLEAM, :MIRRORSHOT, :MIRRORBEAM, :TECHNOBLAST, :DOOMDUMMY, :POWERGEM, :MOONGEISTBEAM, :PHOTONGEYSER, :DIAMONDSTORM, :MENACINGMOONRAZEMAELSTROM, :BLACKHOLEECLIPSE],
		2.0 => [:PRISMATICLASER],
		0.5 => [:LIGHTTHATBURNSTHESKY],
	},
	:accuracyMods => {
		100 => [:DARKVOID],
	},
	:moveMessages => {
		"The darkness began to gather...!" => [:DARKPULSE, :NIGHTDAZE, :NIGHTSLASH],
		"The darkness strengthened the attack!" => [:SHADOWBALL, :SHADOWPUNCH, :SHADOWCLAW, :SHADOWSNEAK, :SHADOWFORCE, :SHADOWBONE, :MENACINGMOONRAZEMAELSTROM],
		"The crystals' light strengthened the attack!" => [:AURORABEAM, :SIGNALBEAM, :FLASHCANNON, :LUSTERPURGE, :DAZZLINGGLEAM, :MIRRORSHOT, :MIRRORBEAM, :TECHNOBLAST, :DOOMDUMMY, :POWERGEM, :MOONGEISTBEAM, :PHOTONGEYSER, :DIAMONDSTORM],
		"The crystal split the attack!" => [:PRISMATICLASER],
		"The consuming darkness fed the attack!" => [:BLACKHOLEECLIPSE],
		"{1} couldn't consume much light..." => [:LIGHTTHATBURNSTHESKY],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {},
	:typeMessages => {},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {
		:CRYSTALCAVERN => "suncheck",
		:CAVE => "@battle.field.counter > 1",
	},
	:fieldChange => {
		:CAVE => [:EARTHQUAKE, :BULLDOZE, :MAGNITUDE, :FISSURE, :TECTONICRAGE],
		:CRYSTALCAVERN => [:SUNNYDAY],
	},
	:dontChangeBackup => [:SUNNYDAY],
	:changeMessage => {
		 "The dark crystals were shattered!" => [:EARTHQUAKE, :BULLDOZE, :MAGNITUDE, :FISSURE, :TECTONICRAGE],
		 "The sun lit up the crystal cavern!" => [:SUNNYDAY],
	},
	:statusMods => [:FLASH, :DARKVOID, :MOONLIGHT, :AURORAVEIL],
	:changeEffects => {},
	:seed => {
		:seedtype => :MAGICALSEED,
		:effect => :MagicCoat,
		:duration => true,
		:message => "{1} shrouded itself with Magic Coat!",
		:animation => :MAGICCOAT,
		:stats => {
			PBStats::SPDEF => 1,
		},
	},
},
:CHESS => {
	:name => "Chess Board",
	:fieldMessage => [
		"Opening variation set."
	],
	:graphic => ["Chess","Chess1"],
	:secretPower => "FEINT",
	:naturePower => :ANCIENTPOWER,
	:mimicry => :PSYCHIC,
	:damageMods => {
		1.5 => [:FEINT, :FEINTATTACK, :FAKEOUT, :SUCKERPUNCH, :FIRSTIMPRESSION, :SHADOWSNEAK, :SMARTSTRIKE, :STRENGTH, :ANCIENTPOWER, :PSYCHIC, :CONTINENTALCRUSH, :SECRETPOWER, :SHATTEREDPSYCHE],
		2.0 => [:BARRAGE],
	},
	:accuracyMods => {},
	:moveMessages => {
		"En passant!" => [:FEINT, :FEINTATTACK, :FAKEOUT, :SUCKERPUNCH, :FIRSTIMPRESSION, :SHADOWSNEAK, :SMARTSTRIKE],
	},
	:typeMods => {
		:ROCK => [:STRENGTH, :ANCIENTPOWER, :PSYCHIC, :BARRAGE, :SECRETPOWER, :SHATTEREDPSYCHE],
	},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {},
	:typeMessages => {},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {},
	:dontChangeBackup => [],
	:changeMessage => {},
	:statusMods => [:CALMMIND, :NASTYPLOT, :TRICKROOM, :NORETREAT, :KINGSSHIELD, :OBSTRUCT],
	:changeEffects => {},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => :MagicCoat,
		:duration => true,
		:message => "{1} shrouded itself with Magic Coat!",
		:animation => :MAGICCOAT,
		:stats => {
			PBStats::SPATK => 1,
		},
	},
},
:BIGTOP => {
	:name => "Big Top Arena",
	:fieldMessage => [
		"Now presenting...!"
	],
	:graphic => ["BigTop"],
	:secretPower => "DYNAMICPUNCH",
	:naturePower => :ACROBATICS,
	:mimicry => :FIGHTING,
	:damageMods => {
		1.5 => [:VINEWHIP, :POWERWHIP, :FIRELASH, :FIERYDANCE, :PETALDANCE, :REVELATIONDANCE, :FLY, :ACROBATICS, :FIRSTIMPRESSION, :DRUMBEATING],
		2.0 => [:PAYDAY],
	},
	:accuracyMods => {
		100 => [:SING],
	},
	:moveMessages => {
		"Back, foul beast!" => [:VINEWHIP, :POWERWHIP, :FIRELASH],
		"What grace!" => [:FIERYDANCE, :PETALDANCE, :REVELATIONDANCE],
		"An extravagant aerial finish!" => [:FLY, :ACROBATICS],
		"And what an entrance it is!" => [:FIRSTIMPRESSION],
		"And a little extra for you, darling!" => [:PAYDAY],
		"Loud and clear!" => [:DRUMBEATING],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {},
	:typeMessages => {},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {},
	:dontChangeBackup => [],
	:changeMessage => {},
	:statusMods => [:ENCORE, :DRAGONDANCE, :QUIVERDANCE, :SWORDSDANCE, :FEATHERDANCE, :SING, :RAINDANCE, :BELLYDRUM, :SPOTLIGHT, :AQUABATICS, :CLANGOROUSSOUL],
	:changeEffects => {},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => :HelpingHand,
		:duration => true,
		:message => "{1} accepts the crowd's help!",
		:animation => :HELPINGHAND,
		:stats => {
			PBStats::ATTACK => 1,
			PBStats::DEFENSE => 1,
		},
	},
},
:VOLCANIC => {
	:name => "Volcanic Field",
	:fieldMessage => [
		"The field is molten!"
	],
	:graphic => ["Volcano"],
	:secretPower => "FLAMETHROWER",
	:naturePower => :FLAMETHROWER,
	:mimicry => :FIRE,
	:damageMods => {
		2.0 => [:SMOG, :CLEARSMOG],
		1.5 => [:SMACKDOWN, :THOUSANDARROWS, :ROCKSLIDE, :INFERNALPARADE],
		0 => [:HAIL],
	},
	:accuracyMods => {
		100 => [:WILLOWISP],
	},
	:moveMessages => {
		"The flames spread from the attack!" => [:SMOG, :CLEARSMOG, :INFERNALPARADE],
		"{1} was knocked into the flames!" => [:SMACKDOWN, :THOUSANDARROWS, :ROCKSLIDE],
		"The " + HAILSNOWLOWMOD + " melted away." => [:HAIL],
	},
	:typeMods => {
		:FIRE => [:SMACKDOWN, :SMOG, :CLEARSMOG, :THOUSANDARROWS, :ROCKSLIDE],
	},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:FIRE],
		0.5 => [:GRASS, :ICE],
	},
	:typeMessages => {
		"The blaze amplified the attack!" => [:FIRE],
		"The blaze softened the attack..." => [:GRASS, :ICE],
	},
	:typeCondition => {
		:FIRE => "!attacker.isAirborne?",
		:GRASS => "!opponent.isAirborne?",
	},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:CAVE => [:WHIRLWIND, :GUST, :RAZORWIND, :DEFOG, :HURRICANE, :TWISTER, :TAILWIND, :SUPERSONICSKYSTRIKE, :WATERSPORT, :SURF, :MUDDYWATER, :WATERSPOUT, :WATERPLEDGE, :SPARKLINGARIA, :SLUDGEWAVE, :SANDTOMB, :CONTINENTALCRUSH, :HYDROVORTEX, :OCEANICOPERETTA],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "The grime snuffed out the flame!" => [:SLUDGEWAVE],
		 "The wind snuffed out the flame!" => [:WHIRLWIND, :GUST, :RAZORWIND, :DEFOG, :HURRICANE, :TWISTER, :TAILWIND, :SUPERSONICSKYSTRIKE],
		 "The water snuffed out the flame!" => [:WATERSPORT, :SURF, :MUDDYWATER, :WATERSPOUT, :WATERPLEDGE, :SPARKLINGARIA, :HYDROVORTEX, :OCEANICOPERETTA],
		 "The sand snuffed out the flame!" => [:SANDTOMB, :CONTINENTALCRUSH],
	},
	:statusMods => [:WILLOWISP, :SMOKESCREEN],
	:changeEffects => {},
	:seed => {
		:seedtype => :ELEMENTALSEED,
		:effect => :MultiTurnAttack,
		:duration => :FIRESPIN,
		:message => "{1} was trapped in the vortex!",
		:animation => :FIRESPIN,
		:stats => {
			PBStats::ATTACK => 1,
			PBStats::SPATK => 1,
			PBStats::SPEED => 1,
		},
	},
},
:SWAMP => {
	:name => "Swamp Field",
	:fieldMessage => [
		"The field is swamped."
	],
	:graphic => ["Swamp"],
	:secretPower => "MUDDYWATER",
	:naturePower => :MUDDYWATER,
	:mimicry => :WATER,
	:damageMods => {
		1.5 => [:MUDBOMB, :MUDSHOT, :MUDSLAP, :MUDBARRAGE, :MUDDYWATER, :SLUDGEWAVE, :GUNKSHOT, :BRINE, :SMACKDOWN, :THOUSANDARROWS, :HYDROVORTEX, :SAVAGESPINOUT, :HONEYPOT],
		1.3 => [:GRASSYGLIDE],
		0.25 => [:EARTHQUAKE, :MAGNITUDE, :BULLDOZE],
		0 => [:SELFDESTRUCT, :EXPLOSION, :MINDBLOWN]
	},
	:accuracyMods => {
		100 => [:SLEEPPOWDER, :STUNSPORE, :POISONPOWDER],
	},
	:moveMessages => {
		"The murk strengthened the attack!" => [:MUDBOMB, :MUDSHOT, :MUDSLAP, :MUDBARRAGE, :MUDDYWATER, :SLUDGEWAVE, :GUNKSHOT, :BRINE, :SMACKDOWN, :THOUSANDARROWS, :HYDROVORTEX],
		"The attack dissipated in the soggy ground..." => [:EARTHQUAKE, :MAGNITUDE, :BULLDOZE],
		"The dampness prevents the explosion!" => [:SELFDESTRUCT, :EXPLOSION, :MINDBLOWN],
		"There are bugs EVERYWHERE!" => [:SAVAGESPINOUT, :HONEYPOT],
		"The attack gained speed across the swamp slick!" => [:GRASSYGLIDE],
	},
	:typeMods => {
		:WATER => [:SMACKDOWN, :THOUSANDARROWS],
	},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:BUG],
		1.3 => [:WATER,:GRASS],
		0.5 => [:FIRE],
	},
	:typeMessages => {
		"Bugs are swarming everywhere!" => [:BUG],
		"The dampness strengthened the attack!" => [:WATER],
		"Thick mangroves line the area!" => [:GRASS],
		"The dampness weakened the flame..." => [:FIRE],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {},
	:dontChangeBackup => [],
	:changeMessage => {},
	:statusMods => [:SLEEPPOWDER, :STUNSPORE, :POISONPOWDER, :AQUARING, :STRENGTHSAP, :LEECHSEED, :STRINGSHOT, :SPIDERWEB],
	:changeEffects => {},
	:seed => {
		:seedtype => :TELLURICSEED,
		:effect => nil,
		:duration => nil,
		:message => "{1}'s body became clear!",
		:animation => :ROCKPOLISH,
		:stats => {
			PBStats::DEFENSE => 1,
		},
	},
},
:RAINBOW => {
	:name => "Rainbow Field",
	:fieldMessage => [
		"What does it mean?"
	],
	:graphic => ["Rainbow"],
	:secretPower => "AURORABEAM",
	:naturePower => :AURORABEAM,
	:mimicry => :DRAGON,
	:damageMods => {
		1.5 => [:SILVERWIND, :MYSTICALFIRE, :DRAGONPULSE, :TRIATTACK, :SACREDFIRE, :FIREPLEDGE, :WATERPLEDGE, :GRASSPLEDGE, :AURORABEAM, :MIRRORBEAM, :JUDGMENT, :RELICSONG, :HIDDENPOWER, :SECRETPOWER, :WEATHERBALL, :MISTBALL, :HEARTSTAMP, :MOONBLAST, :ZENHEADBUTT, :SPARKLINGARIA, :FLEURCANNON, :PRISMATICLASER, :TWINKLETACKLE, :OCEANICOPERETTA, :SOLARBEAM, :SOLARBLADE, :DAZZLINGGLEAM, :HIDDENPOWERNOR, :HIDDENPOWERFIR, :HIDDENPOWERFIG, :HIDDENPOWERWAT, :HIDDENPOWERFLY, :HIDDENPOWERGRA, :HIDDENPOWERPOI, :HIDDENPOWERELE, :HIDDENPOWERGRO, :HIDDENPOWERPSY, :HIDDENPOWERROC, :HIDDENPOWERICE, :HIDDENPOWERBUG, :HIDDENPOWERDRA, :HIDDENPOWERGHO, :HIDDENPOWERDAR, :HIDDENPOWERSTE, :HIDDENPOWERFAI],
		0.5 => [:DARKPULSE, :SHADOWBALL, :NIGHTDAZE, :NEVERENDINGNIGHTMARE],
		0 => [:NIGHTMARE]
	},
	:accuracyMods => {},
	:moveMessages => {
		"The attack was rainbow-charged!" => [:SILVERWIND, :MYSTICALFIRE, :DRAGONPULSE, :TRIATTACK, :SACREDFIRE, :FIREPLEDGE, :WATERPLEDGE, :GRASSPLEDGE, :AURORABEAM, :MIRRORBEAM, :JUDGMENT, :RELICSONG, :HIDDENPOWER, :SECRETPOWER, :WEATHERBALL, :MISTBALL, :HEARTSTAMP, :MOONBLAST, :ZENHEADBUTT, :SPARKLINGARIA, :FLEURCANNON, :PRISMATICLASER, :TWINKLETACKLE, :OCEANICOPERETTA, :SOLARBEAM, :SOLARBLADE, :DAZZLINGGLEAM, :HIDDENPOWERNOR, :HIDDENPOWERFIR, :HIDDENPOWERFIG, :HIDDENPOWERWAT, :HIDDENPOWERFLY, :HIDDENPOWERGRA, :HIDDENPOWERPOI, :HIDDENPOWERELE, :HIDDENPOWERGRO, :HIDDENPOWERPSY, :HIDDENPOWERROC, :HIDDENPOWERICE, :HIDDENPOWERBUG, :HIDDENPOWERDRA, :HIDDENPOWERGHO, :HIDDENPOWERDAR, :HIDDENPOWERSTE, :HIDDENPOWERFAI],
		"The rainbow softened the attack..." => [:DARKPULSE, :SHADOWBALL, :NIGHTDAZE, :NEVERENDINGNIGHTMARE],
		"The rainbow ensures good dreams." => [:NIGHTMARE]
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:NORMAL],
	},
	:typeMessages => {
		"The rainbow energized the attack!" => [:NORMAL],
	},
	:typeCondition => {
		:NORMAL => "self.pbIsSpecial?(type)",
	},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:INDOOR => [:LIGHTTHATBURNSTHESKY],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "The rainbow was consumed!" => [:LIGHTTHATBURNSTHESKY],
	},
	:statusMods => [:COSMICPOWER, :MEDITATE, :WISH, :LIFEDEW, :AURORAVEIL],
	:changeEffects => {},
	:seed => {
		:seedtype => :MAGICALSEED,
		:effect => nil,
		:duration => 0,
		:message => nil,
		:animation => nil,
		:stats => {
			PBStats::SPATK => 1,
		},
	},
	:overlay => {
		:damageMods => {
		},
		:typeMods => {
		},
		:moveMessages => {
		},
		:typeBoosts => {
		},
		:typeMessages => {
		},
		:typeCondition => {
		},
		:statusMods => [],
	},
},
:CORROSIVE => {
	:name => "Corrosive Field",
	:fieldMessage => [
		"The field is corrupted!"
	],
	:graphic => ["Poison"],
	:secretPower => "ACID",
	:naturePower => :ACIDSPRAY,
	:mimicry => :POISON,
	:damageMods => {
		1.5 => [:SMACKDOWN, :MUDSLAP, :MUDSHOT, :MUDBOMB, :MUDDYWATER, :WHIRLPOOL, :THOUSANDARROWS, :APPLEACID],
		2.0 => [:ACID, :ACIDSPRAY, :GRASSKNOT, :SNAPTRAP],
	},
	:accuracyMods => {
		100 => [:POISONPOWDER, :SLEEPPOWDER, :STUNSPORE, :TOXIC],
	},
	:moveMessages => {
		"The corrosion strengthened the attack!" => [:SMACKDOWN, :MUDSLAP, :MUDSHOT, :MUDBOMB, :MUDDYWATER, :WHIRLPOOL, :THOUSANDARROWS, :APPLEACID, :ACID, :ACIDSPRAY, :GRASSKNOT, :SNAPTRAP],
	},
	:typeMods => {
		:POISON => [:SMACKDOWN, :MUDSLAP, :MUDSHOT, :MUDDYWATER, :WHIRLPOOL, :MUDBOMB, :THOUSANDARROWS, :APPLEACID],
	},
	:typeAddOns => {
		:POISON => [:GRASS],
	},
	:moveEffects => {},
	:typeBoosts => {},
	:typeMessages => {},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:GRASSY => [:SEEDFLARE, :PURIFY],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "The polluted field was purified!" => [:SEEDFLARE, :PURIFY],
	},
	:statusMods => [:ACIDARMOR, :POISONPOWDER, :SLEEPPOWDER, :STUNSPORE, :TOXIC, :VENOMDRENCH],
	:changeEffects => {},
	:seed => {
		:seedtype => :TELLURICSEED,
		:effect => :Protect,
		:duration => :BanefulBunker,
		:message => "The Telluric Seed shielded {1} against damage!",
		:animation => :BANEFULBUNKER,
		:stats => {
		},
	},
},
:CORROSIVEMIST => {
	:name => "Corrosive Mist Field",
	:fieldMessage => [
		"Corrosive mist settles on the field!"
	],
	:graphic => ["CorrosiveMist"],
	:secretPower => "ACIDSPRAY",
	:naturePower => :VENOSHOCK,
	:mimicry => :POISON,
	:damageMods => {
		1.5 => [:BUBBLEBEAM, :ACIDSPRAY, :BUBBLE, :SMOG, :CLEARSMOG, :SPARKLINGARIA],
	},
	:accuracyMods => {
		100 => [:TOXIC],
	},
	:moveMessages => {
		"The poison strengthened the attack!" => [:BUBBLEBEAM, :ACIDSPRAY, :BUBBLE, :SMOG, :CLEARSMOG, :SPARKLINGARIA, :APPLEACID],
	},
	:typeMods => {
		:POISON => [:BUBBLE, :BUBBLEBEAM, :ENERGYBALL, :SPARKLINGARIA, :APPLEACID],
	},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:FIRE],
	},
	:typeMessages => {
		"The toxic mist caught flame!" => [:FIRE],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:INDOOR => [:WHIRLWIND, :GUST, :RAZORWIND, :DEFOG, :HURRICANE, :TWISTER, :TAILWIND, :SUPERSONICSKYSTRIKE, :HEATWAVE, :ERUPTION, :SEARINGSHOT, :FLAMEBURST, :LAVAPLUME, :FIREPLEDGE, :MINDBLOWN, :INCINERATE, :INFERNOOVERDRIVE, :SELFDESTRUCT, :EXPLOSION],
		:MISTY => [:SEEDFLARE],
		:CORROSIVE => [:GRAVITY],
	},
	:dontChangeBackup => [:GRAVITY],
	:changeMessage => {
		 "The mist was blown away!" => [:WHIRLWIND, :GUST, :RAZORWIND, :DEFOG, :HURRICANE, :TWISTER, :TAILWIND, :SUPERSONICSKYSTRIKE],
		 "The polluted mist was purified!" => [:SEEDFLARE],
		 "The toxic mist collected on the ground!" => [:GRAVITY],
	},
	:statusMods => [:ACIDARMOR, :SMOKESCREEN, :VENOMDRENCH, :TOXIC],
	:changeEffects => {
		"@battle.mistExplosion(basemove, user)" => [:HEATWAVE, :ERUPTION, :SEARINGSHOT, :FLAMEBURST, :LAVAPLUME, :FIREPLEDGE, :MINDBLOWN, :INCINERATE, :INFERNOOVERDRIVE, :SELFDESTRUCT, :EXPLOSION],
	},
	:seed => {
		:seedtype => :ELEMENTALSEED,
		:effect => nil,
		:duration => 0,
		:message => nil,
		:animation => nil,
		:stats => {
			PBStats::ATTACK => 1,
			PBStats::SPATK => 1,
		},
	},
},
:DESERT => {
	:name => "Desert Field",
	:fieldMessage => [
		"The field is rife with sand."
	],
	:graphic => ["Desert","Desert2","Desert3","DesertNight","DesertEve"],
	:secretPower => "SANDTOMB",
	:naturePower => :SANDTOMB,
	:mimicry => :GROUND,
	:damageMods => {
		1.5 => [:NEEDLEARM, :PINMISSILE, :DIG, :SANDTOMB, :HEATWAVE, :THOUSANDWAVES, :BURNUP, :SEARINGSUNRAZESMASH, :SOLARBLADE, :SOLARBEAM, :SCALD, :STEAMERUPTION, :SANDSEARSTORM,:BONECLUB, :BONERUSH, :BONEMERANG, :SHADOWBONE,:SCORCHINGSANDS],
		0 => [:SOAK, :AQUARING, :LIFEDEW],
	},
	:accuracyMods => {},
	:moveMessages => {
		"The desert strengthened the attack!" => [:NEEDLEARM, :PINMISSILE, :DIG, :SANDTOMB, :HEATWAVE, :THOUSANDWAVES, :BURNUP, :SEARINGSUNRAZESMASH, :SOLARBLADE, :SOLARBEAM, :SCALD, :STEAMERUPTION, :SANDSEARSTORM, :SCORCHINGSANDS],
		"The lifeless desert strengthened the attack!" => [:BONECLUB, :BONERUSH, :BONEMERANG, :SHADOWBONE],
		"The desert is too dry..." => [:SOAK, :AQUARING, :LIFEDEW],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		0.5 => [:WATER, :ELECTRIC],
	},
	:typeMessages => {
		"The desert softened the attack..." => [:WATER, :ELECTRIC],
	},
	:typeCondition => {
		:WATER => "!attacker.isAirborne? && self.move!=:SCALD && self.move!=:STEAMERUPTION",
		:ELECTRIC => "!opponent.isAirborne?",
	},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {},
	:dontChangeBackup => [],
	:changeMessage => {},
	:statusMods => [:SANDSTORM, :SUNNYDAY, :SANDATTACK, :SHOREUP, :ARENITEWALL],
	:changeEffects => {},
	:seed => {
		:seedtype => :TELLURICSEED,
		:effect => :MultiTurnAttack,
		:duration => :SANDTOMB,
		:message => "{1} was trapped by Sand Tomb!",
		:animation => :SANDTOMB,
		:stats => {
			PBStats::DEFENSE => 1,
			PBStats::SPDEF => 1,
			PBStats::SPEED => 1,
		},
	},
},
:ICY => {
	:name => "Icy Field",
	:fieldMessage => [
		"The field is covered in ice."
	],
	:graphic => ["Icy"],
	:secretPower => "ICESHARD",
	:naturePower => :ICEBEAM,
	:mimicry => :ICE,
	:damageMods => {
		1.5 => [:BITTERMALICE],
		0.5 => [:SCALD, :STEAMERUPTION],
	},
	:accuracyMods => {},
	:moveMessages => {
		"The cold strengthened the attack!" => [:BITTERMALICE],
		"The cold softened the attack..." => [:SCALD, :STEAMERUPTION],
	},
	:typeMods => {},
	:typeAddOns => {
		:ICE => [:ROCK],
	},
	:moveEffects => {
		"@battle.iceSpikes" => [:EARTHQUAKE, :BULLDOZE, :MAGNITUDE, :FISSURE, :TECTONICRAGE],
		"@battle.field.counter += 1" => [:SCALD],
		"@battle.field.counter = 2" => [:STEAMERUPTION],
	},
	:typeBoosts => {
		1.5 => [:ICE],
		0.5 => [:FIRE],
	},
	:typeMessages => {
		"The cold strengthened the attack!" => [:ICE],
		"The cold softened the attack..." => [:FIRE],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {
		:INDOOR => "[:WATERSURFACE,:MURKWATERSURFACE].include?(@battle.field.backup) && (self.move!=:DIVE || @battle.field.counter == 3)",
		:WATERSURFACE => "@battle.field.counter > 1",
	},
	:fieldChange => {
		:INDOOR => [:DIVE, :EARTHQUAKE, :BULLDOZE, :MAGNITUDE, :FISSURE, :TECTONICRAGE],
		:CAVE => [:HEATWAVE, :ERUPTION, :SEARINGSHOT, :FLAMEBURST, :LAVAPLUME, :FIREPLEDGE, :MINDBLOWN, :INCINERATE, :INFERNOOVERDRIVE, :MAGMADRIFT, :RAGINGFURY],
		:WATERSURFACE => [:SCALD, :STEAMERUPTION],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		"The ice was broken from underneath!" => [:DIVE],
		"The quake broke up the ice and revealed the water beneath!" => [:EARTHQUAKE, :BULLDOZE, :MAGNITUDE, :FISSURE, :TECTONICRAGE],
		"The ice melted away!" => [:HEATWAVE, :ERUPTION, :SEARINGSHOT, :FLAMEBURST, :LAVAPLUME, :FIREPLEDGE, :MINDBLOWN, :INCINERATE, :INFERNOOVERDRIVE, :MAGMADRIFT, :RAGINGFURY],
		"The hot water melted the ice!" => [:SCALD, :STEAMERUPTION],
	},
	:statusMods => [:HAIL, :AURORAVEIL],
	:changeEffects => {},
	:seed => {
		:seedtype => :ELEMENTALSEED,
		:effect => nil,
		:duration => 0,
		:message => nil,
		:animation => nil,
		:stats => {
			PBStats::SPEED => 2,
		},
	},
},
:ROCKY => {
	:name => "Rocky Field",
	:fieldMessage => [
		"The field is littered with rocks."
	],
	:graphic => ["Rocky"],
	:secretPower => "ROCKTHROW",
	:naturePower => :ROCKSMASH,
	:mimicry => :ROCK,
	:damageMods => {
		1.5 => [:ROCKCLIMB, :STRENGTH, :MAGNITUDE, :EARTHQUAKE, :BULLDOZE, :ACCELEROCK],
		2.0 => [:ROCKSMASH],
	},
	:accuracyMods => {},
	:moveMessages => {
		"The rocks strengthened the attack!" => [:ROCKCLIMB, :STRENGTH, :MAGNITUDE, :EARTHQUAKE, :BULLDOZE, :ACCELEROCK],
		"SMASH'D!" => [:ROCKSMASH],
	},
	:typeMods => {
		:ROCK => [:ROCKCLIMB, :EARTHQUAKE, :MAGNITUDE, :STRENGTH, :BULLDOZE],
	},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:ROCK],
	},
	:typeMessages => {
		"The field strengthened the attack!" => [:ROCK],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {},
	:dontChangeBackup => [],
	:changeMessage => {},
	:statusMods => [:ROCKPOLISH, :SANDSTORM, :ARENITEWALL, :STEALTHROCK],
	:changeEffects => {},
	:seed => {
		:seedtype => :TELLURICSEED,
		:effect => nil,
		:duration => 0,
		:message => nil,
		:animation => nil,
		:stats => {
			PBStats::DEFENSE => 1,
			PBStats::SPDEF => 1,
		},
	},
},
:FOREST => {
	:name => "Forest Field",
	:fieldMessage => [
		"The field is abound with trees."
	],
	:graphic => ["Forest","GoldForest","ForestCave"],
	:secretPower => "WOODHAMMER",
	:naturePower => :WOODHAMMER,
	:mimicry => :BUG,
	:damageMods => {
		0.5 => [:SURF, :MUDDYWATER],
		1.5 => [:TRAILBLAZE, :SLASHANDBURN, :GRAVAPPLE, :ATTACKORDER, :ELECTROWEB, :SLASH, :AIRSLASH, :GALESTRIKE, :FURYCUTTER, :AIRCUTTER, :PSYCHOCUT, :BREAKINGSWIPE],
		2.0 => [:CUT],
	},
	:accuracyMods => {
		85 => [:GRASSWHISTLE],
	},
	:moveMessages => {
		"The forest softened the attack..." => [:SURF, :MUDDYWATER],
		"They're coming out of the woodwork!" => [:ATTACKORDER],
		"Gossamer and arbor strengthened the attack!" => [:ELECTROWEB],
		"The apple did not fall far from the tree" => [:GRAVAPPLE],
		"A tree slammed down!" => [:CUT, :SLASH, :AIRSLASH, :GALESTRIKE, :FURYCUTTER, :AIRCUTTER, :PSYCHOCUT, :BREAKINGSWIPE],
		"Clear the path!" => [:SLASHANDBURN, :TRAILBLAZE],
	},
	:typeMods => {
		:GRASS => [:CUT, :SLASH, :AIRSLASH, :GALESTRIKE, :FURYCUTTER, :AIRCUTTER, :PSYCHOCUT, :BREAKINGSWIPE],
	},
	:typeAddOns => {},
	:moveEffects => {
		"@battle.field.counter += 1" => [:SURF],
		"@battle.field.counter += 2" => [:MUDDYWATER],
	},
	:typeBoosts => {
		1.5 => [:BUG, :GRASS],
		0.5 => [:FLYING],
	},
	:typeMessages => {
		"The attack spread throughout the forest!" => [:BUG],
		"The forestry strengthened the attack!" => [:GRASS],
		"The dense forest canopy blocked the attack!" => [:FLYING],
	},
	:typeCondition => {
		:BUG => "self.pbIsSpecial?(type)",
		:FLYING => "self.contactMove?",
	},
	:typeEffects => {},
	:changeCondition => {
		:SWAMP => "@battle.field.counter > 2",
	},
	:fieldChange => {
		:SWAMP => [:SURF, :MUDDYWATER],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		"The forest became marshy!" => [:SURF, :MUDDYWATER],
	},
	:statusMods => [:STICKYWEB, :DEFENDORDER, :GROWTH, :STRENGTHSAP, :HEALORDER, :NATURESMADNESS, :FORESTSCURSE],
	:changeEffects => {},
	:seed => {
		:seedtype => :TELLURICSEED,
		:effect => :Protect,
		:duration => :SpikyShield,
		:message => "The Telluric Seed shielded {1} against damage!",
		:animation => :SPIKYSHIELD,
		:stats => {
		},
	},
},
:VOLCANICTOP => {
	:name => "Volcanic Top",
	:fieldMessage => [
		"The mountain top is super-heated!"
	],
	:graphic => ["Voltop"],
	:secretPower => "FLAMEBURST",
	:naturePower => :ERUPTION,
	:mimicry => :FIRE,
	:damageMods => {
		1.5 => [:OMINOUSWIND, :SILVERWIND, :RAZORWIND, :ICYWIND, :GUST, :TWISTER, :SMOG, :CLEARSMOG, :PRECIPICEBLADES, :THUNDER, :SCALD, :STEAMERUPTION, :INFERNALPARADE],
		1.3 => [:ERUPTION, :HEATWAVE, :MAGMASTORM, :LAVAPLUME, :MAGMADRIFT],
		0.625 => [:SURF, :MUDDYWATER, :WATERPLEDGE, :WATERSPOUT, :HYDROPUMP, :SPARKLINGARIA, :HYDROVORTEX, :OCEANICOPERETTA],
		0 => [:HAIL]
	},
	:accuracyMods => {
		0 => [:THUNDER]
	},
	:moveMessages => {
		"The field super-heated the attack!" => [:SCALD, :STEAMERUPTION,:OMINOUSWIND, :SILVERWIND, :RAZORWIND, :ICYWIND, :GUST, :TWISTER, :SMOG, :CLEARSMOG, :PRECIPICEBLADES],
		"The field powers up the flaming attacks!" => [:ERUPTION, :HEATWAVE, :MAGMASTORM, :LAVAPLUME, :MAGMADRIFT, :INFERNALPARADE],
		"The field powers up the attack!" => [:THUNDER],
		"The " + HAILSNOWLOWMOD + " melted away." => [:HAIL],
	},
	:typeMods => {
		:FIRE => [:OMINOUSWIND, :SILVERWIND, :RAZORWIND, :ICYWIND, :GUST, :TWISTER, :SMOG, :CLEARSMOG, :PRECIPICEBLADES, :EXPLOSION, :SELFDESTRUCT, :DIG, :DIVE, :SEISMICTOSS, :MAGNETBOMB, :EGGBOMB],
	},
	:typeAddOns => {
		:FIRE => [:ROCK],
	},
	:moveEffects => {
		"@battle.fieldAccuracyDrop" => [:SURF, :MUDDYWATER, :WATERPLEDGE, :WATERSPOUT, :SPARKLINGARIA, :OCEANICOPERETTA, :HYDROVORTEX, :HYDROPUMP, :WATERSPORT],
		"@battle.eruptionChecker" => [:BULLDOZE, :EARTHQUAKE, :MAGNITUDE, :ERUPTION, :PRECIPICEBLADES, :LAVAPLUME, :MAGMADRIFT, :EARTHPOWER, :FEVERPITCH],
	},
	:typeBoosts => {
		0.5 => [:ICE],
		0.9 => [:WATER],
		1.2 => [:FIRE],
		1.3 => [:FLYING],
	},
	:typeMessages => {
		"The extreme heat softened the attack..." => [:ICE, :WATER],
		"The attack was super-heated!" => [:FIRE],
		"The mountain strengthened the attack!!" => [:FLYING],
	},
	:typeCondition => {
		:WATER => "self.move!=:SCALD && self.move!=:STEAMERUPTION",
	},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:SKY => [:FLY, :BOUNCE,],
		:MOUNTAIN => [:BLIZZARD, :GLACIATE, :SUBZEROSLAMMER],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "The battle was taken to the skies!" => [:FLY, :BOUNCE,],
		 "The field cooled off!" => [:BLIZZARD, :GLACIATE, :SUBZEROSLAMMER],
	},
	:statusMods => [:TAILWIND, :STEALTROCK, :SMOKESCREEN, :POISONGAS],
	:changeEffects => {},
	:seed => {
		:seedtype => :TELLURICSEED,
		:effect => :ShellTrap,
		:duration => true,
		:message => "{1} primed a trap!",
		:animation => :ShellTrap,
		:stats => {
			PBStats::DEFENSE => 1,
		},
	},
},
:FACTORY => {
	:name => "Factory Field",
	:fieldMessage => [
		"Machines whir in the background."
	],
	:graphic => ["Factory"],
	:secretPower => "MAGNETBOMB",
	:naturePower => :GEARGRIND,
	:mimicry => :STEEL,
	:damageMods => {
		1.5 => [:STEAMROLLER, :TECHNOBLAST, :ULTRAMEGADEATH],
		2.0 => [:FLASHCANNON, :GYROBALL, :MAGNETBOMB, :GEARGRIND, :DOUBLEIRONBASH],
	},
	:accuracyMods => {},
	:moveMessages => {
		"ATTACK SEQUENCE UPDATE." => [:STEAMROLLER, :TECHNOBLAST, :ULTRAMEGADEATH],
		"ATTACK SEQUENCE INITIATE." => [:FLASHCANNON, :GYROBALL, :MAGNETBOMB, :GEARGRIND, :DOUBLEIRONBASH],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.2 => [:ELECTRIC],
	},
	:typeMessages => {
		"The attack took energy from the field!" => [:ELECTRIC],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {
		:SHORTCIRCUIT => "!(self.move==:ULTRAMEGADEATH && self.pbIsSpecial?(@type))",
	},
	:fieldChange => {
		:SHORTCIRCUIT => [:AURAWHEEL, :IONDELUGE, :GIGAVOLTHAVOC, :EARTHQUAKE, :BULLDOZE, :MAGNITUDE, :FISSURE, :TECTONICRAGE, :SELFDESTRUCT, :EXPLOSION, :LIGHTTHATBURNSTHESKY, :ULTRAMEGADEATH],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "The field was broken!" => [:EARTHQUAKE, :BULLDOZE, :MAGNITUDE, :FISSURE, :TECTONICRAGE, :SELFDESTRUCT, :EXPLOSION, :ULTRAMEGADEATH],
		 "All the light was consumed!" => [:LIGHTTHATBURNSTHESKY],
		 "The field shorted out!" => [:AURAWHEEL, :IONDELUGE, :GIGAVOLTHAVOC],
	},
	:statusMods => [:AUTOTOMIZE, :IRONDEFENSE, :METALSOUND, :SHIFTGEAR, :MAGNETRISE, :GEARUP, :MAGNETRISE],
	:changeEffects => {},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => :LaserFocus,
		:duration => 2,
		:message => "{1} is focused!",
		:animation => :LASERFOCUS,
		:stats => {
			PBStats::SPATK => 1,
		},
	},
},
:SHORTCIRCUIT => {
	:name => "Short-Circuit Field",
	:fieldMessage => [
		"Bzzt!"
	],
	:graphic => ["ShortCircuit"],
	:secretPower => "ELECTROBALL",
	:naturePower => :DISCHARGE,
	:mimicry => :ELECTRIC,
	:damageMods => {
		1.667 => [:STEELBEAM],
		1.5 => [:DAZZLINGGLEAM, :SURF, :MUDDYWATER, :MAGNETBOMB, :GYROBALL, :FLASHCANNON, :GEARGRIND, :HYDROVORTEX, :ULTRAMEGADEATH],
		1.3 => [:DARKPULSE, :NIGHTDAZE, :NIGHTSLASH, :SHADOWBALL, :SHADOWPUNCH, :SHADOWCLAW, :SHADOWSNEAK, :SHADOWFORCE, :SHADOWBONE, :PHANTOMFORCE],
		0.5 => [:LIGHTTHATBURNSTHESKY],
	},
	:accuracyMods => {
		80 => [:ZAPCANNON],
	},
	:moveMessages => {
		"CHARGING UP!" => [:ULTRAMEGADEATH],
		"Blinding!" => [:DAZZLINGGLEAM, :FLASHCANNON],
		"The attack picked up electricity!" => [:SURF, :MUDDYWATER, :MAGNETBOMB, :GYROBALL, :GEARGRIND, :HYDROVORTEX],
		"The darkness strengthened the attack!" => [:DARKPULSE, :NIGHTDAZE, :NIGHTSLASH, :SHADOWBALL, :SHADOWPUNCH, :SHADOWCLAW, :SHADOWSNEAK, :SHADOWFORCE, :SHADOWBONE, :PHANTOMFORCE],
		"{1} couldn't consume much light..." => [:LIGHTTHATBURNSTHESKY],
	},
	:typeMods => {
		:ELECTRIC => [:SURF, :MUDDYWATER, :MAGNETBOMB, :GYROBALL, :FLASHCANNON, :GEARGRIND, :STEELBEAM],
	},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {},
	:typeMessages => {},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {
		:FACTORY => "!(self.move==:ULTRAMEGADEATH && self.pbIsPhysical?(@type))",
	},
	:fieldChange => {
		:FACTORY => [:AURAWHEEL, :PARABOLICCHARGE, :WILDCHARGE, :CHARGEBEAM, :IONDELUGE, :GIGAVOLTHAVOC, :ULTRAMEGADEATH],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "SYSTEM ONLINE." => [:AURAWHEEL, :PARABOLICCHARGE, :WILDCHARGE, :CHARGEBEAM, :IONDELUGE, :GIGAVOLTHAVOC, :ULTRAMEGADEATH],
	},
	:statusMods => [:FLASH, :METALSOUND, :MAGNETRISE],
	:changeEffects => {},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => :MagnetRise,
		:duration => 5,
		:message => "{1} levitated with electromagnetism!",
		:animation => :MAGNETRISE,
		:stats => {
			PBStats::SPDEF => 1,
		},
	},
},
:WASTELAND => {
	:name => "Wasteland",
	:fieldMessage => [
		"The waste is watching..."
	],
	:graphic => ["Wasteland"],
	:secretPower => "GUNKSHOT",
	:naturePower => :GUNKSHOT,
	:mimicry => :POISON,
	:damageMods => {
		1.5 => [:VINEWHIP, :POWERWHIP, :MUDSLAP, :MUDBOMB, :MUDSHOT],
		0.25 => [:EARTHQUAKE, :MAGNITUDE, :BULLDOZE],
		2.0 => [:SPITUP],
		1.2 => [:OCTAZOOKA, :SLUDGE, :GUNKSHOT, :SLUDGEWAVE, :SLUDGEBOMB],
	},
	:accuracyMods => {},
	:moveMessages => {
		"The waste did it for the vine!" => [:VINEWHIP, :POWERWHIP],
		"The waste was added to the attack!" => [:MUDSLAP, :MUDBOMB, :MUDSHOT],
		"Wibble-wibble wobble-wobb..." => [:EARTHQUAKE, :MAGNITUDE, :BULLDOZE],
		"BLEAAARGGGGH!" => [:SPITUP],
		"The waste joined the attack!" => [:OCTAZOOKA, :SLUDGE, :GUNKSHOT, :SLUDGEWAVE, :SLUDGEBOMB, :ACIDDOWNPOUR],
	},
	:typeMods => {
		:POISON => [:MUDBOMB, :MUDSLAP, :MUDSHOT],
	},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {},
	:typeMessages => {},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {},
	:dontChangeBackup => [],
	:changeMessage => {},
	:statusMods => [:SWALLOW, :STEALTHROCK, :SPIKES, :TOXICSPIKES, :STICKYWEB],
	:changeEffects => {},
	:seed => {
		:seedtype => :TELLURICSEED,
		:effect => 0,
		:duration => 0,
		:message => nil,
		:animation => nil,
		:stats => {
			PBStats::ATTACK => 1,
			PBStats::SPATK => 1,
		},
	},
},
:ASHENBEACH => {
	:name => "Beach",
	:fieldMessage => [
		"Focus and relax to the sound of crashing waves..."
	],
	:graphic => ["AshenBeach","Beach","BeachEve","BeachNight"],
	:secretPower => "MUDSHOT",
	:naturePower => :MEDITATE,
	:mimicry => :GROUND,
	:damageMods => {
		1.5 => [:HIDDENPOWER, :BRINE, :SMELLINGSALTS, :CRABHAMMER, :RAZORSHELL, :SHELLSIDEARM, :SHELLTRAP, :SCORCHINGSANDS, :SANDSEARSTORM, :STRENGTH, :LANDSWRATH, :THOUSANDWAVES, :SURF, :MUDDYWATER, :WAVECRASH, :CLANGOROUSSOULBLAZE, :HIDDENPOWERNOR, :HIDDENPOWERFIR, :HIDDENPOWERFIG, :HIDDENPOWERWAT, :HIDDENPOWERFLY, :HIDDENPOWERGRA, :HIDDENPOWERPOI, :HIDDENPOWERELE, :HIDDENPOWERGRO, :HIDDENPOWERPSY, :HIDDENPOWERROC, :HIDDENPOWERICE, :HIDDENPOWERBUG, :HIDDENPOWERDRA, :HIDDENPOWERGHO, :HIDDENPOWERDAR, :HIDDENPOWERSTE, :HIDDENPOWERFAI],
		2.0 => [:MUDSLAP, :MUDSHOT, :MUDBOMB, :SANDTOMB, :SHADOWBONE],
		1.35 => [:STOREDPOWER, :ZENHEADBUTT, :FOCUSBLAST, :AURASPHERE, :FOCUSPUNCH, :PSYCHIC, :DIG],
	},
	:accuracyMods => {
		90 => [:FOCUSBLAST],
	},
	:moveMessages => {
		"...And with pure focus!" => [:HIDDENPOWER, :STRENGTH, :CLANGOROUSSOULBLAZE, :HIDDENPOWERNOR, :HIDDENPOWERFIR, :HIDDENPOWERFIG, :HIDDENPOWERWAT, :HIDDENPOWERFLY, :HIDDENPOWERGRA, :HIDDENPOWERPOI, :HIDDENPOWERELE, :HIDDENPOWERGRO, :HIDDENPOWERPSY, :HIDDENPOWERROC, :HIDDENPOWERICE, :HIDDENPOWERBUG, :HIDDENPOWERDRA, :HIDDENPOWERGHO, :HIDDENPOWERDAR, :HIDDENPOWERSTE, :HIDDENPOWERFAI],
		"The sand strengthened the atttack!" => [:LANDSWRATH, :THOUSANDWAVES, :SANDTOMB, :SCORCHINGSANDS, :SANDSEARSTORM, :DIG],
		"Surf's up!" => [:SURF, :MUDDYWATER, :WAVECRASH],
		"A shining shell on the beach!" => [:RAZORSHELL, :SHELLSIDEARM, :SHELLTRAP],
		"The salty sea strengthened the attack!" => [:BRINE, :SMELLINGSALTS],
		"Time for crab!" => [:CRABHAMMER],
		"Sand mixed into the attack!" => [:MUDSLAP, :MUDSHOT, :MUDBOMB, :MUDBARRAGE],
		"...And with full focus...!" => [:STOREDPOWER, :ZENHEADBUTT, :FOCUSBLAST, :FOCUSPUNCH, :AURASPHERE],
		"...And with focus...!" => [:PSYCHIC],
		"A dance for the gods!" => [:SHADOWBONE],
	},
	:typeMods => {
		:PSYCHIC => [:STRENGTH],
	},
	:typeAddOns => {},
	:moveEffects => {
		"@battle.fieldAccuracyDrop" => [:LEAFTORNADO,:FIRESPIN, :TWISTER, :RAZORWIND, :WHIRLPOOL],
	},
	:typeBoosts => {},
	:typeMessages => {},
	:typeCondition => {
		:FLYING => "self.pbIsSpecial?(type)",
	},
	:typeEffects => {
		:FLYING => "@battle.fieldAccuracyDrop",
	},
	:changeCondition => {},
	:fieldChange => {},
	:dontChangeBackup => [],
	:changeMessage => {},
	:statusMods => [:CALMMIND, :KINESIS, :MEDITATE, :SANDATTACK, :SANDSTORM, :PSYCHUP, :FOCUSENERGY, :SHOREUP, :ARENITEWALL],
	:changeEffects => {},
	:seed => {
		:seedtype => :TELLURICSEED,
		:effect => :FocusEnergy,
		:duration => 3,
		:message => "{1}'s Telluric Seed is getting it pumped!",
		:animation => :FOCUSENERGY,
		:stats => {
		},
	},
},
:WATERSURFACE => {
	:name => "Water Surface",
	:fieldMessage => [
		"The water's surface is calm."
	],
	:graphic => ["Water"],
	:secretPower => "AQUAJET",
	:naturePower => :WHIRLPOOL,
	:mimicry => :WATER,
	:damageMods => {
		1.3 => [:WHIRLPOOL, :SURF, :MUDDYWATER, :WHIRLPOOL, :DIVE, :SLUDGEWAVE, :OCTAZOOKA, :ORIGINPULSE, :HYDROVORTEX, :WAVECRASH],
		0 => [:SPIKES, :TOXICSPIKES],
	},
	:accuracyMods => {},
	:moveMessages => {
		"The attack rode the current!" => [:WHIRLPOOL, :SURF, :MUDDYWATER, :WHIRLPOOL, :DIVE, :ORIGINPULSE, :HYDROVORTEX, :WAVECRASH],
		"Poison spread through the water!" => [:SLUDGEWAVE],
		"...The spikes sank into the water and vanished!" => [:SPIKES, :TOXICSPIKES],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {
		"@battle.field.counter += 1" => [:SLUDGEWAVE],
		"@battle.field.counter = 2" => [:ACIDDOWNPOUR],
	},
	:typeBoosts => {
		1.5 => [:WATER, :ELECTRIC],
		0.5 => [:FIRE],
		0 => [:GROUND],
	},
	:typeMessages => {
		"The water conducted the attack!" => [:ELECTRIC],
		"The water strengthened the attack!" => [:WATER],
		"The water deluged the attack..." => [:FIRE],
		"...But there was no solid ground to attack from!" => [:GROUND],
	},
	:typeCondition => {
		:FIRE => "!opponent.isAirborne?",
		:ELECTRIC => "!opponent.isAirborne?",
	},
	:typeEffects => {},
	:changeCondition => {
		:MURKWATERSURFACE => "@battle.field.counter > 1",
	},
	:fieldChange => {
		:UNDERWATER => [:GRAVITY, :DIVE, :ANCHORSHOT, :GRAVAPPLE],
		:ICY => [:BLIZZARD, :GLACIATE, :SUBZEROSLAMMER],
		:MURKWATERSURFACE => [:SLUDGEWAVE, :ACIDDOWNPOUR],
	},
	:dontChangeBackup => [:BLIZZARD, :GLACIATE, :SUBZEROSLAMMER],
	:changeMessage => {
		 "The battle sank into the depths!" => [:GRAVITY, :GRAVAPPLE],
		 "The battle was pulled underwater!" => [:DIVE, :ANCHORSHOT],
		 "The water froze over!" => [:BLIZZARD, :GLACIATE, :SUBZEROSLAMMER],
		 "The water was polluted!" => [:SLUDGEWAVE, :ACIDDOWNPOUR],
	},
	:statusMods => [:SPLASH, :AQUARING, :LIFEDEW, :TAKEHEART],
	:changeEffects => {},
	:seed => {
		:seedtype => :ELEMENTALSEED,
		:effect => :AquaRing,
		:duration => true,
		:message => "{1} surrounded itself with a veil of water!",
		:animation => :AQUARING,
		:stats => {
			PBStats::SPDEF => 1,
		},
	},
},
:UNDERWATER => {
	:name => "Underwater",
	:fieldMessage => [
		"Blub blub..."
	],
	:graphic => ["Underwater"],
	:secretPower => "AQUATAIL",
	:naturePower => :WATERPULSE,
	:mimicry => :WATER,
	:damageMods => {
		1.5 => [:WATERPULSE],
		2.0 => [:ANCHORSHOT, :DRAGONDARTS, :SLUDGEWAVE, :ACIDDOWNPOUR],
		0 => [:SUNNYDAY, :HAIL, :SANDSTORM, :RAINDANCE, :SHADOWSKY, :TARSHOT],
	},
	:accuracyMods => {},
	:moveMessages => {
		"Jet-streamed!" => [:WATERPULSE],
		"From the depths!" => [:ANCHORSHOT, :DRAGONDARTS],
		"You're too deep to notice the weather!" => [:SUNNYDAY, :HAIL, :SANDSTORM, :RAINDANCE, :SHADOWSKY],
		"The tar washed of instantly!" => [:TARSHOT],
	},
	:typeMods => {
		:WATER => [:DRAGONDARTS, :GRAVAPPLE],
	},
	:typeAddOns => {
		:WATER => [:GROUND],
	},
	:moveEffects => {
		"@battle.field.counter += 1" => [:SLUDGEWAVE],
		"@battle.field.counter = 2" => [:ACIDDOWNPOUR],
	},
	:typeBoosts => {
		1.5 => [:WATER],
		2.0 => [:ELECTRIC],
		0 => [:FIRE],
	},
	:typeMessages => {
		"The water strengthened the attack!" => [:WATER],
		"The water super-conducted the attack!" => [:ELECTRIC],
		"...But the attack was doused instantly!" => [:FIRE],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {
		:MURKWATERSURFACE => "@battle.field.counter > 1",
	},
	:fieldChange => {
		:WATERSURFACE => [:DIVE, :SKYDROP, :FLY, :BOUNCE],
		:MURKWATERSURFACE => [:SLUDGEWAVE, :ACIDDOWNPOUR],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "The battle resurfaced!" => [:DIVE, :SKYDROP, :FLY, :BOUNCE, :SHOREUP, :SURF],
		 "The grime sank beneath the battlers!" => [:SLUDGEWAVE, :ACIDDOWNPOUR],
	},
	:statusMods => [:AQUARING, :TAKEHEART],
	:changeEffects => {
		"@battle.waterPollution" => [:SLUDGEWAVE, :ACIDDOWNPOUR],
	},
	:seed => {
		:seedtype => :ELEMENTALSEED,
		:effect => nil,
		:duration => 0,
		:message => "{1} transformed into the Water type!",
		:animation => :SOAK,
		:stats => {
			PBStats::SPEED => 1,
		},
	},
},
:CAVE => {
	:name => "Cave",
	:fieldMessage => [
		"The cave echoes dully..."
	],
	:graphic => ["Cave"],
	:secretPower => "ROCKWRECKER",
	:naturePower => :ROCKTOMB,
	:mimicry => :ROCK,
	:damageMods => {
		1.5 => [:ROCKTOMB],
		0 => [:SKYDROP],
	},
	:accuracyMods => {},
	:moveMessages => {
		"...Piled on!" => [:ROCKTOMB],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {
		"@battle.caveCollapse(basemove, user)" => [:EARTHQUAKE, :BULLDOZE, :MAGNITUDE, :FISSURE, :TECTONICRAGE, :CONTINENTALCRUSH],
		"@battle.field.counter2 += 1" => [:DRAGONPULSE],
		"@battle.field.counter2 = 2" => [:DRACOMETEOR, :DEVASTATINGDRAKE],
		"@battle.field.counter3 += 1" => [:FEVERPITCH, :MAGMADRIFT, :ERUPTION, :LAVAPLUME, :HEATWAVE, :OVERHEAT, :FUSIONFLARE, :MAGMASTORM],
		"@battle.field.counter3 += 2" => [:INFERNOOVERDRIVE],
		"@battle.field.counter4 += 1" => [:GRAVITY],
	},
	:typeBoosts => {
		1.5 => [:ROCK],
		0.5 => [:FLYING],
	},
	:typeMessages => {
		"The cave choked out the air!" => [:FLYING],
		"The cavern strengthened the attack!" => [:ROCK],
	},
	:typeCondition => {
		:FLYING => "!self.contactMove?",
	},
	:typeEffects => {},
	:changeCondition => {
		:DRAGONSDEN => "@battle.field.counter2 > 1",
		:VOLCANIC => "@battle.field.counter3 > 1",
		:DEEPEARTH => "@battle.field.counter4 > 1",
	},
	:fieldChange => {
		:CRYSTALCAVERN => [:POWERGEM, :DIAMONDSTORM],
		:ICY => [:BLIZZARD, :SUBZEROSLAMMER],
		:CORRUPTED => [:SLUDGEWAVE, :ACIDDOWNPOUR],
		:VOLCANIC => [:FEVERPITCH, :MAGMADRIFT, :ERUPTION, :LAVAPLUME, :HEATWAVE, :OVERHEAT, :FUSIONFLARE],
		:DRAGONSDEN => [:DRAGONPULSE, :DRACOMETEOR, :DEVASTATINGDRAKE],
		:DEEPEARTH => [:GRAVITY],
	},
	:dontChangeBackup => [:BLIZZARD, :SUBZEROSLAMMER],
	:changeMessage => {
		"The cave was littered with crystals!" => [:POWERGEM, :DIAMONDSTORM],
		"The cavern froze over!" => [:BLIZZARD, :SUBZEROSLAMMER],
		"The cave was corrupted!" => [:SLUDGEWAVE, :ACIDDOWNPOUR],
		"The flame ignited the cave!" => [:FEVERPITCH, :MAGMADRIFT, :ERUPTION, :LAVAPLUME, :HEATWAVE, :OVERHEAT, :FUSIONFLARE],
		"The draconic energy mutated the field!" => [:DRAGONPULSE, :DRACOMETEOR, :DEVASTATINGDRAKE],
		"The battle was pulled deeper into the earth!" => [:GRAVITY],
	},
	:statusMods => [:STEALTHROCK],
	:changeEffects => {},
	:seed => {
		:seedtype => :TELLURICSEED,
		:effect => nil,
		:duration => 0,
		:message => nil,
		:animation => nil,
		:stats => {
			PBStats::DEFENSE => 2,
		},
	},
},
:GLITCH => {
	:name => "Glitch Field",
	:fieldMessage => [
		"1n!taliz3 .b//////attl3"
	],
	:graphic => ["Glitch","99"],
	:secretPower => "TECHNOBLAST",
	:naturePower => :METRONOME,
	:mimicry => :QMARKS,
	:damageMods => {
		0 => [:ROAR, :WHIRLWIND],
	},
	:accuracyMods => {
		90 => [:BLIZZARD],
	},
	:moveMessages => {
		"ERROR! MOVE NOT FOUND!" => [:ROAR, :WHIRLWIND],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.2 => [:PSYCHIC],
	},
	:typeMessages => {
		".0P pl$ nerf!-//" => [:PSYCHIC],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {},
	:dontChangeBackup => [],
	:changeMessage => {},
	:statusMods => [:METRONOME],
	:changeEffects => {},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => nil,
		:duration => 0,
		:message => "{1}.TYPE = :QMARKS",
		:animation => :AMNESIA,
		:stats => {
			PBStats::DEFENSE => 1,
		},
	},
},
:CRYSTALCAVERN => {
	:name => "Crystal Cavern",
	:fieldMessage => [
		"The cave is littered with crystals."
	],
	:graphic => ["CrystalCavern","AmethystCave","CaveAqua"],
	:secretPower => "POWERGEM",
	:naturePower => :POWERGEM,
	:mimicry => :DRAGON,
	:damageMods => {
		1.3 => [:AURORABEAM, :SIGNALBEAM, :FLASHCANNON, :DAZZLINGGLEAM, :MIRRORSHOT, :MIRRORBEAM, :TECHNOBLAST, :DOOMDUMMY, :MOONGEISTBEAM, :PHOTONGEYSER, :MENACINGMOONRAZEMAELSTROM],
		1.5 => [:POWERGEM, :DIAMONDSTORM, :ANCIENTPOWER, :JUDGMENT, :ROCKSMASH, :ROCKTOMB, :STRENGTH, :ROCKCLIMB, :MULTIATTACK, :PRISMATICLASER, :LUSTERPURGE],
	},
	:accuracyMods => {},
	:moveMessages => {
		"The crystals' light strengthened the attack!" => [:AURORABEAM, :SIGNALBEAM, :FLASHCANNON, :LUSTERPURGE, :DAZZLINGGLEAM, :MIRRORSHOT, :MIRRORBEAM, :TECHNOBLAST, :DOOMDUMMY, :MOONGEISTBEAM, :PHOTONGEYSER, :PRISMATICLASER, :MENACINGMOONRAZEMAELSTROM],
		"The crystals strengthened the attack!" => [:POWERGEM, :DIAMONDSTORM, :ANCIENTPOWER, :JUDGMENT, :ROCKSMASH, :ROCKTOMB, :STRENGTH, :ROCKCLIMB, :MULTIATTACK],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {
		"@battle.field.counter += 1" => [:EARTHQUAKE, :BULLDOZE, :MAGNITUDE, :FISSURE],
		"@battle.field.counter = 2" => [:TECTONICRAGE],
	},
	:typeBoosts => {
		1.5 => [:ROCK, :DRAGON],
	},
	:typeMessages => {
		"The crystals charged the attack!" => [:ROCK],
		"The crystal energy strengthened the attack!" => [:DRAGON],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {
		:CAVE => "@battle.field.counter > 1",
	},
	:fieldChange => {
		:CAVE => [:EARTHQUAKE, :BULLDOZE, :MAGNITUDE, :FISSURE, :TECTONICRAGE],
		:DARKCRYSTALCAVERN => [:DARKPULSE, :DARKVOID, :NIGHTDAZE, :LIGHTTHATBURNSTHESKY],
	},
	:dontChangeBackup => [:EARTHQUAKE, :BULLDOZE, :MAGNITUDE, :FISSURE, :TECTONICRAGE, :DARKPULSE, :DARKVOID, :NIGHTDAZE],
	:changeMessage => {
		 "The crystals were broken up!" => [:EARTHQUAKE, :BULLDOZE, :MAGNITUDE, :FISSURE, :TECTONICRAGE],
		 "The crystals' light was warped by the darkness!" => [:DARKPULSE, :DARKVOID, :NIGHTDAZE],
		 "The crystals' light was consumed!" => [:LIGHTTHATBURNSTHESKY],
	},
	:statusMods => [:ROCKPOLISH, :STEALTHROCK, :AURORAVEIL],
	:changeEffects => {},
	:seed => {
		:seedtype => :MAGICALSEED,
		:effect => :MagicCoat,
		:duration => true,
		:message => "{1} shrouded itself with Magic Coat!",
		:animation => :MAGICCOAT,
		:stats => {
			PBStats::SPATK => 1,
		},
	},
},
:MURKWATERSURFACE => {
	:name => "Murkwater Surface",
	:fieldMessage => [
		"The water is tainted..."
	],
	:graphic => ["MurkwaterSurface"],
	:secretPower => "SLUDGEBOMB",
	:naturePower => :SLUDGEWAVE,
	:mimicry => :POISON,
	:damageMods => {
		1.5 => [:MUDBOMB, :MUDSLAP, :MUDSHOT, :MUDBARRAGE, :SMACKDOWN, :ACID, :ACIDSPRAY, :BRINE, :THOUSANDWAVES, :APPLEACID],
		0 => [:SPIKES, :TOXICSPIKES],
	},
	:accuracyMods => {},
	:moveMessages => {
		"The toxic water strengthened the attack!" => [:MUDBOMB, :MUDSLAP, :MUDSHOT, :SMACKDOWN, :ACID, :ACIDSPRAY, :THOUSANDWAVES, :APPLEACID, :MUDDYWATER, :SURF],
		"Stinging!" => [:BRINE],
		"...The spikes sank into the water and vanished!" => [:SPIKES, :TOXICSPIKES],
	},
	:typeMods => {
		:POISON => [:MUDBOMB, :MUDSLAP, :MUDSHOT, :MUDBARRAGE, :SMACKDOWN, :THOUSANDWAVES, :APPLEACID, :MUDDYWATER],
		:WATER => [:SLUDGEWAVE],
	},
	:typeAddOns => {
		:POISON => [:WATER],
	},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:WATER, :POISON],
		1.3 => [:ELECTRIC],
		0 => [:GROUND],
	},
	:typeMessages => {
		"The toxic water strengthened the attack!" => [:WATER, :POISON],
		"The toxic water conducted the attack!" => [:ELECTRIC],
		"...But there was no solid ground to attack from!" => [:GROUND],
	},
	:typeCondition => {
		:ELECTRIC => "!opponent.isAirborne?",
	},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:WATERSURFACE => [:WHIRLPOOL, :PURIFY],
		:ICY => [:BLIZZARD, :GLACIATE, :SUBZEROSLAMMER],
	},
	:dontChangeBackup => [:WHIRLPOOL, :PURIFY, :BLIZZARD, :GLACIATE, :SUBZEROSLAMMER],
	:changeMessage => {
		"The maelstrom flushed out the poison!" => [:WHIRLPOOL],
		"The attack cleared the waters!" => [:PURIFY],
		"The toxic water froze over!" => [:BLIZZARD, :GLACIATE, :SUBZEROSLAMMER],
	},
	:statusMods => [:ACIDARMOR, :TARSHOT, :VENOMDRENCH],
	:changeEffects => {},
	:seed => {
		:seedtype => :ELEMENTALSEED,
		:effect => :AquaRing,
		:duration => true,
		:message => "{1} surrounded itself with a veil of water!",
		:animation => :AQUARING,
		:stats => {
			PBStats::SPEED => 1,
		},
	},
},
:MOUNTAIN => {
	:name => "Mountain",
	:fieldMessage => [
		"High up!",
	],
	:graphic => ["Mountain"],
	:secretPower => "ROCKBLAST",
	:naturePower => :ROCKSLIDE,
	:mimicry => :ROCK,
	:damageMods => {
		1.5 => [:VITALTHROW, :CIRCLETHROW, :STORMTHROW, :OMINOUSWIND, :ICYWIND, :SILVERWIND, :TWISTER, :RAZORWIND, :FAIRYWIND, :THUNDER, :ERUPTION, :AVALANCHE, :HYPERVOICE, :MOUNTAINGALE],
	},
	:accuracyMods => {
		0 => [:THUNDER]
	},
	:moveMessages => {
		"{1} was thrown partway down the mountain!" => [:VITALTHROW, :CIRCLETHROW, :STORMTHROW],
		"The wind strengthened the attack!" => [:OMINOUSWIND, :ICYWIND, :SILVERWIND, :TWISTER, :RAZORWIND, :FAIRYWIND, :MOUNTAINGALE],
		"The mountain strengthened the attack!" => [:THUNDER, :ERUPTION, :AVALANCHE],
		"Yodelayheehoo~" => [:HYPERVOICE],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:ROCK, :FLYING],
	},
	:typeMessages => {
		"The mountain strengthened the attack!" => [:ROCK],
		"The open air strengthened the attack!" => [:FLYING],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:SNOWYMOUNTAIN => [:BLIZZARD, :GLACIATE, :SUBZEROSLAMMER, :MOUNTAINGALE],
		:SKY => [:FLY, :BOUNCE],
		:VOLCANICTOP => [:LAVAPLUME, :MAGMADRIFT, :ERUPTION, :INFERNOOVERDRIVE],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		"The mountain was covered in snow!" => [:BLIZZARD, :GLACIATE, :SUBZEROSLAMMER, :MOUNTAINGALE],
		"The battle was taken to the skies!" => [:FLY, :BOUNCE],
		"The mountain erupted!" => [:LAVAPLUME, :MAGMADRIFT, :ERUPTION, :INFERNOOVERDRIVE],
	},
	:statusMods => [:TAILWIND, :SUNNYDAY],
	:changeEffects => {},
	:seed => {
		:seedtype => :TELLURICSEED,
		:effect => nil,
		:duration => 0,
		:message => nil,
		:animation => nil,
		:stats => {
			PBStats::ATTACK => 2,
			PBStats::ACCURACY => -1,
		},
	},
},
:SNOWYMOUNTAIN => {
	:name => "Snowy Mountain",
	:fieldMessage => [
		"The snow glows white on the mountain..."
	],
	:graphic => ["SnowyMountain"],
	:secretPower => "ICEBALL",
	:naturePower => :AVALANCHE,
	:mimicry => :ICE,
	:damageMods => {
		1.5 => [:VITALTHROW, :CIRCLETHROW, :STORMTHROW, :OMINOUSWIND, :SILVERWIND, :TWISTER, :RAZORWIND, :FAIRYWIND, :AVALANCHE, :POWDERSNOW, :HYPERVOICE, :GLACIATE, :MOUNTAINGALE, :BITTERMALICE],
		0.5 => [:SCALD, :STEAMERUPTION],
		2.0 => [:ICYWIND],
	},
	:accuracyMods => {
		0 => [:THUNDER]
	},
	:moveMessages => {
		"{1} was thrown partway down the mountain!" => [:VITALTHROW, :CIRCLETHROW, :STORMTHROW],
		"The wind strengthened the attack!" => [:OMINOUSWIND, :SILVERWIND, :TWISTER, :RAZORWIND, :FAIRYWIND, :MOUNTAINGALE],
		"The snow strengthened the attack!" => [:AVALANCHE, :POWDERSNOW, :BITTERMALICE],
		"The cold softened the attack..." => [:SCALD, :STEAMERUPTION],
		"The frigid wind strengthened the attack!" => [:ICYWIND],
		"Yodelayheehoo~" => [:HYPERVOICE],
	},
	:typeMods => {},
	:typeAddOns => {
		:ICE => [:ROCK],
	},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:ROCK, :ICE, :FLYING],
		0.5 => [:FIRE],
	},
	:typeMessages => {
		"The snowy mountain strengthened the attack!" => [:ROCK, :ICE],
		"The open air strengthened the attack!" => [:FLYING],
		"The cold softened the attack!" => [:FIRE],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:MOUNTAIN => [:HEATWAVE, :SEARINGSHOT, :FLAMEBURST, :LAVAPLUME, :FIREPLEDGE, :MINDBLOWN, :INCINERATE, :INFERNOOVERDRIVE, :RAGINGFURY],
		:VOLCANICTOP => [:ERUPTION, :MAGMADRIFT],
		:SKY => [:FLY, :BOUNCE],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		"The snow melted away!" => [:HEATWAVE, :SEARINGSHOT, :FLAMEBURST, :LAVAPLUME, :FIREPLEDGE, :MINDBLOWN, :INCINERATE, :INFERNOOVERDRIVE, :RAGINGFURY],
		"The mountain erupted!" => [:ERUPTION, :MAGMADRIFT],
		"The battle was taken to the skies!" => [:FLY, :BOUNCE],
	},
	:statusMods => [:TAILWIND, :SUNNYDAY, :HAIL],
	:changeEffects => {},
	:seed => {
		:seedtype => :TELLURICSEED,
		:effect => nil,
		:duration => 0,
		:message => nil,
		:animation => nil,
		:stats => {
			PBStats::SPATK => 2,
			PBStats::ACCURACY => -1,
		},
	},
},
:HOLY => {
	:name => "Blessed Field",
	:fieldMessage => [
		"The field is blessed!"
	],
	:graphic => ["Ruin","Ruin2","Ruin3"],
	:secretPower => "DAZZLINGGLEAM",
	:naturePower => :JUDGMENT,
	:mimicry => :NORMAL,
	:damageMods => {
		1.3 => [:PSYSTRIKE, :AEROBLAST, :ORIGINPULSE, :DOOMDUMMY, :MISTBALL, :CRUSHGRIP, :LUSTERPURGE, :SECRETSWORD, :PSYCHOBOOST, :RELICSONG, :SPACIALREND, :HYPERSPACEHOLE, :ROAROFTIME, :LANDSWRATH, :PRECIPICEBLADES, :DRAGONASCENT, :MOONGEISTBEAM, :SUNSTEELSTRIKE, :PRISMATICLASER, :FLEURCANNON, :DIAMONDSTORM, :GENESISSUPERNOVA, :SEARINGSUNRAZESMASH, :MENACINGMOONRAZEMAELSTROM, :BEHEMOTHBLADE, :BEHEMOTHBASH, :ETERNABEAM, :DYNAMAXCANNON, :MULTIPULSE],
		1.5 => [:MYSTICALFIRE, :MAGICALLEAF, :ANCIENTPOWER, :JUDGMENT, :SACREDFIRE, :EXTREMESPEED, :SACREDSWORD, :RETURN],
	},
	:accuracyMods => {},
	:moveMessages => {
		"Legendary power accelerated the attack!" => [:PSYSTRIKE, :AEROBLAST, :SACREDFIRE, :ORIGINPULSE, :DOOMDUMMY, :JUDGMENT, :MISTBALL, :CRUSHGRIP, :LUSTERPURGE, :SECRETSWORD, :PSYCHOBOOST, :RELICSONG, :SPACIALREND, :HYPERSPACEHOLE, :ROAROFTIME, :LANDSWRATH, :PRECIPICEBLADES, :DRAGONASCENT, :MOONGEISTBEAM, :SUNSTEELSTRIKE, :PRISMATICLASER, :FLEURCANNON, :DIAMONDSTORM, :GENESISSUPERNOVA, :SEARINGSUNRAZESMASH, :MENACINGMOONRAZEMAELSTROM, :BEHEMOTHBLADE, :BEHEMOTHBASH, :ETERNABEAM, :DYNAMAXCANNON, :MULTIPULSE],
		"The holy energy resonated with the attack!" => [:MYSTICALFIRE, :MAGICALLEAF, :ANCIENTPOWER, :SACREDSWORD, :RETURN],
		"Godspeed!" => [:EXTREMESPEED],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:FAIRY, :NORMAL],
		1.2 => [:PSYCHIC, :DRAGON],
		0.5 => [:GHOST, :DARK],
	},
	:typeMessages => {
		"The holy energy resonated with the attack!" => [:FAIRY, :NORMAL],
		"The legendary energy resonated with the attack!" => [:PSYCHIC, :DRAGON],
		"The attack was cleansed..." => [:GHOST, :DARK],
	},
	:typeCondition => {
		:FAIRY => "self.pbIsSpecial?(type)",
		:NORMAL => "self.pbIsSpecial?(type)",
		:DARK => "self.pbIsSpecial?(type)",
	},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:INDOOR => [:LIGHTTHATBURNSTHESKY],
		:HAUNTED=> [:CURSE, :PHANTOMFORCE, :SPECTRALSCREAM, :SHADOWFORCE, :OMINOUSWIND, :TRICKORTREAT],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		"Evil spirits gathered!" => [:CURSE, :PHANTOMFORCE, :SPECTRALSCREAM, :SHADOWFORCE, :OMINOUSWIND, :TRICKORTREAT],
		"The holy light was consumed!" => [:LIGHTTHATBURNSTHESKY],
	},
	:statusMods => [:LIFEDEW, :WISH, :MIRACLEEYE, :COSMICPOWER, :NATURESMADNESS],
	:changeEffects => {},
	:seed => {
		:seedtype => :MAGICALSEED,
		:effect => :MagicCoat,
		:duration => true,
		:message => "{1} shrouded itself with Magic Coat!",
		:animation => :MAGICCOAT,
		:stats => {
			PBStats::SPATK => 1,
		},
	},
},
:MIRROR => {
	:name => "Mirror Arena",
	:fieldMessage => [
		"Mirror, mirror, on the field,",
		"Who shall this fractured power wield?",
	],
	:graphic => ["Mirror"],
	:secretPower => "MIRRORSHOT",
	:naturePower => :MIRRORSHOT,
	:mimicry => :STEEL,
	:damageMods => {
		1.5 => [:AURORABEAM, :SIGNALBEAM, :FLASHCANNON, :LUSTERPURGE, :DAZZLINGGLEAM, :TECHNOBLAST, :DOOMDUMMY, :PRISMATICLASER, :PHOTONGEYSER, :LIGHTTHATBURNSTHESKY],
		2.0 => [:MIRRORSHOT],
	},
	:accuracyMods => {
		0 => [:AURORABEAM, :SIGNALBEAM, :FLASHCANNON, :LUSTERPURGE, :DAZZLINGGLEAM, :TECHNOBLAST, :DOOMDUMMY, :PRISMATICLASER, :PHOTONGEYSER, :LIGHTTHATBURNSTHESKY, :MIRRORSHOT],
	},
	:moveMessages => {
		"The reflected light was blinding!" => [:AURORABEAM, :SIGNALBEAM, :FLASHCANNON, :LUSTERPURGE, :DAZZLINGGLEAM, :TECHNOBLAST, :DOOMDUMMY, :PRISMATICLASER, :PHOTONGEYSER, :LIGHTTHATBURNSTHESKY],
		"The mirrors strengthened the attack!" => [:MIRRORSHOT],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {},
	:typeMessages => {},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:INDOOR => [:EARTHQUAKE, :BULLDOZE, :MAGNITUDE, :FISSURE, :TECTONICRAGE, :BOOMBURST, :HYPERVOICE, :SELFDESTRUCT, :EXPLOSION],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		"The mirror arena shattered!" => [:EARTHQUAKE, :BULLDOZE, :MAGNITUDE, :FISSURE, :TECTONICRAGE, :BOOMBURST, :HYPERVOICE, :SELFDESTRUCT, :EXPLOSION],
	},
	:statusMods => [:LIGHTSCREEN, :AURORAVEIL, :REFLECT, :MIRRORMOVE, :MIRRORCOAT, :DOUBLETEAM, :FLASH],
	:changeEffects => {
		"@battle.mirrorShatter(basemove, user)" => [:EARTHQUAKE, :BULLDOZE, :MAGNITUDE, :FISSURE, :TECTONICRAGE, :BOOMBURST, :HYPERVOICE, :SELFDESTRUCT, :EXPLOSION],
	},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => :MagicCoat,
		:duration => true,
		:message => "{1} shrouded itself with Magic Coat!",
		:animation => :MAGICCOAT,
		:stats => {
			PBStats::EVASION => 1,
		},
	},
},
:FAIRYTALE => {
	:name => "Fairy Tale Field",
	:fieldMessage => [
		"Once upon a time..."
	],
	:graphic => ["FairyTale"],
	:secretPower => "SLASH",
	:naturePower => :SECRETSWORD,
	:mimicry => :FAIRY,
	:damageMods => {
		1.5 => [:NIGHTSLASH, :LEAFBLADE, :PSYCHOCUT, :SMARTSTRIKE, :AIRSLASH, :SOLARBLADE, :MAGICALLEAF, :MYSTICALFIRE, :ANCIENTPOWER, :RELICSONG, :SPARKLINGARIA, :MOONGEISTBEAM, :FLEURCANNON, :RAZORSHELL, :BEHEMOTHBLADE, :BEHEMOTHBASH, :OCEANICOPERETTA, :MENACINGMOONRAZEMAELSTROM,:CEASELESSEDGE,:STONEAXE,:AQUACUTTER],
		2.0 => [:DRAININGKISS, :MISTBALL],
	},
	:accuracyMods => {},
	:moveMessages => {
		"The blade cuts true!" => [:NIGHTSLASH, :LEAFBLADE, :PSYCHOCUT, :SMARTSTRIKE, :AIRSLASH, :SOLARBLADE, :RAZORSHELL, :BEHEMOTHBLADE],
		"The magical energy strengthened the attack!" => [:MAGICALLEAF, :MYSTICALFIRE, :ANCIENTPOWER, :RELICSONG, :SPARKLINGARIA, :MOONGEISTBEAM, :FLEURCANNON, :BEHEMOTHBASH, :MISTBALL, :OCEANICOPERETTA, :MENACINGMOONRAZEMAELSTROM],
		"True love never hurt so badly!" => [:DRAININGKISS],
	},
	:typeMods => {},
	:typeAddOns => {
		:DRAGON => [:FIRE],
	},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:STEEL, :FAIRY],
		2.0 => [:DRAGON],
	},
	:typeMessages => {
		"For ever after!" => [:FAIRY],
		"For justice!" => [:STEEL],
		"The foul beast's attack gained strength!" => [:DRAGON],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {},
	:dontChangeBackup => [],
	:changeMessage => {},
	:statusMods => [:KINGSSHIELD, :CRAFTYSHIELD, :FLOWERSHIELD, :ACIDARMOR, :NOBLEROAR, :SWORDSDANCE, :WISH, :HEALINGWISH, :MIRACLEEYE, :FORESTSCURSE, :FLORALHEALING],
	:changeEffects => {},
	:seed => {
		:seedtype => :MAGICALSEED,
		:effect => :Protect,
		:duration => :KingsShield,
		:message => "The Magical Seed shielded {1} against damage!",
		:animation => :KINGSSHIELD,
		:stats => {
		},
	},
},
:DRAGONSDEN => {
	:name => "Dragon's Den",
	:fieldMessage => [
		"If you wish to slay a dragon..."
	],
	:graphic => ["DragonsDen"],
	:secretPower => "DRAGONPULSE",
	:naturePower => :DRAGONPULSE,
	:mimicry => :DRAGON,
	:damageMods => {
		1.5 => [:MEGAKICK, :MAGMASTORM, :LAVAPLUME, :STOMPINGTANTRUM, :EARTHPOWER, :DIAMONDSTORM, :MATRIXSHOT, :SHELLTRAP, :POWERGEM, :MAGMADRIFT, :ROCKCLIMB, :STRENGTH],             
		2.0 => [:SMACKDOWN, :THOUSANDARROWS, :DRAGONASCENT, :PAYDAY, :MISTBALL, :LUSTERPURGE,],
		0 => [:GRASSYTERRAIN, :PSYCHICTERRAIN, :MISTYTERRAIN, :ELECTRICTERRAIN, :MIST, :HAIL],
	},
	:accuracyMods => {
		100 => [:DRAGONRUSH],
	},
	:moveMessages => {
		"Trial of the Dragon!!!" => [:MEGAKICK],
		"Wrath of the Dragon!!!" => [:STOMPINGTANTRUM],
		"Unrivaled Power!" => [:STRENGTH, :ROCKCLIMB],
		"The lava strengthened the attack!" => [:MAGMASTORM, :LAVAPLUME, :EARTHPOWER, :SHELLTRAP, :MAGMADRIFT],
		"{1} was knocked into the lava!" => [:SMACKDOWN, :THOUSANDARROWS],
		"The draconic energy boosted the attack!" => [:DRAGONASCENT, :MISTBALL, :LUSTERPURGE],
		"Sparkling treasure!" => [:PAYDAY, :POWERGEM, :DIAMONDSTORM, :MATRIXSHOT],
		"The draconic power blocked the terrain..." => [:GRASSYTERRAIN, :PSYCHICTERRAIN, :MISTYTERRAIN, :ELECTRICTERRAIN, :MIST],
		"The " + HAILSNOWLOWMOD + " is melting in the heat..." => [:HAIL],
	},
	:typeMods => {
		:FIRE => [:SMACKDOWN, :THOUSANDARROWS, :STRENGTH, :ROCKCLIMB, :EARTHQUAKE],
	},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:DRAGON, :FIRE],
		1.3 => [:ROCK],
		0.5 => [:ICE, :WATER],
	},
	:typeMessages => {
		"The lava's heat boosted the flame!" => [:FIRE],
		"The draconic energy boosted the attack!" => [:DRAGON],
		"The lava's heat softened the attack..." => [:ICE, :WATER],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {
		:CAVE => "@battle.field.counter > 1",
	},
	:fieldChange => {
		:CAVE => [:GLACIATE, :SUBZEROSLAMMER, :OCEANICOPERETTA, :HYDROVORTEX],
		:FAIRYTALE => [:MISTBALL],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "The lava was frozen solid!" => [:GLACIATE, :SUBZEROSLAMMER],
		 "The lava solidified!" => [:OCEANICOPERETTA, :HYDROVORTEX],
		 "The mist-ical energy altered the surroundings!" => [:MISTBALL],
	},
	:statusMods => [:DRAGONDANCE, :NOBLEROAR, :COIL, :STEALTHROCK],
	:changeEffects => {},
	:seed => {
		:seedtype => :ELEMENTALSEED,
		:effect => :FlashFire,
		:duration => true,
		:message => "{1} raised its Fire power!",
		:animation => nil,
		:stats => {
			PBStats::SPATK => 1,
		},
	},
},
:FLOWERGARDEN1 => {
	:name => "Flower Garden",
	:fieldMessage => [
		"Seeds line the field."
	],
	:graphic => ["FlowerGarden0"],
	:secretPower => "SWEETSCENT",
	:naturePower => :GROWTH,
	:mimicry => :GRASS,
	:damageMods => {
	},
	:accuracyMods => {},
	:moveMessages => {
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {},
	:typeMessages => {},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:FLOWERGARDEN2 => [:GROWTH,:FLOWERSHIELD,:RAINDANCE,:SUNNYDAY,:ROTOTILLER,:INGRAIN,:GRASSYTERRAIN,:WATERSPORT,:BLOOMDOOM],
	},
	:dontChangeBackup => [:GROWTH,:FLOWERSHIELD,:RAINDANCE,:SUNNYDAY, :ROTOTILLER,:INGRAIN,:GRASSYTERRAIN,:WATERSPORT,:BLOOMDOOM],
	:changeMessage => {
		"The garden grew a little!" => [:GROWTH,:FLOWERSHIELD,:RAINDANCE,:SUNNYDAY, :ROTOTILLER,:INGRAIN,:GRASSYTERRAIN,:WATERSPORT,:BLOOMDOOM],
	},
	:statusMods => [:GROWTH, :ROTOTILLER, :RAINDANCE, :WATERSPORT, :SUNNYDAY, :FLOWERSHIELD, :SWEETSCENT, :INGRAIN, :FLORALHEALING],
	:changeEffects => {},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => :Ingrain,
		:duration => true,
		:message => "{1} planted its roots!",
		:animation => :INGRAIN,
		:stats => {
			PBStats::SPDEF => 1,
		},
	},
},
:FLOWERGARDEN2 => {
	:name => "Flower Garden",
	:fieldMessage => [
		"Seeds line the field."
	],
	:graphic => ["FlowerGarden1"],
	:secretPower => "PETALBLIZZARD",
	:naturePower => :GROWTH,
	:mimicry => :GRASS,
	:damageMods => {
		1.5 => [:CUT],
	},
	:accuracyMods => {},
	:moveMessages => {
		"{1} was cut down to size!" => [:CUT],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.1 => [:GRASS],
	},
	:typeMessages => {
		"The garden's power boosted the attack!" => [:GRASS],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:FLOWERGARDEN3 => [:GROWTH,:FLOWERSHIELD,:RAINDANCE,:SUNNYDAY,:ROTOTILLER,:INGRAIN,:GRASSYTERRAIN,:WATERSPORT,:BLOOMDOOM],
		:FLOWERGARDEN1 => [:CUT,:XSCISSOR,:ACIDDOWNPOUR],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		"The garden was cut down a bit!" => [:CUT,:XSCISSOR],
		"The garden grew a little!" => [:GROWTH,:FLOWERSHIELD,:RAINDANCE,:SUNNYDAY,:ROTOTILLER,:INGRAIN,:GRASSYTERRAIN,:WATERSPORT,:BLOOMDOOM],
		"The acid melted the bloom!" => [:ACIDDOWNPOUR],
	},
	:statusMods => [:GROWTH, :ROTOTILLER, :RAINDANCE, :WATERSPORT, :SUNNYDAY, :FLOWERSHIELD, :SWEETSCENT, :INGRAIN, :FLORALHEALING],
	:changeEffects => {},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => :Ingrain,
		:duration => true,
		:message => "{1} planted its roots!",
		:animation => :INGRAIN,
		:stats => {
			PBStats::SPDEF => 1,
		},
	},
},
:FLOWERGARDEN3 => {
	:name => "Flower Garden",
	:fieldMessage => [
		"Seeds line the field."
	],
	:graphic => ["FlowerGarden2"],
	:secretPower => "PETALBLIZZARD",
	:naturePower => :GROWTH,
	:mimicry => :GRASS,
	:damageMods => {
		1.5 => [:CUT],
		1.2 => [:PETALBLIZZARD,:PETALDANCE,:FLEURCANNON],
	},
	:accuracyMods => {
		85 => [:SLEEPPOWDER, :STUNSPORE, :POISONPOWDER],
	},
	:moveMessages => {
		"{1} was cut down to size!" => [:CUT],
		"The fresh scent of flowers boosted the attack!" => [:PETALBLIZZARD,:PETALDANCE,:FLEURCANNON],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:FIRE,:BUG],
		1.3 => [:GRASS],
	},
	:typeMessages => {
		"The budding flowers boosted the attack!" => [:GRASS],
		"The attack infested the garden!" => [:BUG],
		"The nearby flowers caught flame!" => [:FIRE],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {
		:BURNING => "state.effects[:WaterSport] <= 0 && pbWeather != :RAINDANCE",
	},
	:fieldChange => {
		:FLOWERGARDEN4 => [:GROWTH,:FLOWERSHIELD,:RAINDANCE,:SUNNYDAY,:ROTOTILLER,:INGRAIN,:GRASSYTERRAIN,:WATERSPORT,:BLOOMDOOM],
		:FLOWERGARDEN2 => [:CUT,:XSCISSOR],
		:FLOWERGARDEN1 => [:ACIDDOWNPOUR,:HEATWAVE,:ERUPTION,:SEARINGSHOT,:FLAMEBURST,:LAVAPLUME,:FIREPLEDGE,:MINDBLOWN,:INFERNOOVERDRIVE],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		"The garden caught fire!" => [:HEATWAVE,:ERUPTION,:SEARINGSHOT,:FLAMEBURST,:LAVAPLUME,:FIREPLEDGE,:MINDBLOWN,:INFERNOOVERDRIVE],
		"The garden was cut down a bit!" => [:CUT,:XSCISSOR],
		"The garden grew a little!" => [:GROWTH,:FLOWERSHIELD,:RAINDANCE,:SUNNYDAY,:ROTOTILLER,:INGRAIN,:GRASSYTERRAIN,:WATERSPORT,:BLOOMDOOM],
		"The acid melted the bloom!" => [:ACIDDOWNPOUR],
	},
	:statusMods => [:GROWTH, :ROTOTILLER, :RAINDANCE, :WATERSPORT, :SUNNYDAY, :FLOWERSHIELD, :SWEETSCENT, :INGRAIN, :FLORALHEALING],
	:changeEffects => {},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => :Ingrain,
		:duration => true,
		:message => "{1} planted its roots!",
		:animation => :INGRAIN,
		:stats => {
			PBStats::SPDEF => 1,
		},
	},
},
:FLOWERGARDEN4 => {
	:name => "Flower Garden",
	:fieldMessage => [
		"Seeds line the field."
	],
	:graphic => ["FlowerGarden3"],
	:secretPower => "PETALBLIZZARD",
	:naturePower => :GROWTH,
	:mimicry => :GRASS,
	:damageMods => {
		1.5 => [:CUT,:PETALBLIZZARD,:PETALDANCE,:FLEURCANNON],
	},
	:accuracyMods => {
		85 => [:SLEEPPOWDER, :STUNSPORE, :POISONPOWDER],
	},
	:moveMessages => {
		"{1} was cut down to size!" => [:CUT],
		"The vibrant aroma scent of flowers boosted the attack!" => [:PETALBLIZZARD,:PETALDANCE,:FLEURCANNON],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		2.0 => [:BUG],
		1.5 => [:FIRE,:GRASS],
	},
	:typeMessages => {
		"The blooming flowers boosted the attack!" => [:GRASS],
		"The attack infested the flowers!" => [:BUG],
		"The nearby flowers caught flame!" => [:FIRE],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {
		:BURNING => "state.effects[:WaterSport] <= 0 && pbWeather != :RAINDANCE",
	},
	:fieldChange => {
		:FLOWERGARDEN5 => [:GROWTH,:FLOWERSHIELD,:RAINDANCE,:SUNNYDAY,:ROTOTILLER,:INGRAIN,:GRASSYTERRAIN,:WATERSPORT,:BLOOMDOOM],
		:FLOWERGARDEN3 => [:CUT,:XSCISSOR],
		:FLOWERGARDEN1 => [:ACIDDOWNPOUR],
		:FLOWERGARDEN2 => [:HEATWAVE,:ERUPTION,:SEARINGSHOT,:FLAMEBURST,:LAVAPLUME,:FIREPLEDGE,:MINDBLOWN,:INFERNOOVERDRIVE],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		"The garden caught fire!" => [:HEATWAVE,:ERUPTION,:SEARINGSHOT,:FLAMEBURST,:LAVAPLUME,:FIREPLEDGE,:MINDBLOWN,:INFERNOOVERDRIVE],
		"The garden was cut down a bit!" => [:CUT,:XSCISSOR],
		"The garden grew a little!" => [:GROWTH,:FLOWERSHIELD,:RAINDANCE,:SUNNYDAY,:ROTOTILLER,:INGRAIN,:GRASSYTERRAIN,:WATERSPORT,:BLOOMDOOM],
		"The acid melted the bloom!" => [:ACIDDOWNPOUR],
	},
	:statusMods => [:GROWTH, :ROTOTILLER, :RAINDANCE, :WATERSPORT, :SUNNYDAY, :FLOWERSHIELD, :SWEETSCENT, :INGRAIN, :FLORALHEALING],
	:changeEffects => {},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => :Ingrain,
		:duration => true,
		:message => "{1} planted its roots!",
		:animation => :INGRAIN,
		:stats => {
			PBStats::SPDEF => 1,
		},
	},
},
:FLOWERGARDEN5 => {
	:name => "Flower Garden",
	:fieldMessage => [
		"Seeds line the field."
	],
	:graphic => ["FlowerGarden4"],
	:secretPower => "PETALDANCE",
	:naturePower => :PETALBLIZZARD,
	:mimicry => :GRASS,
	:damageMods => {
		1.5 => [:CUT,:PETALBLIZZARD,:PETALDANCE,:FLEURCANNON],
	},
	:accuracyMods => {
		85 => [:SLEEPPOWDER, :STUNSPORE, :POISONPOWDER],
	},
	:moveMessages => {
		"{1} was cut down to size!" => [:CUT],
		"The vibrant aroma scent of flowers boosted the attack!" => [:PETALBLIZZARD,:PETALDANCE,:FLEURCANNON],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		2.0 => [:GRASS,:BUG],
		1.5 => [:FIRE],
	},
	:typeMessages => {
		"The thriving flowers boosted the attack!" => [:GRASS],
		"The attack infested the flowers!" => [:BUG],
		"The nearby flowers caught flame!" => [:FIRE],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {
		:BURNING => "state.effects[:WaterSport] <= 0 && pbWeather != :RAINDANCE",
	},
	:fieldChange => {
		:FLOWERGARDEN4 => [:CUT,:XSCISSOR],
		:FLOWERGARDEN1 => [:ACIDDOWNPOUR],
		:FLOWERGARDEN3 => [:HEATWAVE,:ERUPTION,:SEARINGSHOT,:FLAMEBURST,:LAVAPLUME,:FIREPLEDGE,:MINDBLOWN,:INFERNOOVERDRIVE],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		"The garden caught fire!" => [:HEATWAVE,:ERUPTION,:SEARINGSHOT,:FLAMEBURST,:LAVAPLUME,:FIREPLEDGE,:MINDBLOWN,:INFERNOOVERDRIVE],
		"The garden was cut down a bit!" => [:CUT,:XSCISSOR],
		"The acid melted the bloom!" => [:ACIDDOWNPOUR],
	},
	:statusMods => [:GROWTH, :ROTOTILLER, :RAINDANCE, :WATERSPORT, :SUNNYDAY, :FLOWERSHIELD, :SWEETSCENT, :INGRAIN, :FLORALHEALING],
	:changeEffects => {},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => :Ingrain,
		:duration => true,
		:message => "{1} planted its roots!",
		:animation => :INGRAIN,
		:stats => {
			PBStats::SPDEF => 1,
		},
	},
},
:STARLIGHT => {
	:name => "Starlight Arena",
	:fieldMessage => [
		"Starlight fills the battlefield."
	],
	:graphic => ["Starlight","Starlight1"],
	:secretPower => "SWIFT",
	:naturePower => :MOONBLAST,
	:mimicry => :DARK,
	:damageMods => {
		1.5 => [:AURORABEAM, :SIGNALBEAM, :FLASHCANNON, :LUSTERPURGE, :DAZZLINGGLEAM, :MIRRORSHOT, :MIRRORBEAM, :TECHNOBLAST, :SOLARBEAM, :PHOTONGEYSER, :MOONBLAST, :PRISMATICLASER, :NIGHTSLASH, :NIGHTDAZE],
		2.0 => [:DRACOMETEOR, :METEORMASH, :COMETPUNCH, :SPACIALREND, :SWIFT, :HYPERSPACEHOLE, :HYPERSPACEFURY, :MOONGEISTBEAM, :SUNSTEELSTRIKE, :METEORASSAULT, :BLACKHOLEECLIPSE, :SEARINGSUNRAZESMASH, :MENACINGMOONRAZEMAELSTROM, :LIGHTTHATBURNSTHESKY],
		4.0 => [:DOOMDUMMY],
	},
	:accuracyMods => {},
	:moveMessages => {
		"Starlight surged through the attack!" => [:AURORABEAM, :SIGNALBEAM, :FLASHCANNON, :LUSTERPURGE, :DAZZLINGGLEAM, :MIRRORSHOT, :MIRRORBEAM, :TECHNOBLAST, :SOLARBEAM, :PHOTONGEYSER, :PRISMATICLASER, :LIGHTTHATBURNSTHESKY],
		"Lunar energy surged through the attack!" => [:MOONBLAST, :NIGHTSLASH, :NIGHTDAZE],
		"The astral energy boosted the attack!" => [:DRACOMETEOR, :METEORMASH, :COMETPUNCH, :SPACIALREND, :SWIFT, :HYPERSPACEFURY, :MOONGEISTBEAM, :SUNSTEELSTRIKE, :METEORASSAULT, :BLACKHOLEECLIPSE, :SEARINGSUNRAZESMASH, :MENACINGMOONRAZEMAELSTROM],
		"The astral vortex accelerated the attack!" => [:HYPERSPACEHOLE],
		"A star came crashing down!" => [:DOOMDUMMY],
	},
	:typeMods => {
		:FIRE => [:DOOMDUMMY],
		:FAIRY => [:SOLARBEAM, :SOLARBLADE],
	},
	:typeAddOns => {
		:FAIRY => [:DARK],
	},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:DARK, :PSYCHIC],
		1.3 => [:FAIRY],
	},
	:typeMessages => {
		"Starlight supercharged the attack!" => [:FAIRY],
		"The night sky boosted the attack!" => [:DARK],
		"The astral energy boosted the attack!" => [:PSYCHIC],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:INDOOR => [:LIGHTTHATBURNSTHESKY],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "The cosmic light was consumed!" => [:LIGHTTHATBURNSTHESKY],
	},
	:statusMods => [:AURORAVEIL, :COSMICPOWER, :FLASH, :WISH, :HEALINGWISH, :LUNARDANCE, :MOONLIGHT, :TRICKROOM, :MAGICROOM, :WONDERROOM, :LUNARBLESSING],
	:changeEffects => {},
	:seed => {
		:seedtype => :MAGICALSEED,
		:effect => nil,
		:duration => 0,
		:message => nil,
		:animation => nil,
		:stats => {
			PBStats::SPATK => 1,
		},
	},
},
:NEWWORLD => {
	:name => "New World",
	:fieldMessage => [
		"From darkness, from stardust,",
		"From memories of eons past and visions yet to come...",
	],
	:graphic => ["NewWorld"],
	:secretPower => "ROAROFTIME",
	:naturePower => :SPACIALREND,
	:mimicry => :DARK,
	:damageMods => {
		1.5 => [:AURORABEAM, :SIGNALBEAM, :FLASHCANNON, :DAZZLINGGLEAM, :MIRRORSHOT, :MIRRORBEAM, :PHOTONGEYSER, :PSYSTRIKE, :AEROBLAST, :SACREDFIRE, :MISTBALL, :LUSTERPURGE, :ORIGINPULSE, :PRECIPICEBLADES, :DRAGONASCENT, :PSYCHOBOOST, :ROAROFTIME, :MAGMASTORM, :CRUSHGRIP, :JUDGMENT, :SEEDFLARE, :SHADOWFORCE, :SEARINGSHOT, :VCREATE, :SECRETSWORD, :SACREDSWORD, :RELICSONG, :FUSIONBOLT, :FUSIONFLARE, :ICEBURN, :FREEZESHOCK, :BOLTSTRIKE, :BLUEFLARE, :TECHNOBLAST, :OBLIVIONWING, :LANDSWRATH, :THOUSANDARROWS, :THOUSANDWAVES, :DIAMONDSTORM, :STEAMERUPTION, :COREENFORCER, :FLEURCANNON, :PRISMATICLASER, :SUNSTEELSTRIKE, :SPECTRALTHIEF, :MOONGEISTBEAM, :MULTIATTACK, :MINDBLOWN, :PLASMAFISTS, :EARTHPOWER, :POWERGEM, :ERUPTION, :CONTINENTALCRUSH, :GENESISSUPERNOVA, :SOULSTEALING7STARSTRIKE, :SEARINGSUNRAZESMASH, :MENACINGMOONRAZEMAELSTROM],
		2.0 => [:VACUUMWAVE, :DRACOMETEOR, :METEORMASH, :MOONBLAST, :COMETPUNCH, :SWIFT, :HYPERSPACEHOLE, :SPACIALREND, :HYPERSPACEFURY, :ANCIENTPOWER, :FUTUREDUMMY, :BLACKHOLEECLIPSE, :LIGHTTHATBURNSTHESKY],
		4.0 => [:DOOMDUMMY],
		0.25 => [:EARTHQUAKE, :MAGNITUDE, :BULLDOZE],
		0 => [:HAIL, :SUNNYDAY, :SANDSTORM, :RAINDANCE, :SHADOWSKY, :GRASSYTERRAIN, :PSYCHICTERRAIN, :MISTYTERRAIN, :ELECTRICTERRAIN, :MIST, :FISSURE],
	},
	:accuracyMods => {
		100 => [:DARKVOID],
	},
	:moveMessages => {
		"The light shone through the infinite darkness!" => [:AURORABEAM, :SIGNALBEAM, :FLASHCANNON, :DAZZLINGGLEAM, :MIRRORSHOT, :MIRRORBEAM, :PHOTONGEYSER, :LIGHTTHATBURNSTHESKY],
		"The ethereal energy strengthened the attack!" => [:PSYSTRIKE, :AEROBLAST, :SACREDFIRE, :MISTBALL, :LUSTERPURGE, :ORIGINPULSE, :PRECIPICEBLADES, :DRAGONASCENT, :PSYCHOBOOST, :ROAROFTIME, :MAGMASTORM, :CRUSHGRIP, :JUDGMENT, :SEEDFLARE, :SHADOWFORCE, :SEARINGSHOT, :VCREATE, :SECRETSWORD, :SACREDSWORD, :RELICSONG, :FUSIONBOLT, :FUSIONFLARE, :GLACIATE, :ICEBURN, :FREEZESHOCK, :BOLTSTRIKE, :BLUEFLARE, :TECHNOBLAST, :OBLIVIONWING, :LANDSWRATH, :THOUSANDARROWS, :THOUSANDWAVES, :DIAMONDSTORM, :STEAMERUPTION, :COREENFORCER, :FLEURCANNON, :PRISMATICLASER, :SUNSTEELSTRIKE, :SPECTRALTHIEF, :MOONGEISTBEAM, :MULTIATTACK, :MINDBLOWN, :PLASMAFISTS, :GENESISSUPERNOVA, :SOULSTEALING7STARSTRIKE, :SEARINGSUNRAZESMASH, :MENACINGMOONRAZEMAELSTROM],
		"The germinal matter amassed in the attack!" => [:EARTHPOWER, :POWERGEM, :ERUPTION, :CONTINENTALCRUSH],
		"The astral energy boosted the attack!" => [:VACUUMWAVE, :DRACOMETEOR, :METEORMASH, :MOONBLAST, :COMETPUNCH, :SWIFT, :HYPERSPACEHOLE, :SPACIALREND, :HYPERSPACEFURY, :ANCIENTPOWER, :FUTUREDUMMY],
		"A star came crashing down on {1}!" => [:DOOMDUMMY],
		"{1} was swallowed up by the void!" => [:BLACKHOLEECLIPSE],
		"The unformed land diffused the attack..." => [:EARTHQUAKE, :MAGNITUDE, :BULLDOZE, :FISSURE],
		"The terrain had no solid ground to attach..." => [:GRASSYTERRAIN, :PSYCHICTERRAIN, :MISTYTERRAIN, :ELECTRICTERRAIN, :MIST],
		"The weather drifted off into space..." => [:HAIL, :SUNNYDAY, :SANDSTORM, :RAINDANCE, :SHADOWSKY]
	},
	:typeMods => {
		:FIRE => [:DOOMDUMMY],
	},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:DARK],
	},
	:typeMessages => {
		"Infinity boosted the attack!" => [:DARK],
	},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:STARLIGHT => [:GRAVITY, :GEOMANCY],
	},
	:dontChangeBackup => [:GRAVITY],
	:changeMessage => {
		 "The world's matter reformed!" => [:GRAVITY],
		 "The world was regenerated!" => [:GEOMANCY],
	},
	:statusMods => [:DARKVOID, :HEARTSWAP, :TRICKROOM, :MAGICROOM, :WONDERROOM, :COSMICPOWER, :FLASH, :MOONLIGHT, :NATURESMADNESS, :LUNARBLESSING],
	:changeEffects => {},
	:seed => {
		:seedtype => :MAGICALSEED,
		:effect => :HyperBeam,
		:duration => 1,
		:message => "{1} must recharge!",
		:animation => nil,
		:stats => {
			PBStats::ATTACK => 1,
			PBStats::DEFENSE => 1,
			PBStats::SPEED => 1,
			PBStats::SPATK => 1,
			PBStats::SPDEF => 1,
		},
	},
},
:INVERSE => {
	:name => "Inverse Field",
	:fieldMessage => [
		"!trats elttaB"
	],
	:graphic => ["Inverse"],
	:secretPower => "CONFUSION",
	:naturePower => :TRICKROOM,
	:mimicry => :NORMAL,
	:damageMods => {
		1.5 => [:MATRIXSHOT]
	},
	:accuracyMods => {},
	:moveMessages => {
		"The attack shattered through the matrix!" => [:MATRIXSHOT]
	},
	# Matrix Shot becomes a Matrix-Type attack in inverse field
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {},
	:typeMessages => {},
	:typeCondition => {},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
	},
	:dontChangeBackup => [],
	:changeMessage => {
	},
	:statusMods => [],
	:changeEffects => {},
	:seed => {
		:seedtype => :MAGICALSEED,
		:effect => :HyperBeam,
		:duration => 1,
		:message => "{1} was normalized!",
		:animation => :SHARPEN,
		:stats => {},
	},
},
:PSYTERRAIN => {
	:name => "Psychic Terrain",
	:fieldMessage => [
		"The field became mysterious!"
	],
	:graphic => ["Psychic","Psychic_2"],
	:secretPower => "PSYCHIC",
	:naturePower => :PSYCHIC,
	:mimicry => :PSYCHIC,
	:damageMods => {
		1.5 => [:SECRETPOWER, :HIDDENPOWER, :HEX, :MAGICALLEAF, :MYSTICALFIRE, :MOONBLAST, :AURASPHERE, :FOCUSBLAST, :MINDBLOWN, :HIDDENPOWERNOR, :HIDDENPOWERFIR, :HIDDENPOWERFIG, :HIDDENPOWERWAT, :HIDDENPOWERFLY, :HIDDENPOWERGRA, :HIDDENPOWERPOI, :HIDDENPOWERELE, :HIDDENPOWERGRO, :HIDDENPOWERPSY, :HIDDENPOWERROC, :HIDDENPOWERICE, :HIDDENPOWERBUG, :HIDDENPOWERDRA, :HIDDENPOWERGHO, :HIDDENPOWERDAR, :HIDDENPOWERSTE, :HIDDENPOWERFAI],
	},
	:accuracyMods => {
		90 => [:HYPNOSIS],
	},
	:moveMessages => {
		"The psychic energy strengthened the attack!" => [:SECRETPOWER, :HIDDENPOWER, :HEX, :MAGICALLEAF, :MYSTICALFIRE, :MOONBLAST, :AURASPHERE, :FOCUSBLAST, :MINDBLOWN, :HIDDENPOWERNOR, :HIDDENPOWERFIR, :HIDDENPOWERFIG, :HIDDENPOWERWAT, :HIDDENPOWERFLY, :HIDDENPOWERGRA, :HIDDENPOWERPOI, :HIDDENPOWERELE, :HIDDENPOWERGRO, :HIDDENPOWERPSY, :HIDDENPOWERROC, :HIDDENPOWERICE, :HIDDENPOWERBUG, :HIDDENPOWERDRA, :HIDDENPOWERGHO, :HIDDENPOWERDAR, :HIDDENPOWERSTE, :HIDDENPOWERFAI],
	},
	:typeMods => {},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:PSYCHIC],
	},
	:typeMessages => {
		"The Psychic Terrain strengthened the attack!" => [:PSYCHIC],
	},
	:typeCondition => {
		:PSYCHIC => "!attacker.isAirborne?",
	},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
	},
	:dontChangeBackup => [],
	:changeMessage => {
	},
	:statusMods => [:CALMMIND, :COSMICPOWER, :KINESIS, :MEDITATE, :NASTYPLOT, :HYPNOSIS, :PSYCHUP, :MINDREADER, :MIRACLEEYE, :TELEKINESIS, :GRAVITY, :MAGICROOM, :TRICKROOM, :WONDERROOM],
	:changeEffects => {},
	:seed => {
		:seedtype => :MAGICALSEED,
		:effect => nil,
		:duration => 0,
		:message => nil,
		:animation => nil,
		:stats => {
			PBStats::SPATK => 2,
		},
	},
	:overlay => {
		:damageMods => {
			1.5 => [:SECRETPOWER, :HIDDENPOWER, :MYSTICALFIRE,:MAGICALLEAF,:AURASPHERE,:FOCUSBLAST,:HEX,:MOONBLAST,:MINDBLOWN],
		},
		:typeMods => {
		},
		:moveMessages => {
			"The psychic energy strengthened the attack!" => [:SECRETPOWER, :HIDDENPOWER, :MYSTICALFIRE,:MAGICALLEAF,:AURASPHERE,:HEX,:MOONBLAST,:MINDBLOWN],
		},
		:typeBoosts => {
			1.5 => [:PSYCHIC],
		},
		:typeMessages => {
			"The Psychic Terrain strengthened the attack!" => [:PSYCHIC],
		},
		:typeCondition => {	
			:PSYCHIC => "!attacker.isAirborne?",
		},
		:statusMods => [],
	},
},
:DIMENSIONAL => {
	:name => "Dimensional Field",
	:fieldMessage => [
		"Darkness Radiates."
	],
	:graphic => ["Dimensional","Dimensional1","AelitaRift","DimensionalGard"],
	:secretPower => "DARKPULSE",
	:naturePower => :DARKPULSE,
	:mimicry => :DARK,
	:damageMods => {
		1.5 => [:HYPERSPACEFURY, :HYPERSPACEHOLE, :SPACIALREND, :ROAROFTIME, :ETERNABEAM, :DYNAMAXCANNON, :SHADOWFORCE, :OUTRAGE, :THRASH, :STOMPINGTANTRUM, :LASHOUT, :FREEZINGGLARE, :FIREYWRATH, :RAGINGFURY],
		1.2 => [:DARKPULSE, :NIGHTDAZE],
		0 => [:HAIL, :SUNNYDAY, :SANDSTORM, :RAINDANCE, :TEATIME, :LUCKYCHANT],
	},
	:accuracyMods => {
		0 => [:DARKVOID, :DARKPULSE, :NIGHTDAZE],
	},
	:moveMessages => {
		"The attack has been corrupted." => [:HYPERSPACEFURY, :HYPERSPACEHOLE, :SPACIALREND, :ROAROFTIME, :ETERNABEAM, :DYNAMAXCANNON, :SHADOWFORCE, :DARKPULSE, :NIGHTDAZE],
		"The rage continues." => [:OUTRAGE, :THRASH, :STOMPINGTANTRUM, :LASHOUT, :FREEZINGGLARE, :FIREYWRATH, :RAGINGFURY],
		"But it failed." => [:TEATIME, :LUCKYCHANT],
		"The dark dimension swallowed the sand." => [:SANDSTORM],
		"The dark dimension swallowed the rain." => [:RAINDANCE],
		"The dark dimension swallowed the " + HAILSNOWLOWMOD + "." => [:HAIL],
		"The sunlight cannot pierce the darkness." => [:SUNNYDAY],
	},
	:typeMods => {
	},
	:typeAddOns => {
	},
	:moveEffects => {
		"@battle.field.counter += 1" => [:BLIZZARD, :COLDTRUTH],
		"@battle.field.counter = 2" => [:ICEBURN, :FREEZESHOCK, :GLACIATE, :SUBZEROSLAMMER, :SHEERCOLD],
	},
	:typeBoosts => {
		1.5 => [:DARK, :SHADOW],
		1.2 => [:GHOST],
		0.5 => [:FAIRY],
	},
	:typeMessages => {
		"The darkness is here..." => [:DARK],
		"The shadow is strengthened..." => [:SHADOW],
		"The evil aura powered up the attack..." => [:GHOST],
		"The evil aura depleted the attack!" => [:FAIRY],
	},
	:typeCondition => {
	},
	:typeEffects => {},
	:changeCondition => {
		:FROZENDIMENSION => "@battle.field.counter > 1",
	},
	:fieldChange => {
		:FROZENDIMENSION => [:BLIZZARD, :SHEERCOLD, :ICEBURN, :FREEZESHOCK, :GLACIATE, :COLDTRUTH, :SUBZEROSLAMMER],
		:INFERNAL => [:PRECIPICEBLADES],
		:INDOOR => [:PURIFY, :SEEDFLARE],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "The dimension froze up!" => [:BLIZZARD, :SHEERCOLD, :ICEBURN, :FREEZESHOCK, :GLACIATE, :COLDTRUTH],
		 "The field went up in flames!" => [:PRECIPICEBLADES],
		 "The dimension was purified!" => [:PURIFY, :SEEDFLARE],
	},
	:statusMods => [:OBSTRUCT, :QUASH, :EMBARGO, :HEALBLOCK, :DARKVOID],
	:changeEffects => {},
	:seed => {
		:seedtype => :MAGICALSEED,
		:effect => nil,
		:duration => nil,
		:message => nil,
		:animation => :TRICKROOM,
		:stats => {
			PBStats::DEFENSE => 1,
		},
	},
},
:FROZENDIMENSION => {
	:name => "Frozen Dimensional Field",
	:fieldMessage => [
		"Hate and anger radiates."
	],
	:graphic => ["Angie"],
	:secretPower => "ICEBEAM",
	:naturePower => :ICEBEAM,
	:mimicry => :ICE,
	:damageMods => {
		1.5 => [:RAGINGFURY,:THRASH,:OUTRAGE,:STOMPINGTANTRUM,:RAGE,:LASHOUT,:FREEZINGGLARE,:FIERYWRATH,:ROAROFTIME],
		1.3 => [:SURF, :MUDDYWATER, :WATERPULSE, :HYDROPUMP, :NIGHTSLASH, :DARKPULSE, :HYPERSPACEFURY, :HYPERSPACEHOLE, :CHILLINGWATER],
		0 => [:MAGICROOM, :WONDERROOM, :TRICKROOM, :GRAVITY, :COURTCHANGE, :TEATIME, :ELECTRICTERRAIN, :GRASSYTERRAIN, :PSYCHICTERRAIN, :MISTYTERRAIN],
	},
	:accuracyMods => {
		100 => [:DARKVOID],
	},
	:moveMessages => {
		"The rage continues." => [:RAGINGFURY,:THRASH,:OUTRAGE,:STOMPINGTANTRUM,:RAGE,:LASHOUT,:FREEZINGGLARE,:FIERYWRATH,:ROAROFTIME],
		"The ice warped the attack." => [:SURF, :MUDDYWATER, :WATERPULSE, :HYDROPUMP, :NIGHTSLASH, :DARKPULSE, :HYPERSPACEFURY, :HYPERSPACEHOLE],
		"The frozen dimension remains unchanged." => [:MAGICROOM, :WONDERROOM, :TRICKROOM, :GRAVITY, :COURTCHANGE, :ELECTRICTERRAIN, :GRASSYTERRAIN, :PSYCHICTERRAIN, :MISTYTERRAIN],
		"But it failed." => [:TEATIME],
	},
	:typeMods => {
		:ICE => [:SURF, :MUDDYWATER, :WATERPULSE, :HYDROPUMP, :NIGHTSLASH, :DARKPULSE, :CHILLINGWATER],
	},
	:typeAddOns => {
	},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:ICE],
		1.3 => [:DARK],
		0.5 => [:FIRE],
	},
	:typeMessages => {
		"The darkness is here..." => [:DARK],
		"The dimension mutated the ice!" => [:ICE],
	},
	:typeCondition => {
	},
	:typeEffects => {},
	:changeCondition => {
	},
	:fieldChange => {
		:DIMENSIONAL => [:HEATWAVE, :ERUPTION, :SEARINGSHOT, :FLAMEBURST, :LAVAPLUME, :FIREPLEDGE, :MINDBLOWN, :INCINERATE, :INFERNOOVERDRIVE, :RAGINGFURY],
		:ICY => [:PURIFY],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "The dimension thawed away!" => [:HEATWAVE, :ERUPTION, :SEARINGSHOT, :FLAMEBURST, :LAVAPLUME, :FIREPLEDGE, :MINDBLOWN, :INCINERATE, :INFERNOOVERDRIVE, :RAGINGFURY],
		 "The dimension was purified!" => [:PURIFY],
	},
	:statusMods => [:PARTINGSHOT, :AURORAVEIL, :DARKVOID],
	:changeEffects => {},
	:seed => {
		:seedtype => :ELEMENTALSEED,
		:effect => :Torment,
		:duration => true,
		:message => "{1} is subjected to torment!",
		:animation => :TORMENT,
		:stats => {
			PBStats::SPEED => 2,
		},
	},
},
:HAUNTED => {
	:name => "Haunted Field",
	:fieldMessage => [
		"The field is haunted!"
	],
	:graphic => ["Haunted","Haunted2","Haunted3"],
	:secretPower => "SHADOWCLAW",
	:naturePower => :PHANTOMFORCE,
	:mimicry => :GHOST,
	:damageMods => {
		1.5 => [:FLAMEBURST, :INFERNO, :FLAMECHARGE, :FIRESPIN, :BONECLUB, :BONERUSH, :BONEMERANG, :ASTONISH],
		1.2 => [:SHADOWBONE],
	},
	:accuracyMods => {
		90 => [:WILLOWISP, :HYPNOSIS],
	},
	:moveMessages => {
		"Will-o'-wisps joined the attack!" => [:FLAMEBURST, :INFERNO, :FLAMECHARGE, :FIRESPIN],
		"Spooky scary skeletons!" => [:BONECLUB, :BONERUSH, :BONEMERANG, :SHADOWBONE],	
		"Boo!" => [:ASTONISH],
	},
	:typeMods => {
		:GHOST => [:FLAMEBURST, :INFERNO, :FLAMECHARGE, :FIRESPIN],
	},
	:typeAddOns => {
	},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:GHOST],
	},
	:typeMessages => {
		"The evil aura powered up the attack!" => [:GHOST],
	},
	:typeCondition => {
	},
	:typeEffects => {},
	:changeCondition => {
	},
	:fieldChange => {
		:HOLY => [:JUDGEMENT, :ORIGINPULSE, :SACREDFIRE, :PURIFY],
		:INDOOR => [:FLASH, :DAZZLINGGLEAM],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "The evil spirits have been exorcised!" => [:JUDGEMENT, :ORIGINPULSE, :PURIFY, :SACREDFIRE],
		 "The evil spirits have been forced back!" => [:FLASH, :DAZZLINGGLEAM],
	},
	:statusMods => [:NIGHTMARE, :SPITE, :CURSE, :DESTINYBOND, :MEANLOOK, :SCARYFACE, :MAGICPOWDER, :HYPNOSIS, :WILLOWISP],
	:changeEffects => {},
	:seed => {
		:seedtype => :MAGICALSEED,
		:effect => :nil,
		:duration => nil,
		:message => nil,
		:animation => nil,
		:stats => {
			PBStats::SPDEF => 1,
			PBStats::DEFENSE => 1,
		},
	},
},
:CORRUPTED => {
	:name => "Corrupted Cave",
	:fieldMessage => [
		"Corruption seeps from every crevice!"
	],
	:graphic => ["Corrupted"],
	:secretPower => "POISONJAB",
	:naturePower => :GUNKSHOT,
	:mimicry => :POISON,
	:damageMods => {
		1.5 => [:SEEDFLARE, :APPLEACID],
	},
	:accuracyMods => {
	},
	:moveMessages => {
		"The move absorbed the filth!" => [:SEEDFLARE],
	},
	:typeMods => {
		:POISON => [:ROCKSLIDE, :SMACKDOWN, :STONEEDGE, :ROCKTOMB, :DIAMONDSTORM],
		:ROCK => [:SLUDGEWAVE, :GUNKSHOT],
	},
	:typeAddOns => {
	},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:POISON],
		1.2 => [:ROCK, :GRASS],
		0.5 => [:FAIRY, :FLYING],
	},
	:typeMessages => {
		"The chemicals strengthened the attack." => [:POISON],
		"The corruption morphed the attack!" => [:ROCK, :GRASS],
		"The corruption weakened the attack." => [:FAIRY],
		"The cave choked out the air!" => [:FLYING],
	},
	:typeCondition => {
		:FLYING => "!self.contactMove?",
	},
	:typeEffects => {},
	:changeCondition => {
	},
	:fieldChange => {
		:CAVE => [:SOLARBEAM, :SOLARBLADE, :PURIFY, :SEEDFLARE],
		:VOLCANIC => [:HEATWAVE, :ERUPTION, :LAVAPLUME, :BLASTBURN, :INFERNOOVERDRIVE],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "The cave was purified!" => [:SOLARBEAM, :SOLARBLADE, :PURIFY, :SEEDFLARE],
	},
	:statusMods => [:NIGHTMARE, :SPITE, :CURSE, :DESTINYBOND, :MEANLOOK, :SCARYFACE, :MAGICPOWDER, :HYPNOSIS, :WILLOWISP],
	:changeEffects => {
		"@battle.mistExplosion(basemove, user)" => [:HEATWAVE, :ERUPTION, :LAVAPLUME, :BLASTBURN, :INFERNOOVERDRIVE],
	},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => nil,
		:duration => nil,
		:message => nil,
		:animation => nil,
		:stats => {
			PBStats::DEFENSE => 2,
		},
	},
},
:BEWITCHED => {
	:name => "Bewitched Woods",
	:fieldMessage => [
		"Everlasting glow and glamour!"
	],
	:graphic => ["Darchlight"],
	:secretPower => "NEEDLEARM",
	:naturePower => :MOONBLAST,
	:mimicry => :FAIRY,
	:damageMods => {
		1.5 => [:HEX, :MYSTICALFIRE, :SPIRITBREAK],
		1.3 => [:ICEBEAM, :HYPERBEAM, :SIGNALBEAM, :AURORABEAM, :CHARGEBEAM, :PSYBEAM, :FLASHCANNON, :MIRRORBEAM, :MAGICALLEAF, :BUBBLEBEAM, :DARKPULSE, :NIGHTDAZE, :MOONBLAST],
	},
	:accuracyMods => {
		95 => [:SLEEPPOWDER, :POISONPOWDER, :STUNSPORE],
		85 => [:GRASSWHISTLE]
	},
	:moveMessages => {
		"Magic aura amplified the attack!" => [:HEX, :MYSTICALFIRE, :SPIRITBREAK, :ICEBEAM, :HYPERBEAM, :SIGNALBEAM, :AURORABEAM, :CHARGEBEAM, :PSYBEAM, :FLASHCANNON, :MIRRORBEAM, :MAGICALLEAF, :BUBBLEBEAM],
		"The forest is cursed with nightfall!" => [:DARKPULSE, :NIGHTDAZE, :MOONBLAST],
	},
	:typeMods => {
	},
	:typeAddOns => {
	},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:FAIRY, :GRASS],
		1.3 => [:DARK],
	},
	:typeMessages => {
		"The fairy aura amplified the attack's power!" => [:FAIRY],
		"Flourish!" => [:GRASS],
		"The dark aura amplified the attack's power!" => [:DARK],
	},
	:typeCondition => {
	},
	:typeEffects => {},
	:changeCondition => {
	},
	:fieldChange => {
		:FOREST => [:PURIFY],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "The evil spirits have been exorcised!" => [:PURIFY],
	},
	:statusMods => [:STRENGTHSAP, :FORESTSCURSE, :MAGICPOWDER, :MOONLIGHT, :SLEEPPOWDER, :POISONPOWDER, :STUNSPORE, :GRASSWHISTLE],
	:changeEffects => {},
	:seed => {
		:seedtype => :MAGICALSEED,
		:effect => :Ingrain,
		:duration => true,
		:message => "{1} planted its roots.",
		:animation => :INGRAIN,
		:stats => {
			PBStats::SPDEF => 1,
		},
	},
},
:SKY => {
	:name => "Sky Field",
	:fieldMessage => [
		"The sky is filled with clouds. "
	],
	:graphic => ["GoldenArena"],
	:secretPower => "WINGATTACK",
	:naturePower => :SKYATTACK,
	:mimicry => :FLYING,
	:damageMods => {
		1.5 => [:ICYWIND, :SILVERWIND, :OMINOUSWIND, :FAIRYWIND, :AEROBLAST, :FLYINGPRESS, :SKYUPPERCUT, :THUNDERSHOCK, :THUNDERBOLT, :STEELWING, :DRAGONDARTS, :GRAVAPPLE, :DRAGONASCENT, :THUNDER, :TWISTER, :RAZORWIND, :DIVE, :ESPERWING, :BLEAKWINDSTORM],
		1.3 => [:SPRINGTIDESTORM, :WINDBOLTSTORM, :SANDSEARSTORM],
		0 => [:EARTHQUAKE, :MAGNITUDE, :BULLDOZE, :DIG, :ROTOTILLER, :SPIKES, :TOXICSPIKES, :STICKYWEB]
	},
	:accuracyMods => {
		0 => [:THUNDER, :HURRICANE]
	},
	:moveMessages => {
		"The open skies strengthened the attack!" => [:ICYWIND, :SILVERWIND, :OMINOUSWIND, :FAIRYWIND, :AEROBLAST, :FLYINGPRESS, :SKYUPPERCUT, :THUNDERSHOCK, :THUNDERBOLT, :STEELWING, :DRAGONDARTS, :GRAVAPPLE, :DRAGONASCENT, :THUNDER, :TWISTER, :RAZORWIND, :DIVE, :ESPERWING, :SPRINGTIDESTORM, :WINDBOLTSTORM, :SANDSEARSTORM, :BLEAKWINDSTORM],
		"But there is no solid ground!" => [:EARTHQUAKE, :MAGNITUDE, :BULLDOZE, :DIG, :ROTOTILLER, :SPIKES, :TOXICSPIKES, :STICKYWEB]
	},
	:typeMods => {
		:FLYING => [:DIVE, :TWISTER],
	},
	:typeAddOns => {
	},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:FLYING],
	},
	:typeMessages => {
		"The open air strengthened the attack!" => [:FLYING],
	},
	:typeCondition => {
	},
	:typeEffects => {},
	:changeCondition => {
	},
	:fieldChange => {
		:MOUNTAIN => [:GRAVITY, :INGRAIN, :THOUSANDARROWS, :SMACKDOWN, :GRAVAPPLE],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "The battle has been brought down to the mountains!" => [:GRAVITY, :INGRAIN, :THOUSANDARROWS, :SMACKDOWN, :GRAVAPPLE],
	},
	:statusMods => [:MIRRORMOVE, :TAILWIND, :SUNNYDAY, :HAIL, :SANDSTORM, :RAINDANCE],
	:changeEffects => {},
	:seed => {
		:seedtype => :ELEMENTALSEED,
		:effect => 0,
		:duration => 0,
		:message => nil,
		:animation => nil,
		:stats => {
			PBStats::DEFENSE => 1,
			PBStats::SPDEF => 1,
		},
	},
},
:COLOSSEUM => {
	:name => "Colosseum",
	:fieldMessage => [
		"All eyes are on the combatants!"
	],
	:graphic => ["Colosseum"],
	:secretPower => "POWERUPPUNCH",
	:naturePower => :BEATUP,
	:mimicry => :STEEL,
	:damageMods => {
		2.0 => [:BEATUP, :FELLSTINGER, :PAYDAY, :REVERSAL, :PURSUIT],
		1.5 => [:SACREDSWORD, :SECRETSWORD, :SUBMISSION, :METEORASSAULT, :SMARTSTRIKE, :SMACKDOWN, :BRUTALSWING, :ELECTROWEB, :VINEWHIP, :PSYCHOCUT, :NIGHTSLASH, :BONEMERANG, :FIRSTIMPRESSION, :BONERUSH, :BONECLUB, :LEAFBLADE, :PAYBACK, :PUNISHMENT, :METEORMASH, :BULLETPUNCH, :CLANGINGSCALES, :STEAMROLLER],
		1.2 => [:STORMTHROW, :WOODHAMMER, :DRAGONHAMMER, :POWERWHIP, :SPIRITSHACKLE, :DRILLRUN, :DRILLPECK, :ICEHAMMER, :ICICLESPEAR, :ANCHORSHOT, :CRABHAMMER, :SHADOWBONE, :FIRELASH, :SUCKERPUNCH, :THROATCHOP],
		0 => [:BATONPASS, :ENCORE, :WHIRLWIND],
	},
	:accuracyMods => {
	},
	:moveMessages => {
		"The fighters rallied together!" => [:BEATUP],
		"The coup de grâce!" => [:FELLSTINGER],
		"The audience hurled coins down!" => [:PAYDAY],
		"There is no escape!" => [:PURSUIT],
		"For Honor!" => [:REVERSAL, :SACREDSWORD, :SECRETSWORD, :SUBMISSION, :METEORASSAULT, :SMARTSTRIKE, :SMACKDOWN, :BRUTALSWING, :STORMTHROW],
		"For Glory!" => [:ELECTROWEB, :VINEWHIP, :PSYCHOCUT, :NIGHTSLASH, :BONEMERANG, :FIRSTIMPRESSION, :BONERUSH, :BONECLUB, :LEAFBLADE, :PAYBACK, :PUNISHMENT, :METEORMASH, :BULLETPUNCH, :CLANGINGSCALES, :STEAMROLLER, :WOODHAMMER, :DRAGONHAMMER, :POWERWHIP, :SPIRITSHACKLE, :DRILLRUN, :DRILLPECK, :ICEHAMMER, :ICICLESPEAR, :ANCHORSHOT, :CRABHAMMER, :SHADOWBONE, :FIRELASH, :SUCKERPUNCH, :THROATCHOP],
		"There can be no retreat!" => [:BATONPASS],
		"{1} stands their ground in the arena!!" => [:WHIRLWIND],
		"The audience demands fighting not repetition!" => [:ENCORE],
	},
	:typeMods => {
	},
	:typeAddOns => {
	},
	:moveEffects => {},
	:typeBoosts => {},
	:typeMessages => {},
	:typeCondition => {
	},
	:typeEffects => {},
	:changeCondition => {
	},
	:fieldChange => {
	},
	:dontChangeBackup => [],
	:changeMessage => {
	},
	:statusMods => [:SWORDSDANCE, :KINGSSHIELD, :HOWL, :NORETREAT, :ROAR, :SWAGGER, :FLATTER],
	:changeEffects => {},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => :Taunt,
		:duration => 4,
		:message => "{1} feels taunted!",
		:animation => :TAUNT,
		:stats => {
			PBStats::ATTACK => 2,
		},
	},
},
:INFERNAL => {
	:name => "Infernal Field",
	:fieldMessage => [
		"The souls of the damned burn on."
	],
	:graphic => ["Infernal"],
	:secretPower => "INFERNO",
	:naturePower => :PUNISHMENT,
	:mimicry => :FIRE,
	:damageMods => {
		5.0 => [:SMOG],
		2.0 => [:PUNISHMENT, :DREAMEATER, :CENTIFERNO],
		1.5 => [:BLASTBURN, :EARTHPOWER, :INFERNOOVERDRIVE, :PRECIPICEBLADES, :INFERNO, :RAGINGFURY, :INFERNALPARADE, :FIRELASH],
		0  => [:RAINDANCE, :HAIL],
	},
	:accuracyMods => {
		0 => [:WILLOWISP, :DARKVOID, :INFERNO, :MAGMASTORM],
	},
	:moveMessages => {
		"Hellish Suffering!" => [:PUNISHMENT, :SMOG, :DREAMEATER, :CENTIFERNO, :FIRELASH],
		"Infernal flames strengthened the attack" => [:BLASTBURN, :EARTPOWER, :INFERNOOVERDRIVE, :PRECIPICEBLADES, :INFERNO, :RAGINGFURY, :INFERNALPARADE, :FIRELASH],
		"The " + HAILSNOWLOWMOD + " melted away." => [:HAIL],
		"The rain evaporated." => [:RAINDANCE],
	},
	:typeMods => {
		:DARK => [:SPIRITBREAK, :AURASPHERE, :FRUSTRATION],
	},
	:typeAddOns => {
		:FIRE => [:GROUND, :STEEL, :ROCK],
	},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:FIRE, :DARK],
		0.5 => [:FAIRY, :WATER],
	},
	:typeMessages => {
		"The infernal flames strengthened the attack!" => [:FIRE, :DARK],
		"The hellfire burnt out the attack!" => [:FAIRY, :WATER],
	},
	:typeCondition => {
		:FAIRY => "@move != :SPIRITBREAK",
	},
	:typeEffects => {},
	:changeCondition => {
	},
	:fieldChange => {
		:DIMENSIONAL => [:GLACIATE],
		:VOLCANICTOP => [:JUDGEMENT, :ORIGINPULSE, :PURIFY],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		 "The hellish landscape was doused of its fire!" => [:GLACIATE],
		 "The hellish landscape was purified!" => [:JUDGEMENT, :ORIGINPULSE, :PURIFY],
	},
	:statusMods => [:WILLOWISP, :DARKVOID, :TORMENT, :NIGHTMARE, :STEALTHROCK],
	:changeEffects => {},
	:seed => {
		:seedtype => :ELEMENTALSEED,
		:effect => nil,
		:duration => nil,
		:message => "{1} can't escape now!",
		:animation => :MEANLOOK,
		:stats => {
			PBStats::ATTACK => 1,
			PBStats::SPATK => 1,
		},
	},
},
:CONCERT1 => {
	:name => "Concert Venue",
	:fieldMessage => [
		"Let's get HYPED!"
	],
	:graphic => ["Concert1"],
	:secretPower => "BOOMBURST",
	:naturePower => :HYPERVOICE,
	:mimicry => :NORMAL,
	:damageMods => {
		1.5 => [:ACID,:ACIDSPRAY,:DRUMBEATING,:FAKEOUT,:ROLLOUT,:FIRSTIMPRESSION,:DRAGONTAIL,:CIRCLETHROW,:RAGE,:THRASH,:FRUSTRATION,:OUTRAGE,:STOMPINGTANTRUM,:STEAMROLLER],
	},
	:accuracyMods => {
		100 => [:SING],
	},
	:moveMessages => {
		"Face melting!" => [:ACID,:ACIDSPRAY,:APPLEACID],
		"Rock and roll!" => [:ROLLOUT,:STEAMROLLER],
		"An amazing drumsolo!" => [:DRUMBEATING],
		"What an opening act!" => [:FIRSTIMPRESSION,:FAKEOUT],
		"MOSHPIT!!!" => [:DRAGONTAIL,:CIRCLETHROW],
		"The outraged audience is rioting!" => [:RAGE,:THRASH,:FRUSTRATION,:OUTRAGE,:STOMPINGTANTRUM],
	},
	:typeMods => {
	},
	:typeAddOns => {
	},
	:moveEffects => {},
	:typeBoosts => {
	},
	:typeMessages => {
	},
	:typeCondition => {
	},
	:typeEffects => {},
	:changeCondition => {
	},
	:fieldChange => {
		:CONCERT2 => [:WORKUP,:ROLLOUT,:FIRSTIMPRESSION,:DRUMBEATING,:REVELATIONDANCE,:FIERYDANCE,:PETALDANCE,:DRAGONDANCE,:QUIVERDANCE,:AQUABATICS,:SWORDSDANCE,:FEATHERDANCE,:SWAGGER,:BOOMBURST,:BUGBUZZ,:CHATTER,:CLANGINGSCALES,:CLANGOROUSSOUL,:CLANGOROUSSOULBLAZE,:DISARMINGVOICE,:ECHOEDVOICE,:GROWL,:HOWL,:HYPERVOICE,:METALSOUND,:NOBLEROAR,:OVERDRIVE,:PARTINGSHOT,:RELICSONG,:ROAR,:ROUND,:SCREECH,:SHADOWPANIC,:SING,:SNARL,:SPARKLINGARIA,:SUPERSONIC,:UPROAR,:FEVERPITCH,:SPECTRALSCREAM,:SHIFTGEAR],
		:CONCERT3 => [:LASERFOCUS,:LUCKYCHANT,:FOCUSENERGY,:SPOTLIGHT,:FOLLOWME],
		:CONCERT4 => [:SELFDESTRUCT,:EXPLOSION],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		"The stunning dance makes the audience go wild!" => [:REVELATIONDANCE,:FIERYDANCE,:PETALDANCE,:DRAGONDANCE,:QUIVERDANCE,:AQUABATICS,:SWORDSDANCE,:FEATHERDANCE],
		"The song is getting the audience hyped!" => [:BOOMBURST,:BUGBUZZ,:CHATTER,:CLANGINGSCALES,:CLANGOROUSSOUL,:CLANGOROUSSOULBLAZE,:DISARMINGVOICE,:ECHOEDVOICE,:GROWL,:HOWL,:HYPERVOICE,:METALSOUND,:NOBLEROAR,:OVERDRIVE,:PARTINGSHOT,:RELICSONG,:ROAR,:ROUND,:SCREECH,:SHADOWPANIC,:SING,:SNARL,:SPARKLINGARIA,:SUPERSONIC,:UPROAR,:FEVERPITCH,:SPECTRALSCREAM],
		"The crowd is getting hyped!" => [:DRUMBEATING,:FIRSTIMPRESSION,:WORKUP,:ROLLOUT,:SWAGGER,:SHIFTGEAR],
		"The audience's full attention is on the stage!" => [:LASERFOCUS,:LUCKYCHANT,:FOCUSENERGY,:SPOTLIGHT,:FOLLOWME],
		"The audience cheers for the explosive finish!!" => [:SELFDESTRUCT,:EXPLOSION],
	},
	:statusMods => [:ACIDARMOR,:WORKUP,:HOWL,:PARTINGSHOT,:METALSOUND,:SCREECH,:GROWL,:CLANGOROUSSOUL,:SING,:ROAR,:ENCORE],
	:changeEffects => {
		"@battle.concertNoise" => [:LASERFOCUS,:LUCKYCHANT,:FOCUSENERGY,:SPOTLIGHT,:FOLLOWME,:SELFDESTRUCT,:EXPLOSION]
	},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => :HelpingHand,
		:duration => true,
		:message => "{1} accepts the crowd's help!",
		:animation => :HELPINGHAND,
		:stats => {
			PBStats::SPATK => 1,
		},
	},
},
:CONCERT2 => {
	:name => "Concert Venue",
	:fieldMessage => [
		"Let's get HYPED!"
	],
	:graphic => ["Concert2"],
	:secretPower => "BOOMBURST",
	:naturePower => :HYPERVOICE,
	:mimicry => :NORMAL,
	:damageMods => {
		1.5 => [:ACID,:ACIDSPRAY,:DRUMBEATING,:FAKEOUT,:ROLLOUT,:FIRSTIMPRESSION,:DRAGONTAIL,:CIRCLETHROW,:RAGE,:THRASH,:FRUSTRATION,:OUTRAGE,:STOMPINGTANTRUM, :STEAMROLLER],
	},
	:accuracyMods => {
		100 => [:SING],
	},
	:moveMessages => {
		"Face melting!" => [:ACID,:ACIDSPRAY,:APPLEACID],
		"Rock and roll!" => [:ROLLOUT, :STEAMROLLER],
		"An amazing drumsolo!" => [:DRUMBEATING],
		"What an opening act!" => [:FIRSTIMPRESSION,:FAKEOUT],
		"MOSHPIT!!!" => [:DRAGONTAIL,:CIRCLETHROW],
		"The outraged Audience is rioting!" => [:RAGE,:THRASH,:FRUSTRATION,:OUTRAGE,:STOMPINGTANTRUM],
	},
	:typeMods => {
	},
	:typeAddOns => {
	},
	:moveEffects => {},
	:typeBoosts => {
	},
	:typeMessages => {
	},
	:typeCondition => {
	},
	:typeEffects => {},
	:changeCondition => {
		:CONCERT1 => "!attacker.missAcc || (basemove.move != :SHEERCOLD && basemove.move != :COLDTRUTH)",
	},
	:fieldChange => {
		:CONCERT1 => [:THROATCHOP,:SHEERCOLD,:COLDTRUTH,:EMBARGO,:QUASH,:SLACKOFF,:YAWN,:PLAYNICE,:BABYDOLLEYES,:TICKLE],
		:CONCERT3 => [:WORKUP,:ROLLOUT,:FIRSTIMPRESSION,:DRUMBEATING,:REVELATIONDANCE,:FIERYDANCE,:PETALDANCE,:DRAGONDANCE,:QUIVERDANCE,:AQUABATICS,:SWORDSDANCE,:FEATHERDANCE,:SWAGGER,:BOOMBURST,:BUGBUZZ,:CHATTER,:CLANGINGSCALES,:CLANGOROUSSOUL,:CLANGOROUSSOULBLAZE,:DISARMINGVOICE,:ECHOEDVOICE,:GROWL,:HOWL,:HYPERVOICE,:METALSOUND,:NOBLEROAR,:OVERDRIVE,:PARTINGSHOT,:RELICSONG,:ROAR,:ROUND,:SCREECH,:SHADOWPANIC,:SING,:SNARL,:SPARKLINGARIA,:SUPERSONIC,:UPROAR,:FEVERPITCH,:SPECTRALSCREAM],
		:CONCERT4 => [:LASERFOCUS,:LUCKYCHANT,:FOCUSENERGY,:SPOTLIGHT,:FOLLOWME,:SELFDESTRUCT,:EXPLOSION],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		"The freezing cold drives the audience away..." => [:SHEERCOLD],
		"'Bitter cold AND preaching? I am out of here!'" => [:COLDTRUTH],
		"The leadsingers voice fails..." => [:THROATCHOP],
		"The bar is closed and the crowd does NOT like it..." => [:EMBARGO],
		"The crowd is booing, they want action!" => [:QUASH,:SLACKOFF,:YAWN],
		"The audience is not a fan of this friendly touchy-feely stuff..." => [:PLAYNICE,:BABYDOLLEYES,:TICKLE],
		"The stunning dance makes the audience go wild!" => [:REVELATIONDANCE,:FIERYDANCE,:PETALDANCE,:DRAGONDANCE,:QUIVERDANCE,:AQUABATICS,:SWORDSDANCE,:FEATHERDANCE],
		"The song is getting the audience hyped!" => [:BOOMBURST,:BUGBUZZ,:CHATTER,:CLANGINGSCALES,:CLANGOROUSSOUL,:CLANGOROUSSOULBLAZE,:DISARMINGVOICE,:ECHOEDVOICE,:GROWL,:HOWL,:HYPERVOICE,:METALSOUND,:NOBLEROAR,:OVERDRIVE,:PARTINGSHOT,:RELICSONG,:ROAR,:ROUND,:SCREECH,:SHADOWPANIC,:SING,:SNARL,:SPARKLINGARIA,:SUPERSONIC,:UPROAR,:FEVERPITCH,:SPECTRALSCREAM],
		"The crowd is getting hyped!" => [:DRUMBEATING,:FIRSTIMPRESSION,:WORKUP,:ROLLOUT,:SWAGGER],
		"The audience's full attention is on the stage!" => [:LASERFOCUS,:LUCKYCHANT,:FOCUSENERGY,:SPOTLIGHT,:FOLLOWME],
		"The audience cheers for the explosive finish!!" => [:SELFDESTRUCT,:EXPLOSION],
	},
	:statusMods => [:ACIDARMOR,:WORKUP,:HOWL,:PARTINGSHOT,:METALSOUND,:SCREECH,:GROWL,:CLANGOROUSSOUL,:SING,:ROAR,:ENCORE],
	:changeEffects => {
		"@battle.concertNoise" => [:WORKUP,:ROLLOUT,:FIRSTIMPRESSION,:DRUMBEATING,:REVELATIONDANCE,:FIERYDANCE,:PETALDANCE,:DRAGONDANCE,:QUIVERDANCE,:AQUABATICS,:SWORDSDANCE,:FEATHERDANCE,:SWAGGER,:LASERFOCUS,:LUCKYCHANT,:FOCUSENERGY,:SPOTLIGHT,:FOLLOWME,:BOOMBURST,:BUGBUZZ,:CHATTER,:CLANGINGSCALES,:CLANGOROUSSOUL,:CLANGOROUSSOULBLAZE,:DISARMINGVOICE,:ECHOEDVOICE,:GROWL,:HOWL,:HYPERVOICE,:METALSOUND,:NOBLEROAR,:OVERDRIVE,:PARTINGSHOT,:RELICSONG,:ROAR,:ROUND,:SCREECH,:SHADOWPANIC,:SING,:SNARL,:SPARKLINGARIA,:SUPERSONIC,:UPROAR,:FEVERPITCH,:SPECTRALSCREAM,:SELFDESTRUCT,:EXPLOSION]
	},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => :HelpingHand,
		:duration => true,
		:message => "{1} accepts the crowd's help!",
		:animation => :HELPINGHAND,
		:stats => {
			PBStats::SPATK => 1,
		},
	},
},
:CONCERT3 => {
	:name => "Concert Venue",
	:fieldMessage => [
		"Let's get HYPED!"
	],
	:graphic => ["Concert3"],
	:secretPower => "BOOMBURST",
	:naturePower => :HYPERVOICE,
	:mimicry => :NORMAL,
	:damageMods => {
		1.5 => [:ACID,:ACIDSPRAY,:DRUMBEATING,:FAKEOUT,:ROLLOUT,:FIRSTIMPRESSION,:DRAGONTAIL,:CIRCLETHROW, :STEAMROLLER],
	},
	:accuracyMods => {
		100 => [:SING],
	},
	:moveMessages => {
		"Face melting!" => [:ACID,:ACIDSPRAY,:APPLEACID],
		"Rock and roll!" => [:ROLLOUT, :STEAMROLLER],
		"An amazing drumsolo!" => [:DRUMBEATING],
		"What an opening act!" => [:FIRSTIMPRESSION,:FAKEOUT],
		"MOSHPIT!!!" => [:DRAGONTAIL,:CIRCLETHROW],
	},
	:typeMods => {
	},
	:typeAddOns => {
	},
	:moveEffects => {},
	:typeBoosts => {
	},
	:typeMessages => {
	},
	:typeCondition => {
	},
	:typeEffects => {},
	:changeCondition => {
		:CONCERT1 => "!attacker.missAcc",
	},
	:fieldChange => {
		:CONCERT1 => [:SHEERCOLD,:COLDTRUTH],
		:CONCERT2 => [:THROATCHOP,:EMBARGO,:QUASH,:SLACKOFF,:YAWN,:PLAYNICE,:BABYDOLLEYES,:TICKLE],
		:CONCERT4 => [:WORKUP,:ROLLOUT,:FIRSTIMPRESSION,:DRUMBEATING,:REVELATIONDANCE,:FIERYDANCE,:PETALDANCE,:DRAGONDANCE,:QUIVERDANCE,:AQUABATICS,:SWORDSDANCE,:FEATHERDANCE,:SWAGGER,:LASERFOCUS,:LUCKYCHANT,:FOCUSENERGY,:SPOTLIGHT,:FOLLOWME,:BOOMBURST,:BUGBUZZ,:CHATTER,:CLANGINGSCALES,:CLANGOROUSSOUL,:CLANGOROUSSOULBLAZE,:DISARMINGVOICE,:ECHOEDVOICE,:GROWL,:HOWL,:HYPERVOICE,:METALSOUND,:NOBLEROAR,:OVERDRIVE,:PARTINGSHOT,:RELICSONG,:ROAR,:ROUND,:SCREECH,:SHADOWPANIC,:SING,:SNARL,:SPARKLINGARIA,:SUPERSONIC,:UPROAR,:FEVERPITCH,:SPECTRALSCREAM,:SELFDESTRUCT,:EXPLOSION],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		"The freezing cold drives the audience away..." => [:SHEERCOLD],
		"'Bitter cold AND preaching? I am out of here!'" => [:COLDTRUTH],
		"The leadsingers voice fails..." => [:THROATCHOP],
		"The bar is closed and the crowd does NOT like it..." => [:EMBARGO],
		"The crowd is booing, they want action!" => [:QUASH,:SLACKOFF,:YAWN],
		"The audience is not a fan of this friendly touchy-feely stuff..." => [:PLAYNICE,:BABYDOLLEYES,:TICKLE],
		"The stunning dance makes the audience go wild!" => [:REVELATIONDANCE,:FIERYDANCE,:PETALDANCE,:DRAGONDANCE,:QUIVERDANCE,:AQUABATICS,:SWORDSDANCE,:FEATHERDANCE],
		"The song is getting the audience hyped!" => [:BOOMBURST,:BUGBUZZ,:CHATTER,:CLANGINGSCALES,:CLANGOROUSSOUL,:CLANGOROUSSOULBLAZE,:DISARMINGVOICE,:ECHOEDVOICE,:GROWL,:HOWL,:HYPERVOICE,:METALSOUND,:NOBLEROAR,:OVERDRIVE,:PARTINGSHOT,:RELICSONG,:ROAR,:ROUND,:SCREECH,:SHADOWPANIC,:SING,:SNARL,:SPARKLINGARIA,:SUPERSONIC,:UPROAR,:FEVERPITCH,:SPECTRALSCREAM],
		"The crowd is getting hyped!" => [:DRUMBEATING,:FIRSTIMPRESSION,:WORKUP,:ROLLOUT,:SWAGGER],
		"The audience's full attention is on the stage!" => [:LASERFOCUS,:LUCKYCHANT,:FOCUSENERGY,:SPOTLIGHT,:FOLLOWME],
		"The audience cheers for the explosive finish!!" => [:SELFDESTRUCT,:EXPLOSION],
	},
	:statusMods => [:ACIDARMOR,:WORKUP,:HOWL,:PARTINGSHOT,:METALSOUND,:SCREECH,:GROWL,:CLANGOROUSSOUL,:SING,:ROAR,:ENCORE],
	:changeEffects => {
		"@battle.concertNoise" => [:WORKUP,:ROLLOUT,:FIRSTIMPRESSION,:DRUMBEATING,:REVELATIONDANCE,:FIERYDANCE,:PETALDANCE,:DRAGONDANCE,:QUIVERDANCE,:AQUABATICS,:SWORDSDANCE,:FEATHERDANCE,:SWAGGER,:LASERFOCUS,:LUCKYCHANT,:FOCUSENERGY,:SPOTLIGHT,:FOLLOWME,:BOOMBURST,:BUGBUZZ,:CHATTER,:CLANGINGSCALES,:CLANGOROUSSOUL,:CLANGOROUSSOULBLAZE,:DISARMINGVOICE,:ECHOEDVOICE,:GROWL,:HOWL,:HYPERVOICE,:METALSOUND,:NOBLEROAR,:OVERDRIVE,:PARTINGSHOT,:RELICSONG,:ROAR,:ROUND,:SCREECH,:SHADOWPANIC,:SING,:SNARL,:SPARKLINGARIA,:SUPERSONIC,:UPROAR,:FEVERPITCH,:SPECTRALSCREAM,:SELFDESTRUCT,:EXPLOSION]
	},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => :HelpingHand,
		:duration => true,
		:message => "{1} accepts the crowd's help!",
		:animation => :HELPINGHAND,
		:stats => {
			PBStats::SPATK => 1,
		},
	},
},
:CONCERT4 => {
	:name => "Concert Venue",
	:fieldMessage => [
		"Let's get HYPED!"
	],
	:graphic => ["Concert4"],
	:secretPower => "BOOMBURST",
	:naturePower => :HYPERVOICE,
	:mimicry => :NORMAL,
	:damageMods => {
		1.5 => [:ACID,:ACIDSPRAY,:DRUMBEATING,:FAKEOUT,:ROLLOUT,:FIRSTIMPRESSION,:DRAGONTAIL,:CIRCLETHROW, :STEAMROLLER],
	},
	:accuracyMods => {
		100 => [:SING],
	},
	:moveMessages => {
		"Face melting!" => [:ACID,:ACIDSPRAY,:APPLEACID],
		"Rock and roll!" => [:ROLLOUT, :STEAMROLLER],
		"An amazing drumsolo!" => [:DRUMBEATING],
		"What an opening act!" => [:FIRSTIMPRESSION,:FAKEOUT],
		"MOSHPIT!!!" => [:DRAGONTAIL,:CIRCLETHROW],
	},
	:typeMods => {
	},
	:typeAddOns => {
	},
	:moveEffects => {},
	:typeBoosts => {
	},
	:typeMessages => {
	},
	:typeCondition => {
	},
	:typeEffects => {},
	:changeCondition => {
		:CONCERT1 => "!attacker.missAcc",
	},
	:fieldChange => {
		:CONCERT1 => [:SHEERCOLD,:COLDTRUTH],
		:CONCERT3 => [:THROATCHOP,:EMBARGO,:QUASH,:SLACKOFF,:YAWN,:PLAYNICE,:BABYDOLLEYES,:TICKLE],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		"The freezing cold drives the audience away..." => [:SHEERCOLD],
		"'Bitter cold AND preaching? I am out of here!'" => [:COLDTRUTH],
		"The leadsingers voice fails..." => [:THROATCHOP],
		"The bar is closed and the crowd does NOT like it..." => [:EMBARGO],
		"The crowd is booing, they want action!" => [:QUASH,:SLACKOFF,:YAWN],
		"The audience is not a fan of this friendly touchy-feely stuff..." => [:PLAYNICE,:BABYDOLLEYES,:TICKLE],
	},
	:statusMods => [:ACIDARMOR,:WORKUP,:HOWL,:PARTINGSHOT,:METALSOUND,:SCREECH,:GROWL,:CLANGOROUSSOUL,:SING,:ROAR,:ENCORE],
	:changeEffects => {},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => :HelpingHand,
		:duration => true,
		:message => "{1} accepts the crowd's help!",
		:animation => :HELPINGHAND,
		:stats => {
			PBStats::SPATK => 1,
		},
	},
},
:DEEPEARTH => {
	:name => "Deep Earth",
	:fieldMessage => [
		"The core is pulling you in...",
	],
	:graphic => ["DeepEarth","Zeight","Zeight2","Zeight3","Zeight4"],
	:secretPower => "HEAVYSLAM",
	:naturePower => :GRAVITY,
	:mimicry => :GROUND,
	:damageMods => {
		2.0 => [:LANDSWRATH, :PRECIPICEBLADES, :MAGNETBOMB, :TECTONICRAGE, :CRUSHGRIP, :SMACKDOWN, :COREENFORCER],
		1.5 => [:HEAVYSLAM,	:HEATCRASH, :BODYSLAM, :STOMP, :DRAGONRUSH, :STEAMROLLER, :GRAVAPPLE, :ANCIENTPOWER, :FLING, :GRASSKNOT, :LOWKICK, :SPACIALREND, :STORMTHROW, :CIRCLETHROW, :VITALTHROW, :BODYPRESS, :SUBMISSION, :ICEHAMMER, :HAMMERARM, :CRABHAMMER, :ICICLECRASH, :THOUSANDARROWS, :THOUSANDWAVES, :MATRIXSHOT],
	},
	:accuracyMods => {
	},
	:moveMessages => {
		"The attack came crashing down!" => [:HEAVYSLAM, :HEATCRASH, :BODYSLAM, :STOMP, :DRAGONRUSH, :STEAMROLLER, :GRAVAPPLE, :BODYPRESS, :ICICLECRASH, :FLING],
		"Enjoy the trip!" => [:GRASSKNOT, :LOWKICK],
		"{1} threw their whole weight into it!" => [:ICEHAMMER, :HAMMERARM, :CRABHAMMER],
		"Slammed into the ground!" => [:STORMTHROW, :CIRCLETHROW, :VITALTHROW, :SUBMISSION, :SMACKDOWN],
		"CRUSHED!" => [:CRUSHGRIP],
		"The magnetic field is strengthened!" => [:MAGNETBOMB],
		"The power of the earth is utterly overwhelming!"  => [:THOUSANDARROWS, :THOUSANDWAVES, :LANDSWRATH, :PRECIPICEBLADES, :TECTONICRAGE],
		"The power of ages gone by..." => [:ANCIENTPOWER],
		"The power of the core obliterates all!" => [:COREENFORCER],
		"The intense gravity is ruptured!" => [:SPACIALREND, :MATRIXSHOT],
	},
	:typeMods => {},
	:typeAddOns => {
	},
	:moveEffects => {},
	:typeBoosts => {
		1.3 => [:ROCK, :PSYCHIC],
		1.5 => [:GROUND],
	},
	:typeMessages => {
		"The core's magical forces are immense!" => [:PSYCHIC],
		"The earth empowered the attack!" => [:ROCK, :GROUND],
	},
	:typeCondition => {
		:GROUND => "!opponent.hasType?(:GROUND)",
	},
	:typeEffects => {},
	:changeCondition => {
	},
	:fieldChange => {
	},
	:dontChangeBackup => [],
	:changeMessage => {
	},
	:statusMods => [:AUTOTOMIZE, :GEOMANCY, :ROTOTILLER, :MAGNETFLUX, :EERIEIMPULSE, :MAGNETRISE, :GRAVITY, :TOPSYTURVY, :SEISMICTOSS, :PSYWAVE],
	:changeEffects => {},
	:seed => {
		:seedtype => :TELLURICSEED,
		:effect => nil,
		:duration => nil,
		:message => "{1}'s weight increased!",
		:animation => :QUASH,
		:stats => {
			PBStats::DEFENSE => 1,
		}
	},
},
:BACKALLEY => {
	:name => "Backalley",
	:fieldMessage => [
		"Shifty eyes are all around..."
	],
	:graphic => ["Under"],
	:secretPower => "SMOG",
	:naturePower => :BEATUP,
	:mimicry => :STEEL,
	:damageMods => {
		2 => [:SNARL, :FOULPLAY],
		1.5 => [:STEAMROLLER, :SMOG, :BEATUP, :PAYDAY, :INFESTATION, :SPECTRALTHIEF, :FIRSTIMPRESSION, :TECHNOBLAST, :SHADOWSNEAK,
			:XSCISSOR, :FURYCUTTER, :NIGHTSLASH, :SACREDSWORD, :AIRSLASH, :AERIALACE, :AIRCUTTER, :LEAFBLADE, :RAZORLEAF, :SLASH, :CUT, :CROSSPOISON, :PSYCHOCUT, :RAZORSHELL, :SOLARBLADE, :BEHEMOTHBLADE, :CEASELESSEDGE, :STONEAXE, :AQUACUTTER, :SLASHANDBURN, :HEXINGSLASH,
			:HORNATTACK, :FURYATTACK, :POISONSTING, :TWINEEDLE, :PINMISSILE, :PECK, :DRILLPECK, :MEGAHORN, :POISONJAB, :NEEDLEARM, :PLUCK, :DRILLRUN, :HORNLEECH, :FELLSTINGER, :SMARTSTRIKE, :BRANCHPOKE, :FALSESURRENDER, :GLACIALLANCE, :GILDEDARROW, :GILDEDHELIX, :QUICKSILVERSPEAR, :VENAMSKISS],
	},
	:accuracyMods => {
		0 => [:SMOG, :POISONGAS],
	},
	:moveMessages => {
		"A ferocious snarl!" => [:SNARL],
		"The power of science is amazing!" => [:TECHNOBLAST],
		"A crowd is gathering!" => [:BEATUP],
		"The city smog is suffocating!" => [:SMOG],
		"Careful on the street!" => [:STEAMROLLER],
		"Gotta make ends meet somehow..." => [:PAYDAY, :SPECTRALTHIEF, :SHADOWSNEAK],
		"A frightening first impression!" => [:FIRSTIMPRESSION],
		"A knife glints in the dark!" => [:XSCISSOR, :FURYCUTTER, :NIGHTSLASH, :SACREDSWORD, :AIRSLASH, :AERIALACE, :AIRCUTTER, :LEAFBLADE, :RAZORLEAF, :SLASH, :CUT, :CROSSPOISON, :PSYCHOCUT, :RAZORSHELL, :SOLARBLADE, :BEHEMOTHBLADE, :CEASELESSEDGE, :STONEAXE, :AQUACUTTER, :SLASHANDBURN, :HEXINGSLASH],
		"Better watch your back..." => [:HORNATTACK, :FURYATTACK, :POISONSTING, :TWINEEDLE, :PINMISSILE, :PECK, :DRILLPECK, :MEGAHORN, :POISONJAB, :NEEDLEARM, :PLUCK, :DRILLRUN, :HORNLEECH, :FELLSTINGER, :SMARTSTRIKE, :BRANCHPOKE, :FALSESURRENDER, :GLACIALLANCE, :GILDEDARROW, :GILDEDHELIX, :QUICKSILVERSPEAR, :VENAMSKISS],
	},
	:typeMods => {
		:DARK => [:FIRSTIMPRESSION],
		:POISON => [:BOOMBURST],
	},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:DARK],
		1.3 => [:POISON, :BUG, :STEEL],
		0.5 => [:FAIRY],
	},
	:typeMessages => {
		"Street rules!" => [:DARK],
		"The right tool for the job!" => [:STEEL],
		"In the cracks and the walls!" => [:BUG],
		"All kinds of pollution strengthened the attack!" => [:POISON],
		"This is no place for fairytales..." => [:FAIRY],
	},
	:typeCondition => {
		:DARK => "self.pbIsPhysical?(@type)",
	},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:CITY => [:UPROAR,:HYPERVOICE,:ECHOEDVOICE,:BOOMBURST],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		"Cops! Everyone scatter!" => [:UPROAR,:HYPERVOICE,:ECHOEDVOICE,:BOOMBURST],
	},
	:statusMods => [:SMOKESCREEN, :NASTYPLOT, :PARTINGSHOT, :FAKETEARS, :POISONGAS, :SMOG, :TRICK, :SWITCHEROO, :CORROSIVEGAS, :SNATCH],
	:changeEffects => {},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => 0,
		:duration => 0,
		:message => nil,
		:animation => nil,
		:stats => {
			PBStats::ATTACK => 1,
			PBStats::ACCURACY => 1,
		},
	},
},
:CITY => {
	:name => "City",
	:fieldMessage => [
		"The streets are busy..."
	],
	:graphic => ["GDCCentralSquare","City","GearenNew","GDCDreamDistrict","GDCDistrictOfHope","GDCJudicialDistrict","GDCScholarDistrict"],
	:secretPower => "SMOG",
	:naturePower => :SMOG,
	:mimicry => :NORMAL,
	:damageMods => {
		1.5 => [:STEAMROLLER, :SMOG, :BEATUP, :PAYDAY, :FIRSTIMPRESSION, :TECHNOBLAST],
	},
	:accuracyMods => {
		0 => [:SMOG, :POISONGAS],
	},
	:moveMessages => {
		"The power of science is amazing!" => [:TECHNOBLAST],
		"A crowd is gathering!" => [:BEATUP],
		"The city smog is suffocating!" => [:SMOG],
		"Careful on the street!" => [:STEAMROLLER],
		"Working 9 to 5 for this!" => [:PAYDAY],
		"An overwhelming first impression!" => [:FIRSTIMPRESSION],
	},
	:typeMods => {
		:NORMAL => [:FIRSTIMPRESSION],
	},
	:typeAddOns => {},
	:moveEffects => {},
	:typeBoosts => {
		1.5 => [:NORMAL],
		1.3 => [:POISON, :BUG, :STEEL],
		0.7 => [:FAIRY],
	},
	:typeMessages => {
		"The hustle and bustle of the city!" => [:NORMAL],
		"The power of science is amazing!" => [:STEEL],
		"In the cracks and the walls!" => [:BUG],
		"All kinds of pollution strengthened the attack!" => [:POISON],
		"This is no place for fairytales..." => [:FAIRY],
	},
	:typeCondition => {
		:NORMAL => "self.pbIsPhysical?(@type)",
	},
	:typeEffects => {},
	:changeCondition => {},
	:fieldChange => {
		:BACKALLEY => [:THIEF,:COVET,:PURSUIT],
	},
	:dontChangeBackup => [],
	:changeMessage => {
		"The criminal ran into a backalley!" => [:THIEF,:COVET,:PURSUIT],
	},
	:statusMods => [:SMOKESCREEN, :WORKUP, :AUTOTOMIZE, :SHIFTGEAR, :POISONGAS, :SMOG, :RECYCLE, :CORROSIVEGAS],
	:changeEffects => {},
	:seed => {
		:seedtype => :SYNTHETICSEED,
		:effect => 0,
		:duration => 0,
		:message => nil,
		:animation => nil,
		:stats => {
			PBStats::ATTACK => 1,
			PBStats::ACCURACY => 1,
		},
	},
},
}