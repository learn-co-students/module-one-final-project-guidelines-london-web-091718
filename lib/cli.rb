# require 'rest-client'
# require 'json'
# require 'tco'
# require 'rmagick'
#ßrequire_all 'app'
require 'rest-client'
require 'json'
require 'pry'
require 'terminal-table'
require 'rainbow'

def get_user_name
  username = ''
  is_invalid = true
  while is_invalid do
    puts 'To start please enter your name: '
    username = gets.chomp

    if username.to_i != 0 || username == '0'
      username = get_user_name
    end

    if username.class == String && username.length > 0
      is_invalid = false
    end
  end
  username
end


def greeting
  pokemon_ruby = Rainbow("
 _______  _______  ___   _  _______  __   __  _______  __    _
|       ||       ||   | | ||       ||  |_|  ||       ||  |  | |
|    _  ||   _   ||   |_| ||    ___||       ||   _   ||   |_| |
|   |_| ||  | |  ||      _||   |___ |       ||  | |  ||       |
|    ___||  |_|  ||     |_ |    ___||       ||  |_|  ||  _    |
|   |    |       ||    _  ||   |___ | ||_|| ||       || | |   |
|___|    |_______||___| |_||_______||_|   |_||_______||_|  |__|
               ______    __   __  _______  __   __
              |    _ |  |  | |  ||  _    ||  | |  |
              |   | ||  |  | |  || |_|   ||  |_|  |
              |   |_||_ |  |_|  ||       ||       |
              |    __  ||       ||  _   | |_     _|
              |   |  | ||       || |_|   |  |   |
              |___|  |_||_______||_______|  |___|
").red
  puts pokemon_ruby
  puts "\nGreetings young Pokemon Trainer! Welcome to the Pokemon battle grounds."

  username = get_user_name
  @user = User.create(name: username)
  puts "\nGreetings #{username.capitalize}"
  @user
end
#
# def pick_ten_random
#   puts "please choose a pokemon from a below list"
#   print Pokemon.name.sample(10)
# end

def comp
  @comp = User.create(name: "comp")
end

def get_character_from_user(user, comp)
  count = 0
  pokemon_options = Pokemon.all.sample(10).map { |p| p.name  }
  instance = ["first", "second", "third"]
  puts "\nBefore you can play, you must catch your Pokemon to build your team. \nYour Pokemon options are:"
  pokemon_options.each_with_index { |p, i| puts "#{i + 1}: #{p.capitalize}"}
  puts "Please note that you cannot choose the same Pokemon twice"
  while count < 3
    puts "\nCatch your #{instance[count]} Pokemon from the above list by entering their corresponding number. \n"
    pokemon_choice = gets.chomp
    chosen_pokemon = Pokemon.find_by(name: pokemon_options[pokemon_choice.to_i - 1])
    UserPokemon.create(user: user, pokemon: chosen_pokemon)
    # pokemon_options.delete(pokemon_options[pokemon_choice.to_i - 1])
        if pokemon_options.include?(pokemon_options[pokemon_choice.to_i - 1]) && pokemon_options[pokemon_choice.to_i - 1]
          puts Rainbow("#{pokemon_options[pokemon_choice.to_i - 1].capitalize} has been added to your team\n").green
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

def find_user_and_comp_pokemon
  my_user_pokemon = UserPokemon.all.select { |userpokemon| userpokemon.user_id == @user.id }
  my_pokemon_name = my_user_pokemon.map { |up| up.pokemon.name.capitalize }
  my_pokemon_health = my_user_pokemon.map { |up| up.pokemon.health}
  my_pokemon_attack = my_user_pokemon.map { |up| up.pokemon.attack}

  comp_user_pokemon = UserPokemon.all.select { |userpokemon| userpokemon.user_id == @comp.id }
  comp_pokemon_name = comp_user_pokemon.map { |up| up.pokemon.name.capitalize }
  comp_pokemon_health = comp_user_pokemon.map { |up| up.pokemon.health}
  comp_pokemon_attack = comp_user_pokemon.map { |up| up.pokemon.attack}
  user_table = Terminal::Table.new do |v|
    v.title = "Let's battle!"
    v.add_row  [Rainbow("Your Pokemon Team").blue, Rainbow("The Computer's Pokemon Team").red]
    v.style = {:width => 80}
  end
  bottom = Terminal::Table.new do |v|
    v.add_row ['Pokemon', 'Health', 'Attack', 'Pokemon', 'Health', 'Attack']
    v.add_separator
    v.add_row [my_pokemon_name[0], my_pokemon_health[0], my_pokemon_attack[0], comp_pokemon_name[0], comp_pokemon_health[0], comp_pokemon_attack[0]]
    v.add_row [my_pokemon_name[1], my_pokemon_health[1], my_pokemon_attack[1], comp_pokemon_name[1], comp_pokemon_health[1], comp_pokemon_attack[1]]
    v.add_row [my_pokemon_name[2], my_pokemon_health[2], my_pokemon_attack[2], comp_pokemon_name[2], comp_pokemon_health[2], comp_pokemon_attack[2]]
    v.style = { :border_top => false,:width => 80}
  end
  puts user_table
  puts bottom
end


############################

  def press_enter_to_continue
    puts "\nPress enter to continue"
    gets.chomp
  end

  def player_pokemon_instances
  UserPokemon.all.select { |userpokemon| userpokemon.user_id == @user.id }
  end

  def comp_pokemon_instances
    UserPokemon.all.select { |userpokemon| userpokemon.user_id == @comp.id }
  end

  # def dice_roll
  #   user_dice = rand(4..6)
  #   comp_dice = rand(1..3)
  #     puts "Dice roll time!"
  #     sleep(0.5)
  #     puts "\nYou have rolled #{user_dice}!"
  #     puts "\nThe Computer has rolled #{comp_dice}!"
  #     puts "\nCONGRATS!!!!! YOU GO FIRST!"
  #     puts "Press enter to start"
  #     gets.chomp
  # end

  # def fight(player_pokemons, comp_pokemons)
  #   count = 0
  #   while count < 3
  #     binding.pry
  #   fight(player_pokemons[count], comp_pokemons[count])
  #   puts "Press enter to run to continue"
  #   gets.chomp
  #   count += 1
  #  end
  # end

def round(player_pokemon, comp_pokemon, dice)
  if dice == 1
    comp_pokemon.pokemon.health -= player_pokemon.pokemon.attack #user attacks

  else
    player_pokemon.pokemon.health -= comp_pokemon.pokemon.attack #comp attacks
  end
  # system "clear"
  # puts "Press enter to continue"
  # gets.chomp
end


def stats(player_pokemon, comp_pokemon)
  puts Rainbow("\nYour Pokemon Stats:").blue
  puts "  Name: #{player_pokemon.pokemon.name.capitalize}\n  Health: #{player_pokemon.pokemon.health}\n  Attack: #{player_pokemon.pokemon.attack}  \n"


  puts Rainbow("\nComputer Pokemon Stats:").red
  puts "  Name: #{comp_pokemon.pokemon.name.capitalize}\n  Health: #{comp_pokemon.pokemon.health}\n  Attack: #{comp_pokemon.pokemon.attack}  \n"

    # puts "Your Pokemon #{player_pokemon.pokemon.name.capitalize}'s health is now #{player_pokemon.pokemon.health}"
    #
    # puts "The Computer's Pokemon #{comp_pokemon.pokemon.name.capitalize}'s health is now #{comp_pokemon.pokemon.health}"
end

def fight(player_pokemon, comp_pokemon)
  puts "\n***** PRE-FIGHT STATS *****"
  stats(player_pokemon, comp_pokemon)
  puts "\n***************************\n"


  dice = rand(1..2)
  round = 1

  sleep (1.5)


  while (comp_pokemon.pokemon.health >= 0 && player_pokemon.pokemon.health >= 0)
    puts "\n***** ROUND #{round} *****"
    # puts Rainbow("\n***** ROUND #{round} *****").yellow
    round(player_pokemon, comp_pokemon, dice)
    stats(player_pokemon, comp_pokemon)
    if dice == 1
      dice = 2
    else dice = 1
    end
    round += 1
    puts ""
    sleep (1)
  end

  if player_pokemon.pokemon.health.to_i <= 0
    puts "******************************************"
    puts "\nFIGHT FINISHED"
    puts Rainbow("\nYour Pokemon #{player_pokemon.pokemon.name.capitalize} has been defeated").red
    puts "******************************************"


    comp_pokemon.won += 1
    comp_pokemon.save

  elsif comp_pokemon[:health].to_i <= 0
    # puts Rainbow("\nThe Computer's Pokemon #{comp_pokemon.pokemon.name.capitalize} has been defeated").red
    puts "******************************************"
    puts "\nFIGHT FINISHED"
    puts Rainbow("\nYour Pokemon #{player_pokemon.pokemon.name.capitalize} has won.").blue
    puts "\n******************************************"

    player_pokemon.won += 1
    player_pokemon.save

  end
end

def winner(player_pokemons, comp_pokemons)

  winner = Rainbow("  dP    dP                      dP   dP   dP oo
  Y8.  .8P                      88   88   88
   Y8aa8P  .d8888b. dP    dP    88  .8P  .8P dP 88d888b.
     88    88'  `88 88    88    88  d8'  d8' 88 88'  `88
     88    88.  .88 88.  .88    88.d8P8.d8P  88 88    88
     dP    `88888P' `88888P'    8888' Y88'   dP dP    dP
  ooooooooooooooooooooooooooooooooooooooooooooooooooooooo
  ").green

  loser = Rainbow("dP    dP                      dP
Y8.  .8P                      88
 Y8aa8P  .d8888b. dP    dP    88 .d8888b. .d8888b. .d8888b.
   88    88'  `88 88    88    88 88'  `88 Y8ooooo. 88ooood8
   88    88.  .88 88.  .88    88 88.  .88       88 88.  ...
   dP    `88888P' `88888P'    dP `88888P' `88888P' `88888P'
oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
                                                            ").red
puts
   if player_pokemons.map {|w| w.won}.sum > comp_pokemons.map {|w| w.won}.sum
     # puts "this player's id number is: #{player_pokemons.first.user_id}"
     @user = User.all.find { |user| user.id == player_pokemons.first.user_id}
     # puts "this user is #{@user}"
     puts "Congrats, #{@user.name}!\n"
     puts winner
     # puts "Congrats #{User.find_by(id: 2).name}! You've won!"
   else
     puts loser

   end
end



# print 'eof'




 #def winner_or_loser

#   puts loser
  #   winner = Terminal::Table.new do |v|
  #     table.style = {:width => 40, :padding_left => 3, :border_x => "=", :border_i => "x"}
  #     v.title = "You Win!"
  #   end
  #   # my_user_pokemon = UserPokemon.all.select { |userpokemon| userpokemon.user_id == @user.id }
  #   # my_pokemon_health = my_user_pokemon.map { |up| up.pokemon.health}
  #   # comp_user_pokemon = UserPokemon.all.select { |userpokemon| userpokemon.user_id == @comp.id }
  #   # comp_pokemon_health = comp_user_pokemon.map { |up| up.pokemon.health}
  #   # binding.pry
  #   #
  #   # if my_pokemon_health > comp_pokemon_health
  #   #   puts "you win"
  #   # else
  #   #   puts "you win"
  #   # end
  #
 #end

# def delete_user_table
#   User.destroy_all
# end
#
#
# def delete_userpokemon_table
#   UserPoke.destroy_all
# end
#   UserPoke.destroy_all
# end
