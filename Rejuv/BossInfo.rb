BOSSINFOHASH = {
##############################
# Boss Template
##############################

    :GODKILLER => {
        :name => "God Killer", # nickname
        :shieldCount => 1, # number of shields
        :barGraphic => "", # what kind of hp bar graphic should be pulled
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :capturable => true, # can you catch this boss after shields are removed?
        :entryText => "Heaven-shaking Godkiller appeared.", # dialogue upon enterring battle as a wild pokemon
        :moninfo => { # bosspokemon details
            :species => :GARCHOMP,
            :level => 5,
            :form => 0,
            :item => :LEFTOVERS,
            :moves => [:DARKPULSE,:PSYSHOCK,:MOONLIGHT,:MOONBLAST],
            :ability => :RKSSYSTEM,
            :gender => "F",
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
            :ev => [252,0,4,0,252,0]
            },
        :sosDetails =>  { # sospokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount == 0",
            :continuous => true,
            :totalMonCount => 3,
            :moninfos => {
                1 => {
                    :species => :GARCHOMP,
                    :level => 5,
                    :form => 0,
                    :item => :LEFTOVERS,
                    :moves => [:DARKPULSE,:PSYSHOCK,:MOONLIGHT,:MOONBLAST],
                    :ability => :RKSSYSTEM,
                    :gender => "F",
                    :nature => :MODEST,
                    :iv => 31,
                    :happiness => 255,
                    :ev => [252,0,4,0,252,0]
                },
                2 => {
                    :species => :GYARADOS,
                    :level => 5,
                    :form => 0,
                    :item => :LEFTOVERS,
                    :moves => [:DARKPULSE,:PSYSHOCK,:MOONLIGHT,:MOONBLAST],
                    :ability => :RKSSYSTEM,
                    :gender => "F",
                    :nature => :MODEST,
                    :iv => 31,
                    :happiness => 255,
                    :ev => [252,0,4,0,252,0]
                    },
            },
        },
        :onEntryEffects => { # effects applied on entry, use same attributes/syntax as onbreakeffects
            :fieldChange => :PSYTERRAIN,
            :fieldChangeMessage => "Gothitelle laughs at how dumb your face looks. So mean!"
        },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            1 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "", # message that plays when shield is broken
                :bossEffect => :MagicCoat, # effect that applies on the boss when breaking shield
                :bossEffectduration => true, # duration of the effect(some effects are booleans, double check)
                :bossEffectMessage => "{1} shrouded itself with Magic Coat!", # message that plays for the effect
                :bossEffectanimation => :MAGICCOAT, # effect animation
                :weatherChange => :RAINDANCE, # weather to apply
                :formchange => 0, # formchanges
                :abilitychange => :DOWNLOAD, # ability to change to upon shieldbreaker
                :fieldChange => :SWAMP, # field changes
                :fieldChangeMessage => "", # message that plays when the field is changes
                :weatherCount => 5, # weather turncount
                :weatherChangeMessage => "Rain began to fall!", # weather message
                :weatherChangeAnimation => "Rain", # string of "Rain", "Sunny","Hail","Sandstorm"
                :typeChange => [:FIRE,:ROCK], # any given type changes
                :movesetUpdate => [:EARTHQUAKE,:OUTRAGE,:ROCKSLIDE,:FIREBLAST], # any given moveset changes
                :speciesUpdate => :FLYGON,
                :statusCure => true, # if status is cured when shield is broken
                :effectClear => true, # if effects are cleared when shield is broken
                :bossSideStatusChanges => [:PARALYSIS,"Paralysis"], # what status gets inflicted on a boss/player pokemon when shield is broken. array has 2 elements, first the status symbol, then a string for the animation
                :playerSideStatusChanges => [:PARALYSIS,"Paralysis"], # what status gets inflicted on a boss/player pokemon when shield is broken. array has 2 elements, first the status symbol, then a string for the animation
                :statDropCure => true, # if statdrops are negated when shield is broken
                :playerEffects => :Curse, # effects applied upon enemies on breaking shield
                :playerEffectsduration => true, # enemy effect durration
                :playerEffectsAnimation => :CURSE, # enemyeffect animation
                :playerEffectsMessage => "A curse was inflicted on the opposing side!", # enemy effect message
                :stateChanges => :TrickRoom, # handles state changes found in the Battle_Global class(in Battle_ActiveSide file + Trick Room
                :stateChangeAnimation => :TRICKROOM, # state change animation
                :stateChangeCount => 5, # state change turncount
                :stateChangeMessage => "The dimensions were changed!", # statechange messages
                :playersideChanges => :ToxicSpikes, # handles side changes found in the Battle_Side class(in Battle_ActiveSide file) 
                :playersideChangeAnimation => :TOXICSPIKES, # side change animation
                :playersideChangeCount => 1, # side change turncount
                :playersideChangeMessage => "Toxic Spikes was set up!", # statechange messages
                :bosssideChanges => :ToxicSpikes, # handles side changes found in the Battle_Side class(in Battle_ActiveSide file) 
                :bosssideChangeAnimation => :TOXICSPIKES, # side change animation
                :bosssideChangeCount => 1, # side change turncount
                :bosssideChangeMessage => "Toxic Spikes was set up!", # statechange messages
                :itemchange => :LEFTOVERS, # item that is given upon breaking shield
                :bgmChange => "Battle - Final Endeavor",
                :bossStatChanges => { # any statboosts that are given
                    PBStats::SPATK => 1,
                },
                :playerSideStatChanges => { # any statchanges applied to the players side
                    PBStats::SPATK => -1,
                }
            },
        },
    },
    
##############################
# Normal Bosses
##############################
    :BOSSGARBODOR => {
        :name => "Garbage Menace",
        :entryText => "The Garbodor approached!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :GARBODOR,
            :level => 12,
            :moves => [:POUND,:ACIDSPRAY,:DOUBLESLAP,:ATTRACT],
            :ability => :STENCH,
            :gender => "M",
            :shiny => true,
            :nature => :NAUGHTY,
            :happiness => 255,
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 1",
            :totalMonCount => 2,
            :moninfos => {
                1 => {
                    :species => :TRUBBISH,
                    :level => 11,
                    :moves => [:POUND,:POISONGAS,:THIEF,nil],
                    :ability => :STENCH,
                    :iv => 10,
                },
            },
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "Garbodor's typing changed!",
                :animation => :NASTYPLOT,
                :typeChange => [:POISON,:DARK],
            },
        }
    },

    :RIFTGYARADOS1 => {
        :name => "Rift Gyarados",
        :entryText => "Rift Gyarados attacked in a rage!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :GYARADOS,
            :level => 20,
            :form => 4,
            :moves => [:SHADOWSNEAK,:BITE,:WATERPULSE,:SCREECH],
            :ability => :INTIMIDATE,
            :gender => "M",
            :nature => :NAUGHTY,
            :iv => 20,
            :happiness => 255,
            :ev => [20,20,20,20,20,20]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "Rift Gyarados started acting defensive!",
                :animation => :WITHDRAW,
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::DEFENSE => 1
                }
            }
        }
    },
    
    :BOSSPYROAR => {
        :name => "Pride King",
        :entryText => "The freshly evolved Pyroar attacked!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :PYROAR,
            :level => 20,
            :moves => [:TAKEDOWN,:NOBLEROAR,:FIREFANG,:ROAR],
            :ability => :UNNERVE,
            :gender => "M",
            :nature => :NAUGHTY,
            :iv => 10,
            :happiness => 255,
            :ev => [0,0,0,0,0,0],
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 1",
            :totalMonCount => 2,
            :moninfos => {
                1 => {
                    :species => :LITLEO,
                    :level => 15,
                    :moves => [:EMBER,:HEADBUTT,:LEER,:WORKUP],
                    :ability => :UNNERVE,
                    :iv => 10,
                },
            },
        },
        :onBreakEffects => {
        },
    },
    :RIFTCHANDELURE => {
        :name => "Rift Chandelure",
        :entryText => "Otherworldly wind chimes echo through the air...",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :CHANDELURE,
            :level => 60,
            :item => :FIREGEM,
            :form => 2,
            :moves => [:SHADOWBALL,:AIRSLASH,:FIREBLAST,:WILLOWISP],
            :gender => "M",
            :nature => :TIMID,
            :iv => 31,
            :happiness => 255,
            :ev => [0,0,0,252,4,252]
        },
        :onEntryEffects => {
            :message => "A feeling of warmth emanates from Rift Chandelure...",
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :animation => :OMINOUSWIND,
                :message => "The air feels cold and moist...",
                :statDropRefresh => true,
                :bossStatChanges => {
                    PBStats::SPATK => 1,
                },
                :itemchange => :WATERGEM,
                :typeChange => [:GHOST,:WATER],
                :movesetUpdate => [:SHADOWBALL,:AIRSLASH,:SURF,:WHIRLPOOL],
                :abilitychange => :TRACE
            },
            2 => {
                :threshold => 0,
                :animation => :OMINOUSWIND,
                :message => "A sickly sweet scent attacks your nose...",
                :statDropRefresh => true,
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                    PBStats::SPDEF => 1,
                },
                :itemchange => :GRASSGEM,
                :typeChange => [:GHOST,:GRASS],
                :movesetUpdate => [:SHADOWBALL,:AIRSLASH,:ENERGYBALL,:LEECHSEED],
                :abilitychange => :TRACE
            },
            1 => {
                :threshold => 0,
                :animation => :OMINOUSWIND,
                :message => "The feeling of static is all around...",
                :statDropRefresh => true,
                :bossStatChanges => {
                    PBStats::SPEED => 1,
                },
                :itemchange => :ELECTRICGEM,
                :typeChange => [:GHOST,:ELECTRIC],
                :movesetUpdate => [:SHADOWBALL,:AIRSLASH,:THUNDERBOLT,:THUNDERWAVE],
                :abilitychange => :TRACE
            },
        }
    },
    :SHADOWMEWTWO => {
        :name => "Shadow Mewtwo",
        :entryText => "Mewtwo's power is building up!",
        :shieldCount => 1,
        :immunities => {},
        :onEntryEffects => { # effects applied on entry, use same attributes/syntax as onbreakeffects
            :message => "KETA: We have to defeat it quickly or else...",
        },
        :chargeAttack => {
            :turns => 10,
            :chargingMessage => "Mewtwo is charging its attack...",
            :continueCharging => true,
            :canAttack => false,
            :canIntermediateAttack => true,
            :intermediateattack => {
                :move => :SHADOWBEAM,
                :type => :SHADOW,
                :basedamage => 40,
                :name => "Shadow Beam",
                :category => 0,
                :target => :AllOpposing,
            }
        },
        :moninfo => {
            :species => :MEWTWO,
            :level => 30,
            :moves => [:SHADOWSNEAK,nil,nil,nil],
            :ability => :PRESSURE,
            :nature => :HARDY,
            :iv => 20,
            :happiness => 0,
            :form => 3,
            :shadow => true,
            :ev => [40,40,40,40,40,40]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "Shadow Mewtwo's power grows!",
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => -1,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => -1
                }
            }
        }
    },
    :RIFTGYARADOS2 => {
        :name => "Rift Gyarados",
        :entryText => "Rift Gyarados is intent on revenge!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :GYARADOS,
            :level => 35,
            :form => 4,
            :moves => [:PHANTOMFORCE,:WATERFALL,:GRASSYGLIDE,:SCREECH],
            :ability => :INTIMIDATE,
            :gender => "M",
            :nature => :NAUGHTY,
            :iv => 20,
            :happiness => 255,
            :ev => [40,40,40,40,40,40],
            :BaseStats => [95,145,89,120,110,81]
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "Rift Gyarados's type changed!",
                :typeChange => [:WATER,:DRAGON],
                :movesetUpdate => [:DRAGONRUSH,:WATERFALL,:THUNDERFANG,:SCREECH],
                :fieldChange => :WATERSURFACE,
                :fieldChangeMessage => "Rift Gyarados dragged the battle to the lake!"
            },
            1 => {
                :threshold => 0,
                :message => "Rift Gyarados's type changed!",
                :typeChange => [:FIRE,:DRAGON],
                :movesetUpdate => [:DRAGONRUSH,:LAVAPLUME,:CRUNCH,:SCREECH],
                :statDropCure => true,
                :fieldChange => :INFERNAL,
                :fieldChangeMessage => "Rift Gyarados conflagarated the arena!"
            }
        }
    },
    :PULSEMUSHARNA => {
        :name => "Pulse+ Musharna",
        :entryText => "The dangerous(?) Musharna attacked(?)!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :MUSHARNA,
            :level => 20,
            :form => 2,
            :moves => [:PSYBEAM,:DISARMINGVOICE,:CHARGEBEAM,:SWEETSCENT],
            :gender => "F",
            :nature => :DOCILE,
            :ability => :PASTELVEIL,
            :iv => 20,
            :happiness => 255,
            :ev => [20,20,20,20,20,20]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :fieldChange => :MISTY,
                :fieldChangeMessage => "Pulse Musharna spread mist everywhere."
            }
        }
    },
    :PULSEMUSHARNA2 => {
        :name => "Pulse+ Musharna",
        :entryText => "The dangerous(?) Musharna attacked(?) again!",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :MUSHARNA,
            :level => 91,
            :form => 2,
            :item => :SITRUSBERRY,
            :moves => [:MISTBALL,:DAZZLINGGLEAM,:AURASPHERE,:SWEETSCENT],
            :gender => "F",
            :nature => :MODEST,
            :ability => :PASTELVEIL,
            :iv => 31,
            :happiness => 255,
            :ev => [252,0,4,252,0,0]
        },
        :onEntryEffects => {
            :delayedaction => {
                :delay => 3,
                :playerSideStatChanges => {
                    PBStats::SPEED => -1,
                },
                :message => "The aromatic mist is relaxing...",
                :repeat => true,
                :animation => :FAIRYWIND,
            }
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :bosssideChanges => :Mist,
                :bosssideChangeAnimation => :MIST,
                :bosssideChangeCount => 5,
                :movesetUpdate => [:MISTBALL,:STRANGESTEAM,:PETALDANCE,:STUNSPORE],
                :message => "Pulse Musharna is laying lazily in the flowers...",
                :statusCure => true,
                :statDropCure => true,
                :effectClear => true,
           },
            2 => {
                :threshold => 0,
                :bosssideChanges => :Safeguard,
                :bosssideChangeAnimation => :SAFEGUARD,
                :bosssideChangeCount => 5,
                :message => "Pulse Musharna became one with the bugs...",
                :typeChange => [:BUG,:FAIRY],
                :movesetUpdate => [:BUGBUZZ,:STRANGESTEAM,:MISTBALL,:MYSTICALFIRE],
                :delayedaction => {
                    :delay => 3,
                    :message => "Pulse Musharna issued a defend order!",
                    :animation => :DEFENDORDER,
                    :bossStatChanges => {
                        PBStats::DEFENSE => 2,
                        PBStats::SPDEF => 2,                  
                    },
                    :delayedaction => {
                        :delay => 3,
                        :message => "Pulse Musharna issued an attack order!",
                        :animation => :ATTACKORDER,
                        :bossStatChanges => {
                            PBStats::SPATK => 2,                
                        },
                        :delayedaction => {
                            :delay => 3,
                            :message => "Pulse Musharna issued a heal order!",
                            :animation => :HEALORDER,
                            :itemchange => :LEFTOVERS,
                            :statusCure => true,
                            :statDropCure => true,
                            :effectClear => true,
                            :bossEffect => :Ingrain,
                            :bossEffectduration => true,
                        }
                    }
                }
            },
        }
    },
    :BOSSGOTHITELLE_SHERIDAN => {
        :name => "Gothitelle",
        :entryText => "The mischievous Gothitelle laughs at you!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :GOTHITELLE,
            :level => 35,
            :form => 1,
            :moves => [:FAKETEARS,:PSYCHIC,:FLATTER,:DARKPULSE],
            :gender => "F",
            :nature => :MODEST,
            :ability => :SHADOWTAG,
            :iv => 31,
            :happiness => 255,
            :ev => [252,0,0,252,0,0]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                    PBStats::SPDEF => 1,
                }
            }
        }
    },
    :CRESCGOTHITELLE => {
        :name => "Gothitelle",
        :entryText => "The mischievous Gothitelle laughs at you!",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :GOTHITELLE,
            :level => 60,
            :form => 1,
            :moves => [:PLAYNICE,:TORMENT,:FAKEOUT,:DARKPULSE],
            :gender => "F",
            :nature => :MODEST,
            :ability => :SHADOWTAG,
            :item => :GOTHCREST,
            :iv => 31,
            :happiness => 255,
            :ev => [252,252,252,252,252,252]
        },
        :onEntryEffects => {
            # :animation => :IONDELUGE,
            # :fieldChange => :ELECTERRAIN,
            # :fieldChangeMessage => "Aelita's nightmares manifest into reality...",
            # :delayedaction => {
            #     :delay => 1,
            #     :playerSideStatusChanges => [:PARALYSIS,"Paralysis"],
            #     :delayedaction => {
            #         :delay => 3,
            #         :repeat => true,
            #         :playerEffects => :GastroAcid,
            #         :playerEffectsAnimation => :EMBARGO,
            #         :playerEffectsMessage => "Abilities have been suppressed!"
            #     }
            # }
            :playerEffects => :PerishSong,
            :playerEffectsduration => 4,
            :playerEffectsAnimation => :PERISHSONG,
            :playerEffectsMessage => "Gothitelle sings a haunting tune!",
            :instantMove => [:TAUNT, 0],
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :movesetUpdate => [:GRASSKNOT,:THUNDERBOLT,:TAUNT,:PSYSHOCK],
                :delayedaction => {
                    :delay => 2,
                    :repeat => false,
                    :playerEffects => :PerishSong,
                    :playerEffectsduration => 4,
                    :playerEffectsAnimation => :PERISHSONG,
                    :playerEffectsMessage => "Gothitelle's tune lingers!",
                }
            },
            2 => {
                :threshold => 0,
                :movesetUpdate => [:DARKPULSE,:TAUNT,:CHARM,:PSYSHOCK],
                :delayedaction => {
                    :delay => 2,
                    :repeat => false,
                    :playerEffects => :PerishSong,
                    :playerEffectsduration => 4,
                    :playerEffectsAnimation => :PERISHSONG,
                    :playerEffectsMessage => "Gothitelle mocks your demise!",
                }
            },
            1 => {
                :threshold => 0,
                :fieldChange => :PSYTERRAIN,
                :fieldChangeMessage => "Gothitelle laughs at how dumb your face looks. So mean!",
                :movesetUpdate => [:TAUNT,:PSYSHOCK,:DARKPULSE,:FOCUSBLAST],
                :statDropCure => true,
                :statusCure => true,
                :effectClear => true,
                :delayedaction => {
                    :delay => 2,
                    :repeat => false,
                    :playerEffects => :PerishSong,
                    :playerEffectsduration => 4,
                    :playerEffectsAnimation => :PERISHSONG,
                    :playerEffectsMessage => "Gothitelle sings once more!",
                }

            }
        }
    },
    :KIERANXURK_1 => {
        :name => "Xurkitree",
        :entryText => "Static electricity crackles in the air...",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :XURKITREE,
            :level => 70,
            :form => 1,
            :moves => [:THUNDER,:ENERGYBALL,:DAZZLINGGLEAM,:TAILGLOW],
            :nature => :MODEST,
            :ability => :BEASTBOOST,
            :iv => 31,
            :happiness => 255,
            :ev => [0,0,0,252,0,252]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :fieldChange => :ELECTERRAIN,
                :fieldChangeMessage => "Xurkitree repositions itself."
            }
        }
    },
    :BELIAL => {
        :name => "Belial", # nickname
        :entryText => "A feisty Volcarona appeared!",
        :shieldCount => 4, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :VOLCARONA,
            :level => 55,
            :item => :LEFTOVERS,
            :moves => [:FIERYDANCE,:BUGBUZZ,:GIGADRAIN,:QUIVERDANCE],
            :ability => :DESOLATELAND,
            :nature => :MODEST,
            :gender => "M",
            :iv => 31,
            :happiness => 255,
            :ev => [252,252,252,252,252,252]
        },
        :sosDetails =>  { # pokemon details
        :activationRequirement => "@battle.battlers[battlerIndex].shieldCount <= 4",
        :totalMonCount => 5,
        :continuous => true,
        :moninfos => {
            1 => {
                :species => :SHUCKLE,
                :level => 40,
                :item => :MENTALHERB,
                :moves => [:POWERSPLIT,:STEALTHROCK,:STICKYWEB,:HELPINGHAND],
                :ability => :STURDY,
                :nature => :BOLD,
                :iv => 31,
                :happiness => 255,
            },
            2 => {
                :species => :VIVILLON,
                :level => 40,
                :item => :DARKINIUMZ,
                :moves => [:PUNISHMENT,:RAGEPOWDER,:TAILWIND,:LOVELYKISS],
                :ability => :BADDREAMS,
                :iv => 31,
                :happiness => 255,
                :ev => [252,252,252,252,252,252]
            },
            3 => {
                :species => :PARASECT,
                :level => 40,
                :item => :SYNTHETICSEED,
                :moves => [:SPORE,:RAGEPOWDER,:WIDEGUARD,:POLLENPUFF],
                :ability => :EFFECTSPORE,
                :iv => 31,
                :happiness => 255,
            },
            4 => {
                :species => :VOLBEAT,
                :level => 40,
                :item => :SYNTHETICSEED,
                :moves => [:CHARM,:STRUGGLEBUG,:HELPINGHAND,:THUNDERWAVE],
                :ability => :PRANKSTER,
                :iv => 31,
                :happiness => 255,
            },
            5 => {
                :species => :ILLUMISE,
                :level => 40,
                :item => :SYNTHETICSEED,
                :moves => [:CAPTIVATE,:HELPINGHAND,:SUNNYDAY,:STRUGGLEBUG],
                :ability => :PRANKSTER,
                :iv => 31,
                :happiness => 255,
            },
        },
    },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            4 => {
                :fieldChange => :INFERNAL, # field changes
                :fieldChangeMessage => "The field broke into a hellish inferno!",
                :abilitychange => :FLASHFIRE,
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :itemchange => :ELEMENTALSEED, # item that is given upon breaking shield
            },
            3 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :itemchange => :LEFTOVERS, # item that is given upon breaking shield
                :bosssideChanges => :Safeguard,
                :bosssideChangeCount => 5,
                :bosssideChangeMessage => "Belial shrouded itself with a Safeguard!", # message that plays for the effect
                :statusCure => true, # if status is cured when shield is broken
                :statDropCure => true, # if statdrops are negated when shield is broken
            },
            2 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :fieldChange => :FLOWERGARDEN3, # field changes
                :fieldChangeMessage => "The field is covered in flowers!", # message that plays when the field is changes
                :abilitychange => :SWARM,
                :itemchange => :SYNTHETICSEED, # item that is given upon breaking shield
                :movesetUpdate => [:BUGBUZZ,:FIERYDANCE,:PETALDANCE,:QUIVERDANCE],
            },
            1 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :itemchange => :BUGINIUMZ, # item that is given upon breaking shield
                :instantMove => [:BLOOMDOOM, 0],
            },
        }
    },  
    :SEAPRINCE => {
        :name => "Manaphy", # nickname
        :entryText => "ODESSA: Witness the might of the seas!",
        :shieldCount => 2, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :MANAPHY,
            :level => 58,
            :item => :LEFTOVERS,
            :moves => [:SCALD,:SHADOWBALL,:RAINDANCE,:TAKEHEART],
            :ability => :HYDRATION,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
            :ev => [0,0,0,252,0,252]
        },
        :sosDetails =>  { # pokemon details
        :activationRequirement => "@battle.battlers[battlerIndex].shieldCount == 0",
        :continuous => true,
        :totalMonCount => 2,
        :moninfos => {
            1 => {
                :species => :PHIONE,
                :level => 50,
                :moves => [:SURF,:ENERGYBALL,:HELPINGHAND,:DAZZLINGGLEAM],
                :ability => :HYDRATION,
                :gender => "F",
                :nature => :MODEST,
                :iv => 31,
                :happiness => 255,
            },
        },
    },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            2 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "ODESSA: The Prince of the Sea's tail shines bright. Be blinded by its glow!", # message that plays when shield is broken
                :weatherChange => :RAINDANCE, # weather to apply
                :weatherCount => 5, # weather turncount
                :weatherChangeMessage => "The Rain pours down!", # weather message
                :weatherChangeAnimation => "Rain", # string of "Rain", "Sunny","Hail","Sandstorm"
                :statusCure => true, # if status is cured when shield is broken
                :itemchange => :LEFTOVERS, # item that is given upon breaking shield
                :bossStatChanges => { # any statboosts that are given
                    PBStats::SPATK => 3,
                },
                :delayedaction => {
                    :delay => 2,
                    :message => "The Prince's glowing tail starts to dim...",
                    :bossStatChanges => { 
                        PBStats::SPATK => -3,
                    },
                }
            },
            1 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "ODESSA: The Prince can command the sea themselves. As such as a Prince should! Be purged by the sacred waters of Kristiline! ", # message that plays when shield is broken
                :abilitychange => :PRESSURE,
                :fieldChange => :WATERSURFACE, # field changes
                :fieldChangeMessage => "The battlefield was plunged underwater!", # message that plays when the field is changes
                :statusCure => true, # if status is cured when shield is broken
                :itemchange => :LEFTOVERS, # item that is given upon breaking shield
            },
        }
    },  
    :RIFTGALVANTULA => {
        :name => "Rift Galvantula",
        :shieldCount => 2,
        :entryText => "Joltik swarm the egg...",
        :immunities => {},
        :moninfo => {
            :species => :GALVANTULA,
            :level => 25,
            :form => 2,
            :moves => [:ELECTROWEB,:BUGBITE,:CROSSPOISON,:TOXICTHREAD],
            :gender => "F",
            :nature => :HASTY,
            :iv => 20,
            :happiness => 255,
            :ev => [32,32,32,32,32,32]
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 2",
            :continuous => true,
            :moninfos => {
                1 => {
                    :species => :JOLTIK,
                    :level => 20,
                    :moves => [:ELECTROWEB,:STRINGSHOT,:STRUGGLEBUG,nil],
                    :ability => :COMPOUNDEYES,
                    :form => 1,
                },
            },
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :formchange => 1,
                :message => "Rift Galvantula hatched out of the egg!",
                :abilitychange => :UNNERVE,
                :movesetUpdate => [:ELECTROWEB,:LUNGE,:CROSSPOISON,:VENOSHOCK],
                :statDropCure => true,
                :playersideChanges => :ToxicSpikes,
                :playersideChangeAnimation => :TOXICPSIKES,
                :playersideChangeMessage => "Broken eggshell was strewn everywhere!",
            },
        }
    },
    :RIFTVOLCANION => {
        :name => "Rift Volcanion",
        :entryText => "Rift Volcanion let out a languid grumble...",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :VOLCANION,
            :level => 28,
            :form => 1,
            :moves => [:STEAMERUPTION,:FLAMETHROWER,:SCORCHINGSANDS,:ROCKSLIDE],
            :gender => "F",
            :nature => :LONELY,
            :iv => 20,
            :happiness => 255,
            :ev => [40,40,40,40,40,40]
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "Volcanion is losing motivation…",
                :movesetUpdate => [:SCALD,:INCINERATE,:MUDSHOT,:ROCKTOMB],
                :bossStatChanges => {
                    PBStats::ATTACK => -1,
                    PBStats::DEFENSE => -1,
                    PBStats::SPATK => -1,
                    PBStats::SPDEF => -1,
                    PBStats::SPEED => -1                    
                }
            },
            1 => {
                :threshold => 0,
                :message => "Volcanion is losing motivation…",
                :movesetUpdate => [:WATERGUN,:EMBER,:MUDSLAP,:ROCKTHROW],
                :bossStatChanges => {
                    PBStats::ATTACK => -1,
                    PBStats::DEFENSE => -1,
                    PBStats::SPATK => -1,
                    PBStats::SPDEF => -1,
                    PBStats::SPEED => -1                    
                }
            },
        }
    },
    :BOSSDUSKNOIR => {
        :name => "Dusknoir",
        :entryText => "The Dusknoir is threatening you.",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :DUSKNOIR,
            :level => 30,
            :moves => [:SHADOWPUNCH,:WILLOWISP,:INFESTATION,:PAYBACK],
            :gender => "M",
            :nature => :ADAMANT,
            :iv => 31,
            :form => 1,
            :ev => [100,100,32,32,32,32]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "Dusknoir is about to throw hands!",
                :movesetUpdate => [:SHADOWPUNCH,:WILLOWISP,:ICEPUNCH,:THUNDERPUNCH],
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,                 
                }
            },
        }
    },
    :WISPYGIRATINA => {
        :name => "Renegade Giratina",
        :entryText => "GEARA: Destroy them, Giratina! Show them the might of a Legendary Pokémon!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :GIRATINA,
            :level => 35,
            :moves => [:SHADOWCLAW,:DRAGONBREATH,:SLASH,:ICYWIND],
            :nature => :HARDY,
            :iv => 31,
            :form => 1,
            :ev => [52,80,32,80,32,32]
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "Giratina's ghastly aura lowered offenses!",
                :statDropCure => true,
                :playerSideStatChanges => {
                    PBStats::ATTACK => -1,
                    PBStats::SPATK => -1,                 
                }
            },
            1 => {
                :threshold => 0,
                :message => "Giratina's aura enveloped the battlefield!",
                :bossStatChanges => {
                    PBStats::DEFENSE => -1,
                    PBStats::SPDEF => -1,                 
                },
                :playerSideStatChanges => {
                    PBStats::DEFENSE => -1,
                    PBStats::SPDEF => -1,                 
                }
            }
        }
    },
    :BOSSCROBAT => {
        :name => "Furious Bat",
        :entryText => "The Crobat attacked with furor!",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :CROBAT,
            :level => 38,
            :moves => [:CROSSPOISON,:BITE,:ACROBATICS,:PROTECT],
            :ability => :INFILTRATOR,
            :gender => "F",
            :nature => :NAUGHTY,
            :item => :FLYINGGEM,
            :iv => 31,
            :happiness => 255,
            :ev => [40,40,40,40,40,40],
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 10",
            :continuous => true,
            :moninfos => {
                1 => {
                    :species => :ZUBAT,
                    :level => 32,
                    :moves => [:CONFUSERAY,:POISONFANG,:TORMENT,:THIEF],
                    :ability => :INNERFOCUS,
                    :iv => 31,
                },
                2 => {
                    :species => :WOOBAT,
                    :level => 32,
                    :moves => [:CONFUSION,:CHARM,:HELPINGHAND,:AIRSLASH],
                    :ability => :UNAWARE,
                    :iv => 31,
                },
                3 => {
                    :species => :NOIBAT,
                    :level => 32,
                    :moves => [:SUPERFANG,:WHIRLWIND,:AIRSLASH,:DRAGONRUSH],
                    :ability => :INFILTRATOR,
                    :iv => 31,
                },
            },
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :bosssideChanges => :Tailwind,
                :bosssideChangeAnimation => :TAILWIND,
                :bosssideChangeCount => 3,
                :movesetUpdate => [:BRAVEBIRD,:CROSSPOISON,:PROTECT,:LEECHLIFE],
                :statDropCure => true,
                :itemchange => :SITRUSBERRY,
            },
        },
    },
    :MADAMEXYVELTAL => {
        :name => "Yveltal",
        :entryText => "Yveltal looms above.",
        :shieldCount => 0,
        :immunities => {},
        :moninfo => {
            :species => :YVELTAL,
            :level => 75,
            :moves => [:DECIMATION,:HURRICANE,:FOCUSBLAST,:TAUNT],
            :nature => :MODEST,
            :iv => 31,
            :ev => [252,252,252,252,252,252]
        },
    },
    :TAPUKOKOJUNGLE=> {
        :name => "Thunder Warrior",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :TAPUKOKO,
            :level => 50,
            :shiny => true,
            :moves => [:BRAVEBIRD,:NATURESMADNESS,:NATUREPOWER,:BOLTBEAK],
            :nature => :RASH,
            :ability => :ELECTRICSURGE,
            :iv => 31,
            :item => :SHUCABERRY,
            :happiness => 255,
            :ev => [252,252,252,252,252,252]
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :message => "Tapu Koko is getting worked up!!",
                :abilityChange => :ELECTERRAIN,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPEED => 1,
                },
            },
            2 => {
                :threshold => 0,
                :message => "Tapu Koko is putting in its all!!",
                :movesetUpdate => [:GRASSKNOT,:HIDDENPOWERICE,:ROOST,:RISINGVOLTAGE],
                :statDropCure => true,
                :statusCure => true,
                :effectClear => true,
                :fieldChange => :ELECTERRAIN,
                :fieldChangeMessage => "Electricity stormed acrosss the arena!",
                :abilitychange => :MOLDBREAKER,
                :itemchange => :EXPERTBELT,
            },
            1 => {
                :threshold => 0,
                :message => "TAPU KOKO: KOKOOOOOOO!",
                :movesetUpdate => [:NATURESMADNESS,:HIDDENPOWERICE,:GRASSKNOT,:RISINGVOLTAGE],
                :statDropCure => true,
                :statusCure => true,
                :effectClear => true,
                :itemchange => :LIFEORB,
                :instantMove => [:GUARDIANOFALOLA, 0],
            },
        }
    },
    :BOSSCONKELDURR => {
        :name => "Strained Worker",
        :entryText => "Conkeldurr is agitated!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :CONKELDURR,
            :level => 50,
            :moves => [:FRUSTRATION,:ICEPUNCH,:FIREPUNCH,:THUNDERPUNCH],
            :ability => :IRONFIST,
            :gender => "M",
            :nature => :ADAMANT,
            :iv => 31,
            :happiness => 0,
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 1",
            :continuous => true,
            :moninfos => {
                1 => {
                    :species => :TIMBURR,
                    :level => 40,
                    :moves => [:COACHING,:HELPINGHAND,:ROCKSLIDE,:HAMMERARM],
                    :ability => :IRONFIST,
                    :nature => :ADAMANT
                },
            },
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "Conkeldurr built a miniature city in anger!",
                :fieldChange => :CITY,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,             
                },
            },
            1 => {
                :threshold => 0,
                :message => "The miniature city was destroyed...",
                :fieldChange => :FOREST,
                :bossStatChanges => {
                    PBStats::ATTACK => -1,             
                },
            },
        },
    },
    :RIFTCARNIVINE => {
        :name => "Corrupted Carnivine",
        :entryText => "Carnivine is dancing the samba!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :CARNIVINE,
            :level => 45,
            :form => 1,
            :moves => [:DRAGONDANCE,:POWERWHIP,:DRAGONPULSE,:FLAMETHROWER],
            :ability => :OWNTEMPO,
            :gender => "M",
            :nature => :NAUGHTY,
            :item => :YACHEBERRY,
            :iv => 31,
            :happiness => 255,
            :ev => [40,40,40,40,40,40],
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 2",
            :continuous => true,
            :totalMonCount => 4,
            :moninfos => {
                1 => {
                    :species => :TANGELA,
                    :level => 40,
                    :form => 1,
                    :item => :LEFTOVERS,
                    :moves => [:FOLLOWME,:SWAGGER,:POLLENPUFF,:PETALDANCE],
                    :ability => :DANCER,
                    :gender => "F",
                    :nature => :MODEST,
                    :iv => 31,
                    :happiness => 255,
                    :ev => [0,128,0,128,0,252]
                },
                2 => {
                    :species => :TANGROWTH,
                    :level => 40,
                    :form => 1,
                    :item => :LEFTOVERS,
                    :moves => [:FOLLOWME,:QUASH,:POLLENPUFF,:ROCKTOMB],
                    :ability => :DANCER,
                    :gender => "M",
                    :nature => :MODEST,
                    :iv => 31,
                    :happiness => 255,
                    :ev => [252,128,0,128,0,0]
                },
            },
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :animation => :SHIFTGEAR,
                :message => "The rhythm of the music has changed!",
                :bossEffectMessage => "Carnivine did the robot and became Steel-type!",
                :typeChange => [:GRASS,:STEEL],
                :movesetUpdate => [:SHIFTGEAR,:POWERWHIP,:IRONHEAD,:FIRELASH],
                :statDropRefresh => true,
                :itemchange => :OCCABERRY,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => -1,
                    PBStats::SPDEF => -1,
                    PBStats::SPEED => -1               
                },
                :playerSideStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => -1,
                    PBStats::SPDEF => -1,
                    PBStats::SPEED => -1                
                }
            },
            1 => {
                :threshold => 0,
                :animation => :QUIVERDANCE,
                :message => "The rhythm of the music has changed!",
                :bossEffectMessage => "Carnivine did the jitterbug and became Bug-type!",
                :typeChange => [:GRASS,:BUG],
                :movesetUpdate => [:QUIVERDANCE,:LEAFSTORM,:POLLENPUFF,:FIERYDANCE],
                :statDropRefresh => true,
                :itemchange => :BUGGEM,
                :bossStatChanges => {
                    PBStats::ATTACK => -1,
                    PBStats::DEFENSE => -1,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPEED => 1             
                },
                :playerSideStatChanges => {
                    PBStats::ATTACK => -1,
                    PBStats::DEFENSE => -1,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPEED => 1                
                }
            }
        }
    },
    :TAPUKOKOMAGRODAR=> {
        :name => "Thunder Warrior",
        :entryText => "The Thunder Warrior is ready to rumble!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :TAPUKOKO,
            :level => 60,
            :shiny => true,
            :item => :LIGHTCLAY,
            :moves => [:LIGHTSCREEN,:NATURESMADNESS,:DAZZLINGGLEAM,:REFLECT],
            :nature => :HASTY,
            :ability => :ELECTRICSURGE,
            :iv => 31,
            :happiness => 255,
            :ev => [252, 252, 252, 252, 252, 252]
        },
        :onEntryEffects => { # effects applied on entry, use same attributes/syntax as onbreakeffects
            :weatherChange => nil,
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "true",
            # :refreshingRequirement => [0],
            :entryMessage => ["Charizard charged into the fight!","The Thunder Warrior revitalized Charizard's energy!","The Thunder Warrior revitalized Charizard's energy!"],
            :continuous => true,
            :totalMonCount => 3,
            :moninfos => {
                1 => {
                    :species => :CHARIZARD,
                    :level => 54,
                    :item => :CHARIZARDITEY,
                    :moves => [:FOCUSBLAST,:SOLARBEAM,:AIRSLASH,:HEATWAVE],
                    :ability => :DROUGHT,
                    :shiny => true,
                    :nature => :TIMID,
                    :form => 2,
                    :iv => 31,
                    :ev => [0, 0, 0, 252, 4, 252],
                },
                2 => {
                    :species => :CHARIZARD,
                    :level => 54,
                    :item => :LIFEORB,
                    :moves => [:SCORCHINGSANDS,:ROOST,:DRAGONPULSE,:BLASTBURN],
                    :ability => :SOLARPOWER,
                    :shiny => true,
                    :nature => :MODEST,
                    :form => 0, # becomes giga
                    :iv => 31,
                    :ev => [252, 0, 0, 252, 4, 0],
                },
                3 => {
                    :species => :CHARIZARD,
                    :level => 54,
                    :item => :CHARIZARDITEX,
                    :moves => [:EARTHQUAKE,:OUTRAGE,:FLAREBLITZ,:DRAGONDANCE],
                    :ability => :TOUGHCLAWS,
                    :shiny => true,
                    :nature => :ADAMANT,
                    :form => 1,
                    :iv => 31,
                    :ev => [0, 252, 0, 0, 4, 252],
                },
            },
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :abilitychange => :INTIMIDATE,
                :itemchange => :ELEMENTALSEED,
                :typeChange => [:FIGHTING,:FLYING],
                :message => "Tapu Koko is lets out a defiant shout!",
                :movesetUpdate => [:SKYDROP,:TAILWIND,:CLOSECOMBAT,:BRAVEBIRD],
            },
            1 => {
                :threshold => 0,
                :abilitychange => :BERSERK,
                :typeChange => [:ELECTRIC,:FLYING],
                :itemchange => :AMULETCOIN,
                :message => "Tapu Koko is putting in its all!!",
                :movesetUpdate => [:THUNDERBOLT,:GRASSKNOT,:HIDDENPOWERICE,:BRAVEBIRD],
                :instantMove => [:GUARDIANOFALOLA, 0],
            },
        }
    },
    :BOSS_CHAOTICFUSION => {
        :name => "Chaotic Fusion",
        :entryText => "The fused Pokémon suddenly attacked!",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :SOLROCK,
            :level => 52,
            :moves => [:WILLOWISP,:ROCKTOMB,:SOLARFLARE,:MORNINGSUN],
            :nature => :QUIRKY,
            :iv => 31,
            :form => 1,
            :ability => :SOLARIDOL,
            :item => :SITRUSBERRY,
            :ev => [252,0,252,0,4,0]
        },
        :onEntryEffects => { # effects applied on entry, use same attributes/syntax as onbreakeffects
            :weatherChange => :SUNNYDAY,
            :weatherChangeAnimation => "Sunny",
            :weatherCount => 5,
        },
        :onBreakEffects => {
            3 => {
                :animation => :FLASH,
                :weatherChange => :HAIL,
                :weatherChangeAnimation => "Hail",
                :weatherCount => 5,
                :threshold => 0,
                :message => "Lunatone gained control!",
                :itemchange => :SITRUSBERRY,
                :speciesUpdate => :LUNATONE,
                :abilitychange => :LUNARIDOL,
                :form => 1,
                :movesetUpdate => [:COSMICPOWER,:ANCIENTPOWER,:HOARFROSTMOON,:MOONLIGHT],
            },
            2 => {
                :animation => :FLASH,
                :weatherChange => :SUNNYDAY,
                :weatherChangeAnimation => "Sunny",
                :weatherCount => 5,
                :threshold => 0,
                :message => "Solrock is leading the charge!",
                :itemchange => :FLAMEPLATE,
                :speciesUpdate => :SOLROCK,
                :abilitychange => :SOLARIDOL,
                :form => 1,
                :statDropCure => true,
                :statusCure => true,
                :movesetUpdate => [:ZENHEADBUTT,:STONEEDGE,:SOLARFLARE,:MORNINGSUN],
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                }
            },
            1 => {
                :animation => :FLASH,
                :weatherChange => :HAIL,
                :weatherChangeAnimation => "Hail",
                :weatherCount => 5,
                :threshold => 0,
                :message => "Lunatone is desperate!",
                :itemchange => :ICICLEPLATE,
                :speciesUpdate => :LUNATONE,
                :abilitychange => :LUNARIDOL,
                :form => 1,
                :movesetUpdate => [:PSYCHIC,:MOONBLAST,:HOARFROSTMOON,:MOONLIGHT],
                :bossStatChanges => {
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,
                }
            },
        }
    },
    :AMETHYSTREGIROCK => {
        :name => "Stone Guardian",
        :entryText => "The Guardian is watching your every move.",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :REGIROCK,
            :level => 50,
            :moves => [:CURSE,:BODYPRESS,:ROCKSLIDE,:EARTHQUAKE],
            :nature => :IMPISH,
            :iv => 31,
            :shiny => true,
            :item => :SITRUSBERRY,
            :ev => [100,52,252,0,100,0]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "Regirock hardened up!",
                :statDropCure => true,
                :playersideChanges => :StealthRock,
                :playersideChangeCount => true,
                :playersideChangeAnimation => :STEALTHROCK,
                :playersideChangeMessage => "Floating rocks were deployed!",
                :itemchange => :SITRUSBERRY,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 2,
                    PBStats::SPDEF => 2,                 
                },
            }
        }
    },
    :AMETHYSTREGISTEEL => {
        :name => "Iron Guardian",
        :entryText => "The Guardian is watching your every move.",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :REGISTEEL,
            :level => 50,
            :moves => [:CURSE,:BODYPRESS,:IRONHEAD,:EARTHQUAKE],
            :nature => :IMPISH,
            :iv => 31,
            :shiny => true,
            :item => :SITRUSBERRY,
            :ev => [100,52,252,0,100,0]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "Registeel hardened up!",
                :statDropCure => true,
                :playersideChanges => :Spikes,
                :playersideChangeAnimation => :SPIKES,
                :playersideChangeCount => 1,
                :playersideChangeMessage => "Spikes were deployed!",
                :itemchange => :SITRUSBERRY,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 2,
                    PBStats::SPDEF => 2,                 
                },
            }
        }
    },
    :BOSSKYOGRE => {
        :name => "Leviathan Kyogre",
        :entryText => "Kyogre's power is overwhelming!",
        :shieldCount => 4,
        :immunities => {},
        :moninfo => {
            :species => :KYOGRE,
            :level => 68,
            :moves => [:SURF,:ICEBEAM,:THUNDERBOLT,:CALMMIND],
            :nature => :MODEST,
            :iv => 31,
            :ev => [252,252,252,252,252,252]
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "true",
            # :refreshingRequirement => [0],
            :entryMessage => ["A school of Wishiwashi was summoned!","Dhelmise lurks in the deep...","Tapu Fini joins the fight!","The Sea Prince heard Kyogre's plea!"],
            :continuous => true,
            :totalMonCount => 4,
            :moninfos => {
                1 => {
                    :species => :WISHIWASHI,
                    :level => 50,
                    :item => :MYSTICWATER,
                    :moves => [:WAVECRASH,:SOAK,:HELPINGHAND,:TEARFULLOOK],
                    :ability => :SCHOOLING,
                    :nature => :ADAMANT,
                    :iv => 31,
                    :ev => [252, 0, 0, 252, 4, 0],
                },
                2 => {
                    :species => :DHELMISE,
                    :level => 50,
                    :item => :ELEMENTALSEED,
                    :moves => [:ANCHORSHOT,:POWERWHIP,:LIQUIDATION,:SWORDSDANCE],
                    :ability => :STEELWORKER,
                    :nature => :ADAMANT,
                    :iv => 31,
                    :ev => [252, 252, 0, 0, 4, 0],
                },
                3 => {
                    :species => :TAPUFINI,
                    :level => 55,
                    :item => :LIGHTCLAY,
                    :moves => [:NATURESMADNESS,:LIFEDEW,:REFLECT,:LIGHTSCREEN],
                    :ability => :MISTYSURGE,
                    :shiny => true,
                    :nature => :MODEST,
                    :iv => 31,
                    :ev => [252, 0, 0, 252, 4, 0],
                },
                4 => {
                    :species => :MANAPHY,
                    :level => 55,
                    :item => :WATERIUMZ,
                    :moves => [:TAILGLOW,:MUDDYWATER,:ENERGYBALL,:DAZZLINGGLEAM],
                    :ability => :HYDRATION,
                    :shiny => true,
                    :nature => :ADAMANT,
                    :iv => 31,
                    :ev => [252, 0, 0, 252, 4, 0],
                },
            },
        },
        :onBreakEffects => {
            4 => {
                :threshold => 0,
                :message => "Kyogre summoned a storm and flooded the arena!",
                :fieldChange => :WATERSURFACE,
                :formchange => 1,
                :abilitychange => :PRIMORDIALSEA,
                :movesetUpdate => [:HURRICANE,:THUNDER,:ORIGINPULSE,:ICEBEAM],
                :delayedaction => {
                    :delay => 1,
                    :message => "Whirlpools are forming...",
                    :playerSideStatChanges => {
                        PBStats::SPEED => -1,
                    },
                    :delayedaction => {
                        :delay => 1,
                        :message => "Whirlpools have fully formed!",
                        :playerEffects => :Whirlpool,
                        :playerEffectsAnimation => :WHIRLPOOL,
                        :playerEffectsduration => 8,
                    },
                },
            },
            3 => {
                :threshold => 0,
                :message => "Kyogre dragged the battle underwater!",
                :fieldChange => :UNDERWATER,
                :animation => :DIVE,
                :movesetUpdate => [:ORIGINPULSE,:THUNDER,:AQUABATICS,:ICEBEAM],
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPEED => 1                 
                },
            },
            2 => {
                :threshold => 0,
                :message => "Kyogre let out a terrifying roar!",
                :animation => :NOBLEROAR,
                :abilitychange => :HYDRATION,
                :playerSideStatChanges => {
                    PBStats::ATTACK => -2,
                    PBStats::SPATK => -2,
                },
                :movesetUpdate => [:ORIGINPULSE,:THUNDER,:EARTHQUAKE,:ICEBEAM],
                :statDropCure => true,
                :statusCure => true,
                :bossEffect => :AquaRing,
                :bossEffectMessage => "{1} surrounded itself with a veil of water!",
            },
            1 => {
                :threshold => 0,
                :itemchange => :LIFEORB,
                :message => "Kyogre is putting in it's all!",
                :movesetUpdate => [:STONESURGE,:THUNDER,:REST,:EARTHQUAKE],
                :instantMove => [:HYDROVORTEX, 0],
            }
        }
    },
    :BOSSGROUDON => {
        :name => "Behemoth Groudon",
        :entryText => "Groudon attacked under command!",
        :shieldCount => 2,
        :immunities => {
            :fieldEffectDamage => [:VOLCANIC]
        },
        :moninfo => {
            :species => :GROUDON,
            :level => 65,
            :moves => [:EARTHQUAKE,:STONEEDGE,:SOLARBEAM,:HEATCRASH],
            :nature => :ADAMANT,
            :iv => 31,
            :item => :LEFTOVERS,
            :ev => [252,252,252,252,252,252]
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 2",
            # :refreshingRequirement => [0],
            :entryMessage => ["Gouging Fire stormed into the fray!","Heatran emerged from the magma"],
            :totalMonCount => 2,
            :moninfos => {
                1 => {
                    :species => :GOUGINGFIRE,
                    :level => 55,
                    :item => :SITRUSBERRY,
                    :moves => [:BREAKINGSWIPE,:HEATCRASH,:HOWL,:ROAR],
                    :ability => :PROTOSYNTHESIS,
                    :nature => :CAREFUL,
                    :iv => 31,
                    :ev => [252,4,0,0,252,0]
                },
                2 => {
                    :species => :HEATRAN,
                    :level => 55,
                    :item => :FIRIUMZ,
                    :moves => [:MAGMASTORM,:EARTHPOWER,:FLASHCANNON,:SMACKDOWN],
                    :ability => :FLASHFIRE,
                    :nature => :MODEST,
                    :iv => 31,
                    :ev => [252,0,0,252,0,4]
                },
            },
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "Groudon is drawing primal power from the Core!",
                :formchange => 1,
                :abilitychange => :DESOLATELAND,
                :movesetUpdate => [:PRECIPICEBLADES,:STONEEDGE,:REST,:LAVAPLUME],
                :statDropCure => true,
                :instantMove => [:VOLCALITH, 0],
            },
            1 => {
                :threshold => 0,
                :message => "Groudon summoned fierce eruptions!",
                :fieldChange => :VOLCANIC,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPEED => 1                 
                },
                :movesetUpdate => [:PRECIPICEBLADES,:STONEEDGE,:REST,:LAVAPLUME],
                :statDropCure => true,
                :statusCure => true,
                :instantMove => [:TECTONICRAGE, 0],
            }
        }
    },
    :VALORGIRATINA => {
        :name => "Renegade Giratina",
        :entryText => "Giratina is blocking the way forward!",
        :shieldCount => 5,
        :immunities => {},
        :moninfo => {
            :species => :GIRATINA,
            :level => 65,
            :moves => [:SHADOWFORCE,:AURASPHERE,:EARTHPOWER,:DRAGONCLAW],
            :nature => :NAUGHTY,
            :item => :GRISEOUSORB,
            :form => 1,
            :iv => 31,
            :ev => [252,252,252,252,252,252]
        },
        :onBreakEffects => {
            5 => {
                :threshold => 0,
                :message => "Giratina's form is distorting!",
                :statusCure => true,
                :effectClear => true,
                :formchange => 0,
                :itemchange => :LEFTOVERS,
                :movesetUpdate => [:WILLOWISP,:DRAGONTAIL,:CALMMIND,:HEX],
                :instantMove => [:TOPSYTURVY, 0],
            },
            4 => {
                :threshold => 0,
                :message => "Giratina's form is distorting!",
                :statusCure => true,
                :effectClear => true,
                :formchange => 1,
                :itemchange => :GRISEOUSORB,
                :movesetUpdate => [:SHADOWFORCE,:AURASPHERE,:EARTHPOWER,:DRAGONCLAW],
                :instantMove => [:HYPERSPACEFURY, 0],
            },
            3 => {
                :threshold => 0,
                :message => "Giratina's form is distorting!",
                :statusCure => true,
                :effectClear => true,
                :formchange => 0,
                :movesetUpdate => [:WILLOWISP,:DRAGONTAIL,:CALMMIND,:HEX],
                :itemchange => :LEFTOVERS,
                :instantMove => [:TOPSYTURVY, 0],
            },
            2 => {
                :threshold => 0,
                :message => "Giratina's form is distorting!",
                :statusCure => true,
                :effectClear => true,
                :formchange => 1,
                :itemchange => :GRISEOUSORB,
                :movesetUpdate => [:SHADOWFORCE,:AURASPHERE,:EARTHPOWER,:DRAGONCLAW],
                :instantMove => [:HYPERSPACEFURY, 0],
            },
            1 => {
                :threshold => 0,
                :message => "Giratina drew power from the Distortion World!",
                :statDropCure => true,
                :instantMove => [:DEVASTATINGDRAKE, 0],
                :movesetUpdate => [:SPECTRALTHIEF,:DRACOMETEOR,:EARTHQUAKE,:DRAGONDANCE],
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPEED => 1                 
                },
            }
        }
    },
    :DARCHGIRATINA => {
        :name => "Clown Caricature",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :GIRATINA,
            :level => 64,
            :moves => [:SLUDGEWAVE,:DRAGONPULSE,:DARKPULSE,:FIREBLAST],
            :nature => :NAUGHTY,
            :iv => 31,
            :ev => [85,85,85,85,85,85]
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :speciesUpdate => :PORYGONZ,
                :message => "a Vir us in  d e  ed ",
                :abilitychange => :WONDERGUARD,
                :itemchange => :TOXICORB,
            },
            2 => {
                :threshold => 0,
                :speciesUpdate => :BLACEPHALON,
                :movesetUpdate => [:MINDBLOWN,:SHADOWBALL,:NASTYPLOT,:PRESENT],
                :message => "F u n t i m e s w i t h e v e r y o n e ' s b a d e n d i n g",
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPEED =>1                        
                },
            },
            1 => {
                :threshold => 0,
                :speciesUpdate => :PIDGEY,
                :message => "Can you even beat a Pidgey? Likely not.",
            }
        }
    },
    :LAVALAKAZAM => {
        :name => "Alakazam",
        :shieldCount => 2,
        :immunities => {}, 
        :moninfo => {
            :species => :ALAKAZAM,
            :level => 65,
            :gender => "M",
            :moves => [:CALMMIND,:REFLECT,:LIGHTSCREEN,:NIGHTSHADE],
            :nature => :TIMID,
            :iv => 31,
            :ev => [85,85,85,85,85,85]
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :formchange => 1,
                :message => "Alakazam is pulling all of its psychic energy to its core!",
                :statDropCure => true,
                :movesetUpdate => [:PSYCHIC,:SHADOWBALL,:FOCUSBLAST,:COUNTER],
                :itemchange => :TWISTEDSPOON,
                :bossStatChanges => {
                    PBStats::SPDEF => 2,
                    PBStats::SPEED => 2                 
                },
            },
            1 => {
                :threshold => 0,
                :bosssideChanges => :Reflect, # effect that applies on the boss when breaking shield
                :bosssideChangeCount => 5, # duration of the effect(some effects are booleans, double check)
                :statDropCure => true,
            },
        }
    },
    :DARKGARDEVOIR => {
        :name => "Dark Gardevoir",
        :entryText => "Gardevoir is staring you down.",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :GARDEVOIR,
            :level => 63,
            :item => :LUMBERRY,
            :moves => [:DARKPULSE,:MOONBLAST,:CALMMIND,:PSYSHOCK],
            :nature => :TIMID,
            :form => 2,
            :iv => 31,
            :ev => [0,0,0,252,0,252]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :bosssideChanges => [:Reflect,:Safeguard],
                :bosssideChangeCount => [5,5],
                :bosssideChangeAnimation => [:REFLECT,:SAFEGUARD],
                :message => "Gardevoir quickly set up protection!",
                :statDropCure => true,
            }
        }
    },
    :RIFTGARBODOR => {
        :name => "Rift Garbodor",
        :entryText => "The rampaging Rift Garbodor attacked!",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :GARBODOR,
            :level => 60,
            :item => :BLACKSLUDGE,
            :moves => [:DRAINPUNCH,:GIGADRAIN,:DARKESTLARIAT,:SLUDGEWAVE],
            :nature => :SASSY,
            :form => 2,
            :shiny => true,
            :iv => 31,
            :ev => [252,0,128,0,128,0]
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :message => "Garbodor gorged itself on rotten berries!",
                :typeChange => [:POISON,:GRASS],
                :movesetUpdate => [:DRAINPUNCH,:GIGADRAIN,:DARKESTLARIAT,:BELCH],
                :itemchange => :SITRUSBERRY,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::SPATK => 1,                
                },
                :statDropCure => true,
            },
            2 => {
                :threshold => 0,
                :message => "Garbodor gorged itself on scrap metal!",
                :typeChange => [:POISON,:STEEL],
                :movesetUpdate => [:DRAINPUNCH,:GIGADRAIN,:GYROBALL,:BELCH],
                :itemchange => :METALCOAT,
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                    PBStats::SPDEF => 1,                
                },
                :statDropCure => true,
            },
            1 => {
                :threshold => 0,
                :message => "Garbodor desperately gorged itself on nearby rocks!",
                :typeChange => [:POISON,:ROCK],
                :movesetUpdate => [:ROCKBLAST,:GIGADRAIN,:GYROBALL,:BELCH],
                :itemchange => :ROCKYHELMET,
                :bossStatChanges => {
                    PBStats::ATTACK => 2,
                    PBStats::DEFENSE => -1,
                    PBStats::SPATK => 2,   
                    PBStats::SPDEF => -1,                
                },
                :statDropCure => true,
            },
        }
    },
    :RIFTAELITA => {
        :name => "Rift Aelita",
        :entryText => "Rift Aelita is taking aim...",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :REGIROCK,
            :level => 75,
            :item => :LIFEORB,
            :moves => [:ROCKBLAST,:CLOSECOMBAT,:BULLETSEED,:BARRAGE],
            :nature => :NAUGHTY,
            :form => 2,
            :iv => 31,
            :ev => [0,252,0,252,0,4]
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :message => "Rift Aelita is cocking her gun...",
                :animation => :LASERFOCUS,
                :bossEffect => :LaserFocus,
                :bossEffectduration => 1,
                :movesetUpdate => [:ROCKBLAST,:EARTHQUAKE,:POLLENPUFF,:SHADOWBALL],
                :bossStatChanges => {
                    PBStats::ACCURACY => 1,              
                },
                :fieldChange => :ROCKY,
                :fieldChangeMessage => "The field became littered with rocks!",
                :delayedaction => {
                    :delay => 3,
                    :message => "Rift Aelita is cocking her gun...",
                    :animation => :LASERFOCUS,
                    :bossEffect => :LaserFocus,
                    :bossEffectduration => 1,
                    :repeat => true,
                },
                :statDropCure => true,
                :statusCure => true,
                :effectClear => true,
            },
            2 => {
                :threshold => 0,
                :message => "Rift Aelita let out a piercing screech!",
                :movesetUpdate => [:ROCKSLIDE,:TRIPLEARROWS,:SLUDGEBOMB,:ENERGYBALL],
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 1,   
                    PBStats::SPDEF => 1, 
                },
            },
            1 => {
                :threshold => 0,
                :message => "Rift Aelita is cornered...",
                :movesetUpdate => [:ROCKSLIDE,:TRIPLEARROWS,:ACCELEROCK,:ZAPCANNON],
                :bosssideChanges => :AreniteWall,
                :bosssideChangeCount => 8,
                :bosssideChangeAnimation => :ARENITEWALL,
            },
        }
    },
    :VIVIANREGIROCK => {
        :name => "Stone Guardian",
        :entryText => "The Stone Guardian attacked!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :REGIROCK,
            :level => 70,
            :moves => [:DRAINPUNCH,:BODYPRESS,:ROCKSLIDE,:EARTHQUAKE],
            :nature => :IMPISH,
            :iv => 31,
            :shiny => true,
            :item => :LEFTOVERS,
            :ev => [100,52,252,0,100,0]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :effect => nil,
                :bossEffectduration => nil,
                :message => "Regirock drew power from the earth...",
                :itemchange => :ROCKIUMZ,
                :sideChanges => :StealthRock,
                :sideChangeAnimation => :STEALTHROCK,
                :sideChangesSide => 0,
                :sideChangeMessage => "Floating rocks were deployed!",
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 1,   
                    PBStats::SPDEF => 1, 
                    PBStats::SPEED => 1,                
                },
            }
        }
    },
    :ADMIN => {
        :name => "ADMIN",
        :shieldCount => 1,
        :immunities => {},
        :canrun => true,
        :moninfo => {
            :species => :REGIROCK,
            :level => 70,
            :moves => [:DRAINPUNCH,:BODYPRESS,:ROCKSLIDE,:EARTHQUAKE],
            :nature => :IMPISH,
            :iv => 31,
            :form => 1,
            :item => :LEFTOVERS,
            :ev => [100,52,252,0,100,0]
        },
        :onEntryEffects => {
            :message => "ADMIN drew power from the earth...",
            :itemchange => :ROCKIUMZ,
            :sideChanges => :StealthRock,
            :sideChangeAnimation => :STEALTHROCK,
            :bossEffectduration => nil,
            :sideChangesSide => 0,
            :sideChangeMessage => "Floating rocks were deployed!",
            :bossStatChanges => {
                PBStats::ATTACK => 1,
                PBStats::DEFENSE => 1,
                PBStats::SPATK => 1,   
                PBStats::SPDEF => 1, 
                PBStats::SPEED => 1,                
            },
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0.1,
                :effect => nil,
                :thresholdmessage => "ADMIN reconstructed itself.",
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 1,   
                    PBStats::SPDEF => 1, 
                    PBStats::SPEED => 1,                
                },
            }
        }
    },
    :RIFTFERROTHORN => {
        :name => "Rift Ferrothorn",
        :entryText => "Rift Ferrothorn is readying to attack!",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :FERROTHORN,
            :level => 75,
            :moves => [:POWERWHIP,:LEECHSEED,:GYROBALL,:FIRELASH],
            :nature => :BRAVE,
            :form => 1,
            :iv => 31,
            :item => :LEFTOVERS,
            :ev => [100,52,252,0,100,0]
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :bosssideChanges => [:Reflect,:LightScreen],
                :bosssideChangeAnimation => :REFLECT,
                :bosssideChangeCount => [5,5],
                :message => "Rift Ferrothorn put up defenses!",
            },
            2 => {
                :threshold => 0,
                :effect => nil,
                :bossEffectduration => nil,
                :message => "Rift Ferrothorn became unrestrained!",
                :movesetUpdate => [:FLAREBLITZ,:ENERGYBALL,:IRONHEAD,:SHIFTGEAR],
                :bgmChange => "Battle - Pseudo Contribution",
                :formchange => 2,
                :itemchange => :WHITEHERB,
                :statDropCure => true,
            },
            1 => {
                :threshold => 0,
                :effect => nil,
                :bossEffectduration => nil,
                :message => "Rift Ferrothorn is out of control!",
                :bossStatChanges => {
                    PBStats::ATTACK => 2,
                    PBStats::DEFENSE => -2,
                    PBStats::SPATK => 2,   
                    PBStats::SPDEF => -2, 
                    PBStats::SPEED => 2,                
                },
            }
        }
    },
    :RIFTHIPPOWDON => {
        :name => "Rift Hippowdon",
        :entryText => "Rift Hippowdon is filling the arena with sand!",
        :shieldCount => 4,
        :immunities => {},
        :moninfo => {
            :species => :HIPPOWDON,
            :level => 85,
            :form => 1,
            :moves => [:SPITUP,:HEATWAVE,:EARTHPOWER,:SLUDGEWAVE],
            :gender => "F",
            :nature => :RELAXED,
            :item => :LEFTOVERS,
            :iv => 31,
            :happiness => 0,
            :ev => [4,0,252,0,252,0]
        },
        :onEntryEffects => {
            :animation => :HEATWAVE,
            :message => "The whirling sands are scorching!",
            :delayedaction => {
                :delay => 4,
                :message => "The searing sands inflicted burns!",
                :playerSideStatusChanges => [:BURN,"Burn"],
                :repeat => true,
            }
        },
        :onBreakEffects => {
            4 => {
                :threshold => 0,
                :message => "Rift Hippowdon shot sand everywhere!",
                :movesetUpdate => [:SPITUP,:EARTHQUAKE,:GUNKSHOT,:HEATWAVE],
                :weatherChange => :SANDSTORM,
                :weatherChangeAnimation => "Sandstorm",
                :weatherChangeMessage => "Sandstorms keep brewing...",
                :playersideChanges => :StealthRock,
                :playersideChangeAnimation => :STEALTHROCK,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::SPATK => 1,
                }
            },
            3 => {
                :threshold => 0,
                :message => "A shelter of sand is protecting Rift Hippowdon!",
                :movesetUpdate => [:SPITUP,:EARTHQUAKE,:GUNKSHOT,:BODYPRESS],
                :weatherChange => :SANDSTORM,
                :weatherChangeAnimation => "Sandstorm",
                :weatherChangeMessage => "Sandstorms keep brewing...",
                :bossEffect => :Shelter,
                :bossEffectanimation => :SHELTER,
                :bossEffectduration => true,
                :playersideChanges => :Spikes,
                :playersideChangeAnimation => :SPIKES,
                :playersideChangeCount => 1,
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                    PBStats::SPDEF => 1,
                }
            },
            2 => {
                :threshold => 0,
                :statDropCure => true,
                :statusCure => true,
                :message => "The arena is heating up more!",
                :animation => :INFERNO,
                :movesetUpdate => [:SPITUP,:EARTHPOWER,:DRAGONPULSE,:HEATWAVE],
                :weatherChange => :SANDSTORM,
                :weatherChangeAnimation => "Sandstorm",
                :weatherChangeMessage => "Sandstorms keep brewing...",
                :typeChange => [:GROUND,:FIRE],
                :itemchange => :SITRUSBERRY,
                :playersideChanges => :Spikes,
                :playersideChangeAnimation => :SPIKES,
                :playersideChangeCount => 1,
                :delayedaction => {
                    :delay => 5,
                    :message => "Rift Hippowdon is burning up!",
                    :bossStatChanges => {
                        PBStats::ATTACK => 1,
                        PBStats::SPATK => 1,
                    }
                }
            },
            1 => {
                :threshold => 0,
                :message => "Rift Hippowdon expelled tonnes of sand!",
                :movesetUpdate => [:SPITUP,:DIG,:BODYPRESS,:HEATWAVE],
                :weatherChange => :SANDSTORM,
                :weatherChangeAnimation => "Sandstorm",
                :weatherChangeMessage => "Sandstorms keep brewing...",
                :bosssideChanges => :AreniteWall,
                :bosssideChangeCount => 5,
                :bosssideChangeAnimation => :ARENITEWALL,
                :itemchange => :SITRUSBERRY,
                :delayedaction => {
                    :delay => 4,
                    :message => "The sandstorm is weakening your Pokemon!",
                    :playerSideStatChanges => {
                        PBStats::ATTACK => -1,
                        PBStats::DEFENSE => -1,
                        PBStats::SPATK => -1,
                        PBStats::SPDEF => -1,
                        PBStats::SPEED => -1,
                    }
                },
                :fieldChange => :DESERT,
            },
        }
    },
    :ANGELOFDEATH => {
        :name => "Angel of Death",
        :entryText => "The Angel of Death appears with bloodlust...",
        :shieldCount => 4,
        :immunities => {},
        :moninfo => {
            :species => :GARDEVOIR,
            :level => 75,
            :form => 3,
            :moves => [:DARKPULSE,:LOVELYKISS,:DAZZLINGGLEAM,:MYSTICALFIRE],
            :gender => "F",
            :nature => :SERIOUS,
            :iv => 31,
            :happiness => 255,
            :ev => [85,85,85,85,85,85]
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 2",
            :continuous => true,
            :totalMonCount => 4,
            :moninfos => {
                1 => {
                    :species => :RALTS,
                    :level => 75,
                    :form => 1,
                    :moves => [:TORMENT,:HELPINGHAND,:POISONGAS,:NIGHTSHADE],
                    :gender => "F",
                    :iv => 31,
                },
                2 => {
                    :species => :KIRLIA,
                    :level => 75,
                    :form => 1,
                    :moves => [:QUASH,:HELPINGHAND,:WILLOWISP,:SNARL],
                    :gender => "F",
                    :iv => 31,
                },
            },
        },
        :onBreakEffects => {
            4 => {
                :threshold => 0,
                :animation => :SECRETSWORD,
                :message => "The Angel of Death drew its scythe.",
                :movesetUpdate => [:NIGHTSLASH,:LOVELYKISS,:SPIRITBREAK,:PSYCHOCUT],
                :playerSideStatChanges => {
                    PBStats::DEFENSE => -1,
                }
            },
            3 => {
                :threshold => 0,
                :animation => :CHARGE,
                :itemchange => :LEFTOVERS,
                :message => "The Angel of Death is drawing power.",
                :movesetUpdate => [:NIGHTSLASH,:PROTECT,:LAVAPLUME,:SACREDSWORD],
                :playerSideStatChanges => {
                    PBStats::ATTACK => -1,
                    PBStats::SPATK => -1,
                }
            },
            2 => {
                :threshold => 0,
                :animation => :DAZZLINGGLEAM,
                :message => "The Angel of Death summoned minions.",
                :movesetUpdate => [:DARKPULSE,:PSYCHOCUT,:NIGHTSLASH,:AURASPHERE],
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::SPATK => 1,
                }
            },
            1 => {
                :threshold => 0,
                :animation => :DARKPULSE,
                :message => "The Angel of Death has fury.",
                :itemchange => :DARKINIUMZ,
                :movesetUpdate => [:HYPERSPACEFURY,:MOONBLAST,:EARTHQUAKE,:BOOMBURST],
            },
        }
    },
    :FALLENANGEL => {
        :name => "Fallen Angel",
        :entryText => "The Angel is on its last legs...",
        :shieldCount => 0,
        :immunities => {},
        :moninfo => {
            :species => :GARDEVOIR,
            :level => 75,
            :form => 4,
            :moves => [:LASHOUT,:BURNINGJEALOUSY,:HYPERSPACEHOLE,:THRASH],
            :gender => "F",
            :nature => :LONELY,
            :iv => 31,
            :happiness => 255,
            :ev => [85,85,85,85,85,85]
        },
        :onBreakEffects => {
        }
    },
    :BOSSARCEUS_CASINO => {
        :name => "Casino Bouncer",
        :entryText => "STOP! You've violated the law! Pay the court a fine or serve your sentence. Your stolen goods are now forfeit.",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :ARCEUS,
            :level => 75,
            :moves => [:JUDGMENT,:PUNISHMENT,:EXTREMESPEED,:LIQUIDATION],
            :gender => "F",
            :nature => :LONELY,
            :ability => :MULTITYPE,
            :item => :FISTPLATE,
            :iv => 31,
            :happiness => 255,
            :ev => [0,252,0,4,0,252]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "STOP! You've violated the law! Pay the court a fine or serve your sentence. Your stolen goods are now forfeit.",
                :animation => :COSMICPOWER,
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                    PBStats::SPDEF => 1,
                }
            }
        }
    },
    :NIGHTMAREREMIX => {
        :name => "Nightmare Remix",
        :entryText => "The... Puppet Master? Attacks?",
        :shieldCount => 5,
        :immunities => {},
        :moninfo => {
            :species => :DARKRAI,
            :level => 75,
            :form => 7,
            :moves => [:SPIRITBREAK,:PSYCHIC,:AURORAVEIL,:THROATCHOP],
            :gender => "M",
            :nature => :BRAVE,
            :item => :PSYCHICGEM,
            :iv => 31,
            :happiness => 0,
            :ev => [4,252,0,252,0,0]
        },
        :onEntryEffects => {
            :fieldChange => :STARLIGHT,
            :message => "Twinkle twinkle little star...",
            :delayedaction => {
                :delay => 4,
                :fieldChange => :NEWWORLD,
                :playerSideStatusChanges => [:SLEEP,"Sleep"],
                :message => "All fall to the Puppet Master's sway...",
                :playerEffects => :Nightmare,
                :playerEffectsAnimation => :NIGHTMARE,
                :playerEffectsduration => true,
                :playerEffectsMessage => "Now, sleep with this trauma that will leave you sleepless!",
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPEED => 1,
                }
            }
        },
        :onBreakEffects => {
            5 => {
                :threshold => 0,
                :message => "No fairy tale...",
                :movesetUpdate => [:DARKPULSE,:FLAMETHROWER,:PSYSHOCK,:MOONLIGHT],
                :itemchange => :ROSELIBERRY,
                :bosssideChanges => :Safeguard,
                :bosssideChangeAnimation => :SAFEGUARD,
                :bosssideChangeCount => 5
            },
            4 => {
                :threshold => 0,
                :message => "Grow weary...",
                :movesetUpdate => [:MOONBLAST,:ICEBEAM,:KNOCKOFF,:PROTECT],
                :itemchange => :LEFTOVERS,
                :animation => :HYPNOSIS,
                :playerSideStatChanges => {
                    PBStats::ATTACK => -3,
                    PBStats::SPATK=> -3
                }
            },
            3 => {
                :threshold => 0,
                :message => "Nightmare...",
                :movesetUpdate => [:DAZZLINGGLEAM,:SACREDSWORD,:ZENHEADBUTT,:DARKVOID],
                :itemchange => :FAIRYGEM,
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::DEFENSE => 2,
                    PBStats::SPDEF => 2,
                }
            },
            2 => {
                :threshold => 0,
                :message => "Don't sleep... Don't wake up...",
                :movesetUpdate => [:DOOMDESIRE,:VACUUMWAVE,:DARKPULSE,:ANCIENTPOWER],
                :itemchange => :FIGHTINGGEM,
                :statDropCure => true,
                :statusCure => true,
                :effectClear => true,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::SPATK => 1,
                }
            },
            1 => {
                :threshold => 0,
                :message => "Welcome the end...",
                :itemchange => :STEELGEM,
                :movesetUpdate => [:METEORMASH,:COMETPUNCH,:THROATCHOP,:PSYSTRIKE],
                :statDropCure => true,
            },
        }
    },
    :KKING => {
        :name => "Klinklang King",
        :entryText => "The gears are grinding!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :KLINKLANG,
            :level => 100,
            :form => 1,
            :moves => [:THUNDERCAGE,:ZINGZAP,:PROTECT,:BULLDOZE],
            :gender => "M",
            :nature => :BRAVE,
            :item => :LEFTOVERS,
            :ability => :SPEEDBOOST,
            :shiny => false,
            :iv => 31,
            :happiness => 0,
            :ev => [4,252,0,252,0,0]
        },
        :onBreakEffects => {
        }
    },
    :BIGBETTY => {
        :name => "Big Betty",
        :entryText => "Big Betty stands her ground!",
        :shieldCount => 0,
        :immunities => {},
        :moninfo => {
            :species => :EMBOAR,
            :level => 78,
            :moves => [:EARTHQUAKE,:HEADSMASH,:FLAREBLITZ,:WILLOWISP],
            :ability => :BLAZE,
            :gender => "F",
            :form => 1,
            :nature => :ADAMANT,
            :iv => 31,
        },
        :onBreakEffects => {
        }
    },
    :BIGBETTYTWO => {
        :name => "Big Betty",
        :entryText => "Big Betty stands her ground... again!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :EMBOAR,
            :level => 80,
            :moves => [:EARTHQUAKE,:HEADSMASH,:FLAREBLITZ,:WILLOWISP],
            :ability => :BLAZE,
            :gender => "F",
            :form => 1,
            :nature => :ADAMANT,
            :iv => 31,
        },
        :onEntryEffects => {
            :fieldChange => :FAIRYTALE,
            :fieldChangeMessage => "Goomink's resolve manifested!"
        },
        :onBreakEffects => {
        }
    },
    :BOSSZEKROM => {
        :name => "Fanciful Ideals",
        :entryText => "Zekrom is crackling with electricity!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :ZEKROM,
            :level => 90,
            :item => :LUMBERRY,
            :moves => [:FOCUSBLAST,:REFLECT,:BOLTSTRIKE,:OUTRAGE],
            :ability => :TERAVOLT,
            :gender => "M",
            :nature => :NAIVE,
            :iv => 31,
            :ev => [252, 252, 0, 0, 0, 0]
        },
        :onBreakEffects => {
        }
    },
    :BOSSRESHIRAM => {
        :name => "Imaginary Truths",
        :entryText => "Reshiram is blazing with fire!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :RESHIRAM,
            :level => 90,
            :item => :WISEGLASSES,
            :moves => [:DRAGONCLAW,:FUSIONFLARE,:EARTHPOWER,:CRUNCH],
            :ability => :TURBOBLAZE,
            :gender => "M",
            :nature => :TIMID,
            :iv => 31,
            :ev => [252, 0, 0, 252, 0, 0]
        },
        :onBreakEffects => {
        }
    },
    :BOSSNAGANADEL => {
        :name => "Naganadel",
        :entryText => "Naganadel is ready to kill!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :NAGANADEL,
            :level => 87,
            :item => :LIFEORB,
            :moves => [:SLUDGEWAVE,:DRAGONPULSE,:HEATWAVE,:NASTYPLOT],
            :ability => :BEASTBOOST,
            :gender => "M",
            :nature => :TIMID,
            :iv => 31,
            :happiness => 0,
            :ev => [0, 0, 4, 252, 0, 252]
        },
        :onBreakEffects => {
        }
    },
    :BOSSGOTHITELLE => {
        :name => "Gothitelle",
        :entryText => "Gothitelle is looking serious!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :GOTHITELLE,
            :level => 90,
            :item => :GOTHCREST,
            :moves => [:GRAVITY,:GRASSKNOT,:PSYCHIC,:DARKPULSE],
            :ability => :SHADOWTAG,
            :gender => "F",
            :nature => :MODEST,
            :form => 1,
            :iv => 31,
            :ev => [4,0,0,252,0,252]
        },
        :onBreakEffects => {
        }
    },
    :GEARAGIRA => {
        :name => "Giratina",
        :entryText => "Giratina appears once again!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :GIRATINA,
            :level => 65,
            :item => :GRISEOUSORB,
            :moves => [:EARTHPOWER,:SHADOWSNEAK,:DRAGONPULSE,:THUNDER],
            :ability => :LEVITATE,
            :nature => :NAIVE,
            :form => 1,
            :iv => 31,
            :ev => [252,252,252,252,252,252]
        },
        :onBreakEffects => {
        }
    },
    :STORMNINE => {
        :name => "STORM | Wind",
        :entryText => "Erratic weather begets a disaster...",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :XERNEAS,
            :level => 85,
            :item => :LIFEORB,
            :moves => [:WEATHERBALL,:HURRICANE,:THUNDER,:PSYSHOCK],
            :ability => :TEMPEST,
            :nature => :MODEST,
            :form => 1,
            :iv => 31,
            :ev => [252,0,4,252,0,0]
        },
        :onBreakEffects => {
        }
    },
    :BOSSCOFAGRIGUS => {
        :name => "Totem Cofagrigus",
        :entryText => "The menacing Cofagrigus attacked!",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :COFAGRIGUS,
            :level => 85,
            :moves => [:SHADOWBALL,:TOXICSPIKES,:WILLOWISP,:ENERGYBALL],
            :ability => :MUMMY,
            :gender => "M",
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
            :ev => [0,0,0,252,252,0],
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 3",
            :totalMonCount => 3,
            :moninfos => {
                1 => {
                    :species => :STANTLER,
                    :level => 80,
                    :item => :STANTCREST,
                    :moves => [:HYPNOSIS,:MEGAHORN,:JUMPKICK,:ZENHEADBUTT],
                    :ability => :INTIMIDATE,
                    :gender => "F",
                    :nature => :JOLLY,
                    :iv => 31,
                    :happiness => 255,
                    :ev => [0,252,0,0,0,252]
                },
                2 => {
                    :species => :MAGCARGO,
                    :level => 80,
                    :item => :MAGCREST,
                    :moves => [:FLAMEBURST,:YAWN,:EARTHPOWER,:WILLOWISP],
                    :ability => :FLAMEBODY,
                    :gender => "M",
                    :nature => :BOLD,
                    :iv => 31,
                    :happiness => 255,
                    :ev => [0,0,252,252,0,0]
                },
                3 => {
                    :species => :LEAFEON,
                    :level => 80,
                    :item => :LEAFCREST,
                    :moves => [:SWORDSDANCE,:NATUREPOWER,:LEAFBLADE,:XSCISSOR],
                    :ability => :LEAFGUARD,
                    :gender => "F",
                    :nature => :ADAMANT,
                    :iv => 31,
                    :happiness => 255,
                    :ev => [252,128,0,0,252,0]
                },
            },
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :bosssideChanges => :AreniteWall,
                :bosssideChangeAnimation => :ARENITEWALL,
                :bosssideChangeCount => 5,
                :message => "Sand swarms all around!",
                :movesetUpdate => [:SHADOWBALL,:BODYPRESS,:CALMMIND,:PSYCHIC],
                :itemchange => :SITRUSBERRY,
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                    PBStats::SPDEF => 1,             
                },
            },
            2 => {
                :threshold => 0,
                :movesetUpdate => [:SHADOWBALL,:PROTECT,:ENERGYBALL,:HIDDENPOWERFIG],
                :itemchange => :LEFTOVERS,
                :delayedaction => {
                    :delay => 3,
                    :message => "Beware the Pharaoh's curse!",
                    :playerEffects => :Curse,
                    :playerEffectsAnimation => :CURSE,
                    :playerEffectsduration => true,
                    :repeat => true,            
                },
            },
            1 => {
                :threshold => 0,
                :itemchange => :COFCREST,
                :statDropCure => true,
                :effectClear => true,
            },
        }
    },
    :COFFEEGREGUS => {
        :name => "COFFEE GREGUS",
        :entryText => "COFFEE GREGUS!",
        :shieldCount => 4,
        :immunities => {},
        :moninfo => {
            :species => :COFAGRIGUS,
            :level => 85,
            :moves => [:SHADOWPUNCH,:COMETPUNCH,:BULLETPUNCH,:BULKUP],
            :item => :FOCUSSASH,
            :gender => "M",
            :nature => :MODEST,
            :form => 1,
            :iv => 31,
            :happiness => 255,
            :ev => [0,252,0,0,0,252],
        },
        :onBreakEffects => {
            4 => {
                :threshold => 0,
                :movesetUpdate => [:SHADOWPUNCH,:SCORCHINGSANDS,:AURASPHERE,:BULKUP],
                :itemchange => :SITRUSBERRY,
                :message => "COFFEE GREGUS!",
                :animation => :BULKUP,
                :bossStatChanges => {
                    PBStats::DEFENSE => 2,
                    PBStats::SPDEF => 2,             
                },
                :fieldChange => :BIGTOP,
                :fieldChangeMessage => "CLOWN FIESTA!"
            },
            3 => {
                :threshold => 0,
                :movesetUpdate => [:SHADOWPUNCH,:CROSSCHOP,:ICEPUNCH,:BULKUP],
                :itemchange => :GHOSTGEM,
                :bossEffect => :LaserFocus,
                :bossEffectanimation => :LASERFOCUS,
                :bossEffectduration => 1,
                :message => "COFFEE GREGUS!",
                :animation => :BULKUP,
            },
            2 => {
                :threshold => 0,
                :movesetUpdate => [:SHADOWPUNCH,:DYNAMICPUNCH,:BODYPRESS,:BULKUP],
                :itemchange => :SITRUSBERRY,
                :message => "COFFEE GREGUS!",
                :animation => :BULKUP,
                :statDropCure => true,
                :effectClear => true,
                :delayedaction => {
                    :delay => 1,
                    :repeat => true,
                    :playerEffects => :Foresight,
                    :playerEffectsAnimation => :FORESIGHT,
                    :message => "THERE IS NO ESCAPE FROM COFFEE GREGUS!",
                    :playerSideStatChanges => {
                        PBStats::EVASION => -1
                    }
                }
            },
        }
    },
    :KAWOPUDUNGA => {
        :name => "Kawopudunga",
        :entryText => "Kawopudunga is ready to feast!",
        :shieldCount => 4,
        :immunities => {},
        :moninfo => {
            :species => :WAILORD,
            :level => 75,
            :form => 1,
            :moves => [:DIVE,:DARKESTLARIAT,:AQUARING,:FRUSTRATION],
            :gender => "F",
            :nature => :HARDY,
            :item => :SITRUSBERRY,
            :iv => 31,
            :happiness => 0,
            :ev => [4,252,0,252,0,0]
        },
        :onBreakEffects => {
            4 => {
                :threshold => 0,
                :itemchange => :SITRUSBERRY,
                :message => "Kawopudunga changed its type!",
                :movesetUpdate => [:DIVE,:HEAVYSLAM,:NOBLEROAR,:BODYPRESS],
                :typeChange => [:WATER,:STEEL],
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::DEFENSE => 2,
                }
            },
            3 => {
                :threshold => 0,
                :itemchange => :SITRUSBERRY,
                :message => "Kawopudunga changed its type!",
                :movesetUpdate => [:DIVE,:ICICLECRASH,:ENCORE,:FREEZEDRY],
                :typeChange => [:WATER,:ICE],
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::SPDEF => 2,
                }
            },
            2 => {
                :threshold => 0,
                :itemchange => :SITRUSBERRY,
                :message => "Kawopudunga changed its type!",
                :movesetUpdate => [:DIVE,:OUTRAGE,:DRAGONDANCE,:HEAVYSLAM],
                :typeChange => [:WATER,:DRAGON],
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::ATTACK => 2,
                }
            },
            1 => {
                :threshold => 0,
                :itemchange => :SITRUSBERRY,
                :message => "Kawopudunga changed its type!",
                :movesetUpdate => [:DIVE,:DARKPULSE,:RECOVER,:TOXIC],
                :typeChange => [:WATER,:DARK],
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::SPATK => 2,
                }
            },
        }
    },
    :BOSSKECLEON => {
        :name => "Wacky Lizard",
        :entryText => "Wacky Lizard's staring into space.",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :KECLEON,
            :level => 85,
            :form => 0,
            :moves => [:PLAYROUGH,:THUNDERPUNCH,:BOUNCE,:EARTHQUAKE],
            :gender => "F",
            :ability => :SHEERFORCE,
            :nature => :BRAVE,
            :item => :SITRUSBERRY,
            :iv => 31,
            :happiness => 0,
            :ev => [0,252,4,252,0,0]
        },
        :onEntryEffects => {
            :delayedaction => {
                :delay => 1,
                :repeat => true,
                :loopingsetchanges => true,
                :itemchange => :LIFEORB,
                :setwinvariable => true,
                :message => "Wacky Lizard's type shifted!",
                :typeSequence => {
                    1 => {
                            :typeChange => [:FLYING,:FLYING],
                         },
                    2 => {
                            :typeChange => [:ELECTRIC,:FLYING],
                         },
                    3 => {
                            :typeChange => [:GROUND,:FLYING],
                         },
                    4 => {
                            :typeChange => [:FAIRY,:FLYING],
                         },
                },
            },
        },
        :onBreakEffects => {
            2 => {
            :threshold => 0,
            :itemchange => :LIFEORB,
            :movesetUpdate => [:THUNDER,:HURRICANE,:MOONBLAST,:EARTHPOWER],
            :statDropCure => true,
            :bossStatChanges => {
                PBStats::SPATK => 2,
                PBStats::ACCURACY => 1, 
                }
            },
        },
    },
    :BOSSGOURGEIST => {
        :name => "Jack-o'-lantern",
        :entryText => "A large pumpkin suddenly attacked!",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :GOURGEIST,
            :level => 80,
            :form => 1,
            :moves => [:WILLOWISP,:SEEDBOMB,:LEECHSEED,:CURSE],
            :gender => "F",
            :ability => :INSOMNIA,
            :nature => :BRAVE,
            :item => :SITRUSBERRY,
            :iv => 31,
            :happiness => 0,
            :ev => [252,252,4,0,0,0]
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :message => "The Jack-o'-lantern was lit up!",
                :movesetUpdate => [:FIREBLAST,:ENERGYBALL,:TRICKROOM,:ROCKSLIDE],
                :typeChange => [:GRASS,:FIRE],
                :abilitychange => :FLASHFIRE,
                :itemchange => :ELEMENTALSEED,
                :fieldChange => :GRASSY,
                :statDropCure => true,
                :statusCure => true,
                :effectClear => true,
                :bossStatChanges => {
                    PBStats::SPATK => 2,
                }
            },
            2 => {
                :threshold => 0,
                :itemchange => :BIGROOT,
                :movesetUpdate => [:GIGADRAIN,:LEECHSEED,:MYSTICALFIRE,:PHANTOMFORCE],
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                    PBStats::SPDEF => 1,
                }
            },
            1 => {
                :threshold => 0,
                :movesetUpdate => [:GRASSYGLIDE,:ROCKSLIDE,:SYNTHESIS,:SHADOWSNEAK],
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::ATTACK => 2,
                }
            },
        }
    },
    :DUFAUX => {
        :name => "Dufaux",
        :entryText => "The Clefairy doll attacked!",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :FROSLASS,
            :level => 90,
            :form => 2,
            :moves => [:POISONGAS,:DISCHARGE,:ICEBEAM,:MOONBLAST],
            :gender => "F",
            :nature => :MODEST,
            :item => :SITRUSBERRY,
            :iv => 31,
            :happiness => 0,
            :ev => [252,0,0,252,0,0]
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :bosssideChanges => :Safeguard,
                :bosssideChangeCount => 5,
                :bosssideChangeAnimation => :SAFEGUARD,
                :itemchange => :MAGICALSEED,
                :message => "Dufaux attempted to repair itself...",
                :statDropCure => true,
                :statusCure => true,
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                }
            },
            2 => {
                :threshold => 0,
                :itemchange => :MAGNET,
                :message => "Dufaux broke out of its shell!",
                :movesetUpdate => [:SLUDGEBOMB,:DISCHARGE,:BLIZZARD,:WILLOWISP],
                :statDropCure => true,
                :formchange => 3,
                :weatherChange => :HAIL,
                :weatherChangeMessage => HAILSNOWMOD + " started to fall!",
                :weatherChangeAnimation => "Hail",
                :playerSideStatChanges => {
                    PBStats::ATTACK => -1,
                    PBStats::DEFENSE => -1,
                    PBStats::SPATK => -1,
                    PBStats::SPDEF => -1,
                    PBStats::SPEED => -1
                }
            },
            1 => {
                :threshold => 0,
                :statDropCure => true,
                :weatherChange => :HAIL,
                :weatherChangeMessage => HAILSNOWMOD + " started to fall!",
                :weatherChangeAnimation => "Hail",
                :bossStatChanges => {
                    PBStats::SPATK => 1,
                }
            },
        }
    },
    :MECHAGYARADOS => {
        :name => "GYARA-01",
        :entryText => "WARNING! WARNING! WARNING!",
        :shieldCount => 6,
        :immunities => {},
        :moninfo => {
            :species => :GYARADOS,
            :level => 90,
            :form => 3,
            :moves => [:THUNDERBOLT,:HYPERBEAM,:FLAMETHROWER,:SCALD],
            :gender => "F",
            :nature => :HARDY,
            :iv => 31,
            :happiness => 0,
            :ev => [4,252,0,252,0,0]
        },
        :onBreakEffects => {
            5 => {
                :threshold => 0,
                :message => "DESTRUCTION MODE ENGAGED!",
                :movesetUpdate => [:STEELBEAM,:MINDBLOWN,nil,nil],
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::SPATK => 1,
                }
            },
            3 => {
                :threshold => 0,
                :message => "COOLING DOWN...",
                :movesetUpdate => [:HYPERVOICE,:ICEBEAM,:IRONHEAD,:DOUBLEEDGE],
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::SPEED => -1,
                }
            },
            1 => {
                :threshold => 0,
                :message => "SELF-DESTRUCT SEQUENCE ACTIVATED!",
                :movesetUpdate => [:EXPLOSION,nil,nil,nil],
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::ATTACK => 6,
                }
            }
        }
    },
    :MASTEROFNIGHTMARES => {
        :name => "Master of Nightmares",
        :entryText => "The battle against nightmares has begun.",
        :shieldCount => 5,
        :immunities => {},
        :moninfo => {
            :species => :DARKRAI,
            :level => 90,
            :form => 2,
            :moves => [:THUNDERCAGE,:CROSSCHOP,:BUNRAKUBEATDOWN,:NIGHTMARE],
            :gender => "M",
            :nature => :BRAVE,
            :item => :LEFTOVERS,
            :iv => 31,
            :happiness => 0,
            :ev => [4,252,0,252,0,0]
        },
        :onEntryEffects => {
            :animation => :IONDELUGE,
            :fieldChange => :ELECTERRAIN,
            :fieldChangeMessage => "Aelita's nightmares manifest into reality...",
            :delayedaction => {
                :delay => 1,
                :playerSideStatusChanges => [:PARALYSIS,"Paralysis"],
                :delayedaction => {
                    :delay => 3,
                    :repeat => true,
                    :playerEffects => :GastroAcid,
                    :playerEffectsAnimation => :EMBARGO,
                    :playerEffectsMessage => "Abilities have been suppressed!"
                }
            }
        },
        :onBreakEffects => {
            5 => {
                :threshold => 0,
                :message => "Memories of being burned alive pass by...",
                :movesetUpdate => [:ERUPTION,:EARTHQUAKE,:BUNRAKUBEATDOWN,:NIGHTMARE],
                :formchange => 3,
                :statDropCure => true,
                :animation => :ERUPTION,
                :playerSideStatusChanges => [:BURN,"Burn"],
                :playerEffects => :TarShot,
                :playerEffectsAnimation => :TARSHOT,
                :playerEffectsMessage => "You feel highly flammable...",
                :fieldChange => :VOLCANICTOP,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::SPATK => 1,
                }
            },
            4 => {
                :threshold => 0,
                :message => "The feeling of an explosion creeps up your spine...",
                :movesetUpdate => [:MOONBLAST,:SACREDSWORD,:BUNRAKUBEATDOWN,:NIGHTMARE],
                :formchange => 4,
                :statDropCure => true,
                :animation => :EXPLOSION,
                :fieldChange => :DIMENSIONAL,
                :bossStatChanges => {
                    PBStats::SPDEF => 1,
                },
                :playerSideStatChanges => {
                    PBStats::DEFENSE => -2,
                    PBStats::SPDEF => -2
                }
            },
            3 => {
                :threshold => 0,
                :message => "You feel death incarnate staring you down...",
                :movesetUpdate => [:OBLIVIONWING,:DARKPULSE,:BUNRAKUBEATDOWN,:NIGHTMARE],
                :formchange => 5,
                :statDropCure => true,
                :fieldChange => :CHESS,
                :animation => :DECIMATION,
                :playerEffects => :PerishSong,
                :playerEffectsduration => 3,
                :playerEffectsAnimation => :PERISHSONG,
                :playerEffectsMessage => "Death is imminent...",
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                }
            },
            2 => {
                :threshold => 0,
                :message => "The true nightmare begins.",
                :movesetUpdate => [:BUNRAKUBEATDOWN,:FIERYWRATH,:MOONGEISTBEAM,:THUNDERCAGE],
                :formchange => 1,
                :statDropCure => true,
                :statusCure => true,
                :effectClear => true,
                :fieldChange => :NEWWORLD,
                :animation => :NIGHTDAZE,
                :delayedaction => {
                    :delay => 1,
                    :playerEffects => :Yawn,
                    :playerEffectsAnimation => :YAWN,
                    :playerEffectsduration => 1,
                    :playerEffectsMessage => "A strong feeling of drowsiness...",
                    :delayedaction => {
                        :delay => 4,
                        :repeat => true,
                        :playerEffects => :Yawn,
                        :playerEffectsAnimation => :YAWN,
                        :playerEffectsduration => 1,
                        :playerEffectsMessage => "A strong feeling of drowsiness...",
                    },
                },
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPEED => 1,
                },
                :itemchange => :GHOSTIUMZ
            },
        }
    },
    :MASTEROFNIGHTMARES2 => {
        :name => "Master of Nightmares",
        :entryText => "The nightmare will end soon.",
        :shieldCount => 0,
        :immunities => {},
        :moninfo => {
            :species => :DARKRAI,
            :level => 90,
            :moves => [:BUNRAKUBEATDOWN,:NIGHTMARE,:TAUNT,:SHADOWCLAW],
            :gender => "F",
            :nature => :MODEST,
            :form => 6,
            :iv => 31,
        },
        :onBreakEffects => {
        }
    },
    :BOSSKLINKLANG => {
        :name => "Klinklang Queen",
        :entryText => "KLINKLANG: Ohohoho!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :KLINKLANG,
            :level => 85,
            :form => 1,
            :moves => [:SHIFTGEAR,:GEARGRIND,:FACADE,:WILDCHARGE],
            :nature => :ADAMANT,
            :item => :LEFTOVERS,
            :iv => 31,
            :happiness => 0,
            :ev => [252,252,0,0,0,4]
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "The Klinklang Queen revs up!",
                :statusCure => true,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPEED => 1
                }
            },
            1 => {
                :threshold => 0,
                :message => "Gears appear all around!",
                :movesetUpdate => [:SUBSTITUTE,:GEARGRIND,:FACADE,:WILDCHARGE],
                :fieldChange => :FACTORY,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::SPEED => 2
                }
            },
        }
    },
    :GERBIL1 => {
        :name => "Entei", # nickname
        :entryText => "Entei appeared before you!",
        :shieldCount => 2, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :capturable => true, # can you catch this boss after shields are removed?
        :moninfo => { # pokemon details
            :species => :ENTEI,
            :level => 85,
            :form => 0,
            :item => :LEFTOVERS,
            :moves => [:SACREDFIRE,:EARTHQUAKE,:EXTREMESPEED,:WILLOWISP],
            :ability => :PRESSURE,
            :nature => :ADAMANT,
            :iv => 31,
            :happiness => 255,
            :ev => [252,252,4,0,0,0]
        },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            2 => {
                :bgmChange => "Battle - Final Endeavor",
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :weatherChange => :SUNNYDAY, # weather to apply
                :fieldChange => :VOLCANICTOP, # field changes
                :fieldChangeMessage => "Entei changed reality around it!", # message that plays when the field is changes
                :weatherCount => 5, # weather turncount
                :weatherChangeMessage => "The Sun is bright!", # weather message
                :weatherChangeAnimation => "Sunny", # string of "Rain", "Sunny","Hail","Sandstorm"
                :statusCure => true, # if status is cured when shield is broken
                :statDropCure => true, # if statdrops are negated when shield is broken
                :movesetUpdate => [:ERUPTION,:EXTRASENSORY,:EARTHQUAKE,:CALMMIND],
                :itemchange => :CHARCOAL, # item that is given upon breaking shield
                :bossStatChanges => { # any statboosts that are given
                    PBStats::ATTACK => 1,
                    PBStats::SPATK => 2,
                },
            },
        }
    },  
    :GERBIL2 => {
        :name => "Suicune", # nickname
        :entryText => "Suicune appeared before you!",
        :shieldCount => 2, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :capturable => true, # can you catch this boss after shields are removed?
        :moninfo => { # pokemon details
            :species => :SUICUNE,
            :level => 85,
            :form => 0,
            :item => :LEFTOVERS,
            :moves => [:AQUARING,:EXTRASENSORY,:SCALD,:CALMMIND],
            :ability => :PRESSURE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
            :ev => [252,0,4,252,0,0]
        },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            2 => {
                :bgmChange => "Battle - Final Endeavor",
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "", # message that plays when shield is broken
                :abilitychange => :PRESSURE,
                :fieldChange => :UNDERWATER, # field changes
                :fieldChangeMessage => "Suicune changed reality around it!", # message that plays when the field is changes
                :statusCure => true, # if status is cured when shield is broken
                :statDropCure => true, # if statdrops are negated when shield is broken
                :itemchange => :MYSTICWATER, # item that is given upon breaking shield
                :movesetUpdate => [:SURF,:ICEBEAM,:EXTRASENSORY,:CALMMIND],
                :bossStatChanges => { # any statboosts that are given
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 2,
                },
            },
        }
    },  
    :GERBIL3 => {
        :name => "Raikou", # nickname
        :entryText => "Raikou appeared before you!",
        :shieldCount => 2, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :capturable => true, # can you catch this boss after shields are removed?
        :moninfo => { # pokemon details
            :species => :RAIKOU,
            :level => 85,
            :form => 0,
            :item => :LEFTOVERS,
            :moves => [:THUNDER,:AURASPHERE,:SCALD,:CALMMIND],
            :ability => :PRESSURE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
            :ev => [252,0,4,252,0,0]
        },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            2 => {
                :bgmChange => "Battle - Final Endeavor",
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "", # message that plays when shield is broken
                :weatherChange => :RAINDANCE, # weather to apply
                :fieldChange => :ELECTERRAIN, # field changes
                :fieldChangeMessage => "Raikou changed reality around it!", # message that plays when the field is changes
                :weatherChangeMessage => "The Rain pours down!", # weather message
                :weatherChangeAnimation => "Rain", # string of "Rain", "Sunny","Hail","Sandstorm"
                :statusCure => true, # if status is cured when shield is broken
                :statDropCure => true, # if statdrops are negated when shield is broken
                :itemchange => :MAGNET, # item that is given upon breaking shield
                :movesetUpdate => [:THUNDER,:WEATHERBALL,:AURASPHERE,:HIDDENPOWER],
                :bossStatChanges => { # any statboosts that are given
                    PBStats::SPATK => 3,
                },
            },
        }
    },  
    :ICESOLDIER => {
        :name => "Ice Soldier", # nickname
        :entryText => "En Garde!",
        :shieldCount => 2, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :REGICE,
            :level => 90,
            :form => 1,
            :moves => [:HAIL,:SURF,:PSYCHIC,:COLDTRUTH],
            :ability => :LEVITATE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
            :ev => [0,0,4,252,0,252]
        },
        :sosDetails =>  { # pokemon details
        :activationRequirement => "@battle.battlers[battlerIndex].shieldCount == 0",
        :continuous => true,
        :totalMonCount => 2,
        :moninfos => {
            1 => {
                :species => :SABLEYE,
                :level => 85,
                :item => :SABLENITE,
                :moves => [:CONFUSERAY,:WILLOWISP,:PROTECT,:RECOVER],
                :ability => :MAGICBOUNCE,
                :nature => :CAREFUL,
                :form => 1,
                :iv => 31,
                :happiness => 255,
                :ev => [252,0,4,0,252,0]
            },
            2 => {
                :species => :SPIRITOMB,
                :level => 80,
                :item => :LEFTOVERS,
                :moves => [:SUCKERPUNCH,:FOULPLAY,:WILLOWISP,:SPITE],
                :ability => :INFILTRATOR,
                :nature => :ADAMANT,
                :iv => 31,
                :happiness => 255,
                :ev => [252,252,4,0,0,0]
                },
        },
    },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            2 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "ALICE: Soldier! Protect your Queen! Use everything you have!", # message that plays when shield is broken
                :bosssideChanges => :Safeguard,
                :bosssideChangeCount => 5,
                :bosssideChangeMessage => "Ice Soldier shrouded itself with a Safeguard!", # message that plays for the effect
                :abilitychange => :REFRIGERATE,
                :typeChange => [:ICE,:GHOST],
                :fieldChange => :GLITCH,
                :movesetUpdate => [:HYPERBEAM,nil,nil,nil],
                :fieldChangeMessage => "The ice castle is crumbling!", # message that plays when the field is changes
                :statusCure => true, # if status is cured when shield is broken
                :itemchange => :LEFTOVERS, # item that is given upon breaking shield
                :statBoosts => { # any statboosts that are given
                    PBStats::SPATK => 6,
                    PBStats::SPEED => 1,
                },
            },
        }
    },
    :TIEMPAGOOD => {
        :name => "Tiempa", # nickname
        :entryText => "Tiempa is looking ready to attack!",
        :shieldCount => 2, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :DIALGA,
            :level => 90,
            :form => 0,
            :item => :ADAMANTORB,
            :moves => [:EARTHPOWER,:FLASHCANNON,:POWERGEM,:DRAGONPULSE],
            :ability => :PRESSURE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
            :ev => [0,0,4,252,0,252]
        },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            2 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "Tiempa is twisting time around the field!", # message that plays when shield is broken
                :statusCure => true, # if status is cured when shield is broken
                :statDropCure => true, # if statdrops are negated when shield is broken
                :itemchange => :ADAMANTORB, # item that is given upon breaking shield
                :movesetUpdate => [:EARTHPOWER,:FLASHCANNON,:AURASPHERE,:ROAROFTIME],
                :bossStatChanges => { # any statboosts that are given
                    PBStats::SPDEF => 1,
                    PBStats::DEFENSE => 1,
                },
                :playerSideStatChanges => {
                    PBStats::SPEED => -2,
                },
                :delayedaction => {
                    :delay => 3,
                    :message => "Tiempa slows down movement!",
                    :animation => :FAIRYLOCK,
                    :playerSideStatChanges => {
                        PBStats::SPEED => -1,
                    },
                    :repeat => true,
                }
            },
        }
    }, 
    :SPACEAGOOD => {
        :name => "Spacea", # nickname
        :entryText => "Spacea is finishing what Tiempa started!",
        :shieldCount => 3, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :PALKIA,
            :level => 90,
            :form => 0,
            :item => :TELLURICSEED,
            :moves => [:SURF,:HEAVYSLAM,:SPACIALREND,:FLAMETHROWER],
            :ability => :PRESSURE,
            :nature => :MILD,
            :iv => 31,
            :happiness => 255,
            :ev => [0,0,4,252,0,252]
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount <= 3",
            # :continuous => true,
            :playerMons => true,
            :moninfos => {
                1 => {
                    :species => :MINIOR,
                    :level => 90,
                    :form => 0,
                    :moves => [:ROCKSLIDE,:CONFUSERAY,:ACROBATICS,:LIGHTSCREEN],
                    :ability => :SHIELDSDOWN,
                },
            },
        },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            3 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :itemchange => :LUSTROUSORB, # item that is given upon breaking shield
                :stateChanges => :WonderRoom, # handles state changes found in the Battle_Global class(in Battle_ActiveSide file + Trick Room
                :stateChangeAnimation => :WONDERROOM, # state change animation
                :stateChangeCount => 99, # state change turncount
                :stateChangeMessage => "The dimensions were changed!", # statechange messages
            },
            2 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :statDropCure => true, # if statdrops are negated when shield is broken
                :movesetUpdate => [:THUNDER,:FIREBLAST,:SPACIALREND,:SURF],
                :itemchange => :LUSTROUSORB, # item that is given upon breaking shield
                :abilitychange => :MOLDBREAKER,
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                    PBStats::SPDEF => 1,
                },
            },
            1 => {
                :message => "SPACEA: No more... NO... MORE!!!!!!!", # message that plays when shield is broken
                :animation => :FLASH, # effect animation
                :bgmChange => "Battle - End of Night",
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :formchange => 1, # formchanges
                :statusCure => true, # if status is cured when shield is broken
                :effectClear => true,
                :soscontinuous => true,
                :statDropCure => true, # if statdrops are negated when shield is broken
                :itemchange => :LUSTROUSORB, # item that is given upon breaking shield
                :abilitychange => :MOLDBREAKER,
                :movesetUpdate => [:THUNDER,:HEAVYSLAM,:SPACIALREND,:SURF],
                :bossStatChanges => { # any statboosts that are given
                    PBStats::ATTACK => 1,
                    PBStats::SPATK => 1,
                },
            },
        }
    },
    :SPACEABAD => {
        :name => "Spacea", # nickname
        :entryText => "Spacea is looking ready to attack!",
        :shieldCount => 2, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :PALKIA,
            :level => 95,
            :form => 0,
            :item => :LUSTROUSORB,
            :moves => [:SURF,:SPACIALREND,:FLAMETHROWER,:HEAVYSLAM],
            :ability => :PRESSURE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
            :ev => [0,0,4,252,0,252]
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 2",
            :continuous => true,
            :totalMonCount => 2,
            :moninfos => {
                1 => {
                    :species => :CLEFAIRY,
                    :level => 90,
                    :item => :EVIOLITE,
                    :moves => [:FOLLOWME,:HELPINGHAND,:MOONBLAST,:REFLECT],
                    :ability => :FRIENDGUARD,
                    :ev => [252, 0, 252, 0, 0, 4],
                },
                2 => {
                    :species => :HOOPA,
                    :level => 90,
                    :item => :TELLURICSEED,
                    :moves => [:HYPERSPACEHOLE,:SHADOWBALL,:GRASSKNOT,:THUNDER],
                    :ability => :MAGICIAN,
                    :ev => [252, 0, 4, 252, 0, 0],
                },
            },
        },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            2 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :statDropCure => true, # if statdrops are negated when shield is broken
                :movesetUpdate => [:HEAVYSLAM,:FIREBLAST,:SPACIALREND,:HYDROPUMP],
                :itemchange => :LUSTROUSORB, # item that is given upon breaking shield
                :abilitychange => :MOLDBREAKER,
                :stateChanges => :WonderRoom, # handles state changes found in the Battle_Global class(in Battle_ActiveSide file + Trick Room
                :stateChangeAnimation => :WONDERROOM, # state change animation
                :stateChangeCount => 99, # state change turncount
                :stateChangeMessage => "The dimensions were changed!", # statechange messages
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPDEF => 1,
                },
            },
            1 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "Spacea twisted the space around the field!", # message that plays when shield is broken
                :statusCure => true, # if status is cured when shield is broken
                :statDropCure => true, # if statdrops are negated when shield is broken
                :effectClear => true,
                :itemchange => :LUSTROUSORB, # item that is given upon breaking shield
                :movesetUpdate => [:HYDROPUMP,:SPACIALREND,:FIREBLAST,:THUNDER],
                :bossStatChanges => { # any statboosts that are given
                    PBStats::SPATK => 1,
                },
                :playerSideStatChanges => {
                    PBStats::DEFENSE => -1,
                    PBStats::SPDEF => -1,
                }
            },
        }
    }, 
    :TIEMPABAD => {
        :name => "Tiempa", # nickname
        :entryText => "Tiempa is finishing what Spacea started!",
        :shieldCount => 3, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :DIALGA,
            :level => 95,
            :form => 0,
            :item => :TELLURICSEED,
            :moves => [:POWERGEM,:ROAROFTIME,:HEAVYSLAM,:EARTHPOWER],
            :ability => :PRESSURE,
            :nature => :QUIET,
            :iv => 31,
            :happiness => 255,
            :ev => [252,0,4,252,0,0]
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 3",
            :totalMonCount => 2,
            :moninfos => {
                1 => {
                    :species => :CELEBI,
                    :level => 90,
                    :form => 0,
                    :item => :LIGHTCLAY,
                    :moves => [:GRASSKNOT,:REFLECT,:PSYSHOCK,:LIGHTSCREEN],
                    :ability => :NATURALCURE,
                    :nature => :TIMID,
                    :iv => 31,
                    :happiness => 255,
                    :ev => [252,0,0,252,0,0]
                },
                2 => {
                    :species => :JIRACHI,
                    :level => 90,
                    :form => 0,
                    :item => :LEFTOVERS,
                    :moves => [:MOONBLAST,:FLASHCANNON,:FOLLOWME,:PSYCHIC],
                    :ability => :SERENEGRACE,
                    :nature => :CALM,
                    :iv => 31,
                    :happiness => 255,
                    :ev => [252,0,4,0,252,0]
                    },
            },
        },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            3 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :itemchange => :ADAMANTORB, # item that is given upon breaking shield
                :statDropCure => true, # if statdrops are negated when shield is broken
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                },
            },
            2 => {
                :CustomMethod => "battlesnapshot(battler,1,1)",
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :itemchange => :ADAMANTORB, # item that is given upon breaking shield
                :playerSideStatChanges => { # any statboosts that are given
                    PBStats::DEFENSE => -1,
                    PBStats::SPDEF => -1,
                    PBStats::SPEED => -1,
                },
            },
            1 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :itemchange => :ADAMANTORB, # item that is given upon breaking shield
                :statusCure => true, # if status is cured when shield is broken
                :bossStatChanges => {
                    PBStats::SPATK => 1,
                },
            },
            0 => {
                :CustomMethod => "timewarp(battler,1)",
                :movesetUpdate => [:PROTECT,:DOOMDESIRE,:SNARL,:ROAROFTIME],
                :delayedaction => {
                    :delay => 1,
                    :CustomMethod => "battlesnapshot(battler,2,-1)",
                    :message => "Tiempa is focusing on the flow of time!",
                    :playerEffects => [:FutureSight,:FutureSightMove],
                    :playerEffectsduration => [2,:DOOMDESIRE],
                    :playerEffectsAnimation => :DOOMDESIRE,
                    :delayedaction => {
                        :delay => 5,
                        :message => "TIEMPA: You are wasting your time, Interceptor...",
                        :CustomMethod => "timewarp(battler,2)",
                    },
                },
                :message => "TIEMPA: No more... NO... MORE!!!!!!!", # message that plays when shield is broken
                :animation => :FLASH, # effect animation
                :bgmChange => "Battle - End of Night",
                :fieldChange => :NEWWORLD, # field changes
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :formchange => 1, # formchanges
                :statusCure => true, # if status is cured when shield is broken
                :statDropCure => true, # if statdrops are negated when shield is broken
                :itemchange => :ADAMANTORB, # item that is given upon breaking shield
                :bossStatChanges => { # any statboosts that are given
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,
                },
            },
            -2 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :movesetUpdate => [:FLAMETHROWER,:ROAROFTIME,:HEAVYSLAM,:THUNDERBOLT],
                :itemchange => :ADAMANTORB, # item that is given upon breaking shield
                :playerSideStatChanges => { # any statboosts that are given
                    PBStats::DEFENSE => -1,
                    PBStats::SPDEF => -1,
                    PBStats::SPEED => -1,
                },
            },
            -1 => {
                :CustomMethod => "battlesnapshot(battler,3,-1)",
                :message => "Tiempa's concentration was broken!",
                :movesetUpdate => [:FLAMETHROWER,:ROAROFTIME,:FLASHCANNON,:THUNDERBOLT],
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :statusCure => true, # if status is cured when shield is broken
                :statDropCure => true, # if statdrops are negated when shield is broken
                :itemchange => :ADAMANTORB, # item that is given upon breaking shield
                :delayedaction => {
                    :delay => 5,
                    :message => "TIEMPA: Just one mistake is all it takes...",
                    :CustomMethod => "timewarp(battler,3)",
                },
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPATK => 1,
                },
            },
        }
    },
    :BOSSRATICATE => {
        :name => "Monstrosity",
        :entryText => "The grotesque rodent attacked!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :RATICATE,
            :level => 18,
            :form => 2,
            :moves => [:POISONFANG,:BITE,:TAILWHIP,:SECRETPOWER],
            :ability => :NOGUARD,
            :nature => :NAUGHTY,
            :iv => 20,
            :happiness => 255,
            :ev => [20,20,20,20,20,20]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "The Monstrosity started acting desperate!",
                :statDropCure => true,
                :movesetUpdate => [:DIRECLAW,:BITE,:TAILWHIP,:SECRETPOWER],
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => -1,
                    PBStats::SPDEF => -1,
                    PBStats::SPEED => 1,
                }
            }
        }
    },  
    :STARMIEGOD => {
        :name => "Shooting Star",
        :entryText => "You can't look away from the Star...",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :STARMIE,
            :level => 88,
            :moves => [:SURF,:THUNDERBOLT,:RECOVER,:PSYCHIC],
            :ability => :ANALYTIC,
            :nature => :MODEST,
            :item => :PETAYABERRY,
            :iv => 31,
            :happiness => 255,
            :shiny => true,
            :ev => [0,0,0,252,0,252]
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "The Shooting Star is sparkling!",
                :statDropCure => true,
                :itemchange => :PETAYABERRY,
                :fieldChange => :RAINBOW,
                :fieldChangeMessage => "A prismatic luminance buries the surroundings!",
                :movesetUpdate => [:TRIATTACK,:DAZZLINGGLEAM,:COSMICPOWER,:PSYSHOCK],
                :abilitychange => :PRISMARMOR,
            }
        }
    }, 
    :UXIEBAD => {
        :name => "Uxie", # nickname
        :entryText => "Uxie is defending itself!",
        :shieldCount => 2, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :UXIE,
            :level => 90,
            :form => 0,
            :moves => [:AMNESIA,:MYSTICALPOWER,:DRAININGKISS,:YAWN],
            :ability => :LEVITATE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
            :ev => [0,0,4,252,0,252]
        },
        :sosDetails =>  { # pokemon details
        :activationRequirement => "@battle.battlers[battlerIndex].shieldCount == 0",
        :continuous => true,
        :totalMonCount => 2,
        :moninfos => {
            1 => {
                :species => :MESPRIT,
                :level => 80,
                :item => :MAGICALSEED,
                :moves => [:CHARM,:PSYSHOCK,:SHADOWBALL,:CONFUSERAY],
                :ability => :LEVITATE,
                :nature => :MODEST,
                :iv => 31,
                :happiness => 255,
                :ev => [252,0,4,0,252,0]
            },
            2 => {
                :species => :AZELF,
                :level => 80,
                :item => :MAGICALSEED,
                :moves => [:THUNDERWAVE,:ZENHEADBUTT,:PLAYROUGH,:KNOCKOFF],
                :ability => :LEVITATE,
                :nature => :ADAMANT,
                :iv => 31,
                :happiness => 255,
                :ev => [0,252,4,0,0,252]
                },
        },
    },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            2 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "Uxie drew power from the Starlight!", # message that plays when shield is broken
                :bosssideChanges => :Safeguard,
                :bosssideChangeCount => 5,
                :bosssideChangeMessage => "Uxie shrouded itself with a Safeguard!", # message that plays for the effect
                :abilitychange => :VICTORYSTAR,
                :typeChange => [:PSYCHIC,:FAIRY],
                :fieldChange => :STARLIGHT,
                :movesetUpdate => [:MYSTICALPOWER,:DRAININGKISS,:YAWN,:SIGNALBEAM],
                :fieldChangeMessage => "The field shines bright!", # message that plays when the field is changes
                :statusCure => true, # if status is cured when shield is broken
                :itemchange => :MAGICALSEED, # item that is given upon breaking shield
                :statBoosts => { # any statboosts that are given
                    PBStats::DEFENSE => 1,
                    PBStats::SPEED => 1,
                },
            },
        }
    },
    :MESPRITBAD => {
        :name => "Mesprit", # nickname
        :entryText => "Mesprit is defending itself!",
        :shieldCount => 2, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :MESPRIT,
            :level => 90,
            :form => 0,
            :moves => [:WATERPULSE,:CHARGEBEAM,:DRAININGKISS,:MYSTICALPOWER],
            :ability => :LEVITATE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
            :ev => [0,0,4,252,0,252]
        },
        :sosDetails =>  { # pokemon details
        :activationRequirement => "@battle.battlers[battlerIndex].shieldCount == 0",
        :continuous => true,
        :totalMonCount => 2,
        :moninfos => {
            1 => {
                :species => :UXIE,
                :level => 80,
                :item => :ELEMENTALSEED,
                :moves => [:YAWN,:PSYCHIC,:THUNDERBOLT,:HELPINGHAND],
                :ability => :LEVITATE,
                :nature => :MODEST,
                :iv => 31,
                :happiness => 255,
                :ev => [252,0,4,0,252,0]
            },
            2 => {
                :species => :AZELF,
                :level => 80,
                :item => :ELEMENTALSEED,
                :moves => [:THUNDERWAVE,:ZENHEADBUTT,:PLAYROUGH,:KNOCKOFF],
                :ability => :LEVITATE,
                :nature => :ADAMANT,
                :iv => 31,
                :happiness => 255,
                :ev => [0,252,4,0,0,252]
                },
        },
    },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            2 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "Mesprit surrounded itself in water!", # message that plays when shield is broken
                :bosssideChanges => :Safeguard,
                :bosssideChangeCount => 5,
                :bosssideChangeMessage => "Mesprit shrouded itself with a Safeguard!", # message that plays for the effect
                :abilitychange => :TECHNICIAN,
                :typeChange => [:PSYCHIC,:WATER],
                :fieldChange => :WATERSURFACE,
                :movesetUpdate => [:MYSTICALPOWER,:DRAININGKISS,:CHARGEBEAM,:WATERPULSE],
                :fieldChangeMessage => "The field was flash flooded!", # message that plays when the field is changes
                :statusCure => true, # if status is cured when shield is broken
                :itemchange => :ELEMENTALSEED, # item that is given upon breaking shield
                :statBoosts => { # any statboosts that are given
                    PBStats::DEFENSE => 1,
                    PBStats::SPEED => 1,
                },
            },
        }
    },
    :AZELFBAD => {
        :name => "Azelf", # nickname
        :entryText => "Azelf is defending itself!",
        :shieldCount => 2, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :AZELF,
            :level => 90,
            :form => 0,
            :moves => [:NASTYPLOT,:FLAMETHROWER,:KNOCKOFF,:MYSTICALPOWER],
            :ability => :LEVITATE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
            :ev => [0,0,4,252,0,252]
        },
        :sosDetails =>  { # pokemon details
        :activationRequirement => "@battle.battlers[battlerIndex].shieldCount == 0",
        :continuous => true,
        :totalMonCount => 2,
        :moninfos => {
            1 => {
                :species => :UXIE,
                :level => 80,
                :item => :ELEMENTALSEED,
                :moves => [:YAWN,:PSYCHIC,:THUNDERBOLT,:HELPINGHAND],
                :ability => :LEVITATE,
                :nature => :MODEST,
                :iv => 31,
                :happiness => 255,
                :ev => [252,0,4,0,252,0]
            },
            2 => {
                :species => :MESPRIT,
                :level => 80,
                :item => :ELEMENTALSEED,
                :moves => [:CHARM,:PSYSHOCK,:SHADOWBALL,:CONFUSERAY],
                :ability => :LEVITATE,
                :nature => :MODEST,
                :iv => 31,
                :happiness => 255,
                :ev => [252,0,4,0,252,0]
            },
        },
    },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            2 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "Azelf conflagrated in hellfire!", # message that plays when shield is broken
                :bosssideChanges => :Safeguard,
                :bosssideChangeCount => 5,
                :bosssideChangeMessage => "Azelf shrouded itself with a Safeguard!", # message that plays for the effect
                :abilitychange => :MAGMAARMOR,
                :typeChange => [:PSYCHIC,:DARK],
                :fieldChange => :INFERNAL,
                :movesetUpdate => [:TORMENT,:FLAMETHROWER,:KNOCKOFF,:MYSTICALPOWER],
                :fieldChangeMessage => "The field is burning with anguish!", # message that plays when the field is changes
                :statusCure => true, # if status is cured when shield is broken
                :itemchange => :ELEMENTALSEED, # item that is given upon breaking shield
                :statBoosts => { # any statboosts that are given
                    PBStats::ATTACK => 2,
                },
            },
        }
    },
    :RIFTTALON => {
        :name => "Karma Beast Talon",
        :entryText => "Talon fumbles toward you...",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :BRAVIARY,
            :level => 90,
            :form => 2,
            :moves => [:SLUDGEWAVE,:ACROBATICS,:ESPERWING,:VENOSHOCK],
            :gender => "M",
            :nature => :BRAVE,
            :item => :TELLURICSEED,
            :iv => 31,
            :happiness => 0,
            :ev => [4,252,0,252,0,0]
        },
        :onEntryEffects => { # effects applied on entry, use same attributes/syntax as onbreakeffects
            :fieldChange => :CORRUPTED,
            :fieldChangeMessage => "The arena melted into toxic slag!"
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :message => ".... stOooP.....",
                :movesetUpdate => [:ACIDARMOR,:BARBBARRAGE,:HURRICANE,:BODYPRESS],
                :playersideChanges => :ToxicSpikes, # handles side changes found in the Battle_Side class(in Battle_ActiveSide file) 
                :playersideChangeAnimation => :TOXICSPIKES, # side change animation
                :playersideChangeCount => 1, # side change turncount
                :playersideChangeMessage => "Toxic Spikes was set up!",
                :itemchange => :BLACKSLUDGE,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::SPATK => 1,
                }
            },
            2 => {
                :threshold => 0,
                :message => "oUu.... dOn'T.....",
                :typeChange => [:POISON,:DRAGON],
                :movesetUpdate => [:HEXINGSLASH,:DRAGONCLAW,:DRACOMETEOR,:VENOSHOCK],
                :statDropCure => true,
                :statusCure => true,
                :formchange => 3,
                :fieldChange => :CORROSIVEMIST,
                :playerSideStatChanges => {
                    PBStats::DEFENSE => -2,
                    PBStats::SPDEF => -2
                }
            },
            1 => {
                :threshold => 0,
                :message => ".... pLEase.... enD IT....",
                :movesetUpdate => [:VILEASSAULT,:DRAGONRUSH,:HEATWAVE,:DRAGONDANCE],
                :itemchange => :POISONIUMZ,
                :bossStatChanges => {
                    PBStats::DEFENSE => -1,
                    PBStats::SPDEF => -1,
                    PBStats::SPEED => 2,
                }
            },
        }
    },
    :NANODRIVE => {
        :name => "NANO DRIVE",
        :entryText => "The NANO DRIVE is analyzing...",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :MAGNEZONE,
            :level => 100,
            :form => 1,
            :moves => [:DOUBLEIRONBASH,:POWERUPPUNCH,:SHELTER,:SUCKERPUNCH],
            :gender => "F",
            :nature => :IMPISH,
            :item => :PROTECTIVEPADS,
            :iv => 31,
            :happiness => 0,
            :ev => [4,252,252,0,0,0]
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "The NANO DRIVE is planning...",
                :movesetUpdate => [:DOUBLEIRONBASH,:BRUTALSWING,:BULLETPUNCH,:ELECTROWEB],
                :playersideChanges => :Spikes, # handles side changes found in the Battle_Side class(in Battle_ActiveSide file) 
                :playersideChangeAnimation => :SPIKES, # side change animation
                :playersideChangeCount => 1, # side change turncount
                :playersideChangeMessage => "A layer of Spikes was set up!",
                :itemchange => :ELECTRICGEM,
                :bossStatChanges => {
                    PBStats::SPATK => 2,
                }
            },
            1 => {
                :threshold => 0,
                :message => "The NANO DRIVE is closing out the battle...",
                :movesetUpdate => [:DOUBLEIRONBASH,:STEAMROLLER,:SPIKYSHIELD,:SUBMISSION],
                :itemchange => :STEELIUMZ,
                :bossStatChanges => {
                    PBStats::DEFENSE => 2,
                }
            },
        }
    },
    :NANODRIVE_1 => {
        :name => "NANO DRIVE",
        :entryText => "The NANO DRIVE is analyzing...",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :MAGNEZONE,
            :level => 100,
            :item => :FOCUSSASH,
            :moves => [:HAMMERARM,:WOODHAMMER,:ICEHAMMER,:DRAGONHAMMER],
            :nature => :NAUGHTY,
            :form => 2,
            :iv => 31,
            :happiness => 0,
            :ev => [0,252,0,252,0,4]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "Will you... Remember all of this too? ",
                :itemchange => :LIFEORB,
                :movesetUpdate => [:BLIZZARD,:THUNDER,:FIREBLAST,:HYPERBEAM],
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPEED => 1
                }
            },
        }
    },
    :IRONHELL => {
        :name => "Iron Moth",
        :entryText => "The Iron Moth is ready to take you down.",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :IRONMOTH,
            :level => 100,
            :item => :AIRBALLOON,
            :moves => [:MORNINGSUN,:FIERYDANCE,:STRUGGLEBUG,:SOLARBEAM],
            :ability => :QUARKDRIVE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
            :shiny => true,
            :ev => [4,0,0,252,0,252]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "V: You're annoying. Let's ramp this up.",
                :statDropCure => true,
                :statusCure => true,
                :itemchange => :ELECTRICGEM,
                :fieldChange => :ELECTERRAIN, # field changes
                :movesetUpdate => [:OVERHEAT,:FIERYDANCE,:SLUDGEWAVE,:DISCHARGE],
                :bossStatChanges => {
                    PBStats::DEFENSE => 2,
                    PBStats::SPATK => 1
                }
            },
        }
    },
    :DOXIE => {
        :name => "Doxie",
        :entryText => "Doxie is hungry.",
        :shieldCount => 7,
        :immunities => {},
        :moninfo => {
            :species => :MARSHADOW,
            :level => 100,
            :moves => [:SPECTRALTHIEF,:DRAINPUNCH,:SHADOWSNEAK,:SHADOWBALL],
            :ability => :TECHNICIAN,
            :item => :LEPPABERRY,
            :gender => "M",
            :nature => :JOLLY,
            :iv => 31,
            :happiness => 255,
            :ev => [252,252,252,252,252,252]
        },
        :onBreakEffects => {
            6 => {
                :threshold => 0,
                :statDropCure => true,
                :statusCure => true,
                :fieldChange => :HAUNTED, # field changes
                :itemchange => :LEPPABERRY,
                :bossStatChanges => {
                    PBStats::ATTACK => 2,
                    PBStats::SPATK => 2,
                }
            },
            5 => {
                :threshold => 0,
                :statDropCure => true,
                :statusCure => true,
                :fieldChange => :HAUNTED, # field changes
                :itemchange => :LEPPABERRY,
                :bossStatChanges => {
                    PBStats::ATTACK => 2,
                    PBStats::SPATK => 2,
                }
            },
            4 => {
                :threshold => 0,
                :statDropCure => true,
                :statusCure => true,
                :fieldChange => :HAUNTED, # field changes
                :effectClear => true,
                :itemchange => :LEPPABERRY,
                :bossStatChanges => {
                    PBStats::ATTACK => 3,
                    PBStats::SPATK => 3,
                }
            },
            3 => {
                :threshold => 0,
                :statDropCure => true,
                :statusCure => true,
                :fieldChange => :HAUNTED, # field changes
                :abilitychange => :MOLDBREAKER,
                :itemchange => :LEPPABERRY,
                :bossStatChanges => {
                    PBStats::ATTACK => 4,
                    PBStats::SPATK => 4,
                }
            },
            2 => {
                :threshold => 0,
                :statDropCure => true,
                :statusCure => true,
                :fieldChange => :HAUNTED, # field changes
                :effectClear => true,
                :itemchange => :LEPPABERRY,
                :bossStatChanges => {
                    PBStats::ATTACK => 5,
                    PBStats::SPATK => 5,
                }
            },
            1 => {
                :threshold => 0,
                :statDropCure => true,
                :statusCure => true,
                :fieldChange => :HAUNTED, # field changes
                :abilitychange => :MOLDBREAKER,
                :itemchange => :LEPPABERRY,
                :effectClear => true,
                :bossStatChanges => {
                    PBStats::ATTACK => 6,
                    PBStats::DEFENSE => 2,
                    PBStats::SPATK => 6,
                    PBStats::SPDEF => 2,
                    PBStats::SPEED => 6,
                }
            },
        },
    },
##############################
# Easy Bosses
##############################
    :BOSSGARBODOR_EASY => {
        :name => "Garbage Menace",
        :entryText => "The Garbage Crew approached!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :GARBODOR,
            :level => 10,
            :moves => [:POUND,:ACIDSPRAY,:DOUBLESLAP,:ATTRACT],
            :ability => :STENCH,
            :gender => "M",
            :shiny => true,
            :nature => :NAUGHTY,
            :happiness => 255,
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 1",
            :totalMonCount => 2,
            :moninfos => {
                1 => {
                    :species => :TRUBBISH,
                    :level => 9,
                    :moves => [:POUND,:POISONGAS,:THIEF,nil],
                    :ability => :STENCH,
                    :iv => 10,
                },
            },
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "Garbodor's typing changed!",
                :animation => :NASTYPLOT,
                :typeChange => [:POISON,:DARK],
            },
        }
    },

    :RIFTGYARADOS1_EASY => {
        :name => "Rift Gyarados",
        :entryText => "Rift Gyarados attacked in a rage!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :GYARADOS,
            :level => 18,
            :form => 4,
            :moves => [:SHADOWSNEAK,:BITE,:WATERGUN,:LEER],
            :ability => :INTIMIDATE,
            :gender => "M",
            :nature => :NAUGHTY,
            :iv => 10,
            :happiness => 255,
            :ev => [0,0,0,0,0,0]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "Rift Gyarados started acting defensive!",
                :animation => :WITHDRAW,
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::ATTACK => -1,
                    PBStats::DEFENSE => 1
                }
            }
        }
    },
    :BOSSPYROAR_EASY => {
        :name => "Pride King",
        :entryText => "The freshly evolved Pyroar attacked!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :PYROAR,
            :level => 15,
            :moves => [:TAKEDOWN,:NOBLEROAR,:FIREFANG,:ROAR],
            :ability => :UNNERVE,
            :gender => "M",
            :nature => :NAUGHTY,
            :iv => 10,
            :happiness => 255,
            :ev => [0,0,0,0,0,0],
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 1",
            :continuous => true,
            :moninfos => {
                1 => {
                    :species => :LITLEO,
                    :level => 12,
                    :moves => [:EMBER,:HEADBUTT,:LEER,:WORKUP],
                    :ability => :UNNERVE,
                    :iv => 10,
                },
            },
        },
        :onBreakEffects => {
        },
    },
    :RIFTCHANDELURE_EASY => {
        :name => "Rift Chandelure",
        :entryText => "Otherworldly wind chimes echo through the air...",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :CHANDELURE,
            :level => 55,
            :form => 2,
            :moves => [:SHADOWBALL,:HEX,:FIREBLAST,:WILLOWISP],
            :gender => "M",
            :nature => :TIMID,
            :happiness => 255,
        },
        :onEntryEffects => {
            :message => "A feeling of warmth emanates from Rift Chandelure...",
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :animation => :OMINOUSWIND,
                :message => "The air feels cold and moist...",
                :statDropRefresh => true,
                :bossStatChanges => {
                    PBStats::SPATK => 1,
                },
                :typeChange => [:GHOST,:WATER],
                :movesetUpdate => [:SHADOWBALL,:HEX,:SURF,:WHIRLPOOL],
                :abilitychange => :TRACE
            },
            1 => {
                :threshold => 0,
                :animation => :OMINOUSWIND,
                :message => "A sickly sweet scent attacks your nose...",
                :statDropRefresh => true,
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                },
                :typeChange => [:GHOST,:GRASS],
                :movesetUpdate => [:SHADOWBALL,:HEX,:ENERGYBALL,:LEECHSEED],
                :abilitychange => :TRACE
            },
        }
    },
    :SHADOWMEWTWO_EASY => {
        :name => "Shadow Mewtwo",
        :entryText => "Mewtwo's power is building up!",
        :shieldCount => 1,
        :immunities => {},
        :onEntryEffects => { # effects applied on entry, use same attributes/syntax as onbreakeffects
            :message => "KETA: We have to defeat it quickly or else...",
        },
        :chargeAttack => {
            :turns => 10,
            :chargingMessage => "Mewtwo is charging its attack...",
            :continueCharging => true,
            :canAttack => false,
            :intermediateattack => {
                :move => :SHADOWBEAM,
                :type => :SHADOW,
                :basedamage => 20,
                :name => "Shadow Beam",
                :category => 0,
                :target => :AllOpposing,
            }
        },
        :moninfo => {
            :species => :MEWTWO,
            :level => 27,
            :moves => [:SHADOWSNEAK],
            :ability => :PRESSURE,
            :nature => :HARDY,
            :iv => 20,
            :happiness => 0,
            :form => 3,
            :shadow => true,
            :ev => [20,20,20,20,20,20]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "Shadow Mewtwo's power grows!",
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => -2,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => -2
                }
            }
        }
    },
    :RIFTGYARADOS2_EASY => {
        :name => "Rift Gyarados",
        :entryText => "Rift Gyarados is intent on revenge!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :GYARADOS,
            :level => 31,
            :form => 4,
            :moves => [:PHANTOMFORCE,:WATERFALL,:BITE,:SCREECH],
            :ability => :INTIMIDATE,
            :gender => "M",
            :nature => :NAUGHTY,
            :iv => 20,
            :happiness => 255,
            :ev => [20,20,20,20,20,20],
            :BaseStats => [95,145,89,120,110,81]
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "Rift Gyarados's type changed!",
                :typeChange => [:WATER,:DRAGON],
                :movesetUpdate => [:DRAGONBREATH,:WATERFALL,:THUNDERFANG,:SCREECH],
                :fieldChange => :WATERSURFACE,
                :fieldChangeMessage => "Rift Gyarados dragged the battle to the lake!"
            },
            1 => {
                :threshold => 0,
                :message => "Rift Gyarados's type changed!",
                :typeChange => [:FIRE,:DRAGON],
                :movesetUpdate => [:DRAGONBREATH,:LAVAPLUME,:BITE,:SCREECH],
                :statDropCure => true,
                :fieldChange => :INFERNAL,
                :fieldChangeMessage => "Rift Gyarados conflagarated the arena!"
            }
        }
    },
    :PULSEMUSHARNA_EASY => {
        :name => "Pulse+ Musharna",
        :entryText => "The dangerous(?) Musharna attacked(?)!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :MUSHARNA,
            :level => 18,
            :form => 2,
            :moves => [:PSYBEAM,:DISARMINGVOICE,:CHARGEBEAM,:SWEETSCENT],
            :gender => "F",
            :nature => :DOCILE,
            :ability => :PASTELVEIL,
            :iv => 0,
            :happiness => 255,
            :ev => [0,0,0,0,0,0]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :fieldChange => :MISTY,
                :fieldChangeMessage => "Pulse Musharna spread mist everywhere."
            }
        }
    },
    :PULSEMUSHARNA2_EASY => {
        :name => "Pulse+ Musharna",
        :entryText => "The dangerous(?) Musharna attacked(?) again!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :MUSHARNA,
            :level => 86,
            :form => 2,
            :item => :SITRUSBERRY,
            :moves => [:MISTBALL,:DAZZLINGGLEAM,:AURASPHERE,:SWEETSCENT],
            :gender => "F",
            :nature => :MODEST,
            :ability => :PASTELVEIL,
            :happiness => 255,
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :bosssideChanges => :Mist,
                :bosssideChangeAnimation => :MIST,
                :bosssideChangeCount => 3,
                :movesetUpdate => [:MISTBALL,:STRANGESTEAM,:MAGICALLEAF,:STUNSPORE],
                :message => "Pulse Musharna is laying lazily in the flowers...",
           },
            1 => {
                :threshold => 0,
                :bosssideChanges => :Safeguard,
                :bosssideChangeAnimation => :SAFEGUARD,
                :bosssideChangeCount => 3,
                :message => "Pulse Musharna became one with the bugs...",
                :typeChange => [:BUG,:FAIRY],
                :movesetUpdate => [:BUGBUZZ,:STRANGESTEAM,:MISTBALL,:MYSTICALFIRE],
                :delayedaction => {
                    :delay => 4,
                    :message => "Pulse Musharna let out a defend order!",
                    :animation => :DEFENDORDER,
                    :bossStatChanges => {
                        PBStats::DEFENSE => 1,
                        PBStats::SPDEF => 1,                  
                    },
                    :delayedaction => {
                        :delay => 4,
                        :message => "Pulse Musharna let out an attack order!",
                        :animation => :ATTACKORDER,
                        :bossStatChanges => {
                            PBStats::SPATK => 1,                
                        },
                        :delayedaction => {
                            :delay => 4,
                            :message => "Pulse Musharna let out a heal order!",
                            :animation => :HEALORDER,
                            :statusCure => true,
                            :statDropCure => true,
                            :effectClear => true,
                        }
                    }
                }
            },
        }
    },
    :BOSSGOTHITELLE_SHERIDAN_EASY => {
        :name => "Gothitelle",
        :entryText => "The mischievous Gothitelle laughs at you!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :GOTHITELLE,
            :level => 32,
            :form => 1,
            :moves => [:FAKETEARS,:PSYCHIC,:FLATTER,:DARKPULSE],
            :gender => "F",
            :nature => :MODEST,
            :ability => :SHADOWTAG,
            :happiness => 255,
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                }
            }
        }
    },
    :CRESCGOTHITELLE_EASY => {
        :name => "Gothitelle",
        :entryText => "The mischievous Gothitelle laughs at you!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :GOTHITELLE,
            :level => 45,
            :form => 1,
            :moves => [:PLAYNICE,:PSYSHOCK,:FOCUSBLAST,:DARKPULSE],
            :gender => "F",
            :nature => :MODEST,
            :ability => :COMPETITIVE,
            :iv => 20,
            :happiness => 255,
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :fieldChange => :PSYTERRAIN,
                :fieldChangeMessage => "Gothitelle laughs at how dumb your face looks. So mean!"
            }
        }
    },
    :KIERANXURK_1_EASY => {
        :name => "Xurkitree",
        :entryText => "Static electricity crackles in the air...",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :XURKITREE,
            :level => 65,
            :form => 1,
            :moves => [:THUNDER,:ENERGYBALL,:DAZZLINGGLEAM,:TAILGLOW],
            :nature => :MODEST,
            :ability => :BEASTBOOST,
            :iv => 31,
            :happiness => 255,
            :ev => [0,0,0,252,0,252]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :fieldChange => :ELECTERRAIN,
                :fieldChangeMessage => "Xurkitree repositions itself."
            }
        }
    },
    :SEAPRINCE_EASY => {
        :name => "Manaphy", # nickname
        :entryText => "ODESSA: Witness the might of the seas!",
        :shieldCount => 2, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :MANAPHY,
            :level => 53,
            :item => :LEFTOVERS,
            :moves => [:SCALD,:SHADOWBALL,:RAINDANCE,:TAKEHEART],
            :ability => :HYDRATION,
            :nature => :MODEST,
            :happiness => 255,
        },
        :sosDetails =>  { # pokemon details
        :activationRequirement => "@battle.battlers[battlerIndex].shieldCount == 0",
        :continuous => true,
        :totalMonCount => 3,
        :moninfos => {
            1 => {
                :species => :PHIONE,
                :level => 45,
                :moves => [:SURF,:ENERGYBALL,:HELPINGHAND,:DAZZLINGGLEAM],
                :ability => :HYDRATION,
                :gender => "F",
                :nature => :MODEST,
                :happiness => 255,
            },
        },
    },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            2 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "ODESSA: The Prince of the Sea's tail shines bright. Be blinded by its glow!", # message that plays when shield is broken
                :animation => :TAILGLOW,
                :weatherChange => :RAINDANCE, # weather to apply
                :weatherCount => 5, # weather turncount
                :weatherChangeMessage => "The Rain pours down!", # weather message
                :weatherChangeAnimation => "Rain", # string of "Rain", "Sunny","Hail","Sandstorm"
                :statusCure => true, # if status is cured when shield is broken
                :itemchange => :LEFTOVERS, # item that is given upon breaking shield
                :bossStatChanges => { # any statboosts that are given
                    PBStats::SPATK => 1,
                },
                :delayedaction => {
                    :delay => 2,
                    :message => "The Prince's glowing tail starts to dim...",
                    :bossStatChanges => { 
                        PBStats::SPATK => -1,
                    },
                }
            },
            1 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "ODESSA: The Prince can command the sea themselves. As such as a Prince should! Be purged by the sacred waters of Kristiline! ", # message that plays when shield is broken
                :abilitychange => :PRESSURE,
                :fieldChange => :WATERSURFACE, # field changes
                :fieldChangeMessage => "The battlefield was plunged underwater!", # message that plays when the field is changes
                :statusCure => true, # if status is cured when shield is broken
                :itemchange => :LEFTOVERS, # item that is given upon breaking shield
            },
        }
    },  
    :RIFTGALVANTULA_EASY => {
        :name => "Rift Galvantula",
        :entryText => "Joltik swarm the egg...",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :GALVANTULA,
            :level => 22,
            :form => 2,
            :moves => [:ELECTROWEB,:BUGBITE,:CROSSPOISON,:TOXICTHREAD],
            :gender => "F",
            :nature => :HASTY,
            :ability => :PARENTALBOND,
            :iv => 20,
            :happiness => 255,
            :ev => [0,0,0,0,0,0]
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 2",
            :continuous => true,
            :moninfos => {
                1 => {
                    :species => :JOLTIK,
                    :level => 17,
                    :moves => [:ELECTROWEB,:STRINGSHOT,:STRUGGLEBUG,nil],
                    :ability => :COMPOUNDEYES,
                    :form => 1,
                },
            },
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :formchange => 1,
                :message => "Rift Galvantula hatched out of the egg!",
                :movesetUpdate => [:ELECTROWEB,:BUGBITE,:CROSSPOISON,:SLUDGE],
                :statDropCure => true,
                :playersideChanges => :ToxicSpikes,
                :playersideChangeAnimation => :TOXICPSIKES,
                :playersideChangeMessage => "Broken eggshell was strewn everywhere!",
            },
        }
    },
    :RIFTVOLCANION_EASY => {
        :name => "Rift Volcanion",
        :entryText => "Rift Volcanion let out a languid grumble...",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :VOLCANION,
            :level => 24,
            :form => 1,
            :moves => [:STEAMERUPTION,:FLAMETHROWER,:SCORCHINGSANDS,:ROCKSLIDE],
            :gender => "F",
            :nature => :LONELY,
            :iv => 0,
            :happiness => 255,
            :ev => [0,0,0,0,0,0]
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "Volcanion is losing motivation…",
                :movesetUpdate => [:SCALD,:INCINERATE,:MUDSHOT,:ROCKTOMB],
                :bossStatChanges => {
                    PBStats::ATTACK => -1,
                    PBStats::DEFENSE => -1,
                    PBStats::SPATK => -1,
                    PBStats::SPDEF => -1,
                    PBStats::SPEED => -1                    
                }
            },
            1 => {
                :threshold => 0,
                :message => "Volcanion is losing motivation…",
                :movesetUpdate => [:WATERGUN,:EMBER,:MUDSLAP,:ROCKTHROW],
                :bossStatChanges => {
                    PBStats::ATTACK => -1,
                    PBStats::DEFENSE => -1,
                    PBStats::SPATK => -1,
                    PBStats::SPDEF => -1,
                    PBStats::SPEED => -1                    
                }
            },
        }
    },
    :BOSSDUSKNOIR_EASY => {
        :name => "Dusknoir",
        :entryText => "The Dusknoir is threatening you.",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :DUSKNOIR,
            :level => 28,
            :moves => [:SHADOWPUNCH,:WILLOWISP,:INFESTATION,:PAYBACK],
            :gender => "M",
            :nature => :ADAMANT,
            :iv => 20,
            :form => 1,
            :ev => [32,32,32,32,32,32]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "Dusknoir is about to throw hands!",
                :movesetUpdate => [:SHADOWPUNCH,:WILLOWISP,:ICYWIND,:THUNDERPUNCH],
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,                
                }
            },
        }
    },
    :WISPYGIRATINA_EASY => {
        :name => "Renegade Giratina",
        :entryText => "GEARA: Destroy them, Giratina! Show them the might of a Legendary Pokémon!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :GIRATINA,
            :level => 33,
            :moves => [:SHADOWCLAW,:DRAGONBREATH,:SLASH,:SCARYFACE],
            :nature => :HARDY,
            :iv => 20,
			:form => 1,
            :ev => [32,32,32,32,32,32]
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "Giratina's ghastly aura lowered offenses!",
                :statDropCure => true,
                :playerSideStatChanges => {
                    PBStats::ATTACK => -1,               
                }
            },
            1 => {
                :threshold => 0,
                :message => "Giratina's aura enveloped the battlefield!",
                :bossStatChanges => {
                    PBStats::DEFENSE => -2,
                    PBStats::SPDEF => -2,                 
                },
                :playerSideStatChanges => {
                    PBStats::DEFENSE => -1,
                    PBStats::SPDEF => -1,                 
                }
            }
        }
    },
    :BOSSCROBAT_EASY => {
        :name => "Furious Bat",
        :entryText => "The Crobat attacked with furor!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :CROBAT,
            :level => 32,
            :moves => [:CROSSPOISON,:BITE,:WINGATTACK,:PROTECT],
            :ability => :INFILTRATOR,
            :gender => "F",
            :nature => :NAUGHTY,
            :item => :FLYINGGEM,
            :happiness => 255,
            :ev => [0,0,0,0,0,0],
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 10",
            :continuous => true,
            :moninfos => {
                1 => {
                    :species => :ZUBAT,
                    :level => 27,
                    :moves => [:CONFUSERAY,:POISONFANG,:THIEF,],
                    :ability => :INNERFOCUS,
                    :iv => 31,
                },
                2 => {
                    :species => :WOOBAT,
                    :level => 27,
                    :moves => [:CONFUSION,:CHARM,:AIRSLASH,],
                    :ability => :UNAWARE,
                    :iv => 31,
                },
                3 => {
                    :species => :NOIBAT,
                    :level => 27,
                    :moves => [:SUPERFANG,:WHIRLWIND,:AIRSLASH,],
                    :ability => :INFILTRATOR,
                    :iv => 31,
                },
            },
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :bosssideChanges => :Tailwind,
                :bosssideChangeAnimation => :TAILWIND,
                :bosssideChangeCount => 3,
                :movesetUpdate => [:ACROBATICS,:CROSSPOISON,:PROTECT,:UTURN],
                :statDropCure => true,
                :itemchange => :SITRUSBERRY,
            },
        },
    },
    :MADAMEXYVELTAL_EASY => {
        :name => "Yveltal",
        :entryText => "Yveltal looms above.",
        :shieldCount => 0,
        :immunities => {},
        :moninfo => {
            :species => :YVELTAL,
            :level => 75,
            :moves => [:DECIMATION,:HURRICANE,:FOCUSBLAST,nil],
            :nature => :MODEST,
            :ev => [0,0,0,0,0,0]
        },
    },
    :TAPUKOKOJUNGLE_EASY => {
        :name => "Thunder Warrior",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :TAPUKOKO,
            :level => 50,
            :shiny => true,
            :moves => [:BRAVEBIRD,:NATURESMADNESS,:NATUREPOWER,:BOLTBEAK],
            :nature => :RASH,
            :ability => :ELECTRICSURGE,
            :iv => 31,
            :item => :SHUCABERRY,
            :happiness => 255,
            :ev => [252,252,252,252,252,252]
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "Tapu Koko is getting worked up!!",
                :abilityChange => :ELECTERRAIN,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPEED => 1,
                },
            },
            1 => {
                :threshold => 0,
                :message => "Tapu Koko is putting in its all!!",
                :movesetUpdate => [:GRASSKNOT,:HIDDENPOWERICE,:ROOST,:RISINGVOLTAGE],
                :statDropCure => true,
                :statusCure => true,
                :effectClear => true,
                :fieldChange => :ELECTERRAIN,
                :fieldChangeMessage => "Electricity stormed acrosss the arena!",
                :abilitychange => :MOLDBREAKER,
                :itemchange => :EXPERTBELT,

            },
        }
    },
    :BOSSCONKELDURR_EASY => {
        :name => "Strained Worker",
        :entryText => "Conkeldurr is agitated!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :CONKELDURR,
            :level => 45,
            :moves => [:CHIPAWAY,:ICEPUNCH,:FIREPUNCH,:THUNDERPUNCH],
            :ability => :IRONFIST,
            :gender => "M",
            :nature => :ADAMANT,
            :iv => 0,
            :happiness => 0,
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 1",
            :continuous => true,
            :moninfos => {
                1 => {
                    :species => :TIMBURR,
                    :level => 30,
                    :moves => [:COACHING,:HELPINGHAND,:ROCKTHROW,:HAMMERARM],
                    :ability => :IRONFIST,
                    :nature => :ADAMANT
                },
            },
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "Conkeldurr built a miniature city in anger!",
                :fieldChange => :CITY,
            },
            1 => {
                :threshold => 0,
                :message => "The miniature city was destroyed...",
                :fieldChange => :FOREST,
                :bossStatChanges => {
                    PBStats::ATTACK => -1,             
                },
            },
        },
    },
    :RIFTCARNIVINE_EASY => {
        :name => "Corrupted Carnivine",
        :entryText => "Carnivine is dancing the samba!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :CARNIVINE,
            :level => 40,
            :form => 1,
            :moves => [:DRAGONDANCE,:SEEDBOMB,:DRAGONPULSE,:FLAMEBURST],
            :ability => :OWNTEMPO,
            :gender => "M",
            :nature => :NAUGHTY,
            :happiness => 255,
            :ev => [0,0,0,0,0,0],
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 2",
            :continuous => true,
            :totalMonCount => 2,
            :moninfos => {
                1 => {
                    :species => :TANGELA,
                    :level => 35,
                    :form => 1,
                    :moves => [:FOLLOWME,:SWAGGER,:POLLENPUFF,:PETALDANCE],
                    :ability => :DANCER,
                    :gender => "F",
                    :nature => :MODEST,
                    :happiness => 255,
                },
                2 => {
                    :species => :TANGROWTH,
                    :level => 35,
                    :form => 1,
                    :moves => [:FOLLOWME,:QUASH,:POLLENPUFF,:ROCKTOMB],
                    :ability => :DANCER,
                    :gender => "M",
                    :nature => :MODEST,
                    :happiness => 255,
                },
            },
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :animation => :SHIFTGEAR,
                :message => "The rhythm of the music has changed!",
                :bossEffectMessage => "Carnivine did the robot and became Steel-type!",
                :typeChange => [:GRASS,:STEEL],
                :movesetUpdate => [:SHIFTGEAR,:SEEDBOMB,:IRONHEAD,:KNOCKOFF],
                :statDropRefresh => true,
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => -1,
                    PBStats::SPDEF => -1,
                    PBStats::SPEED => -1               
                },
                :playerSideStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,             
                }
            },
            1 => {
                :threshold => 0,
                :animation => :QUIVERDANCE,
                :message => "The rhythm of the music has changed!",
                :bossEffectMessage => "Carnivine did the jitterbug and became Bug-type!",
                :typeChange => [:GRASS,:BUG],
                :movesetUpdate => [:QUIVERDANCE,:SEEDBOMB,:POLLENPUFF,:KNOCKOFF],
                :statDropRefresh => true,
                :bossStatChanges => {
                    PBStats::ATTACK => -1,
                    PBStats::DEFENSE => -1,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,           
                },
                :playerSideStatChanges => {
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPEED => 1                
                }
            }
        }
    },
    :TAPUKOKOMAGRODAR_EASY => {
        :name => "Thunder Warrior",
        :entryText => "The Thunder Warrior is ready to rumble!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :TAPUKOKO,
            :level => 45,
            :shiny => true,
            :moves => [:LIGHTSCREEN,:NATURESMADNESS,:BRAVEBIRD,:REFLECT],
            :nature => :TIMID,
            :ability => :ELECTRICSURGE,
        },
        :onEntryEffects => { # effects applied on entry, use same attributes/syntax as onbreakeffects
            :weatherChange => nil,
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount <= 1",
            :refreshingRequirement => [0],
            :entryMessage => ["Charizard charged into the fight!","The Thunder Warrior revitalized Charizard's energy!"],
            :totalMonCount => 2,
            :moninfos => {
                1 => {
                    :species => :CHARIZARD,
                    :level => 40,
                    :moves => [:INCINERATE,:AIRSLASH,:DRAGONBREATH,:ROOST],
                    :ability => :BLAZE,
                    :shiny => true,
                    :nature => :TIMID,
                },
                2 => {
                    :species => :CHARIZARD,
                    :level => 40,
                    :item => :CHARIZARDITEX,
                    :moves => [:BULLDOZE,:DRAGONBREATH,:INCINERATE,:AIRSLASH],
                    :ability => :BLAZE,
                    :shiny => true,
                    :nature => :BRAVE,
                },
            },
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :ability => :TELEPATHY,
                :itemchange => :ELEMENTALSEED,
                :message => "Tapu Koko is putting in its all!!",
                :movesetUpdate => [:SPARK,:HYPERVOICE,:ROOST,:DAZZLINGGLEAM],
            },
        }
    },
    :BOSS_CHAOTICFUSION_EASY => {
        :name => "Chaotic Fusion",
        :entryText => "The fused Pokémon suddenly attacked!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :SOLROCK,
            :level => 48,
            :moves => [:WILLOWISP,:ROCKTOMB,:SOLARFLARE,:MORNINGSUN],
            :nature => :QUIRKY,
            :form => 1,
            :ability => :SOLARIDOL,
            :item => :SITRUSBERRY,
        },
        :onEntryEffects => { # effects applied on entry, use same attributes/syntax as onbreakeffects
            :weatherChange => :SUNNYDAY,
            :weatherChangeAnimation => "Sunny",
            :weatherCount => 5,
        },
        :onBreakEffects => {
            3 => {
                :animation => :FLASH,
                :weatherChange => :HAIL,
                :weatherChangeAnimation => "Hail",
                :weatherCount => 5,
                :threshold => 0,
                :message => "Lunatone gained control!",
                :itemchange => :SITRUSBERRY,
                :speciesUpdate => :LUNATONE,
                :abilitychange => :LUNARIDOL,
                :form => 1,
                :movesetUpdate => [:COSMICPOWER,:ANCIENTPOWER,:HOARFROSTMOON,:MOONLIGHT],
            },
        }
    },
    :AMETHYSTREGIROCK_EASY => {
        :name => "Stone Guardian",
        :entryText => "The Guardian is watching your every move.",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :REGIROCK,
            :level => 48,
            :moves => [:CURSE,:HAMMERARM,:ROCKSLIDE,:EARTHQUAKE],
            :nature => :IMPISH,
            :iv => 31,
            :shiny => true,
            :item => :SITRUSBERRY,
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "Regirock hardened up!",
                :statDropCure => true,
                :playersideChanges => :StealthRock,
                :playersideChangeCount => true,
                :playersideChangeAnimation => :STEALTHROCK,
                :playersideChangeMessage => "Floating rocks were deployed!",
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                    PBStats::SPDEF => 1,                 
                },
            }
        }
    },
    :AMETHYSTREGISTEEL_EASY => {
        :name => "Iron Guardian",
        :entryText => "The Guardian is watching your every move.",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :REGISTEEL,
            :level => 48,
            :moves => [:CURSE,:HAMMERARM,:IRONHEAD,:EARTHQUAKE],
            :nature => :IMPISH,
            :iv => 31,
            :shiny => true,
            :item => :SITRUSBERRY,
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "Registeel hardened up!",
                :statDropCure => true,
                :playersideChanges => :Spikes,
                :playersideChangeAnimation => :SPIKES,
                :playersideChangeCount => 1,
                :playersideChangeMessage => "Spikes were deployed!",
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                    PBStats::SPDEF => 1,                 
                },
            }
        }
    },
    :BELIAL_EASY => {
        :name => "Belial", # nickname
        :entryText => "A feisty Volcarona appeared!",
        :shieldCount => 1, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :VOLCARONA,
            :level => 40,
            :moves => [:MYSTICALFIRE,:BUGBUZZ,:GIGADRAIN,:SUNNYDAY],
            :ability => :FLAMEBODY,
            :nature => :MODEST,
            :gender => "M",
            :iv => 31,
            :happiness => 255,
        },
        :sosDetails =>  { # pokemon details
        :activationRequirement => "@battle.battlers[battlerIndex].shieldCount == 0",
        :totalMonCount => 2,
        :continuous => true,
        :moninfos => {
            1 => {
                :species => :SHUCKLE,
                :level => 30,
                :moves => [:STEALTHROCK,:INFESTATION,:STICKYWEB,:HELPINGHAND],
                :ability => :STURDY,
                :nature => :BOLD,
                :iv => 31,
            },
            2 => {
                :species => :MOTHIM,
                :level => 30,
                :moves => [:STRUGGLEBUG,:POISONPOWDER,:PROTECT,:LUNGE],
                :ability => :TINTEDLENS,
                :iv => 31,
            },
        },
    },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            1 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "Belial is in its last stand!", # message that plays when shield is broken                :weatherChange => :SUNNYDAY, # weather to applyes
                :abilitychange => :SWARM,
                :fieldChange => :FLOWERGARDEN1, # field changes
                :fieldChangeMessage => "The field is covered in flowers!", # message that plays when the field is changes
                :weatherCount => 5, # weather turncount
                :weatherChangeMessage => "The Sun is bright!", # weather message
                :weatherChangeAnimation => "Sunny", # string of "Rain", "Sunny","Hail","Sandstorm"
                :statusCure => true, # if status is cured when shield is broken
                :statDropCure => true, # if statdrops are negated when shield is broken
                :itemchange => :LEFTOVERS, # item that is given upon breaking shield
            },
        }
    },  
    :BOSSKYOGRE_EASY => {
        :name => "Leviathan Kyogre",
        :entryText => "Kyogre's power is overwhelming!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :KYOGRE,
            :level => 55,
            :moves => [:MUDDYWATER,:ICYWIND,:ANCIENTPOWER,:THUNDERWAVE],
            :nature => :MODEST,
            :item => :SITRUSBERRY,
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "Kyogre summoned a storm and flooded the arena!",
                :weatherChangeAnimation => "Rain",
                :fieldChange => :WATERSURFACE,
                :movesetUpdate => [:WHIRLPOOL,:SHOCKWAVE,:ANCIENTPOWER,:THUNDERWAVE],
                :statDropCure => true,
            }
        }
    },
    :BOSSGROUDON_EASY => {
        :name => "Behemoth Groudon",
        :entryText => "Groudon attacked under command!",
        :shieldCount => 1,
        :immunities => {
            :fieldEffectDamage => [:VOLCANIC]
        },
        :moninfo => {
            :species => :GROUDON,
            :level => 65,
            :moves => [:EARTHQUAKE,:STONEEDGE,:SOLARBEAM,:HEATCRASH],
            :nature => :ADAMANT,
            :iv => 31,
            :item => :LEFTOVERS,
            :ev => [252,252,252,252,252,252]
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount == 0",
            :refreshingRequirement => [0],
            :entryMessage => ["Heatran emerged from the magma"],
            :totalMonCount => 1,
            :moninfos => {
                1 => {
                    :species => :HEATRAN,
                    :level => 55,
                    :item => :STEELIUMZ,
                    :moves => [:MAGMASTORM,:EARTHPOWER,:FLASHCANNON,:SMACKDOWN],
                    :ability => :BLAZE,
                    :nature => :MODEST,
                    :iv => 31,
                    :ev => [252,0,0,252,0,4]
                },
            },
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "Groudon summoned fierce eruptions!",
                :formchange => 1,
                :itemchange => :REDORB,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPEED => 1                 
                },
                :abilitychange => :DESOLATELAND,
                :fieldChange => :VOLCANIC,
                :movesetUpdate => [:PRECIPICEBLADES,:ROCKSLIDE,:REST,:LAVAPLUME],
                :statDropCure => true,
                :statusCure => true,
                :instantMove => [:TECTONICRAGE, 0],
            }
        }
    },
    :VALORGIRATINA_EASY => {
        :name => "Renegade Giratina",
        :entryText => "Giratina is blocking the way forward!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :GIRATINA,
            :level => 50,
            :moves => [:SHADOWFORCE,:AURASPHERE,:EARTHPOWER,:DRAGONCLAW],
            :nature => :NAUGHTY,
            :iv => 31,
			:form => 1,
            :ev => [0,0,0,0,0,0]
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "Giratina drew power from the Distortion World!",
                :statDropCure => true,
                :itemchange => :GRISEOUSORB,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::SPATK => 1,               
                },
            }
        }
    },
    :DARCHGIRATINA_EASY => {
        :name => "Clown Caricature",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :GIRATINA,
            :level => 62,
            :moves => [:SLUDGEWAVE,:DRAGONPULSE,:NASTYPLOT,:FIREBLAST],
            :nature => :NAUGHTY,
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :speciesUpdate => :PORYGONZ,
                :message => "a Vir us in  d e  ed ",
                :statDropCure => true,
                :abilitychange => :WONDERGUARD,
                :itemchange => :TOXICORB,
            },
            2 => {
                :threshold => 0,
                :speciesUpdate => :BLACEPHALON,
                :movesetUpdate => [:MINDBLOWN,:SHADOWBALL,:NASTYPLOT,:PRESENT],
                :message => "F u n t i m e s w i t h e v e r y o n e ' s b a d e n d i n g",
                :statDropCure => true,
            },
            1 => {
                :threshold => 0,
                :speciesUpdate => :PIDGEY,
                :message => "Can you even beat a Pidgey? Likely not.",
                :statDropCure => true,
            }
        }
    },
    :LAVALAKAZAM_EASY => {
        :name => "Alakazam",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :ALAKAZAM,
            :level => 62,
            :gender => "M",
            :moves => [:CALMMIND,:REFLECT,:LIGHTSCREEN,:NIGHTSHADE],
            :nature => :TIMID,
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :formchange => 1,
                :message => "Alakazam is pulling all of its psychic energy to its core!",
                :statDropCure => true,
                :movesetUpdate => [:PSYCHIC,:SHADOWBALL,:FOCUSBLAST,:COUNTER],
                :itemchange => :TWISTEDSPOON,
                :bossStatChanges => {
                    PBStats::SPDEF => 2,
                    PBStats::SPEED => 2                 
                },
            },
            1 => {
                :threshold => 0,
                :bosssideChanges => :Reflect, # effect that applies on the boss when breaking shield
                :bosssideChangeCount => 5, # duration of the effect(some effects are booleans, double check)
                :statDropCure => true,
            },
        }
    },
    :DARKGARDEVOIR_EASY => {
        :name => "Dark Gardevoir",
        :entryText => "Gardevoir is staring you down.",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :GARDEVOIR,
            :level => 60,
            :moves => [:DARKPULSE,:DAZZLINGGLEAM,:CALMMIND,:PSYCHIC],
            :nature => :TIMID,
            :form => 2,
            :iv => 31,
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :bosssideChanges => [:Reflect,:Safeguard],
                :bosssideChangeCount => [3,3],
                :bosssideChangeAnimation => [:REFLECT,:SAFEGUARD],
                :message => "Gardevoir quickly set up protection!",
                :statDropCure => true,
            }
        }
    },
    :RIFTGARBODOR_EASY => {
        :name => "Rift Garbodor",
        :entryText => "The rampaging Rift Garbodor attacked!",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :GARBODOR,
            :level => 57,
            :item => :BLACKSLUDGE,
            :moves => [:DRAINPUNCH,:BULLETSEED,:BRUTALSWING,:SLUDGEWAVE],
            :nature => :SASSY,
            :shiny => true,
            :form => 2,
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :message => "Garbodor gorged itself on rotten berries!",
                :typeChange => [:POISON,:GRASS],
                :movesetUpdate => [:DRAINPUNCH,:GIGADRAIN,:BRUTALSWING,:BELCH],
                :itemchange => :SITRUSBERRY,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,              
                },
                :statDropCure => true,
            },
            2 => {
                :threshold => 0,
                :message => "Garbodor gorged itself on scrap metal!",
                :typeChange => [:POISON,:STEEL],
                :movesetUpdate => [:DRAINPUNCH,:GIGADRAIN,:MAGNETBOMB,:BELCH],
                :itemchange => :METALCOAT,
                :bossStatChanges => {
                    PBStats::SPDEF => 1,                
                },
                :statDropCure => true,
            },
            1 => {
                :threshold => 0,
                :message => "Garbodor desperately gorged itself on nearby rocks!",
                :typeChange => [:POISON,:ROCK],
                :movesetUpdate => [:ROCKBLAST,:GIGADRAIN,:MAGNETBOMB,:BELCH],
                :itemchange => :ROCKYHELMET,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => -2,
                    PBStats::SPATK => 1,   
                    PBStats::SPDEF => -2,                
                },
                :statDropCure => true,
            },
        }
    },
    :RIFTAELITA_EASY => {
        :name => "Rift Aelita",
        :entryText => "Rift Aelita is taking aim...",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :REGIROCK,
            :level => 70,
            :item => :LIFEORB,
            :moves => [:ROCKBLAST,:ARMTHRUST,:BULLETSEED,:BARRAGE],
            :nature => :NAUGHTY,
            :form => 2,
            :iv => 31,
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :message => "Rift Aelita is cocking her gun...",
                :animation => :LASERFOCUS,
                :bossEffect => :LaserFocus,
                :bossEffectduration => 1,
                :fieldChange => :ROCKY,
                :fieldChangeMessage => "The field became littered with rocks!",
                :movesetUpdate => [:ROCKBLAST,:BULLDOZE,:POLLENPUFF,:SHADOWBALL],
                :bossStatChanges => {
                    PBStats::ACCURACY => 1,              
                },
                :delayedaction => {
                    :delay => 5,
                    :message => "Rift Aelita is cocking her gun...",
                    :animation => :LASERFOCUS,
                    :bossEffect => :LaserFocus,
                    :bossEffectduration => 1,
                    :repeat => true,
                }
            },
            2 => {
                :threshold => 0,
                :message => "Aelita let out a piercing screech!",
                :movesetUpdate => [:ROCKWRECKER,:AURASPHERE,:ACIDSPRAY,:ENERGYBALL],
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => -1,
                    PBStats::SPATK => 1,   
                    PBStats::SPDEF => -1,               
                },
                :statDropCure => true,
                :statusCure => true,
                :effectClear => true,
            },
        }
    },
    :VIVIANREGIROCK_EASY => {
        :name => "Stone Guardian",
        :entryText => "The Stone Guardian attacked!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :REGIROCK,
            :level => 68,
            :shiny => true,
            :moves => [:DRAINPUNCH,:SUPERPOWER,:ROCKSLIDE,:EARTHQUAKE],
            :nature => :IMPISH,
            :iv => 31,
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :effect => nil,
                :bossEffectduration => nil,
                :message => "Regirock drew power from the earth...",
                :itemchange => :ROCKIUMZ,
                :sideChanges => :StealthRock,
                :sideChangeAnimation => :STEALTHROCK,
                :sideChangesSide => 0,
                :sideChangeMessage => "Floating rocks were deployed!",
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,  
                    PBStats::SPDEF => 1,                
                },
            }
        }
    },
    :RIFTFERROTHORN_EASY => {
        :name => "Rift Ferrothorn",
        :entryText => "Rift Ferrothorn is readying to attack!",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :FERROTHORN,
            :level => 70,
            :moves => [:SEEDBOMB,:LEECHSEED,:GYROBALL,:FIRELASH],
            :nature => :BRAVE,
            :form => 1,
            :iv => 31,
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :bosssideChanges => [:Reflect,:LightScreen],
                :bosssideChangeCount => [3,3],
                :message => "Rift Ferrothorn put up defenses!",
            },
            2 => {
                :threshold => 0,
                :effect => nil,
                :bossEffectduration => nil,
                :message => "Rift Ferrothorn became unrestrained!",
                :bgmChange => "Battle - Pseudo Contribution",
                :movesetUpdate => [:FLAREBLITZ,:ENERGYBALL,:IRONHEAD,:SHIFTGEAR],
                :formchange => 2,
                :statDropCure => true,
            },
            1 => {
                :threshold => 0,
                :effect => nil,
                :bossEffectduration => nil,
                :message => "Rift Ferrothorn is out of control!",
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => -2,
                    PBStats::SPATK => 1,   
                    PBStats::SPDEF => -2, 
                    PBStats::SPEED => 1,                
                },
            }
        }
    },
    :RIFTHIPPOWDON_EASY => {
        :name => "Rift Hippowdon",
        :entryText => "Rift Hippowdon is filling the arena with sand!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :HIPPOWDON,
            :level => 80,
            :form => 1,
            :moves => [:SPITUP,:HEATWAVE,:EARTHPOWER,:SLUDGEBOMB],
            :gender => "F",
            :nature => :RELAXED,
            :item => :BLACKSLUDGE,
            :iv => 31,
            :happiness => 0,
        },
        :onEntryEffects => {
            :animation => :HEATWAVE,
            :message => "The whirling sands are scorching!",
            :delayedaction => {
                :delay => 4,
                :message => "The searing sands inflicted burns!",
                :playerSideStatusChanges => [:BURN,"Burn"],
                :repeat => true,
            }
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "Rift Hippowdon shot sand everywhere!",
                :movesetUpdate => [:SPITUP,:EARTHQUAKE,:GUNKSHOT,:FLAMETHROWER],
                :weatherChange => :SANDSTORM,
                :weatherChangeAnimation => "Sandstorm",
                :weatherChangeMessage => "Sandstorms keep brewing...",
                :playersideChanges => :StealthRock,
                :playersideChangeAnimation => :STEALTHROCK,
            },
            1 => {
                :threshold => 0,
                :statDropCure => true,
                :statusCure => true,
                :message => "The arena is heating up more!",
                :animation => :INFERNO,
                :movesetUpdate => [:SPITUP,:EARTHPOWER,:DRAGONPULSE,:HEATWAVE],
                :weatherChange => :SANDSTORM,
                :weatherChangeAnimation => "Sandstorm",
                :weatherChangeMessage => "Sandstorms keep brewing...",
                :typeChange => [:GROUND,:FIRE],
                :itemchange => :SITRUSBERRY,
                :playersideChanges => :Spikes,
                :playersideChangeAnimation => :SPIKES,
                :playersideChangeCount => 1,
                :delayedaction => {
                    :delay => 5,
                    :message => "Rift Hippowdon is burning up!",
                    :bossStatChanges => {
                        PBStats::ATTACK => 1,
                        PBStats::SPATK => 1,
                    }
                }
            },
        }
    },
    :ANGELOFDEATH_EASY => {
        :name => "Angel of Death",
        :entryText => "The Angel of Death appears with bloodlust...",
        :shieldCount => 4,
        :immunities => {},
        :moninfo => {
            :species => :GARDEVOIR,
            :level => 70,
            :form => 3,
            :moves => [:DARKPULSE,:SWEETKISS,:DAZZLINGGLEAM,:MYSTICALFIRE],
            :gender => "F",
            :nature => :SERIOUS,
            :item => :LUMBERRY,
            :iv => 10,
            :happiness => 255,
            :ev => [35,35,35,35,35,35]
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 3",
            :continuous => true,
            :totalMonCount => 4,
            :moninfos => {
                1 => {
                    :species => :RALTS,
                    :level => 70,
                    :form => 1,
                    :moves => [:TORMENT,:HELPINGHAND,:POISONGAS,:NIGHTSHADE],
                    :gender => "F",
                    :iv => 10,
                },
                2 => {
                    :species => :KIRLIA,
                    :level => 70,
                    :form => 1,
                    :moves => [:QUASH,:HELPINGHAND,:WILLOWISP,:SNARL],
                    :gender => "F",
                    :iv => 10,
                },
            },
        },
        :onBreakEffects => {
            4 => {
                :threshold => 0,
                :animation => :SECRETSWORD,
                :message => "The Angel of Death drew its scythe.",
                :movesetUpdate => [:NIGHTSLASH,:SWEETKISS,:SPIRITBREAK,:PSYCHOCUT],
                :playerSideStatChanges => {
                    PBStats::DEFENSE => -1,
                }
            },
            3 => {
                :threshold => 0,
                :animation => :DAZZLINGGLEAM,
                :message => "The Angel of Death summoned minions.",
                :movesetUpdate => [:NIGHTSLASH,:PROTECT,:LAVAPLUME,:SACREDSWORD],
                :playerSideStatChanges => {
                    PBStats::SPATK => -1,
                }
            },
            2 => {
                :threshold => 0,
                :animation => :CHARGE,
                :message => "The Angel of Death is summoning power.",
                :movesetUpdate => [:DARKPULSE,:PSYCHOCUT,:BULLDOZE,:AURASPHERE],
            },
            1 => {
                :threshold => 0,
                :animation => :DARKPULSE,
                :message => "The Angel of Death has fury.",
                :movesetUpdate => [:HYPERSPACEFURY,:DAZZLINGGLEAM,:TAUNT,:HYPERVOICE],
            },
        }
    },
    :FALLENANGEL_EASY => {
        :name => "Fallen Angel",
        :entryText => "The Angel is on its last legs...",
        :shieldCount => 0,
        :immunities => {},
        :moninfo => {
            :species => :GARDEVOIR,
            :level => 70,
            :form => 4,
            :moves => [:LASHOUT,:BURNINGJEALOUSY,:HYPERSPACEHOLE,:THRASH],
            :gender => "F",
            :nature => :LONELY,
            :iv => 31,
            :happiness => 255,
            :ev => [0,0,0,0,0,0]
        },
        :onBreakEffects => {
        }
    },
    :BOSSARCEUS_CASINO_EASY => {
        :name => "Casino Bouncer",
        :entryText => "STOP! You've violated the law! Pay the court a fine or serve your sentence. Your stolen goods are now forfeit.",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :ARCEUS,
            :level => 70,
            :moves => [:JUDGMENT,:PUNISHMENT,:EXTREMESPEED,:LIQUIDATION],
            :gender => "F",
            :nature => :LONELY,
            :ability => :MULTITYPE,
            :item => :FISTPLATE,
            :happiness => 255,
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "STOP! You've violated the law! Pay the court a fine or serve your sentence. Your stolen goods are now forfeit.",
                :animation => :COSMICPOWER,
            }
        }
    },
    :NIGHTMAREREMIX_EASY => {
        :name => "Nightmare Remix",
        :entryText => "The... Puppet Master? Attacks?",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :DARKRAI,
            :level => 70,
            :form => 7,
            :moves => [:SPIRITBREAK,:PSYCHIC,:AURORAVEIL,:THROATCHOP],
            :gender => "M",
            :nature => :BRAVE,
            :happiness => 0,
        },
        :onEntryEffects => {
            :fieldChange => :STARLIGHT,
            :message => "Twinkle twinkle little star...",
            :delayedaction => {
                :delay => 5,
                :fieldChange => :NEWWORLD,
                :playerSideStatusChanges => [:SLEEP,"Sleep"],
                :message => "All fall to the Puppet Master's sway...",
                :playerEffects => :Nightmare,
                :playerEffectsAnimation => :NIGHTMARE,
                :playerEffectsduration => true,
                :playerEffectsMessage => "Now, sleep with this trauma that will leave you sleepless!",
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPEED => 1,
                }
            }
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :message => "Grow weary...",
                :movesetUpdate => [:MOONBLAST,:ICEBEAM,:EARTHQUAKE,:PROTECT],
                :itemchange => :LEFTOVERS,
                :animation => :HYPNOSIS,
                :playerSideStatChanges => {
                    PBStats::ATTACK => -3,
                    PBStats::SPATK=> -3
                }
            },
            2 => {
                :threshold => 0,
                :message => "Don't sleep... Don't wake up...",
                :movesetUpdate => [:DOOMDESIRE,:VACUUMWAVE,:DARKPULSE,:ANCIENTPOWER],
                :statDropCure => true,
                :statusCure => true,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::SPATK => 1,
                }
            },
            1 => {
                :threshold => 0,
                :message => "Welcome the end...",
                :movesetUpdate => [:METEORMASH,:COMETPUNCH,:THROATCHOP,:PSYSTRIKE],
                :statDropCure => true,
            },
        }
    },
    :BIGBETTY_EASY => {
        :name => "Big Betty",
        :entryText => "Big Betty stands her ground!",
        :shieldCount => 0,
        :immunities => {},
        :moninfo => {
            :species => :EMBOAR,
            :level => 76,
            :moves => [:EARTHQUAKE,:HEADSMASH,:FLAREBLITZ,:WILLOWISP],
            :ability => :BLAZE,
            :gender => "F",
            :form => 1,
            :nature => :ADAMANT,
            :iv => 31,
        },
        :onBreakEffects => {
        }
    },
    :BIGBETTYTWO_EASY => {
        :name => "Big Betty",
        :entryText => "Big Betty stands her ground... again!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :EMBOAR,
            :level => 78,
            :moves => [:EARTHQUAKE,:HEADSMASH,:FLAREBLITZ,:WILLOWISP],
            :ability => :BLAZE,
            :gender => "F",
            :form => 1,
            :nature => :ADAMANT,
            :iv => 31,
        },
        :onEntryEffects => {
            :fieldChange => :FAIRYTALE,
            :fieldChangeMessage => "Goomink's resolve manifested!"
        },
        :onBreakEffects => {
        }
    },
    :BOSSZEKROM_EASY => {
        :name => "Fanciful Ideals",
        :entryText => "Zekrom is crackling with electricity!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :ZEKROM,
            :level => 85,
            :moves => [:FOCUSBLAST,:REFLECT,:BOLTSTRIKE,:OUTRAGE],
            :ability => :TERAVOLT,
            :gender => "M",
            :nature => :NAIVE,
            :iv => 31,
        },
        :onBreakEffects => {
        }
    },
    :BOSSRESHIRAM_EASY => {
        :name => "Imaginary Truths",
        :entryText => "Reshiram is blazing with fire!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :RESHIRAM,
            :level => 85,
            :moves => [:DRAGONCLAW,:FUSIONFLARE,:LIGHTSCREEN,:CRUNCH],
            :ability => :TURBOBLAZE,
            :gender => "M",
            :nature => :TIMID,
            :iv => 31,
        },
        :onBreakEffects => {
        }
    },
    :BOSSNAGANADEL_EASY => {
        :name => "Naganadel",
        :entryText => "Naganadel is ready to kill!",
        :shieldCount => 0,
        :immunities => {},
        :moninfo => {
            :species => :NAGANADEL,
            :level => 87,
            :item => :LIFEORB,
            :moves => [:SLUDGEWAVE,:DRAGONPULSE,:TOXIC,:NASTYPLOT],
            :ability => :BEASTBOOST,
            :gender => "M",
            :nature => :TIMID,
            :iv => 31,
            :happiness => 0,
        },
        :onBreakEffects => {
        }
    },
    :BOSSGOTHITELLE_EASY => {
        :name => "Gothitelle",
        :entryText => "Gothitelle is looking serious!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :GOTHITELLE,
            :level => 86,
            :item => :GOTHCREST,
            :moves => [:GRAVITY,:THUNDERBOLT,:PSYCHIC,:DARKPULSE],
            :ability => :SHADOWTAG,
            :gender => "F",
            :nature => :MODEST,
            :form => 1,
        },
        :onBreakEffects => {
        }
    },
    :STORMNINE_EASY => {
        :name => "STORM | Wind",
        :entryText => "Erratic weather begets a disaster...",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :XERNEAS,
            :level => 80,
            :item => :LIFEORB,
            :moves => [:WEATHERBALL,:HURRICANE,:THUNDERBOLT,:PSYSHOCK],
            :ability => :TEMPEST,
            :nature => :MODEST,
            :form => 1,
            :iv => 31,
        },
        :onBreakEffects => {
        }
    },
    :BOSSCOFAGRIGUS_EASY => {
        :name => "Totem Cofagrigus",
        :entryText => "The menacing Cofagrigus attacked!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :COFAGRIGUS,
            :level => 80,
            :moves => [:SHADOWBALL,:NASTYPLOT,:WILLOWISP,:ENERGYBALL],
            :ability => :MUMMY,
            :gender => "M",
            :nature => :MODEST,
            :happiness => 255,
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount < 2",
            :totalMonCount => 4,
            :moninfos => {
                1 => {
                    :species => :STANTLER,
                    :level => 75,
                    :item => :STANTCREST,
                    :moves => [:HYPNOSIS,:MEGAHORN,:JUMPKICK,:ZENHEADBUTT],
                    :ability => :INTIMIDATE,
                    :gender => "F",
                    :nature => :JOLLY,
                    :happiness => 255,
                },
                2 => {
                    :species => :MAGCARGO,
                    :level => 75,
                    :item => :MAGCREST,
                    :moves => [:FLAMEBURST,:YAWN,:EARTHPOWER,:WILLOWISP],
                    :ability => :FLAMEBODY,
                    :gender => "M",
                    :nature => :BOLD,
                    :happiness => 255,
                },
                3 => {
                    :species => :LEAFEON,
                    :level => 75,
                    :item => :LEAFCREST,
                    :moves => [:SWORDSDANCE,:NATUREPOWER,:LEAFBLADE,:XSCISSOR],
                    :ability => :LEAFGUARD,
                    :gender => "F",
                    :nature => :ADAMANT,
                    :happiness => 255,
                },
            },
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :bosssideChanges => :AreniteWall,
                :bosssideChangeAnimation => :ARENITEWALL,
                :bosssideChangeCount => 5,
                :message => "Sand swarms all around!",
                :movesetUpdate => [:SHADOWBALL,:BODYPRESS,:CALMMIND,:PSYCHIC],
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,           
                },
            },
            1 => {
                :threshold => 0,
                :movesetUpdate => [:SHADOWBALL,:PROTECT,:ENERGYBALL,:HIDDENPOWERFIG],
                :statDropCure => true,
                :itemchange => :LEFTOVERS,
                :delayedaction => {
                    :delay => 5,
                    :message => "Beware the Pharaoh's curse!",
                    :playerEffects => :Curse,
                    :playerEffectsAnimation => :CURSE,
                    :playerEffectsduration => true,
                    :repeat => true,            
                }
            }
        }
    },
    :COFFEEGREGUS_EASY => {
        :name => "COFFEE GREGUS",
        :entryText => "COFFEE GREGUS!",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :COFAGRIGUS,
            :level => 80,
            :moves => [:SHADOWPUNCH,:COMETPUNCH,:BULLETPUNCH,:HOWL],
            :gender => "M",
            :nature => :MODEST,
            :form => 1,
            :happiness => 255,
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :movesetUpdate => [:SHADOWPUNCH,:SCORCHINGSANDS,:AURASPHERE,:HOWL],
                :message => "COFFEE GREGUS!",
                :animation => :BULKUP,
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                    PBStats::SPDEF => 1,             
                },
                :fieldChange => :BIGTOP,
                :fieldChangeMessage => "CLOWN FIESTA!"
            },
            2 => {
                :threshold => 0,
                :movesetUpdate => [:SHADOWPUNCH,:DYNAMICPUNCH,:BODYPRESS,:HOWL],
                :message => "COFFEE GREGUS!",
                :animation => :BULKUP,
                :statDropCure => true,
                :effectClear => true,
                :delayedaction => {
                    :delay => 2,
                    :repeat => true,
                    :playerEffects => :Foresight,
                    :playerEffectsAnimation => :FORESIGHT,
                    :message => "THERE IS NO ESCAPE FROM COFFEE GREGUS!",
                    :playerSideStatChanges => {
                        PBStats::EVASION => -1
                    }
                }
            },
        }
    },
    :KAWOPUDUNGA_EASY => {
        :name => "Kawopudunga",
        :entryText => "Kawopudunga is ready to feast!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :WAILORD,
            :level => 70,
            :form => 1,
            :moves => [:DIVE,:DARKESTLARIAT,:AQUARING,:FRUSTRATION],
            :gender => "F",
            :nature => :HARDY,
            :item => :SITRUSBERRY,
            :iv => 31,
            :happiness => 0,
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :itemchange => :SITRUSBERRY,
                :message => "Kawopudunga changed its type!",
                :movesetUpdate => [:DIVE,:OUTRAGE,:DRAGONDANCE,:HEAVYSLAM],
                :typeChange => [:WATER,:DRAGON],
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::ATTACK => 2,
                }
            },
            1 => {
                :threshold => 0,
                :itemchange => :SITRUSBERRY,
                :message => "Kawopudunga changed its type!",
                :movesetUpdate => [:DIVE,:DARKPULSE,:RECOVER,:TOXIC],
                :typeChange => [:WATER,:DARK],
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::SPATK => 2,
                }
            },
        }
    },
    :BOSSGOURGEIST_EASY => {
        :name => "Jack-o'-lantern",
        :entryText => "A large pumpkin suddenly attacked!",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :GOURGEIST,
            :level => 75,
            :form => 1,
            :moves => [:WILLOWISP,:SEEDBOMB,:LEECHSEED,:CURSE],
            :gender => "F",
            :ability => :INSOMNIA,
            :nature => :BRAVE,
            :item => :SITRUSBERRY,
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :message => "The Jack-o'-lantern was lit up!",
                :movesetUpdate => [:FLAMETHROWER,:ENERGYBALL,:DISABLE,:ROCKSLIDE],
                :typeChange => [:GRASS,:FIRE],
                :abilitychange => :FLASHFIRE,
                :itemchange => :ELEMENTALSEED,
                :fieldChange => :GRASSY,
                :statDropCure => true,
                :statusCure => true,
                :effectClear => true,
                :bossStatChanges => {
                    PBStats::SPATK => 1,
                }
            },
            2 => {
                :threshold => 0,
                :movesetUpdate => [:GIGADRAIN,:LEECHSEED,:MYSTICALFIRE,:PHANTOMFORCE],
                :bossStatChanges => {
                    PBStats::SPDEF => 1,
                }
            },
            1 => {
                :threshold => 0,
                :movesetUpdate => [:GRASSYGLIDE,:ROCKSLIDE,:SYNTHESIS,:SHADOWSNEAK],
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                }
            },
        }
    },
    :BOSSKECLEON => {
        :name => "Wacky Lizard",
        :entryText => "Wacky Lizard's staring into space.",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :KECLEON,
            :level => 80,
            :form => 0,
            :moves => [:PLAYROUGH,:THUNDERPUNCH,:BOUNCE,:EARTHQUAKE],
            :gender => "F",
            :ability => :SHEERFORCE,
            :nature => :BRAVE,
            :item => :SITRUSBERRY,
            :iv => 31,
            :happiness => 0,
        },
        :onEntryEffects => {
            :delayedaction => {
                :delay => 1,
                :repeat => true,
                :loopingsetchanges => true,
                :itemchange => :LIFEORB,
                :setwinvariable => true,
                :message => "Wacky Lizard's type shifted!",
                :typeSequence => {
                    1 => {
                            :typeChange => [:FLYING,:FLYING],
                         },
                    2 => {
                            :typeChange => [:ELECTRIC,:FLYING],
                         },
                    3 => {
                            :typeChange => [:GROUND,:FLYING],
                         },
                    4 => {
                            :typeChange => [:FAIRY,:FLYING],
                         },
                },
            },
        },
        :onBreakEffects => {
            1 => {
            :threshold => 0,
            :statDropCure => true,
            :bossStatChanges => {
                }
            },
        },
    },
    :DUFAUX_EASY => {
        :name => "Dufaux",
        :entryText => "The Clefairy doll attacked!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :FROSLASS,
            :level => 85,
            :form => 2,
            :moves => [:POISONGAS,:THUNDERBOLT,:ICEBEAM,:MOONBLAST],
            :gender => "F",
            :nature => :MODEST,
            :iv => 31,
            :happiness => 0,
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :bosssideChanges => :Safeguard,
                :bosssideChangeCount => 5,
                :bosssideChangeAnimation => :SAFEGUARD,
                :itemchange => :MAGICALSEED,
                :message => "Dufaux attempted to repair itself…",
                :statDropCure => true,
                :statusCure => true,
                :bossStatChanges => {
                    PBStats::SPATK => -1
                }
            },
            1 => {
                :threshold => 0,
                :itemchange => :MAGNET,
                :message => "Dufaux broke out of its shell!",
                :movesetUpdate => [:SLUDGEBOMB,:DISCHARGE,:BLIZZARD,:WILLOWISP],
                :statDropCure => true,
                :formchange => 3,
                :weatherChange => :HAIL,
                :weatherChangeMessage => HAILSNOWMOD + " started to fall!",
                :weatherChangeAnimation => "Hail",
                :playerSideStatChanges => {
                    PBStats::ATTACK => -1,
                    PBStats::DEFENSE => -1,
                    PBStats::SPATK => -1,
                    PBStats::SPDEF => -1,
                    PBStats::SPEED => -1
                }
            },
        }
    },
    :MECHAGYARADOS_EASY => {
        :name => "GYARA-01",
        :entryText => "WARNING! WARNING! WARNING!",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :GYARADOS,
            :level => 86,
            :form => 3,
            :moves => [:THUNDERBOLT,:HYPERBEAM,:FLAMETHROWER,:SCALD],
            :gender => "F",
            :nature => :HARDY,
            :iv => 31,
            :happiness => 0,
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :message => "DESTRUCTION MODE ENGAGED!",
                :movesetUpdate => [:STEELBEAM,:MINDBLOWN,nil,nil],
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::SPATK => 1,
                }
            },
            2 => {
                :threshold => 0,
                :message => "COOLING DOWN...",
                :movesetUpdate => [:HYPERVOICE,:ICEBEAM,:IRONHEAD,:DOUBLEEDGE],
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::SPEED => -1,
                }
            },
            1 => {
                :threshold => 0,
                :message => "SELF-DESTRUCT SEQUENCE ACTIVATED!",
                :movesetUpdate => [:EXPLOSION,nil,nil,nil],
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::ATTACK => 6,
                }
            }
        }
    },
    :MASTEROFNIGHTMARES_EASY => {
        :name => "Master of Nightmares",
        :entryText => "The battle against nightmares has begun.",
        :shieldCount => 4,
        :immunities => {},
        :moninfo => {
            :species => :DARKRAI,
            :level => 85,
            :form => 2,
            :moves => [:THUNDERBOLT,:LOWKICK,:BUNRAKUBEATDOWN,:NIGHTMARE],
            :gender => "M",
            :nature => :BRAVE,
            :happiness => 0,
        },
        :onEntryEffects => {
            :animation => :IONDELUGE,
            :fieldChange => :ELECTERRAIN,
            :fieldChangeMessage => "Aelita's nightmares manifest into reality...",
            :delayedaction => {
                :delay => 1,
                :playerSideStatusChanges => [:PARALYSIS,"Paralysis"],
            }
        },
        :onBreakEffects => {
            4 => {
                :threshold => 0,
                :message => "Memories of being burned alive pass by...",
                :movesetUpdate => [:LAVAPLUME,:BULLDOZE,:BUNRAKUBEATDOWN,:NIGHTMARE],
                :formchange => 3,
                :animation => :ERUPTION,
                :playerSideStatusChanges => [:BURN,"Burn"],
                :playerEffects => :TarShot,
                :playerEffectsAnimation => :TARSHOT,
                :playerEffectsMessage => "You feel highly flammable...",
                :fieldChange => :VOLCANICTOP,
            },
            3 => {
                :threshold => 0,
                :message => "The feeling of an explosion creeps up your spine...",
                :movesetUpdate => [:DAZZLINGGLEAM,:SACREDSWORD,:BUNRAKUBEATDOWN,:NIGHTMARE],
                :formchange => 4,
                :animation => :EXPLOSION,
                :fieldChange => :DIMENSIONAL,
                :bossStatChanges => {
                    PBStats::SPDEF => 1,
                },
                :playerSideStatChanges => {
                    PBStats::DEFENSE => -1,
                    PBStats::SPDEF => -1
                }
            },
            2 => {
                :threshold => 0,
                :message => "You feel death incarnate staring you down...",
                :movesetUpdate => [:AIRSLASH,:DARKPULSE,:BUNRAKUBEATDOWN,:NIGHTMARE],
                :formchange => 5,
                :fieldChange => :CHESS,
                :animation => :DECIMATION,
                :playerEffects => :PerishSong,
                :playerEffectsduration => 3,
                :playerEffectsAnimation => :PERISHSONG,
                :playerEffectsMessage => "Death is imminent...",
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                }
            },
            1 => {
                :threshold => 0,
                :message => "The true nightmare begins.",
                :movesetUpdate => [:BUNRAKUBEATDOWN,:DARKPULSE,:SHADOWBALL,:THUNDERCAGE],
                :formchange => 1,
                :statDropCure => true,
                :fieldChange => :NEWWORLD,
                :animation => :NIGHTDAZE,
                :delayedaction => {
                    :delay => 1,
                    :playerEffects => :Yawn,
                    :playerEffectsAnimation => :YAWN,
                    :playerEffectsduration => 1,
                    :playerEffectsMessage => "A strong feeling of drowsiness...",
                },
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                    PBStats::SPDEF => 1,
                    PBStats::SPEED => 1,
                },
                :itemchange => :GHOSTIUMZ
            },
        }
    },
    :MASTEROFNIGHTMARES2_EASY => {
        :name => "Master of Nightmares",
        :entryText => "The nightmare will end soon.",
        :shieldCount => 0,
        :immunities => {},
        :moninfo => {
            :species => :DARKRAI,
            :level => 80,
            :moves => [:BUNRAKUBEATDOWN,:NIGHTMARE,:TAUNT,:SHADOWCLAW],
            :gender => "F",
            :nature => :MODEST,
            :form => 6,
            :iv => 31,
        },
        :onBreakEffects => {
        }
    },
    :BOSSKLINKLANG_EASY => {
        :name => "Klinklang Queen",
        :entryText => "KLINKLANG: Ohohoho!",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :KLINKLANG,
            :level => 82,
            :form => 1,
            :moves => [:SHIFTGEAR,:GEARGRIND,:FACADE,:WILDCHARGE],
            :nature => :ADAMANT,
            :ability => :CLEARBODY,
            :item => :LEFTOVERS,
            :iv => 31,
            :happiness => 0,
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "The Klinklang Queen revs up!",
                :statusCure => true,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::SPEED => 1
                }
            },
            1 => {
                :threshold => 0,
                :message => "Gears appear all around!",
                :movesetUpdate => [:SUBSTITUTE,:GEARGRIND,:FACADE,:WILDCHARGE],
                :fieldChange => :FACTORY,
                :bossStatChanges => {
                    PBStats::SPEED => 1
                }
            },
        }
    },
    :GERBIL1_EASY => {
        :name => "Entei", # nickname
        :entryText => "Entei appeared before you!",
        :shieldCount => 1, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :capturable => true, # can you catch this boss after shields are removed?
        :moninfo => { # pokemon details
            :species => :ENTEI,
            :level => 80,
            :form => 0,
            :moves => [:SACREDFIRE,:DIG,:EXTREMESPEED,:WILLOWISP],
            :ability => :PRESSURE,
            :nature => :ADAMANT,
            :iv => 31,
            :happiness => 255,
        },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            1 => {
                :bgmChange => "Battle - Final Endeavor",
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :weatherChange => :SUNNYDAY, # weather to apply
                :fieldChange => :VOLCANICTOP, # field changes
                :fieldChangeMessage => "Entei changed reality around it!", # message that plays when the field is changes
                :weatherCount => 5, # weather turncount
                :weatherChangeMessage => "The Sun is bright!", # weather message
                :weatherChangeAnimation => "Sunny", # string of "Rain", "Sunny","Hail","Sandstorm"
                :statusCure => true, # if status is cured when shield is broken
                :statDropCure => true, # if statdrops are negated when shield is broken
                :movesetUpdate => [:LAVAPLUME,:EXTRASENSORY,:EARTHQUAKE,:CALMMIND],
                :bossStatChanges => { # any statboosts that are given
                    PBStats::SPATK => 1,
                },
            },
        }
    },  
    :GERBIL2_EASY => {
        :name => "Suicune", # nickname
        :entryText => "Suicune appeared before you!",
        :shieldCount => 1, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :capturable => true, # can you catch this boss after shields are removed?
        :moninfo => { # pokemon details
            :species => :SUICUNE,
            :level => 80,
            :form => 0,
            :moves => [:AQUARING,:EXTRASENSORY,:SCALD,:CALMMIND],
            :ability => :PRESSURE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
        },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            1 => {
                :bgmChange => "Battle - Final Endeavor",
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "", # message that plays when shield is broken
                :abilitychange => :PRESSURE,
                :fieldChange => :UNDERWATER, # field changes
                :fieldChangeMessage => "Suicune changed reality around it!", # message that plays when the field is changes
                :statusCure => true, # if status is cured when shield is broken
                :statDropCure => true, # if statdrops are negated when shield is broken shield
                :movesetUpdate => [:SURF,:ICEBEAM,:EXTRASENSORY,:CALMMIND],
                :bossStatChanges => { # any statboosts that are given
                    PBStats::DEFENSE => 1,
                },
            },
        }
    },  
    :GERBIL3_EASY => {
        :name => "Raikou", # nickname
        :entryText => "Raikou appeared before you!",
        :shieldCount => 1, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :capturable => true, # can you catch this boss after shields are removed?
        :moninfo => { # pokemon details
            :species => :RAIKOU,
            :level => 80,
            :form => 0,
            :moves => [:THUNDERBOLT,:AURASPHERE,:SCALD,:CALMMIND],
            :ability => :PRESSURE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
        },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            1 => {
                :bgmChange => "Battle - Final Endeavor",
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "", # message that plays when shield is broken
                :weatherChange => :RAINDANCE, # weather to apply
                :fieldChange => :ELECTERRAIN, # field changes
                :fieldChangeMessage => "Raikou changed reality around it!", # message that plays when the field is changes
                :weatherChangeMessage => "The Rain pours down!", # weather message
                :weatherChangeAnimation => "Rain", # string of "Rain", "Sunny","Hail","Sandstorm"
                :statusCure => true, # if status is cured when shield is broken
                :statDropCure => true, # if statdrops are negated when shield is broken
                :movesetUpdate => [:THUNDERBOLT,:WEATHERBALL,:AURASPHERE,:EXTREMESPEED],
                :bossStatChanges => { # any statboosts that are given
                    PBStats::SPATK => 1,
                },
            },
        }
    },
    :TIEMPAGOOD_EASY => {
        :name => "Tiempa", # nickname
        :entryText => "Tiempa is looking ready to attack!",
        :shieldCount => 1, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :DIALGA,
            :level => 85,
            :form => 0,
            :item => :ADAMANTORB,
            :moves => [:EARTHPOWER,:FLASHCANNON,:POWERGEM,:DRAGONPULSE],
            :ability => :PRESSURE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
        },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            1 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "Tiempa twisted time around the field!", # message that plays when shield is broken
                :statusCure => true, # if status is cured when shield is broken
                :statDropCure => true, # if statdrops are negated when shield is broken
                :itemchange => :ADAMANTORB, # item that is given upon breaking shield
                :movesetUpdate => [:EARTHPOWER,:FLASHCANNON,:AURASPHERE,:ROAROFTIME],
                :playerSideStatChanges => {
                    PBStats::SPEED => -1,
                },
                :delayedaction => {
                    :delay => 2,
                    :message => "Tiempa slows down movement!",
                    :animation => :FAIRYLOCK,
                    :playerSideStatChanges => {
                        PBStats::SPEED => -1,
                    },
                    :repeat => true,
                }
            },
        }
    }, 
    :SPACEAGOOD_EASY => {
        :name => "Spacea", # nickname
        :entryText => "Spacea is finishing what Tiempa started!",
        :shieldCount => 2, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :PALKIA,
            :level => 85,
            :form => 0,
            :item => :LUSTROUSORB,
            :moves => [:SURF,:THUNDERBOLT,:DRAGONPULSE,:FLAMETHROWER],
            :ability => :PRESSURE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount == 2",
            :totalMonCount => 1,
            :playerMons => true,
            :moninfos => {
                1 => {
                    :species => :MINIOR,
                    :level => 90,
                    :form => 0,
                    :moves => [:ROCKSLIDE,:CONFUSERAY,:ACROBATICS,:LIGHTSCREEN],
                    :ability => :SHIELDSDOWN,
                },
            },
        },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            2 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :statDropCure => true, # if statdrops are negated when shield is broken
                :movesetUpdate => [:THUNDER,:FIREBLAST,:SPACIALREND,:HYDROPUMP],
                :itemchange => :LUSTROUSORB, # item that is given upon breaking shield
                :statchanges => :Gravity,
                :stateChangeAnimation => :GRAVITY,
                :stateChangeCount => 99,
                :stateChangeMessage => "The space around was contorted!",
                :bossStatChanges => {
                }
            },
            1 => {
                :message => "SPACEA: No more... NO... MORE!!!!!!!", # message that plays when shield is broken
                :animation => :FLASH, # effect animation
                :bgmChange => "Battle - End of Night",
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :formchange => 1, # formchanges
                :statusCure => true, # if status is cured when shield is broken
                :statDropCure => true, # if statdrops are negated when shield is broken
                :itemchange => :LUSTROUSORB, # item that is given upon breaking shield
                :bossStatChanges => { # any statboosts that are given
                    PBStats::DEFENSE => 1,
                    PBStats::SPATK => 1,
                },
            },
        }
    },
    :SPACEABAD_EASY => {
        :name => "Spacea", # nickname
        :entryText => "Spacea is looking ready to attack!",
        :shieldCount => 1, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :PALKIA,
            :level => 90,
            :form => 0,
            :item => :LUSTROUSORB,
            :moves => [:SURF,:DRAGONPULSE,:FLAMETHROWER,:THUNDERBOLT],
            :ability => :PRESSURE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
        },
        :sosDetails =>  { # pokemon details
            :activationRequirement => "@battle.battlers[battlerIndex].shieldCount == 1",
            :continuous => true,
            :totalMonCount => 2,
            :moninfos => {
                1 => {
                    :species => :MINIOR,
                    :level => 85,
                    :item => :FLYINGGEM,
                    :moves => [:ROCKSLIDE,:CONFUSERAY,:ACROBATICS,:LIGHTSCREEN],
                    :ability => :SHIELDSDOWN,
                },
                2 => {
                    :species => :CLEFAIRY,
                    :level => 85,
                    :item => :EVIOLITE,
                    :moves => [:FOLLOWME,:HELPINGHAND,:MOONBLAST,:REFLECT],
                    :ability => :FRIENDGUARD,
                },
            },
        },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            1 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "Spacea twisted the space around the field!", # message that plays when shield is broken
                :statusCure => true, # if status is cured when shield is broken
                :statDropCure => true, # if statdrops are negated when shield is broken
                :itemchange => :LUSTROUSORB, # item that is given upon breaking shield
                :movesetUpdate => [:HYDROPUMP,:SPACIALREND,:FIREBLAST,:THUNDER],
                :bossStatChanges => { # any statboosts that are given
                    PBStats::SPATK => 1,
                    PBStats::SPEED => 1,
                },
                :playerSideStatChanges => {
                    PBStats::SPEED => -1,
                }
            },
        }
    }, 
    :TIEMPABAD_EASY => {
        :name => "Tiempa", # nickname
        :entryText => "Tiempa is finishing what Spacea started!",
        :shieldCount => 3, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :DIALGA,
            :level => 90,
            :form => 0,
            :item => :ADAMANTORB,
            :moves => [:POWERGEM,:ROAROFTIME,:FLASHCANNON,:EARTHPOWER],
            :ability => :PRESSURE,
            :nature => :MODEST,
            :happiness => 255,
        },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            2 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :statDropCure => true, # if statdrops are negated when shield is broken
                :itemchange => :ADAMANTORB, # item that is given upon breaking shield
            },
            1 => {
                :CustomMethod => "battlesnapshot(battler,1,1)",
            },
            0 => {
                :CustomMethod => "timewarp(battler,1)",
                :movesetUpdate => [:FLAMETHROWER,:ROAROFTIME,:FLASHCANNON,:ICEBEAM],
                :delayedaction => {
                    :delay => 1,
                    :CustomMethod => "battlesnapshot(battler,2,-1)",
                    :message => "Tiempa is focusing on the kill!",
                    :bossStatChanges => { # any statboosts that are given
                        PBStats::DEFENSE => -1,
                        PBStats::SPDEF => -1,
                    },
                    :delayedaction => {
                        :delay => 8,
                        :message => "TIEMPA: You are wasting your time, Interceptor...",
                        :CustomMethod => "timewarp(battler,2)",
                    },
                },
                :message => "TIEMPA: No more... NO... MORE!!!!!!!", # message that plays when shield is broken
                :animation => :FLASH, # effect animation
                :bgmChange => "Battle - End of Night",
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :formchange => 1, # formchanges
                :statusCure => true, # if status is cured when shield is broken
                :statDropCure => true, # if statdrops are negated when shield is broken
                :itemchange => :ADAMANTORB, # item that is given upon breaking shield
            },
        }
    },
    :BOSSRATICATE_EASY => {
        :name => "Monstrosity",
        :entryText => "The grotesque rodent attacked!",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :RATICATE,
            :level => 16,
            :form => 2,
            :moves => [:POISONFANG,:BITE,:TAILWHIP,:SECRETPOWER],
            :ability => :NOGUARD,
            :nature => :NAUGHTY,
            :iv => 10,
            :happiness => 255,
            :ev => [0,0,0,0,0,0]
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "The Monstrosity started acting desperate!",
                :statDropCure => true,
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::DEFENSE => -1,
                    PBStats::SPDEF => -1,
                }
            }
        }
    },  
    :STARMIEGOD_EASY => {
        :name => "Shooting Star",
        :entryText => "You can't look away from the Star...",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :STARMIE,
            :level => 88,
            :moves => [:SURF,:THUNDERBOLT,:RECOVER,:PSYCHIC],
            :ability => :NATURALCURE,
            :nature => :MODEST,
            :item => :PETAYABERRY,
            :iv => 31,
            :happiness => 255,
            :shiny => true,
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "The Shooting Star is sparkling!",
                :statDropCure => true,
                :fieldChange => :RAINBOW,
                :fieldChangeMessage => "A prismatic luminance buries the surroundings!",
                :movesetUpdate => [:TRIATTACK,:DAZZLINGGLEAM,:RAPIDSPIN,:PSYSHOCK],
                :abilitychange => :PRISMARMOR,
            }
        }
    }, 
    :UXIEBAD_EASY => {
        :name => "Uxie", # nickname
        :entryText => "Uxie is defending itself!",
        :shieldCount => 1, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :UXIE,
            :level => 85,
            :form => 0,
            :moves => [:PSYCHUP,:PSYCHIC,:DRAININGKISS,:YAWN],
            :ability => :LEVITATE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
        },
        :sosDetails =>  { # pokemon details
        :activationRequirement => "@battle.battlers[battlerIndex].shieldCount == 0",
        :continuous => true,
        :totalMonCount => 2,
        :moninfos => {
            1 => {
                :species => :MESPRIT,
                :level => 80,
                :moves => [:CHARM,:PSYSHOCK,:SHADOWBALL,:CONFUSERAY],
                :ability => :LEVITATE,
                :nature => :MODEST,
                :iv => 31,
                :happiness => 255,
            },
            2 => {
                :species => :AZELF,
                :level => 80,
                :moves => [:THUNDERWAVE,:ZENHEADBUTT,:PLAYROUGH,:KNOCKOFF],
                :ability => :LEVITATE,
                :nature => :ADAMANT,
                :iv => 31,
                :happiness => 255,
                },
        },
    },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            1 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "Uxie drew power from the Starlight!", # message that plays when shield is broken
                :abilitychange => :VICTORYSTAR,
                :typeChange => [:PSYCHIC,:FAIRY],
                :fieldChange => :STARLIGHT,
                :movesetUpdate => [:PSYCHIC,:DRAININGKISS,:YAWN,:SIGNALBEAM],
                :fieldChangeMessage => "The field shines bright!", # message that plays when the field is changes
                :statusCure => true, # if status is cured when shield is broken
                :itemchange => :MAGICALSEED, # item that is given upon breaking shield
                :statBoosts => { # any statboosts that are given
                    PBStats::DEFENSE => 1,
                },
            },
        }
    },
    :MESPRITBAD_EASY => {
        :name => "Mesprit", # nickname
        :entryText => "Mesprit is defending itself!",
        :shieldCount => 1, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :MESPRIT,
            :level => 85,
            :form => 0,
            :moves => [:FLATTER,:CHARGEBEAM,:DRAININGKISS,:PSYCHIC],
            :ability => :LEVITATE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
        },
        :sosDetails =>  { # pokemon details
        :activationRequirement => "@battle.battlers[battlerIndex].shieldCount == 0",
        :continuous => true,
        :totalMonCount => 2,
        :moninfos => {
            1 => {
                :species => :UXIE,
                :level => 80,
                :moves => [:YAWN,:PSYCHIC,:THUNDERBOLT,:HELPINGHAND],
                :ability => :LEVITATE,
                :nature => :MODEST,
                :iv => 31,
                :happiness => 255,
            },
            2 => {
                :species => :AZELF,
                :level => 80,
                :moves => [:THUNDERWAVE,:ZENHEADBUTT,:PLAYROUGH,:KNOCKOFF],
                :ability => :LEVITATE,
                :nature => :ADAMANT,
                :iv => 31,
                :happiness => 255,
                },
        },
    },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            1 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "Mesprit submerged itself in water!", # message that plays when shield is broken
                :abilitychange => :TECHNICIAN,
                :typeChange => [:PSYCHIC,:WATER],
                :fieldChange => :WATERSURFACE,
                :movesetUpdate => [:PSYCHIC,:DRAININGKISS,:CHARGEBEAM,:WATERPULSE],
                :fieldChangeMessage => "The field was flash flooded!", # message that plays when the field is changes
                :statusCure => true, # if status is cured when shield is broken
                :itemchange => :ELEMENTALSEED, # item that is given upon breaking shield
                :statBoosts => { # any statboosts that are given
                    PBStats::SPEED => 1,
                },
            },
        }
    },
    :AZELFBAD_EASY => {
        :name => "Azelf", # nickname
        :entryText => "Azelf is defending itself!",
        :shieldCount => 1, # number of shields
        :barGraphic => "",
        :immunities => { # any immunities to things 
            :moves => [],
            :fieldEffectDamage => []
        },
        :moninfo => { # pokemon details
            :species => :AZELF,
            :level => 85,
            :form => 0,
            :moves => [:TAUNT,:FLAMETHROWER,:KNOCKOFF,:PSYCHIC],
            :ability => :LEVITATE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
        },
        :sosDetails =>  { # pokemon details
        :activationRequirement => "@battle.battlers[battlerIndex].shieldCount == 0",
        :continuous => true,
        :totalMonCount => 2,
        :moninfos => {
            1 => {
                :species => :UXIE,
                :level => 80,
                :moves => [:YAWN,:PSYCHIC,:THUNDERBOLT,:HELPINGHAND],
                :ability => :LEVITATE,
                :nature => :MODEST,
                :iv => 31,
                :happiness => 255,
            },
            2 => {
                :species => :MESPRIT,
                :level => 80,
                :moves => [:CHARM,:PSYSHOCK,:SHADOWBALL,:CONFUSERAY],
                :ability => :LEVITATE,
                :nature => :MODEST,
                :iv => 31,
                :happiness => 255,
            },
        },
    },
        :onBreakEffects => { # in order of shield count, with the highest value being the first shield broken and the lowest the last
            1 => {
                :threshold => 0, # if desired, shield can be broken at higher hp% than 0
                :message => "Azelf conflagrated in hellfire!", # message that plays when shield is broken
                :abilitychange => :MAGMAARMOR,
                :typeChange => [:PSYCHIC,:DARK],
                :fieldChange => :INFERNAL,
                :movesetUpdate => [:TORMENT,:FLAMETHROWER,:KNOCKOFF,:PSYCHIC],
                :fieldChangeMessage => "The field is burning with anguish!", # message that plays when the field is changes
                :statusCure => true, # if status is cured when shield is broken
                :itemchange => :ELEMENTALSEED, # item that is given upon breaking shield
                :statBoosts => { # any statboosts that are given
                    PBStats::ATTACK => 1,
                },
            },
        }
    },
    :RIFTTALON_EASY => {
        :name => "Karma Beast Talon",
        :entryText => "Talon fumbles toward you...",
        :shieldCount => 3,
        :immunities => {},
        :moninfo => {
            :species => :BRAVIARY,
            :level => 85,
            :form => 2,
            :moves => [:SLUDGEWAVE,:STEELWING,:ESPERWING,:VENOSHOCK],
            :gender => "M",
            :nature => :BRAVE,
            :item => :TELLURICSEED,
            :iv => 31,
            :happiness => 0,
        },
        :onBreakEffects => {
            3 => {
                :threshold => 0,
                :message => ".... stOooP.....",
                :movesetUpdate => [:ACIDARMOR,:BARBBARRAGE,:AIRSLASH,:BODYPRESS],
                :playersideChanges => :ToxicSpikes, # handles side changes found in the Battle_Side class(in Battle_ActiveSide file) 
                :playersideChangeAnimation => :TOXICSPIKES, # side change animation
                :playersideChangeCount => 1, # side change turncount
                :playersideChangeMessage => "Toxic Spikes was set up!",
            },
            2 => {
                :threshold => 0,
                :message => "oUu.... dOn'T.....",
                :formchange => 3,
                :typeChange => [:POISON,:DRAGON],
                :movesetUpdate => [:HEXINGSLASH,:DRAGONCLAW,:DRACOMETEOR,:ACIDSPRAY],
                :statDropCure => true,
                :statusCure => true,
                :formchange => 3,
                :fieldChange => :CORROSIVEMIST,
                :playerSideStatChanges => {
                    PBStats::DEFENSE => -1,
                    PBStats::SPDEF => -1
                }
            },
            1 => {
                :threshold => 0,
                :message => ".... pLEase.... enD IT....",
                :movesetUpdate => [:VILEASSAULT,:DRAGONRUSH,:SHADOWCLAW,:DRAGONDANCE],
                :itemchange => :POISONIUMZ,
                :bossStatChanges => {
                    PBStats::DEFENSE => -2,
                    PBStats::SPDEF => -2,
                    PBStats::SPEED => 1,
                }
            },
        }
    },
    :NANODRIVE_EASY => {
        :name => "NANO DRIVE",
        :entryText => "The NANO DRIVE is analyzing...",
        :shieldCount => 2,
        :immunities => {},
        :moninfo => {
            :species => :MAGNEZONE,
            :level => 90,
            :form => 1,
            :moves => [:DOUBLEIRONBASH,:BRICKBREAK,:IRONDEFENSE,:SUCKERPUNCH],
            :gender => "F",
            :nature => :IMPISH,
            :happiness => 0,
        },
        :onBreakEffects => {
            2 => {
                :threshold => 0,
                :message => "The NANO DRIVE is planning...",
                :movesetUpdate => [:DOUBLEIRONBASH,:BRUTALSWING,:SCREECH,:ELECTROWEB],
                :playersideChanges => :Spikes, # handles side changes found in the Battle_Side class(in Battle_ActiveSide file) 
                :playersideChangeAnimation => :SPIKES, # side change animation
                :playersideChangeCount => 1, # side change turncount
                :playersideChangeMessage => "A layer of Spikes was set up!",
                :bossStatChanges => {
                    PBStats::SPATK => 1,
                }
            },
            1 => {
                :threshold => 0,
                :message => "The NANO DRIVE is closing out the battle...",
                :movesetUpdate => [:METEORMASH,:ELECTROWEB,:KINGSSHIELD,:CLOSECOMBAT],
                :bossStatChanges => {
                    PBStats::DEFENSE => 1,
                }
            },
        }
    },
    :NANODRIVE_1_EASY => {
        :name => "NANO DRIVE",
        :entryText => "The NANO DRIVE is analyzing...",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :MAGNEZONE,
            :level => 90,
            :moves => [:HAMMERARM,:WOODHAMMER,:ICEHAMMER,:DRAGONHAMMER],
            :nature => :NAUGHTY,
            :form => 2,
            :happiness => 0,
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "Will you... Remember all of this too? ",
                :movesetUpdate => [:BLIZZARD,:THUNDER,:FIREBLAST,:HYPERBEAM],
                :bossStatChanges => {
                    PBStats::ATTACK => 1,
                    PBStats::SPATK => 1,                  
                },
                :statDropCure => true,
            },
        }
    },
    :IRONHELL_EASY => {
        :name => "Iron Moth",
        :entryText => "The Iron Moth is ready to take you down.",
        :shieldCount => 1,
        :immunities => {},
        :moninfo => {
            :species => :IRONMOTH,
            :level => 90,
            :moves => [:MORNINGSUN,:FIERYDANCE,:STRUGGLEBUG,:SOLARBEAM],
            :ability => :QUARKDRIVE,
            :nature => :MODEST,
            :iv => 31,
            :happiness => 255,
        },
        :onBreakEffects => {
            1 => {
                :threshold => 0,
                :message => "V: You... Grandma was right about you. This ends now.",
                :bossStatChanges => {
                    PBStats::SPEED => 1,
                }
            },
        }
    },

##############################
# Shadow Den Template
##############################

    :SHADOWDEN => {
        :name => "",
        :shieldCount => 1,
        :immunities => {},
        :capturable => true, # can you catch this boss after shields are removed?
        :moninfo => {},
        :onBreakEffects => {}
    },
}