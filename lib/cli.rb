#ßrequire_all 'app'
require 'rest-client'
require 'json'
require 'pry'
require 'terminal-table'

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
  puts "Greetings young Pokemon Trainer! Welcome to the Pokemon battle grounds."

  username = get_user_name
  @user = User.create(name: username)
  puts "Greetings #{username.capitalize}"
  @user
end

def comp
  @comp = User.create(name: "comp")
end

def get_character_from_user(user, comp)
  count = 0
  pokemon_options = Pokemon.all.sample(10).map { |p| p.name  }
  instance = ["first", "second", "third"]
  puts "Before you can play you must catch your pokemon to build your team. Your Pokemon options are:"
  pokemon_options.each_with_index { |p, i| puts "#{i + 1}: #{p.capitalize}"}
  while count < 3
    puts "Catch your #{instance[count]} pokemon from the above list by entering their corresponding number. \n Please note that you cannot choose the same Pokemon twice"
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
    v.add_row  ["Your Pokemon Team", "The Computer's Pokemon Team"]
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


def winner_or_loser
  winner = "  dP    dP                      dP   dP   dP oo
  Y8.  .8P                      88   88   88
   Y8aa8P  .d8888b. dP    dP    88  .8P  .8P dP 88d888b.
     88    88'  `88 88    88    88  d8'  d8' 88 88'  `88
     88    88.  .88 88.  .88    88.d8P8.d8P  88 88    88
     dP    `88888P' `88888P'    8888' Y88'   dP dP    dP
  ooooooooooooooooooooooooooooooooooooooooooooooooooooooo
  "

  loser = "dP    dP                      dP
Y8.  .8P                      88
 Y8aa8P  .d8888b. dP    dP    88 .d8888b. .d8888b. .d8888b.
   88    88'  `88 88    88    88 88'  `88 Y8ooooo. 88ooood8
   88    88.  .88 88.  .88    88 88.  .88       88 88.  ...
   dP    `88888P' `88888P'    dP `88888P' `88888P' `88888P'
oooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
                                                            "
  puts winner
  puts loser
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
end


# def delete_user_table
#   User.destroy_all
# end
#
#
# def delete_userpokemon_table
#   UserPoke.destroy_all
# end
