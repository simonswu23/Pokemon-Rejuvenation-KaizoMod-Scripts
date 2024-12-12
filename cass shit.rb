def eventfindreplace
    for n in 1..999
        savemap = false
        map_name = sprintf("Data/Map%03d.rxdata", n)
        next if !(File.open(map_name,"rb") { true } rescue false)
        map = load_data(map_name)
        for i in map.events.keys.sort
            event = map.events[i]
            for j in 0...event.pages.length
                page = event.pages[j]
                list = page.list
                index = 0 
                while index < list.length - 1
                    if list[index].code == 101 ||list[index].code == 401
                        text = list[index].parameters[0]
                        if text.include? "aïve"
                            puts "found"
                            savemap = true
                            map.events[i].pages[j].list[index].parameters[0].gsub! 'aïve', 'aive'
                        end
                    end
                    index += 1
                end
            end
        end
        if savemap
            save_data(map,sprintf("Data/Map%03d.rxdata", n))
        end
    end
end

def eventfixtransfer
  for n in 1..999
      savemap = false
      map_name = sprintf("Data/Map%03d.rxdata", n)
      next if !(File.open(map_name,"rb") { true } rescue false)
      map = load_data(map_name)
      for i in map.events.keys.sort
          event = map.events[i]
          for j in 0...event.pages.length
              page = event.pages[j]
              list = page.list
              index = 0 
              while index < list.length - 1
                  if list[index].code == 201
                    if list[index].parameters[5] != 1
                      map.events[i].pages[j].list[index].parameters[5] = 1 
                      savemap = true
                    end
                  end
                  index += 1
              end
          end
      end
      if savemap
          save_data(map,sprintf("Data/Map%03d.rxdata", n))
      end
  end
end

def eventscriptamender
	for n in 1..999
		savemap = false
		map_name = sprintf("Data/Map%03d.rxdata", n)
		next if !(File.open(map_name,"rb") { true } rescue false)
		map = load_data(map_name)
		for i in map.events.keys.sort
			event = map.events[i]
			for j in 0...event.pages.length
				page = event.pages[j]
				list = page.list
				index = 0 
				while index < list.length - 1
					if list[index].code == 355 || list[index].code == 655
						map.events[i].pages[j].list[index].parameters[0].gsub! '$fefieldeffect', '$game_variables[7]'
						savemap = true
					end
					index += 1
				end
			end
		end
		if savemap
			save_data(map,sprintf("Data/Map%03d.rxdata", n))
		end
	end
end

def typosCSVFix
	typoarray = File.read("typos.txt").split("\n").map(&:strip)
	for i in 0...typoarray.length
		typoarray[i] = typoarray[i].split("@")
		typoarray[i][2] = false
	end
	for n in 1..910
		savemap = false
		map_name = sprintf("Data/Map%03d.rxdata", n)
		next if !(File.open(map_name,"rb") { true } rescue false)
		map = load_data(map_name)
		for typo in typoarray
			for i in map.events.keys.sort
				event = map.events[i]
				for j in 0...event.pages.length
					page = event.pages[j]
					list = page.list
					index = 0 
					while index < list.length - 1
						if list[index].code == 101 ||list[index].code == 401
							text = list[index].parameters[0]
							if text.include? typo[0]
								puts "#========# found #{typo[0]}"
								puts "full line: #{text}"
								savemap = true
								typo[2] = true
								map.events[i].pages[j].list[index].parameters[0].gsub! typo[0], typo[1]
							end
						end
						index += 1
					end
				end
			end
		end
		if savemap
			puts "saving map #{n}"
			save_data(map,sprintf("Data/Map%03d.rxdata", n))
		end
	end
	for typo in typoarray
		puts "Failed to find: #{typo[0]}" if typo[2] == false 
	end

end

def teamtotext
    f = File.open("#{$Trainer.name} team.txt","w")
    for poke in $Trainer.party
        f.write(getMonName(poke.species))
		case poke.gender
			when 0 #male
				f.write(" (M)")
			when 1 #female
				f.write(" (F)")
			else #genderless
				#do nothing
		end
		if poke.item != nil
			f.write(" @ #{getItemName(poke.item)}")
		end
		f.write("\nAbility: #{getAbilityName(poke.ability)}")
        f.write("\nLevel: #{poke.level}")
		if poke.isShiny?
			f.write("\nShiny: Yes")
		end
		f.write("\nEVs: #{poke.ev[0]} HP / #{poke.ev[1]} Atk / #{poke.ev[2]} Def / #{poke.ev[3]} SpA / #{poke.ev[4]} SpD / #{poke.ev[5]} Spe")
		f.write("\nNature: #{getNatureName(poke.nature)}")
		f.write("\nIVs: #{poke.iv[0]} HP / #{poke.iv[1]} Atk / #{poke.iv[2]} Def / #{poke.iv[3]} SpA / #{poke.iv[4]} SpD / #{poke.iv[5]} Spe")
        for move in poke.moves
            f.write("\n- #{getMoveName(move.move)}")
        end
        f.write("\n\n")
    end
    f.close
end

def makeRockClimbList
	eventlist = []
	for n in 1..910
		puts n
		savemap = false
		map_name = sprintf("Data/Map%03d.rxdata", n)
		next if !(File.open(map_name,"rb") { true } rescue false)
		map = load_data(map_name)
		for i in map.events.keys.sort
			event = map.events[i]
			for j in 0...event.pages.length
				page = event.pages[j]
				list = page.list
				index = 0 
				while index < list.length - 5
					if list[index].code == 209 && list[index].parameters[1].list[0].code == 37 && list[index].parameters[1].list[1].code == 29 && list[index].parameters[1].list[2].code == 32
						puts "found rock climb"
						newlist = fixRCevent(list)
						if !newlist
							puts "false positive"
							index += 1
							next
						end
						savemap = true
						map.events[i].pages[j].list = newlist
					end
					index += 1
				end
			end
		end
		if savemap
			puts "saving map #{n}"
			save_data(map,sprintf("Data/Map%03d.rxdata", n))
		end
	end
end

def showEvent
	map = load_data("Data/Map024.rxdata")
	for index in map.events[16].pages[0].list
		array = [index.code,index.indent,index.parameters]
		puts array.inspect
	end
end

def fixRCevent(list)
	for i in 0...list.length
		#find the indices of the start and end of the relevant section
		start = i if list[i].code == 209
		stop = i if list[i].code == 115
	end
	return nil if !stop
	newlist = []
	newlist.push(RPG::EventCommand.new(111,0,[12,"Kernel.pbRockClimb"]))
	baseindent = list[start].indent
	for i in start..stop
		if list[i].indent == baseindent
			list[i].indent = 1 
		else 
			list[i].indent = 2
			puts "motherfucking piece of shit rat bastard"
		end
		newlist.push(list[i])
	end
	newlist.push(RPG::EventCommand.new(0,1,[]))
	newlist.push(RPG::EventCommand.new(412,0,[]))
	newlist.push(RPG::EventCommand.new(0,0,[]))
	return newlist
end

#put forms and shinies on the same icon file
def imageFuserEgg
	for species in 1..890
		next if !pbResolveBitmap(sprintf("Graphics/Icons/icon%03degg",species))
		puts species
		forms = 0
		shiny = true
		fileexists = true
		currentform = 0
		oldfilename=pbCheckPokemonIconFiles([species, false, false, currentform,false],true)
		#check for multiple forms
		while oldfilename != fileexists
			currentform += 1
			fileexists=pbCheckPokemonIconFiles([species, false, false, currentform,false],true)
		end
		height = currentform*64
		width = 256
		combined_bitmap=Bitmap.new(width,height)
		rectangle = Rect.new(0,0,128,64)
		for i in 0...currentform
			unshiny = RPG::Cache.load_bitmap(pbCheckPokemonIconFiles([species, false, false, i,false],true))
			shiny = RPG::Cache.load_bitmap(pbCheckPokemonIconFiles([species, false, true, i,false],true))
			combined_bitmap.blt(0,i*64,unshiny,rectangle)
			combined_bitmap.blt(128,i*64,shiny,rectangle)
		end
		combined_bitmap.to_file(sprintf("Graphics/Icons/icon%03degg.png",species))
	end
end

#put forms and shinies on the same icon file
def imageFuserGirlEgg
	for species in 1..890
		next if !pbResolveBitmap(sprintf("Graphics/Icons/icon%03dfegg",species))
		puts species
		forms = 0
		shiny = true
		fileexists = true
		currentform = 0
		oldfilename=pbCheckPokemonIconFiles([species, true, false, currentform,false],true)
		#check for multiple forms
		while oldfilename != fileexists
			currentform += 1
			fileexists=pbCheckPokemonIconFiles([species, true, false, currentform,false],true)
		end
		height = currentform*64
		width = 256
		combined_bitmap=Bitmap.new(width,height)
		rectangle = Rect.new(0,0,128,64)
		for i in 0...currentform
			unshiny = RPG::Cache.load_bitmap(pbCheckPokemonIconFiles([species, true, false, i,false],true))
			shiny = RPG::Cache.load_bitmap(pbCheckPokemonIconFiles([species, true, true, i,false],true))
			combined_bitmap.blt(0,i*64,unshiny,rectangle)
			combined_bitmap.blt(128,i*64,shiny,rectangle)
		end
		combined_bitmap.to_file(sprintf("Graphics/Icons/icon%03dfegg.png",species))
	end
end

#put forms and shinies on the same icon file
def battlerFuser
	wrongmondimension = []
	$cache.pkmn.each do |monsym, mondata|
		species = mondata.dexnum
		name = mondata.name.upcase
		totalforms = mondata.formData.empty? ? 0 : mondata.formData.length
		formnum = mondata.forms.empty? ? 0 : mondata.forms.keys.last
		next if mondata.flags[:toobig]
		next if species == 869 #alcreamie. no one can fix up this thing.
		bitmapFileName=sprintf("Graphics/Battlers/%03d.png",species) #basic "make sure this exists"
		totalforms = formnum if (formnum>totalforms && !mondata.flags[:toobig])
		next if !pbResolveBitmap(bitmapFileName)
		#check for multiple forms
		if totalforms != 0
			bitmapFileName=sprintf("Graphics/Battlers/%03d_%d.png",species,totalforms)
			while !pbResolveBitmap(bitmapFileName) #if you can't resolve a picture, cut the total forms until you can
				totalforms -= 1
				break if totalforms == 0
				bitmapFileName=sprintf("Graphics/Battlers/%03d_%d.png",species,totalforms)
			end
		end
		height = (totalforms+1)*384
		width = 384
		width = 480 if mondata.flags[:toobig]
		combined_bitmap=Bitmap.new(width,height)
		rectangle = Rect.new(0,0,192,192)
		for i in 0..totalforms
			formnumber = ""
			formnumber = "_"+i.to_s if i!=0
			j = 0
			for file in ["%03d%s","%03ds%s","%03db%s","%03dsb%s"]
				filename = sprintf("Graphics/Battlers/#{file}.png",species,formnumber)
				if !pbResolveBitmap(filename)
					j+=1
					next
				end
				bitmap = RPG::Cache.load_bitmap(filename)
				unless [160,192].include?(bitmap.height) && ([160,192].include?(bitmap.width) || mondata.flags[:toobig])
					wrongmondimension.push(filename)
					puts "file #{file} for mon #{name} doesn't match dimensions"
					next 
				end
				width = bitmap.width == 160 ? 16 : 0
				height = i == 0 ? 16 : 0
				height = 16 if (species == 493 || species == 773 || species == 774) 
				width = 240 - bitmap.width/2 if mondata.flags[:toobig]
				case j%4
					when 0 then combined_bitmap.blt(width,i*384+height,bitmap,rectangle)
					when 1 then combined_bitmap.blt(192+width,i*384+height,bitmap,rectangle)
					when 2 then combined_bitmap.blt(width,i*384+192+height,bitmap,rectangle)
					when 3 then combined_bitmap.blt(192+width,i*384+192+height,bitmap,rectangle)
				end
				File.delete(sprintf("%s",filename)) if pbResolveBitmap(filename)
				j+=1
			end
		end
		combined_bitmap.to_file(sprintf("Graphics/Battlers/%03d.png",species))
		#say, are you one of those mons with gender differences?
		bitmapFileName=sprintf("Graphics/Battlers/%03df.png",species)
		next if !pbResolveBitmap(bitmapFileName) #you're not? thank god.
		height = (totalforms+1)*384
		width = 384
		width = 480 if mondata.flags[:toobig]
		combined_bitmap=Bitmap.new(width,height)
		rectangle = Rect.new(0,0,192,192)
		for i in 0..totalforms
			formnumber = ""
			formnumber = "_"+i.to_s if i!=0
			j = 0
			for file in ["%03df%s","%03dfs%s","%03dfb%s","%03dfsb%s"]
				filename = sprintf("Graphics/Battlers/#{file}.png",species,formnumber)
				if !pbResolveBitmap(filename)
					j+=1
					next
				end
				bitmap = RPG::Cache.load_bitmap(filename)
				unless [160,192].include?(bitmap.height) && ([160,192].include?(bitmap.width) || mondata.flags[:toobig])
					wrongmondimension.push(filename)
					puts "file #{file} for mon #{name} doesn't match dimensions"
					next 
				end
				width = bitmap.width == 160 ? 16 : 0
				height = bitmap.height == 160 ? 16 : 0
				width = 240 - bitmap.width/2 if mondata.flags[:toobig]
				case j%4
					when 0 then combined_bitmap.blt(width,i*384+height,bitmap,rectangle)
					when 1 then combined_bitmap.blt(192+width,i*384+height,bitmap,rectangle)
					when 2 then combined_bitmap.blt(width,i*384+192+height,bitmap,rectangle)
					when 3 then combined_bitmap.blt(192+width,i*384+192+height,bitmap,rectangle)
				end
				File.delete(sprintf("%s",filename)) if pbResolveBitmap(filename)
				j+=1
			end
		end
		combined_bitmap.to_file(sprintf("Graphics/Battlers/%03d_f.png",species))
	end
	f = File.open("#{$Trainer.name} fuckedup.txt","w")
	wrongmondimension.each do |monsym|
		f.write(monsym)
		f.write("\n")
	end
	f.close
end	

def fixingmyfuckups
	### az comment
	### this is/was the worst shit i've written in my life
	### why am i doing comparisons of pixels in arrays just to safely adjust sprites enmasse
	### its so gross. im leaving this comment here so i may be properly lambasted for it at a later point if anyone sees this.
	### i dont even have to anymore since i have an entire array of what needs fixing now but god. 
	# specieslist = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,174,175,176,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,326,327,328,329,330,331,332,333,334,335,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,356,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,424,425,426,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,447,448,449,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,473,474,475,476,477,478,480,481,482,483,484,485,486,487,488,489,490,491,492,493,550,666,775,860]
	specieslist = [35,36,42,128,243,244,245,267,269,276,318,319,322,323,324,356,424,426,447,448,473,484]
	$cache.pkmn.each do |monsym, mondata|
		species = mondata.dexnum
		next if !(specieslist.include?(species))
		next if mondata.flags[:toobig]
		name = mondata.name.upcase
		totalforms = mondata.formData.empty? ? 0 : mondata.forms.keys.last
		totalforms = mondata.forms.keys.last if (species == 493 || species == 773 || species == 774)
		next if species == 869 #alcreamie. no one can fix up this thing.
		bitmapFileName=sprintf("Graphics/Battlers/%03d.png",species) # basic make sure this thing exists
		next if !pbResolveBitmap(bitmapFileName)
		#how about some funky shadow pokes?
		height = (totalforms+1)*384
		width = 384
		width = 480 if mondata.flags[:toobig]
		combined_bitmap=Bitmap.new(width,height)
		bitmap = RPG::Cache.load_bitmap(bitmapFileName)
		next if !pbResolveBitmap(bitmapFileName) #you're not? thank god.
		for i in 0..totalforms
			for n in 0..1
				rectangle = Rect.new(0,(i*384)+(n*192),384,192)
				width = 0
				height = i == 0 ? 16 : 0
				height = 16 if (species == 493 || species == 773 || species == 774) 
				width = 240 - bitmap.width/2 if mondata.flags[:toobig]
				case n%2
					when 0 then combined_bitmap.blt(width,(i*384)+height,bitmap,rectangle)
					when 1 then combined_bitmap.blt(width,(i*384)+192,bitmap,rectangle)
				end
			end
		end
		combined_bitmap.to_file(sprintf("Graphics/Battlers/%03d.png",species))
		bitmapFileName=sprintf("Graphics/Battlers/%03d_f.png",species)
		next if !pbResolveBitmap(bitmapFileName) #you're not? thank god.
		bitmap = RPG::Cache.load_bitmap(bitmapFileName)
		combined_bitmap.clear
		height = (totalforms+1)*384
		width = 384
		width = 480 if mondata.flags[:toobig]
		next if !pbResolveBitmap(bitmapFileName) #you're not? thank god.
		for i in 0..totalforms
			for n in 0..1
				rectangle = Rect.new(0,(i*384)+(n*192),384,192)
				width = 0
				height = i == 0 ? 16 : 0
				height = 16 if (species == 493 || species == 773 || species == 774) 
				width = 240 - bitmap.width/2 if mondata.flags[:toobig]
				case n%2
					when 0 then combined_bitmap.blt(width,(i*384)+height,bitmap,rectangle)
					when 1 then combined_bitmap.blt(width,(i*384)+192,bitmap,rectangle)
				end
			end
		end
		combined_bitmap.to_file(sprintf("Graphics/Battlers/%03d_f.png",species))
	end
end

def fixingmyfuckupsfemale
	### az comment
	### this is/was the worst shit i've written in my life
	### why am i doing comparisons of pixels in arrays just to safely adjust sprites enmasse
	### its so gross. im leaving this comment here so i may be properly lambasted for it at a later point if anyone sees this.
	### i dont even have to anymore since i have an entire array of what needs fixing now but god. 
	specieslist = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,37,38,39,40,41,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,174,175,176,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,228,229,230,231,232,233,235,236,237,238,239,240,241,242,246,247,248,249,250,251,252,253,254,255,256,257,258,259,261,262,263,264,265,266,268,270,271,272,273,274,275,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,320,321,325,326,327,328,329,330,331,332,333,334,335,337,338,339,340,341,342,343,344,345,346,347,348,349,350,351,352,353,354,355,357,358,359,360,361,362,363,364,365,366,367,368,369,370,371,372,373,374,375,376,377,378,379,380,381,382,383,384,385,386,387,388,389,390,391,392,393,394,395,396,397,398,399,400,401,402,403,404,405,406,407,408,409,410,411,412,413,414,415,416,417,418,419,420,421,422,423,425,427,428,429,430,431,432,433,434,435,436,437,438,439,440,441,442,443,444,445,446,449,451,452,453,454,455,456,457,458,459,460,461,462,463,464,465,466,467,468,469,470,471,472,474,475,476,477,478,480,481,482,483,485,486,487,488,489,490,491,492,493,550,666,775,860]
	$cache.pkmn.each do |monsym, mondata|
		species = mondata.dexnum
		next if !(specieslist.include?(species))
		next if mondata.flags[:toobig]
		name = mondata.name.upcase
		totalforms = mondata.formData.empty? ? 0 : mondata.forms.keys.last
		totalforms = mondata.forms.keys.last if (species == 493 || species == 773 || species == 774)
		next if species == 869 #alcreamie. no one can fix up this thing.
		bitmapFileName=sprintf("Graphics/Battlers/%03d_f.png",species)
		next if !pbResolveBitmap(bitmapFileName) #you're not? thank god.
		bitmap = RPG::Cache.load_bitmap(bitmapFileName)
		height = (totalforms+1)*384
		width = 384
		width = 480 if mondata.flags[:toobig]
		combined_bitmap=Bitmap.new(width,height)
		next if !pbResolveBitmap(bitmapFileName) #you're not? thank god.
		for i in 0..totalforms
			for n in 0..1
				rectangle = Rect.new(0,(i*384)+(n*192),384,192)
				width = 0
				height = i == 0 ? 16 : 0
				height = 16 if (species == 493 || species == 773 || species == 774) 
				width = 240 - bitmap.width/2 if mondata.flags[:toobig]
				case n%2
					when 0 then combined_bitmap.blt(width,(i*384)+height,bitmap,rectangle)
					when 1 then combined_bitmap.blt(width,(i*384)+192,bitmap,rectangle)
				end
			end
		end
		combined_bitmap.to_file(sprintf("Graphics/Battlers/%03d_f.png",species))
	end
end

def shadowFuser
	return if !Rejuv
	wrongmondimension = []
	$cache.pkmn.each do |monsym, mondata|
		species = mondata.dexnum
		name = mondata.name.upcase
		totalforms = mondata.formData.empty? ? 0 : mondata.formData.length
		next if species == 869 #alcreamie. no one can fix up this thing.
		bitmapFileName=sprintf("Graphics/Battlers/%03d_shadow.png",species) # basic make sure this thing exists
		next if !pbResolveBitmap(bitmapFileName)
		#check for multiple forms
		if totalforms != 0
			bitmapFileName=sprintf("Graphics/Battlers/%03d_%d.png",species,totalforms)
			while !pbResolveBitmap(bitmapFileName) #if you can't resolve a picture, cut the total forms until you can
				totalforms -= 1
				break if totalforms == 0
				bitmapFileName=sprintf("Graphics/Battlers/%03d_%d.png",species,totalforms)
			end
		end
		#how about some funky shadow pokes?
		height = (totalforms+1)*384
		width = 384
		width = 480 if mondata.flags[:toobig]
		combined_bitmap=Bitmap.new(width,height)
		rectangle = Rect.new(0,0,192,192)
		for i in 0..totalforms
			formnumber = ""
			formnumber = "_"+i.to_s if i!=0
			j = 0
			for file in ["%03d%s_shadow","%03ds%s_shadow","%03db%s_shadow","%03dsb%s_shadow"]
				filename = sprintf("Graphics/Battlers/#{file}.png",species,formnumber)
				if !pbResolveBitmap(filename)
					j+=1
					next
				end
				bitmap = RPG::Cache.load_bitmap(filename)
				unless [160,192].include?(bitmap.height) && ([160,192].include?(bitmap.width) || mondata.flags[:toobig])
					wrongmondimension.push(filename)
					puts "file #{file} for mon #{name} doesn't match dimensions"
					next 
				end
				width = bitmap.width == 160 ? 16 : 0
				height = bitmap.height == 160 ? 16 : 0
				width = 240 - bitmap.width/2 if mondata.flags[:toobig]
				case j%4
					when 0 then combined_bitmap.blt(width,i*384+height,bitmap,rectangle)
					when 1 then combined_bitmap.blt(192+width,i*384+height,bitmap,rectangle)
					when 2 then combined_bitmap.blt(width,i*384+192+height,bitmap,rectangle)
					when 3 then combined_bitmap.blt(192+width,i*384+192+height,bitmap,rectangle)
				end
				File.delete(sprintf("%s",filename)) if pbResolveBitmap(filename)
				j+=1
			end
		end
		combined_bitmap.to_file(sprintf("Graphics/Battlers/%03d_shadow.png",species))
		#how about some fuckin' gender-difference shadow pokes?
		bitmapFileName=sprintf("Graphics/Battlers/%03df_shadow.png",species)
		next if !pbResolveBitmap(bitmapFileName) #you're not? thank god.
		height = (totalforms+1)*384
		width = 384
		width = 480 if mondata.flags[:toobig]
		combined_bitmap=Bitmap.new(width,height)
		rectangle = Rect.new(0,0,192,192)
		for i in 0..totalforms
			formnumber = ""
			formnumber = "_"+i.to_s if i!=0
			j = 0
			for file in ["%03df%s_shadow","%03dfs%s_shadow","%03dfb%s_shadow","%03dfsb%s_shadow"]
				filename = sprintf("Graphics/Battlers/#{file}.png",species,formnumber)
				if !pbResolveBitmap(filename)
					j+=1
					next
				end
				bitmap = RPG::Cache.load_bitmap(filename)
				unless [160,192].include?(bitmap.height) && ([160,192].include?(bitmap.width) || mondata.flags[:toobig])
					wrongmondimension.push(filename)
					puts "file #{file} for mon #{name} doesn't match dimensions"
					next 
				end
				width = bitmap.width == 160 ? 16 : 0
				height = bitmap.height == 160 ? 16 : 0
				width = 240 - bitmap.width/2 if mondata.flags[:toobig]
				case j%4
					when 0 then combined_bitmap.blt(width,i*384+height,bitmap,rectangle)
					when 1 then combined_bitmap.blt(192+width,i*384+height,bitmap,rectangle)
					when 2 then combined_bitmap.blt(width,i*384+192+height,bitmap,rectangle)
					when 3 then combined_bitmap.blt(192+width,i*384+192+height,bitmap,rectangle)
				end
				File.delete(sprintf("%s",filename)) if pbResolveBitmap(filename)
				j+=1
			end
		end
		combined_bitmap.to_file(sprintf("Graphics/Battlers/%03df_shadow.png",species))
	end
	f = File.open("#{$Trainer.name} fuckedup.txt","w")
	wrongmondimension.each do |monsym|
		f.write(monsym)
		f.write("\n")
	end
	f.close
end

#for blitting new battlers after the fact
def battlerAttacher
	Dir.foreach("Battlers/") do |filename|
    next if filename == '.' || filename == '..' || !pbResolveBitmap(filename)
		#REVERSE LOOKUP DEX NUMBER
		#mondata = $cache.pkmn[{REVERSED DEX NUMBER}]
		newBitmap = RPG::Cache.load_bitmap("Battlers/#{filename}")
		if newBitmap.height != 192 || (newBitmap.width != 192 && !mondata.flags[:toobig])
			puts "Check the dimensions on file #{filename}"
			next
		end
		if filename.include?('f')
			bitmapFileName = "Graphics/Battlers/#{mondata.name.upcase}_f"
		else
			bitmapFileName = "Graphics/Battlers/#{mondata.name.upcase}"
		end
		oldBitmap = RPG::Cache.load_bitmap(bitmapFileName)
		shiny = filename.include?('s') ? 192 : 0
		back = filename.include?('b') ? 192 : 0
		form = filename.include?('_') ? filename[-1].to_i : 0
		if (form+1) >= (oldBitmap.height / 3)
			puts "Form doesn't exist on base sheet for #{filename}"
			next
		end
		rectangle = Rect.new(0,0,192,192)
		oldBitmap.blt(shiny,form*384+back,newBitmap,rectangle)
		oldBitmap.to_file(bitmapFileName)
  end
end

#for un-doing a spritesheet
def battlerSplitter
	$cache.pkmn.each do |monsym, mondata|
		species = mondata.dexnum
		# return if species!=101
		name = mondata.name.upcase
		totalforms = mondata.formData.empty? ? 0 : mondata.forms.keys.last
		next if species == 869 #alcreamie. no one can fix up this thing.
		bitmapFileName=sprintf("Graphics/Battlers/%03d.png",species) # basic make sure this thing exists
		next if !pbResolveBitmap(bitmapFileName)
		#how about some funky shadow pokes?
		height = 192
		width = 192
		width = 240 if mondata.flags[:toobig]
		bitmapcomparer = Bitmap.new(width,height)
		bitmap = RPG::Cache.load_bitmap(bitmapFileName)
		splitbitmap=Bitmap.new(width,height)
		next if !pbResolveBitmap(bitmapFileName) #you're not? thank god.
		for i in 0..totalforms
			formnumber = ""
			formnumber = "_"+i.to_s if i!=0
			for j in 0..4
				splitbitmap.clear
				width = 0
				height = 16
				width = 240 - bitmap.width/2 if mondata.flags[:toobig]
				case j%4
					when 0 
						rectangle = Rect.new(0,0 + i*384,192,192)
						splitbitmap.blt(0,0,bitmap,rectangle)
						next if splitbitmap.get_pixel(96,96) == bitmapcomparer.get_pixel(96,96)
						splitbitmap.to_file(sprintf("Graphics/Battlers/%03d%s.png",species,formnumber))
					when 1 
						rectangle = Rect.new(192,0 + i*384,192,192)
						splitbitmap.blt(0,0,bitmap,rectangle)
						next if splitbitmap.get_pixel(96,96) == bitmapcomparer.get_pixel(96,96)
						splitbitmap.to_file(sprintf("Graphics/Battlers/%03ds%s.png",species,formnumber))
					when 2 
						rectangle = Rect.new(0,192+(0 + i*384),192,192)
						splitbitmap.blt(0,0,bitmap,rectangle)
						next if splitbitmap.get_pixel(96,96) == bitmapcomparer.get_pixel(96,96)
						splitbitmap.to_file(sprintf("Graphics/Battlers/%03db%s.png",species,formnumber))
					when 3 
						rectangle = Rect.new(192,192+(0 + i*384),192,192)
						splitbitmap.blt(0,0,bitmap,rectangle)
						next if splitbitmap.get_pixel(96,96) == bitmapcomparer.get_pixel(96,96)
						splitbitmap.to_file(sprintf("Graphics/Battlers/%03dsb%s.png",species,formnumber))
				end
			end
		end
		bitmapFileName=sprintf("Graphics/Battlers/%03d_f.png",species) # basic make sure this thing exists
		next if !pbResolveBitmap(bitmapFileName)
		#how about some gender difference pokes
		height = 192
		width = 192
		width = 240 if mondata.flags[:toobig]
		bitmap = RPG::Cache.load_bitmap(bitmapFileName)
		splitbitmap=Bitmap.new(width,height)
		next if !pbResolveBitmap(bitmapFileName) #you're not? thank god.
		for i in 0..totalforms
			formnumber = ""
			formnumber = "_"+i.to_s if i!=0
			for j in 0..4
				splitbitmap.clear
				width = 0
				height = 16
				width = 240 - bitmap.width/2 if mondata.flags[:toobig]
				case j%4
					when 0 
						rectangle = Rect.new(0,0 + i*384,192,192)
						splitbitmap.blt(0,0,bitmap,rectangle)
						next if splitbitmap.get_pixel(96,96) == bitmapcomparer.get_pixel(96,96)
						splitbitmap.to_file(sprintf("Graphics/Battlers/%03df%s.png",species,formnumber))
					when 1 
						rectangle = Rect.new(192,0 + i*384,192,192)
						splitbitmap.blt(0,0,bitmap,rectangle)
						next if splitbitmap.get_pixel(96,96) == bitmapcomparer.get_pixel(96,96)
						splitbitmap.to_file(sprintf("Graphics/Battlers/%03dfs%s.png",species,formnumber))
					when 2 
						rectangle = Rect.new(0,192+(0 + i*384),192,192)
						splitbitmap.blt(0,0,bitmap,rectangle)
						next if splitbitmap.get_pixel(96,96) == bitmapcomparer.get_pixel(96,96)
						splitbitmap.to_file(sprintf("Graphics/Battlers/%03dfb%s.png",species,formnumber))
					when 3 
						rectangle = Rect.new(192,192+(0 + i*384),192,192)
						splitbitmap.blt(0,0,bitmap,rectangle)
						next if splitbitmap.get_pixel(96,96) == bitmapcomparer.get_pixel(96,96)
						splitbitmap.to_file(sprintf("Graphics/Battlers/%03dfsb%s.png",species,formnumber))
				end
			end
		end
	end
end

def eggFuser
	for species in 1..890
		bitmapFileName=sprintf("Graphics/Battlers/%03dEgg",species)
		next if !pbResolveBitmap(bitmapFileName)
		puts species
		currentform = 0
		if currentform!=0
			formnumber = "_"+currentform.to_s
		else
			formnumber=""
		end
		bitmapFileName=sprintf("Graphics/Battlers/%03dEgg%s",species,formnumber)
		bitmapFuckName=""
		#check for multiple forms
		while pbResolveBitmap(bitmapFileName) || pbResolveBitmap(bitmapFuckName)
			currentform += 1
			formnumber = "_"+currentform.to_s
			bitmapFileName=sprintf("Graphics/Battlers/%03dEgg%s",species,formnumber)
			bitmapFuckName=sprintf("Graphics/Battlers/%03d%sEgg",species,formnumber)
		end
		height = currentform*64
		width = 128
		next if height==0
		combined_bitmap=Bitmap.new(width,height)
		rectangle = Rect.new(48,48,64,64)
		for i in 0...currentform
			if i!=0
				formnumber = "_"+i.to_s
			else
				formnumber=""
			end
			filename=sprintf("Graphics/Battlers/%03dEgg%s",species,formnumber)
			filename=sprintf("Graphics/Battlers/%03d%sEgg",species,formnumber) if !pbResolveBitmap(filename)
			unshiny = RPG::Cache.load_bitmap(filename)
			combined_bitmap.blt(0,i*64,unshiny,rectangle)
			filename=sprintf("Graphics/Battlers/%03dsEgg%s",species,formnumber)
			if !pbResolveBitmap(filename)
				puts "OOOOOOOOOH SMEARGLE MISSED #{species}"
			else
				shiny = RPG::Cache.load_bitmap(filename)
				combined_bitmap.blt(64,i*64,shiny,rectangle)
			end
			File.delete(sprintf("%s.png",filename)) if pbResolveBitmap(filename)
		end
		combined_bitmap.to_file(sprintf("Graphics/Battlers/%03dEgg.png",species))
	end
end

def eggFuserGirl
	for species in 1..890
		bitmapFileName=sprintf("Graphics/Battlers/%03dfEgg",species)
		next if !pbResolveBitmap(bitmapFileName)
		puts species
		currentform = 0
		if currentform!=0
			formnumber = "_"+currentform.to_s
		else
			formnumber=""
		end
		bitmapFileName=sprintf("Graphics/Battlers/%03dfEgg%s",species,formnumber)
		#check for multiple forms
		while pbResolveBitmap(bitmapFileName)
			currentform += 1
			formnumber = "_"+currentform.to_s
			bitmapFileName=sprintf("Graphics/Battlers/%03dfEgg%s",species,formnumber)
		end
		height = currentform*64
		width = 128
		next if height==0
		combined_bitmap=Bitmap.new(width,height)
		rectangle = Rect.new(48,48,64,64)
		for i in 0...currentform
			if i!=0
				formnumber = "_"+i.to_s
			else
				formnumber=""
			end
			filename=sprintf("Graphics/Battlers/%03dfEgg%s",species,formnumber)
			next if !pbResolveBitmap(filename)
			unshiny = RPG::Cache.load_bitmap(filename)
			combined_bitmap.blt(0,i*64,unshiny,rectangle)
			filename=sprintf("Graphics/Battlers/%03dfsEgg%s",species,formnumber)
			if !pbResolveBitmap(filename)
				puts "OOOOOOOOOH SMEARGLE MISSED #{species}"
			else
				shiny = RPG::Cache.load_bitmap(filename)
				combined_bitmap.blt(64,i*64,shiny,rectangle)
			end
			File.delete(sprintf("%s.png",filename)) if pbResolveBitmap(filename)
		end
		combined_bitmap.to_file(sprintf("Graphics/Battlers/%03dfEgg.png",species))
	end
end

def makeicons
	imageFuser
	imageFuserEgg
	imageFuserGirl
	imageFuserGirlEgg
end

def makebattlers
	battlerFuser
	eggFuser
	eggFuserGirl
	shadowFuser
	# shadowFuserGirl
end

def mapPicture
	mapdisplay=Sprite.new
	mapdisplay.x=20
	mapdisplay.y=20
	mapdisplay.z=100000
	mapdisplay.bitmap=createMinimap3($game_map.map_id,$game_player.x,$game_player.y)
	mapdisplay.visible=true
end

def createMinimap3(mapid,eventx,eventy)
	map=load_data(sprintf("Data/Map%03d.rxdata",mapid)) rescue nil
	bitmap=BitmapWrapper.new(240,240)
	black=Color.new(0,0,0)
	tilesets=load_data("Data/Tilesets.rxdata")
	tileset=tilesets[map.tileset_id]
	return bitmap if !tileset
	helper=TileDrawingHelper.fromTileset(tileset)
	ymin = [0,eventy-15].max
	ymax = [map.height,eventy+15].min
	xmin = [0,eventx-15].max
	xmax = [map.width,eventx+15].min
	for y in ymin...ymax
	  for x in xmin...xmax
		for z in 0..2
		  id=map.data[x,y,z]
		  id=0 if !id
		  helper.bltSmallTile(bitmap,(x-xmin)*8,(y-ymin)*8,32,32,id)
		end
	  end
	end
	bitmap.fill_rect(0,0,bitmap.width,1,black)
	bitmap.fill_rect(0,bitmap.height-1,bitmap.width,1,black)
	bitmap.fill_rect(0,0,1,bitmap.height,black)
	bitmap.fill_rect(bitmap.width-1,0,1,bitmap.height,black)
	return bitmap
end

def relvarDump
	output = ""
	varnums = (279..289).to_a + [277,745,746] + (294..315).to_a
	for value in varnums
		output += "#{$cache.RXsystem.variables[value]},#{$game_variables[value]}\n"
	end
	File.open("relationships.csv","w"){|f|
		f.write(output)
	}
end

def renameItemIcons
	$cache.items.each do |key, data|
		id = data.checkFlag?(:ID)
		icon = RPG::Cache.load_bitmap(sprintf("Graphics/Icons/%03d.png",id)) rescue next
		icon.to_file("Graphics/Icons/#{key.to_s.downcase!}.png")
	end
end

#image fusers for the modern era.
def imageFuser
	for species in 1..890
		puts species
		forms = 0
		shiny = true
		fileexists = true
		currentform = 0
		oldfilename=pbCheckPokemonIconFiles([species, false, false, currentform,false],false)
		#check for multiple forms
		while oldfilename != fileexists
			currentform += 1
			fileexists=pbCheckPokemonIconFiles([species, false, false, currentform,false],false)
		end
		height = currentform*64
		width = 256
		combined_bitmap=Bitmap.new(width,height)
		rectangle = Rect.new(0,0,128,64)
		for i in 0...currentform
			unshiny = RPG::Cache.load_bitmap(pbCheckPokemonIconFiles([species, false, false, i,false],false))
			shiny = RPG::Cache.load_bitmap(pbCheckPokemonIconFiles([species, false, true, i,false],false))
			combined_bitmap.blt(0,i*64,unshiny,rectangle)
			combined_bitmap.blt(128,i*64,shiny,rectangle)
		end
		combined_bitmap.to_file(sprintf("Graphics/Icons/icon%03d.png",species))
	end
end

def imageFuserGirl
	for species in 1..890
		next if !pbResolveBitmap(sprintf("Graphics/Icons/icon%03df",species))
		puts species
		forms = 0
		shiny = true
		fileexists = true
		currentform = 0
		oldfilename=pbCheckPokemonIconFiles([species, true, false, currentform,false],false)
		#check for multiple forms
		while oldfilename != fileexists
			currentform += 1
			fileexists=pbCheckPokemonIconFiles([species, true, false, currentform,false],false)
		end
		height = currentform*64
		width = 256
		combined_bitmap=Bitmap.new(width,height)
		rectangle = Rect.new(0,0,128,64)
		for i in 0...currentform
			unshiny = RPG::Cache.load_bitmap(pbCheckPokemonIconFiles([species, true, false, i,false],false))
			shiny = RPG::Cache.load_bitmap(pbCheckPokemonIconFiles([species, true, true, i,false],false))
			combined_bitmap.blt(0,i*64,unshiny,rectangle)
			combined_bitmap.blt(128,i*64,shiny,rectangle)
		end
		combined_bitmap.to_file(sprintf("Graphics/Icons/icon%03df.png",species))
	end
end