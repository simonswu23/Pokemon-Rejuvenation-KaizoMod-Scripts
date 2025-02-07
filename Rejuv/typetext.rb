TYPEHASH = {
:NORMAL => {
    :name => "Normal",
    :weaknesses => [:FIGHTING,:SHADOW],
    :immunities => [:GHOST]
},

:FIGHTING => {
    :name => "Fighting",
    :weaknesses => [:FLYING,:PSYCHIC,:FAIRY,:SHADOW],
    :resistances => [:ROCK,:BUG,:DARK]
},

:FLYING => {
    :name => "Flying",
    :weaknesses => [:ROCK,:ELECTRIC,:ICE,:SHADOW],
    :resistances => [:FIGHTING,:BUG,:GRASS],
    :immunities => [:GROUND]
},

:POISON => {
    :name => "Poison",
    :weaknesses => [:GROUND,:PSYCHIC,:SHADOW],
    :resistances => [:FIGHTING,:POISON,:BUG,:GRASS,:FAIRY]
},

:GROUND => {
    :name => "Ground",
    :weaknesses => [:WATER,:GRASS,:ICE,:SHADOW],
    :resistances => [:POISON,:ROCK],
    :immunities => [:ELECTRIC]
},

:ROCK => {
    :name => "Rock",
    :weaknesses => [:FIGHTING,:GROUND,:STEEL,:WATER,:GRASS,:SHADOW],
    :resistances => [:NORMAL,:FLYING,:POISON,:FIRE]
},

:BUG => {
    :name => "Bug",
    :weaknesses => [:FLYING,:ROCK,:FIRE,:SHADOW],
    :resistances => [:FIGHTING,:GROUND,:GRASS,:FAIRY]
},

:GHOST => {
    :name => "Ghost",
    :weaknesses => [:GHOST,:DARK,:SHADOW],
    :resistances => [:POISON,:BUG],
    :immunities => [:NORMAL,:FIGHTING]
},

:STEEL => {
    :name => "Steel",
    :weaknesses => [:FIGHTING,:GROUND,:FIRE,:SHADOW],
    :resistances => [:NORMAL,:FLYING,:ROCK,:BUG,:FAIRY,:STEEL,:GRASS,:PSYCHIC,:ICE,:DRAGON],
    :immunities => [:POISON]
},

:QMARKS => {
    :name => "???",
},

:FIRE => {
    :name => "Fire",
    :weaknesses => [:GROUND,:ROCK,:WATER,:SHADOW],
    :resistances => [:BUG,:STEEL,:FIRE,:GRASS,:ICE,:FAIRY],
    :specialtype => true
},

:WATER => {
    :name => "Water",
    :weaknesses => [:GRASS,:ELECTRIC,:SHADOW],
    :resistances => [:STEEL,:FIRE,:WATER,:ICE],
    :specialtype => true
},

:GRASS => {
    :name => "Grass",
    :weaknesses => [:FLYING,:POISON,:BUG,:FIRE,:ICE,:SHADOW],
    :resistances => [:GROUND,:WATER,:GRASS,:ELECTRIC],
    :specialtype => true
},

:ELECTRIC => {
    :name => "Electric",
    :weaknesses => [:GROUND,:SHADOW],
    :resistances => [:FLYING,:STEEL,:ELECTRIC],
    :specialtype => true
},

:PSYCHIC => {
    :name => "Psychic",
    :weaknesses => [:BUG,:GHOST,:DARK,:SHADOW],
    :resistances => [:FIGHTING,:PSYCHIC],
    :specialtype => true
},

:ICE => {
    :name => "Ice",
    :weaknesses => [:FIGHTING,:ROCK,:STEEL,:FIRE,:SHADOW],
    :resistances => [:ICE],
    :specialtype => true
},

:DRAGON => {
    :name => "Dragon",
    :weaknesses => [:ICE,:DRAGON,:FAIRY,:SHADOW],
    :resistances => [:FIRE,:WATER,:GRASS,:ELECTRIC],
    :specialtype => true
},

:DARK => {
    :name => "Dark",
    :weaknesses => [:FIGHTING,:BUG,:FAIRY,:SHADOW],
    :resistances => [:GHOST,:DARK],
    :immunities => [:PSYCHIC],
    :specialtype => true
},


:FAIRY => {
    :name => "Fairy",
    :weaknesses => [:POISON,:STEEL],
    :resistances => [:FIGHTING,:DARK,:SHADOW],
    :immunities => [:DRAGON],
    :specialtype => true
},

:SHADOW => {
    :name => "Shadow",
    :weaknesses => [:FAIRY],
    :resistances => [:SHADOW],
    :specialtype => true
},

# Gen 9 Mod -  Added Stellar Type
:STELLAR => {
    :name => "Stellar",
    :specialtype => true
}

}
