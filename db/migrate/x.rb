#require_all 'lib'
require 'rest-client'
require 'json'
require 'pry'

  def get_character_properties_from_api(character)
    response_string = RestClient.get("http://pokeapi.co/api/v2/pokemon/#{character}")
    response_hash = JSON.parse(response_string)
  end


  # def get_user_pokemon(user_input)
  #  get_character_properties_from_api(user_input)
  # end

  #pokemon = get_user_pokemon(user_input)

  pokemon = get_character_properties_from_api(character = rand(1..100))

  def get_pokemons_name(pokemon)
    pokemon["name"]
  end

  def get_pokemons_health(pokemon)
    pokemon["stats"][0]["base_stat"]
  end

  pokemon_health = get_pokemons_health(pokemon)

  def get_pokemons_attack(pokemon_health)
    (pokemon_health * 0.4).to_i
  end

  def pokemon_array
    pokemons = []
    count = 0
    get_character_properties_from_api(character = rand(1..100))
    until count == 10
      pokemons << get_pokemon_name
      count += 1
    end
    pokemons
  end
binding.pry
