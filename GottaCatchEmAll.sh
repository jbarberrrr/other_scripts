#!/bin/bash

echo -e "Hello! I am going to guess your favorite pokemon."
sleep 1

# Read the first type and create a list with pokemon of that type
read -p "What is your pokemons type? " pokemon_type1
curl -s https://pokeapi.co/api/v2/type/$pokemon_type1 | jq '.pokemon[].pokemon.name' >> pokemon_type1.txt

# If the user's pokemon has a second type, repeat then compare the two files
read -p "Does your pokemon have a 2nd type? (Y/N) " type2_bool
if [[ $type2_bool = [Yy] ]]; then
	read -p "What is your pokemons 2nd type? " pokemon_type2
	curl -s https://pokeapi.co/api/v2/type/$pokemon_type2 | jq '.pokemon[].pokemon.name' >> pokemon_type1.txt
elif [[ $type2_bool = [Nn] ]]; then
	read -p "What generation is your pokemon from? " gen
	curl -s https://pokeapi.co/api/v2/generation/$gen | jq '.pokemon_species[].name' >> pokemon_type2.txt
else
	echo "Invalid input. Do you not want me to guess your favorite pokemon?"
fi

# Run thru pokemon and make get rid of the ones with two types
#for pokemon in $pokemon_type
#do
#	 curl -s https://pokeapi.co/api/v2/type/$pokemon_type2 | jq '.pokemon[].pokemon.name' >> pokemon_type1.txt
#done

# Compare files for matching pokemon
if [[ $type2_bool != [YyNn] || -e pokemon_type2.txt ]]; then
	echo "The files don't exist b/c of bad input. "
	sort pokemon_type1.txt >> pokemon_type1_sorted.txt
	sort pokemon_type2.txt >> pokemon_type2_sorted.txt
	comm -12 pokemon_type1_sorted.txt pokemon_type2_sorted.txt
fi

# Git rid of duplicates ???????????????
#uniq -w 5 pokemon_type1.txt

# Remove temp files
rm pokemon_type*

#https://pokeapi.co/api/v2/{endpoint}/
