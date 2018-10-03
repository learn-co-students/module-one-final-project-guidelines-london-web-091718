#ßrequire_all 'app'
require 'rest-client'
require 'json'
require 'pry'


def greeting
  puts "Greetings! Welcome to the Pokemon battle grounds. To start please enter your name: "
  input = gets.chomp
  user = User.create(name: input)
  puts "Welcome #{input}"
  user
end

def comp
  User.create(name: "comp")
end

# def pick_ten_random
#   puts "please choose a pokemon from a below list"
#   print Pokemon.name.sample(10)
# end

def get_character_from_user(user, comp)
  count = 0
  pokemon_options = Pokemon.all.sample(10).map { |p| p.name  }
  instance = ["first", "second", "third"]
  puts "Before you can play you must catch your pokemon to build your team. Your Pokemon options are:"
  pokemon_options.each_with_index { |p, i| puts "#{i + 1}: #{p}"}
  while count < 3
    puts "Please select your #{instance[count]} pokemon from the above list."
    pokemon_choice = gets.chomp
    chosen_pokemon = Pokemon.find_by(name: pokemon_options[pokemon_choice.to_i - 1])
    UserPokemon.create(user: user, pokemon: chosen_pokemon)
    # pokemon_options.delete(pokemon_options[pokemon_choice.to_i - 1])
        if pokemon_options.include?(pokemon_options[pokemon_choice.to_i - 1]) && pokemon_options[pokemon_choice.to_i - 1]
          puts "Thank you #{pokemon_options[pokemon_choice.to_i - 1]} has been added to your team"
          count += 1
          pokemon_options[pokemon_choice.to_i - 1] = nil
        else
          puts "That is an invalid choice, please choose one of the pokemon listed above."
        end
    end
    3.times do
      pokemon_options.delete_if {|pokemon| pokemon == nil}
      random_pokemon = pokemon_options.sample
      new_pokemon = Pokemon.find_by(name: random_pokemon)
      UserPokemon.create(user: comp, pokemon: new_pokemon)
      pokemon_options.delete(random_pokemon)
    end
end
