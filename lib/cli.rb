
# require 'rest-client'
# require 'json'
# require 'pry'


def greeting
  puts "Greetings! Welcome to the Pokemon battle grounds. \n To start please enter your name: "
  input = gets.chomp
  User.create(name: input)
  puts "Welcome #{input}"
end

# def pick_ten_random
#   puts "please choose a pokemon from a below list"
#   print Pokemon.name.sample(10)
# end

def get_character_from_user
  count = 0
  pokemon_options = Pokemon.all.sample(10).map { |p| p.name  }
  instance = ["first", "second", "third"]
  puts "Before you can play you must catch your pokemon to build your team. Your Pokemon options are:"
  pokemon_options.each_with_index { |p, i| puts "#{i + 1}: #{p}"}
  while count < 3
    puts "Please select your #{instance[count]} pokemon from the above list."
    pokemon_choice = gets.chomp.to_i
        if pokemon_options[pokemon_choice - 1]
          puts "Thank you #{pokemon_options[pokemon_choice - 1]} has been added to your team"

          count += 1
        else
          puts "That is an invalid choice, please choose one of the pokemon listed above."
        end
    end
end
