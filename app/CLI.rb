#MAKE A LIST OF THE SEQUENCE OF COMMANDS

require 'rest-client'
require 'json'
require "pry"


def get_fav_language(user_instance)
  #gets the fav language from user if user logs into CLI for first time
  puts "Please tell us your main programming language:"
  favorite_language = STDIN.gets.chomp
  user_instance.fav_language = favorite_language
  return favorite_language
  #returns the users favorite language to use in other methods
end

def saving_query(user,language)
  #asks if the user would like to save his info
  puts "Would you like to save the information? (y/n)"
  answer = STDIN.gets.chomp
  if answer == "y"
    #saves the user to database
    user.save
    "Your profile has been saved."
  elsif answer == "n"
    #tells the user that his data isn't saved
    puts "You are browsing the listings anonymously."
  else
    #if the user is an idiot, ask him again
    puts 'Please answer "y" or "n" '
    saving_query(user,language)
  end
  user
end


def welcome_user
  #returns user
  puts "Welcome to the GitHub job listings CLI. Please enter your name:"
  username = STDIN.gets.chomp
  user_search = User.all.find_or_create_by(name: username)
  #looks the user up in the DB by name
  puts "Welcome, #{username}."
  user_search
end

def make_query_empty?(query)
  #in case the user doesn't want to search by a certain criteria, make it nil
  if query == 0
    query = nil
  end
end

def search_query(user)
  puts "Would you like to search by [C]ity, [L]anguage or [J]ob keyword? /n [E]xit"

  city = ''
  language = ''
  job = ''
  loop do
    choice = STDIN.gets.chomp.upcase
    case choice
    when 'C'
      puts "Please enter the city:"
      city = STDIN.gets.chomp
    when 'L'
      puts "Please enter your favourite language:"
      lang = STDIN.gets.chomp
    when 'J'
      puts "Please enter a keyword e.g 'Full-Stack'"
      keywords = STDIN.gets.chomp
      #when writing calling method check for spelling (i.e. join(-), split, join(' '), etc...)
    when 'E'
      "Goodbye! Thank you for visiting our jobsearch."
    end
  end

  #if user_input == "L"
  make_query_empty?(sal)
  hash= {city: city, fav_language: lang}
  #collects all the data and shoves in a hash.
  #the method is defined in case of looping:
  def would_you_like_to_save(user,hash)
    puts "Would you like to save these details for future searches? y/n"
    answer=STDIN.gets.chomp
      if ans="y"
        user.update(hash)
      elsif ans="n"
        puts "Okay, browsing as incognito"
      else
        puts "Please choose y or n"
        would_you_like_to_save
      end
  end
  #the saving method is called here:
  would_you_like_to_save(user,hash)
  #ASK IF YOU LIKE TO SAVE
  #if yes
  #user.language = lang
  # user.city=city
  # user.salary=sal
  #user.update(hash)
  #else
  #search dont save  use hash.



  #
  # query = {}
  #


  #needs methods to shove fav city, lang and sal into
  #user db (by city and job IDs)



end



####CALLING FUNCTIONS###
#patrick=User.second
# user=welcome_user
# search_query(user)

#binding.pry
0

#Try to implement a loading bar

# def listings_count(returned_results_array_or_hash)
#   puts "A total of #{returned_results_array_or_hash.count} listings has been found."
# end

# url = 'https://api.spotify.com/v1/search?type=artist&q=tycho'
# response = RestClient.get(url)
# JSON.parse(response)
