require_relative '../config/environment'
require "pry"

<<<<<<< HEAD
#
# greeting
# get_character_from_user


# "#{user_num}".to_i = string to fixnum
# User.find_by(name: name).user_pokemons ==> get user pokemon



# my_pokes = [Pokemon.all[0],Pokemon.all[1],Pokemon.all[2]]

# User.create(name: "Computer")
# User.create(name: "Player")
#
# computer = User.find_by(name: 'Computer')
# player = User.find_by(name: 'Player')
#
# UserPokemon.create(pokemon_id: 3, user_id: computer.id)
# UserPokemon.create(pokemon_id: 7, user_id: computer.id)
# UserPokemon.create(pokemon_id: 10, user_id: computer.id)
#
# UserPokemon.create(pokemon_id: 6, user_id: player.id)
# UserPokemon.create(pokemon_id: 34, user_id: player.id)
# UserPokemon.create(pokemon_id: 16, user_id: player.id)
#
player_pokemons = User.find_by(name: 'Player').user_pokemons
comp_pokemons = User.find_by(name: 'Computer').user_pokemons





fight(player_pokemons[0], comp_pokemons[0])
fight(player_pokemons[1], comp_pokemons[1])
fight(player_pokemons[2], comp_pokemons[2])

winner(player_pokemons, comp_pokemons)

puts "GAME OVER"
=======
get_character_from_user(greeting, comp)
find_user_and_comp_pokemon
winner_or_loser
#user_table
# delete_user_table
# delete_userpokemon_table
puts "EOF"
>>>>>>> 4419fcbd5d43c50be71006a13f2e179d08898b6c
