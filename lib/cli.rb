#ßrequire_all 'app'
require 'rest-client'
require 'json'
require 'pry'
require 'terminal-table'


def greeting
  puts "Greetings! Welcome to the Pokemon battle grounds. To start please enter your name: "
  input = gets.chomp
  @user = User.create(name: input)
  puts "Welcome #{input}"
  @user
end

def comp
  @comp = User.create(name: "comp")
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

def find_users_pokemon
  my_user_pokemon = UserPokemon.all.select { |userpokemon| userpokemon.user_id == @user.id }
  my_pokemon_name = my_user_pokemon.map { |up| up.pokemon.name.capitalize }
  my_pokemon_health = my_user_pokemon.map { |up| up.pokemon.health}
  my_pokemon_attack = my_user_pokemon.map { |up| up.pokemon.attack}
  # puts "your pokemon are: #{my_pokemon_name}"
  user_table = Terminal::Table.new do |v|
    v.title = "Your Pokemon Team"
    v.headings = 'Pokemon', 'Health', 'Attack'
    v.add_row [my_pokemon_name[0], my_pokemon_health[0], my_pokemon_attack[0]]
    v.add_row [my_pokemon_name[1], my_pokemon_health[1], my_pokemon_attack[1]]
    v.add_row [my_pokemon_name[2], my_pokemon_health[2], my_pokemon_attack[2]]
  end
  puts user_table
end

def find_comp_pokemon
  comp_user_pokemon = UserPokemon.all.select { |userpokemon| userpokemon.user_id == @comp.id }
  comp_pokemon_name = comp_user_pokemon.map { |up| up.pokemon.name.capitalize }
  comp_pokemon_health = comp_user_pokemon.map { |up| up.pokemon.health}
  comp_pokemon_attack = comp_user_pokemon.map { |up| up.pokemon.attack}
  # puts "your pokemon are: #{my_pokemon_name}"
  user_table = Terminal::Table.new do |v|
    v.title = "The Computer's Pokemon Team"
    v.headings = 'Pokemon', 'Health', 'Attack'
    v.add_row [comp_pokemon_name[0], comp_pokemon_health[0], comp_pokemon_attack[0]]
    v.add_row [comp_pokemon_name[1], comp_pokemon_health[1], comp_pokemon_attack[1]]
    v.add_row [comp_pokemon_name[2], comp_pokemon_health[2], comp_pokemon_attack[2]]
  end
  puts user_table
end

# def user_pokemon
#   puts User.all.find_by(id: 1)
# end
# user_table = Terminal::Table.new do |v|
#   v.title = "Your Pokemon Team"
#   v.headings = 'Pokemon', 'Health', 'Attack'
#   v.add_row [1, greeting]
#   # v << %w(  )
#   # v << %w( Bob Someone bob@vision-media.ca )
#   # v << %w( Joe Whatever bob@vision-media.ca )
# end
# puts user_table
#
# comp_table = Terminal::Table.new do |v|
#   v.title = "The Computers Pokemon Team"
#   v.headings = 'Pokemon', 'Health', 'Attack'
#   v << %w( TJ Holowaychuk tj@vision-media.ca )
#   v << %w( Bob Someone bob@vision-media.ca )
#   v << %w( Joe Whatever bob@vision-media.ca )
# end
# puts comp_table


# def delete_user_table
#   User.destroy_all
# end
#
#
# def delete_userpokemon_table
#   UserPoke.destroy_all
# end
