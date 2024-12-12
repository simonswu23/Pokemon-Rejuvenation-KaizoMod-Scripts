def compileAll
  compileMons
  compileMoves
  compileItems
  compileAbilities
  compileMapData
  compileMetadata
  compileFields
  compileFieldNotes if !Rejuv
  compileTypes
  compileTrainerTypes
  compileTrainers
  compileNatures
  compileBosses if Rejuv
  $cache = nil
  $cache = Cache_Game.new
end

def compileMons
	cprint "Compiling Pokemon..."
	begin
		File.open("Scripts/"+GAMEFOLDER+"/montext.rb"){|f|
			eval(f.read)
		}
	rescue
		cprint "failed.\n"
		throw $!.inspect
		return
	end
	cprint "done.\n"
	cprint "Creating Pokemon DOH..."
  mons = {}
	begin
		MONHASH.each {|key, value|
			mons[key] = MonData.new(key,value)
		}
		save_data(mons,"Data/mons.dat")
	rescue
		cprint "failed.\n"
		throw $!.inspect
		return
	end
	cprint "done.\n"
	if $Trainer
		$Trainer.pokedex.refreshDex
	end
end

def compileMoves
  File.open("Scripts/"+GAMEFOLDER+"/movetext.rb"){|f|
    eval(f.read)
  }
  moves = {}
  MOVEHASH.each {|key, value|
    moves[key] = MoveData.new(key,value)
  }
  save_data(moves,"Data/moves.dat")
end

def compileItems
  File.open("Scripts/"+GAMEFOLDER+"/itemtext.rb"){|f|
    eval(f.read)
  }
  items = {}
  ITEMHASH.each {|key, value|
    items[key] = ItemData.new(key,value)	
  }
  $PokemonBag.reQuantity() if $PokemonBag
  save_data(items,"Data/items.dat")
end

def compileAbilities
  File.open("Scripts/"+GAMEFOLDER+"/abiltext.rb"){|f|
    eval(f.read)
  }
  abilities = {}
  ABILHASH.each {|key, value|
    abilities[key] = AbilityData.new(key,value)
  }
  save_data(abilities,"Data/abil.dat")
  if $cache
	$cache.cacheAbilities
  end
end

def compileMapData
  File.open("Scripts/"+GAMEFOLDER+"/enctext.rb"){|f|
    eval(f.read)
  }
  File.open("Scripts/"+GAMEFOLDER+"/metatext.rb"){|f|
    eval(f.read)
  }
  mapdata = []
  for i in 1...1000   #rmxp's classic map limit
    encdata = ENCHASH[i]
    metadata = METAHASH[i]
    next if !metadata
    mapdata[i] = MapMetadata.new(i,encdata,metadata)
  end
  save_data(mapdata,"Data/maps.dat")
  if $game_map
	$game_map.need_refresh = true
  end
end

def compileTownMap
	return if !Rejuv
	File.open("Scripts/"+GAMEFOLDER+"/townmap.rb"){|f|
		eval(f.read)
	}
	townmap = {}
	for i in 0...TOWNMAP.length
		region = TOWNMAP[i]
		townmap[i] = {}
		townmap[i][:name] = region[:name]
		townmap[i][:filename] = region[:filename]
		region[:points].each{|point, data|
			townmap[point] = TownMapData.new(point, data, i)
			if !data[:flyData].empty?
				puts "#{i}: #{point.inspect}"
				flyData = data[:flyData]
				$cache.mapdata[flyData[0]].syncMapData(i,point,flyData)
			end
		}
	end
	save_data(townmap,"Data/townmap.dat")
	save_data($cache.mapdata,"Data/maps.dat")
end

def compileMetadata
  File.open("Scripts/"+GAMEFOLDER+"/metatext.rb"){|f|
    eval(f.read)
  }
  players = []
  METAHASH.each {|key, value|
    next if key.is_a?(Integer)
    players.push(METAHASH[key]) if key.to_s.include?("player")
  }
  meta = {}
  meta[:home]             = METAHASH[:home]
  meta[:TrainerVictory]   = METAHASH[:TrainerVictory]
  meta[:WildVictory]      = METAHASH[:WildVictory]
  meta[:TrainerBattle]    = METAHASH[:TrainerBattle]
  meta[:WildBattle]       = METAHASH[:WildBattle]
  meta[:Surf]             = METAHASH[:Surf]
  meta[:LavaSurf]		  = METAHASH[:LavaSurf]
  meta[:Bicycle]          = METAHASH[:Bicycle]
  meta[:Players]          = players
  save_data(meta,"Data/meta.dat")
end

def compileTypes
	File.open("Scripts/"+GAMEFOLDER+"/typetext.rb"){|f|
	  eval(f.read)
	}
	types = {}
	TYPEHASH.each {|key, value|
		types[key] = TypeData.new(key,value)
	}
	save_data(types,"Data/types.dat")
end

def compileTrainerTypes
  File.open("Scripts/"+GAMEFOLDER+"/ttypetext.rb"){|f|
    eval(f.read)
  }
  ttypes = {}
  TTYPEHASH.each {|key, value|
    ttypes[key] = TrainerData.new(key,value)
  }
  save_data(ttypes,"Data/ttypes.dat")
end

def compileTrainers
	#it's really more like "assembling" them but w/e
	File.open("Scripts/"+GAMEFOLDER+"/trainertext.rb"){|f|
    eval(f.read)
  }
	fulltrainerdata = {}
  #iterate through, sort teams into hashes
  for trainer in TEAMARRAY
		next if trainer.nil?
		#split trainer into important components
		trainertype = trainer[:teamid][1]
		name = trainer[:teamid][0]
		items = trainer[:items]
		pkmn = trainer[:mons]
		partyid =trainer[:teamid][2]
		ace = trainer[:ace]
		defeat = trainer[:defeat]
		trainereffect = trainer[:trainereffect] if Rejuv
		#see if there's a trainer with the same type/name in the hash already
    fulltrainerdata[trainertype] = {} if !fulltrainerdata[trainertype]
    fulltrainerdata[trainertype][name] = [] if !fulltrainerdata[trainertype][name]
	if Rejuv
		fulltrainerdata[trainertype][name].push([partyid,pkmn,items,ace,defeat,trainereffect])
	else
		fulltrainerdata[trainertype][name].push([partyid,pkmn,items,ace,defeat])
	end
  end
  save_data(fulltrainerdata,"Data/trainers.dat")
end

def compileForms(mondata=$cache.pkmn)
	#Two part process: canon forms, then game forms.
	baseforms = ""
	File.open("Scripts/MultipleForms.rb"){|f|
		baseforms = f.read
		eval(f.read)
	}
	gameforms = ""
	File.open("Scripts/"+GAMEFOLDER+"/Forms.rb"){|f|
		gameforms = f.read
		eval(f.read)
	}

	$GamePokemonForms.each{|mon,data|
		if !$PokemonForms.keys.include?(mon)
			$PokemonForms.store(mon,data) 
			next
		end
		#puts mon
		if data.is_a?(Hash)
			data.each{|formkey, formdata|
			if !$PokemonForms[mon].keys.include?(formkey)
				$PokemonForms[mon].store(formkey,formdata) 
				next
			else
				next if formdata == $PokemonForms[mon][formkey]
				if formkey != :OnCreation
					$PokemonForms[mon][formkey].merge!(formdata) 
				else
					$PokemonForms[mon][formKey] = formdata
				end
			end

			}
		end
	}

	$PokemonForms.each {|mon, data|
		if !mondata[mon]
			puts "non-existent mon #{mon}"
			next
		end
		mondata[mon].forms = data[:FormName]
		if data[:OnCreation]
			mondata[mon].formInit = extractFormProc(baseforms, gameforms, data[:OnCreation], mon)
		end
		mondata[mon].formData = data
		mondata[mon].formData.delete(:OnCreation)
		mondata[mon].formData.delete(:FormName)
	}
	return mondata
end

def compileBosses
	bossdata = {}
	File.open("Scripts/"+GAMEFOLDER+"/BossInfo.rb"){|f| eval(f.read)}
	BOSSINFOHASH.each {|boss, data|
		bossdata[boss] = BossData.new(boss,data)
	}
	save_data(bossdata,"Data/bossdata.dat")
end

def compileConnections
	File.open("Scripts/"+GAMEFOLDER+"/mapconnections.rb"){|f|
		eval(f.read)
	}
	connections = {}
	MAPCONNECTIONSHASH.each {|key, value|
		connections[key] = value
	}
	save_data(connections,"Data/connections.dat")
end

def compileFields
	fields = {}
	File.open("Scripts/"+GAMEFOLDER+"/fieldtxt.rb"){|f| eval(f.read)}

	FIELDEFFECTS[nil] = FIELDEFFECTS[:INDOOR].clone
	FIELDEFFECTS[0] = FIELDEFFECTS[:INDOOR].clone

	FIELDEFFECTS.each{|key, data|
		currentfield = FEData.new
		#Basic data copying
		currentfield.name 				= data[:name]
		currentfield.message 			= data[:fieldMessage] 
		currentfield.graphic 			= data[:graphic]
		currentfield.secretPower 		= data[:secretPower]
		currentfield.naturePower 		= data[:naturePower]
		currentfield.mimicry 			= data[:mimicry]
		currentfield.statusMods 		= data[:statusMods]
		currentfield.overlayStatusMods 	= data[:overlay][:statusMods] if data[:overlay]
		#now for worse shit
		#invert hashes such that move => mod
		movedamageboost 	= pbHashForwardizer(data[:damageMods]) 		|| {}
		movetypemod 		= pbHashForwardizer(data[:typeMods])  		|| {}
		moveaccuracyboost 	= pbHashForwardizer(data[:accuracyMods]) 	|| {}
		moveeffects 		= pbHashForwardizer(data[:moveEffects]) 	|| {}
		typedamageboost 	= pbHashForwardizer(data[:typeBoosts]) 		|| {}
		typetypemod 		= pbHashForwardizer(data[:typeAddOns])  	|| {}
		fieldchange 		= pbHashForwardizer(data[:fieldChange]) 	|| {}
		changeeffects 		= pbHashForwardizer(data[:changeEffects]) 	|| {}
		typecondition 		= data[:typeCondition] 	 	? data[:typeCondition]   	: {}
		typeeffects 		= data[:typeEffects] 	 	? data[:typeEffects]   	: {}
		changecondition 	= data[:changeCondition] 	? data[:changeCondition] 	: {}
    	dontchangebackup  	= data[:dontChangeBackup] 	? data[:dontChangeBackup] 	: {}
		if data[:overlay]
			overlaydamage 		= pbHashForwardizer(data[:overlay][:damageMods]) 		|| {}
			overlaytypemod 		= pbHashForwardizer(data[:overlay][:typeMods])  		|| {}
			overlaytypeboost 	= pbHashForwardizer(data[:overlay][:typeBoosts]) 		|| {}
			overlaytypecons 	= data[:overlay][:typeCondition] ? data[:overlay][:typeCondition] : {}
		end

		#messages get stored separately and are replaced by an index
		movemessages  = data[:moveMessages]  || {}
		typemessages  = data[:typeMessages]  || {}
		changemessage = data[:changeMessage] || {}
		overlaymovemsg= data[:overlay][:moveMessages] || {} if data[:overlay]
		overlaytypemsg= data[:overlay][:typeMessages] || {}	if data[:overlay]
		movemessagelist = []
		typemessagelist = []
		changemessagelist = []
		olmovemessagelist = []
		oltypemessagelist = []
		messagearray = [movemessages,typemessages,changemessage]
		messagearray = [movemessages,typemessages,changemessage,overlaymovemsg,overlaytypemsg] if data[:overlay]
		messagearray.each_with_index{|hashdata, index|
			messagelist = hashdata.keys
			newhashdata = {}
			hashdata.each {|key, value|
				newhashdata[messagelist.index(key)+1] = value
			}
			invhash = pbHashForwardizer(newhashdata)
			case index
			when 0
				movemessagelist = messagelist
				movemessages = invhash
			when 1
				typemessagelist = messagelist
				typemessages = invhash
			when 2
				changemessagelist = messagelist
				changemessage = invhash
			when 3
				olmovemessagelist = messagelist
				overlaymovemsg = invhash
			when 4
				oltypemessagelist = messagelist
				overlaytypemsg = invhash
			end
		}

		#now we have all our hashes de-backwarded, and can fuse them all together.
		#first, moves:
		#get all the keys in one place
		keys = (movedamageboost.keys << movetypemod.keys << moveaccuracyboost.keys << moveeffects.keys << fieldchange.keys).flatten
		#now we take all the old hashes and squish them into one:
		fieldmovedata = {}
		for move in keys
			movedata = {}
			movedata[:mult] = movedamageboost[move] if movedamageboost[move]
			movedata[:typemod] = movetypemod[move] if movetypemod[move]
			movedata[:accmod] = moveaccuracyboost[move] if moveaccuracyboost[move]
			movedata[:multtext] = movemessages[move] if movemessages[move]
			movedata[:moveeffect] = moveeffects[move] if moveeffects[move]
			movedata[:fieldchange] = fieldchange[move] if fieldchange[move]
			movedata[:changetext] = changemessage[move] if changemessage[move]
			movedata[:changeeffect] = changeeffects[move] if changeeffects[move]
      		movedata[:dontchangebackup] = dontchangebackup.include?(move)
			fieldmovedata[move] = movedata
		end
		#now, types!
		fieldtypedata = {}
		keys = (typedamageboost.keys << typetypemod.keys << typeeffects.keys).flatten
		for type in keys
			typedata = {}
			typedata[:mult] = typedamageboost[type] if typedamageboost[type]
			typedata[:typemod] = typetypemod[type] if typetypemod[type]
			typedata[:typeeffect] = typeeffects[type] if typeeffects[type]
			typedata[:multtext] = typemessages[type] if typemessages[type]
			typedata[:condition] = typecondition[type] if typecondition[type]
			fieldtypedata[type] = typedata
		end
		if data[:overlay]
			overlaymovedata = {}
			keys = (overlaydamage.keys << overlaytypemod.keys).flatten
			for move in keys
				movedata = {}
				movedata[:mult] = overlaydamage[move] if overlaydamage[move]
				movedata[:typemod] = overlaytypemod[move] if overlaytypemod[move]
				movedata[:multtext] = overlaymovemsg[move] if overlaymovemsg[move]
				overlaymovedata[move] = movedata
			end
			overlaytypedata = {}
			keys = overlaytypeboost.keys
			for type in keys
				typedata = {}
				typedata[:mult] = overlaytypeboost[type] if overlaytypeboost[type]
				typedata[:multtext] = overlaytypemsg[type] if overlaytypemsg[type]
				typedata[:condition] = overlaytypecons[type] if overlaytypecons[type]
				overlaytypedata[type] = typedata
			end
		end

		#seeds for good measure.
		seeddata = {}
		seeddata = data[:seed]
		currentfield.fieldtypedata = fieldtypedata
		currentfield.fieldmovedata = fieldmovedata
		currentfield.seeddata = seeddata
		currentfield.movemessagelist = movemessagelist
		currentfield.typemessagelist = typemessagelist
		currentfield.changemessagelist = changemessagelist
    	currentfield.fieldchangeconditions = changecondition
		currentfield.overlaytypedata = overlaytypedata if overlaytypedata
		currentfield.overlaymovedata = overlaymovedata if overlaymovedata
		currentfield.overlaymovemessagelist = olmovemessagelist if olmovemessagelist
		currentfield.overlaytypemessagelist = oltypemessagelist if oltypemessagelist
		#all done!
		fields.store(key, currentfield)
	}
	save_data(fields,"Data/fields.dat")
end

def compileNatures
	File.open("Scripts/"+GAMEFOLDER+"/naturetxt.rb"){|f|
	  eval(f.read)
	}
	natures = {}
	NATUREHASH.each {|key, value|
		natures[key] = NatureData.new(key,value)
	}
	save_data(natures, "Data/natures.dat")
end

def compileAnimations
  begin
    pbanims=load_data("Data/PkmnAnimations.rxdata")
  rescue
    pbanims=PBAnimations.new
  end
  move2anim=[{},{}]
  for i in 0...pbanims.length
    next if !pbanims[i]
    if pbanims[i].name[/^OppMove\:\s*(.*)$/]
      if $cache.moves.key?(pbanims[i].name.split(":")[1].intern)
        moveid=pbanims[i].name.split(":")[1].intern
        move2anim[1][moveid.intern]=i
      end
    elsif pbanims[i].name[/^Move\:\s*(.*)$/]
      if $cache.moves.key?(pbanims[i].name.split(":")[1].intern)
        moveid=pbanims[i].name.split(":")[1].intern
        move2anim[0][moveid.intern]=i
      end
    end
  end
  save_data(move2anim,"Data/move2anim.dat")
  save_data(pbanims,"Data/PkmnAnimations.rxdata")
  animExpander
end

def animExpander
  for i in 0...$cache.animations.length
    for j in 1...$cache.animations[i].length
      for k in 0...$cache.animations[i][j].length
        if $cache.animations[i][j][k] == 0
          $cache.animations[i][j][k] = $cache.animations[i][j-1][k].clone
        end
      end
    end
  end
end