require 'rest-client'
require 'json'
require 'pry'

# Pokemon.destroy_all

  def get_character_properties_from_api(character)
    response_string = RestClient.get("http://pokeapi.co/api/v2/pokemon/#{character}")
    response_hash = JSON.parse(response_string)
    response_hash
  end

  pokemon = get_character_properties_from_api(rand(1..100))

  def get_pokemons_name(pokemon)
    pokemon["name"]
  end

  def get_pokemons_health(pokemon)
    rand(70..100)
  end

  def get_pokemons_attack(pokemon_health)
    rand(30..45)
  end

  def pokemon_array
    pokemons = []

    until pokemons.length >= 150
      pokemon = get_character_properties_from_api(pokemons.length + 1)
      required_data = {
        name: get_pokemons_name(pokemon),
        health: get_pokemons_health(pokemon),
        attack: get_pokemons_attack(get_pokemons_health(pokemon))
      }
      pokemons << required_data
    end

    pokemons
  end


  # def pokemon_names_array
  #   pokemon_array.collect {|pokemon| get_pokemons_name(pokemon).capitalize}
  # end

  def create_pokemon_instances(array_of_pokehashes)
    array_of_pokehashes.each do |pokehash|
      Pokemon.create(pokehash)
    end
  end

  create_pokemon_instances(pokemon_array)
