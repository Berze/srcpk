local a = {
[2331] = {level = {15, 25}, balltype = "normal", ballid = 11825,  ----- LVL 50
        pokemons = {"Ivysaur", "Charmeleon", "Wartortle", "Raichu", "Fearow", "Vileplume", "Venomoth", "Parasect", "Clefable", 
	"Wigglytuff", "Sandslash", "Dugtrio", "Golduck", "Primeape", "Kadabra", "Machoke", "Victreebell", "Graveler", "Rapidash", 
	"Slowbro", "Magneton", "Farfetch'd", "Dodrio", "Cloyster", "Haunter", "Onix", "Hypno", "Kingler", "Electrode", 
 	"Exeggutor", "Marowak", "Hitmonlee", "Hitmonchan", "Lickitung", "Chansey", "Tangela", "Kangaskhan", "Seadra", 
	"Starmie", "Mr. Mime", "Pinsir", "Tauros", "Ditto", "Vaporeon", "Jolteon", "Flareon", "Porygon"}},
	
[9074] = {level = {20, 35}, balltype = "normal", ballid = 11825, ---- LVL 80
        pokemons = {"Shiny Abra","Shiny Butterfree","Shiny Ekans","Shiny Goldeen","Shiny Ivysaur","Shiny Seaking","Shiny Primeape","Slowbro", "Magneton", "Farfetch'd", "Dodrio", "Cloyster", "Haunter", "Onix", "Hypno", "Kingler", "Electrode", 
 	"Exeggutor", "Marowak", "Hitmonlee", "Hitmonchan","Shiny Starmie","Shiny Squirtle","Shiny Ponyta", "Lickitung", "Chansey", "Tangela", "Kangaskhan", "Seadra", 
	"Starmie", "Mr. Mime", "Pinsir", "Tauros", "Ditto", "Vaporeon","Nidoking","Nidoqueen","Dragonite","Golem","Gengar","Machamp","Blastoise","Charizard","Venusaur", "Jolteon", "Flareon", "Porygon"}},	
        
------- VIP
}



local extrastrength = 1.1 
       

function onUse(cid, item, frompos, item2, topos)
         local b = a[item.itemid]                                    
               if not b then return true end
         local pokemon = b.pokemons[math.random(#b.pokemons)]
         local pokeinfo = getPokemonStatus(pokemon)
               if not pokeinfo then return true end
         local btype = b.balltype
               if not pokeballs[btype] then return true end
         local gender = getRandomGenderByName(pokemon)
         local level = math.random(b.level[1], b.level[2])
         local offense = pokeinfo.off * level * extrastrength
         local defense = pokeinfo.def * level * extrastrength
         local agility = pokeinfo.agi * level * extrastrength
         local spatk = pokeinfo.spatk * level * extrastrength
	     local vit = pokeinfo.vit * level * extrastrength
         local happy = 180
         local leveltable = getPokemonExperienceTable(pokemon)
                  local ball = 0
         local sendToDepot = false                                                      --alterado v2.6
	     if getCreatureMana(cid) <= 6 or not hasSpaceInContainer(getPlayerSlotItem(cid, 3).uid) then
               sendToDepot = true
               ball = doCreateItemEx(b.ballid,true)  --alterado v1.5
         else
               ball = item.uid
         end  
         
           doItemSetAttribute(ball, "poke", pokemon)
           doItemSetAttribute(ball, "hp", 1)
           doItemSetAttribute(ball, "level", level)
           doItemSetAttribute(ball, "exp", leveltable[level])
           doItemSetAttribute(ball, "nextlevelexp", leveltable[level+1] - leveltable[level])
           doItemSetAttribute(ball, "offense", offense)
		   doItemSetAttribute(ball, "defense", defense)
		   doItemSetAttribute(ball, "speed", agility)
		   doItemSetAttribute(ball, "vitality", vit)
		   doItemSetAttribute(ball, "specialattack", spatk)
		   doItemSetAttribute(ball, "happy", happy)
		   doItemSetAttribute(ball, "gender", gender)
		   		   if pokemon == "Hitmonchan" or pokemon == "Shiny Hitmonchan" then
		      doItemSetAttribute(ball, "hands", 0)
           end
		   doItemSetAttribute(ball, "description", "Contains a "..pokemon..".")
		   doItemSetAttribute(ball, "fakedesc", "Contains a "..pokemon..".")  
           doPlayerSendMailByName(getCreatureName(cid), ball, 1)
           doPlayerSendTextMessage(cid, 27, "[BOX] Voce Abriu a Box e Ganhou um "..pokemon.." (level "..level.."), E Foi Para o Depot!")
           doPlayerSendTextMessage(cid, 19, "[BOX] Por Seguranša a Ball Foi Para Depot!")
           --doTransformItem(ball, pokeballs[btype].on)
           doSendMagicEffect(getThingPos(cid), 29)
           doSendAnimatedText(getCreaturePosition(cid),"DEPOT",math.random(1,255)) 
           doRemoveItem(item.uid)
return true
end