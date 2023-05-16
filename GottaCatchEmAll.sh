#!/bin/bash
# Joshua Barber
# GottaCatchEmAll
# May 15 2023

echo -e "Hello! I am going to guess your favorite pokemon."
sleep 1

# Read the first type and create a list with pokemon of that type
read -p "What is your pokemons type? " pokemon_type1
curl -s https://pokeapi.co/api/v2/type/$pokemon_type1 | jq '.pokemon[].pokemon.name' >> pokemon_type1.txt

# Get the user's pokemons 2nd type or what generation it is from
read -p "Does your pokemon have a 2nd type? (Y/N) " type2_bool
	sort pokemon_type1.txt >> pokemon_type1_sorted.txt
if [[ $type2_bool = [Yy] ]]; then
	read -p "What is your pokemons 2nd type? " pokemon_type2
	curl -s https://pokeapi.co/api/v2/type/$pokemon_type2 | jq '.pokemon[].pokemon.name' >> pokemon_type2.txt
elif [[ $type2_bool = [Nn] ]]; then
	read -p "What generation is your pokemon from? " gen
	curl -s https://pokeapi.co/api/v2/generation/$gen | jq '.pokemon_species[].name' >> pokemon_type2.txt
else
	echo "Invalid input. Do you not want me to guess your favorite pokemon? "
fi

# Compare files for matching pokemon
if [[ $type2_bool != [YyNn] || ! -f pokemon_type2.txt ]]; then
	echo ""
	echo "Bad input. Check spelling on types. "
else
	uniq pokemon_type1.txt >> pokemon_type1_unique.txt
	uniq pokemon_type2.txt >> pokemon_type2_unique.txt
        sort pokemon_type1_unique.txt >> pokemon_type1_unique_sorted.txt
        sort pokemon_type2_unique.txt >> pokemon_type2_unique_sorted.txt
        comm -12 pokemon_type1_unique_sorted.txt pokemon_type2_unique_sorted.txt
fi

# Remove temp files
rm pokemon_type*

#https://pokeapi.co/api/v2/{endpoint}/
