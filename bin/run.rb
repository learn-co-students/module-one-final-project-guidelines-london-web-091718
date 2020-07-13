require_relative '../config/environment'
require "pry"

system "clear"
get_character_from_user(greeting, comp)
find_user_and_comp_pokemon


#
# computer = User.find_or_create_by(name: 'Player')
# player = User.find_or_create_by(name: 'Computer')
#
# UserPokemon.find_or_create_by(pokemon_id: 3, user_id: computer.id)
# UserPokemon.find_or_create_by(pokemon_id: 7, user_id: computer.id)
# UserPokemon.find_or_create_by(pokemon_id: 10, user_id: computer.id)
# #
# UserPokemon.find_or_create_by(pokemon_id: 6, user_id: player.id)
# UserPokemon.find_or_create_by(pokemon_id: 34, user_id: player.id)
# UserPokemon.find_or_create_by(pokemon_id: 16, user_id: player.id)
#
player_pokemons = player_pokemon_instances
comp_pokemons = comp_pokemon_instances
press_enter_to_continue
# dice_roll
fight(player_pokemons[0], comp_pokemons[0])
press_enter_to_continue
fight(player_pokemons[1], comp_pokemons[1])
press_enter_to_continue
fight(player_pokemons[2], comp_pokemons[2])
press_enter_to_continue
winner(player_pokemons, comp_pokemons)



# delete_user_table
# delete_userpokemon_table
