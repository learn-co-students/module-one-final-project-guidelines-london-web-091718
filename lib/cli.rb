# require 'rest-client'
# require 'json'
require 'pry'
# require 'tco'
# require 'rmagick'


def greeting
  puts "Greetings! Welcome to the Pokemon battle grounds. \n To start please enter your name: "
  input = gets.chomp
  User.create(name: input)
  puts "Welcome #{input}"
end
#
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


############################



def round(player_pokemon, comp_pokemon, dice)
  if dice == 1
    comp_pokemon.pokemon.health -= player_pokemon.pokemon.attack #user attacks

  else
    player_pokemon.pokemon.health -= comp_pokemon.pokemon.attack #comp attacks
  end
end


def stats(player_pokemon, comp_pokemon)
  puts "\nYour Pokemon Stats:"
  puts "  Name: #{player_pokemon.pokemon.name.capitalize}\n  Health: #{player_pokemon.pokemon.health}\n  Attack: #{player_pokemon.pokemon.attack}  \n"


  puts "\nComputer Pokemon Stats:"
  puts "  Name: #{comp_pokemon.pokemon.name.capitalize}\n  Health: #{comp_pokemon.pokemon.health}\n  Attack: #{comp_pokemon.pokemon.attack}  \n"
end

def fight(player_pokemon, comp_pokemon)
  puts "\n***** PRE-FIGHT STATS *****"
  stats(player_pokemon, comp_pokemon)
  puts "\n***************************\n"


  dice = rand(1..2)
  round = 1

  sleep (2)


  while (comp_pokemon.pokemon.health >= 0 && player_pokemon.pokemon.health >= 0)
    puts "\n***** ROUND #{round} *****"
    round(player_pokemon, comp_pokemon, dice)
    stats(player_pokemon, comp_pokemon)
    if dice == 1
      dice = 2
    else dice = 1
    end
    round += 1
    puts ""
    sleep (0.5)
  end

  if player_pokemon.pokemon.health.to_i <= 0
    puts "Your Pokemon #{player_pokemon.pokemon.name.capitalize} has been defeated"
    puts "FIGHT FINSIH \n"

    comp_pokemon.won += 1
    comp_pokemon.save

  elsif comp_pokemon[:health].to_i <= 0
    puts "The Computer's Pokemon #{comp_pokemon.pokemon.name.capitalize} has been defeated"
    puts "FIGHT FINSIH \n"

    player_pokemon.won += 1
    player_pokemon.save

  end
end

def winner(player_pokemons, comp_pokemons)

   if player_pokemons.map {|w| w.won}.sum > comp_pokemons.map {|w| w.won}.sum
     # puts "this player's id number is: #{player_pokemons.first.user_id}"
     @user = User.all.find { |user| user.id == player_pokemons.first.user_id}
     # puts "this user is #{@user}"
     puts "Congrats, #{@user.name}! You won!"
     # puts "Congrats #{User.find_by(id: 2).name}! You've won!"
   else
     puts "Aw shucks! You lost!"
   end
end



# print 'eof'
