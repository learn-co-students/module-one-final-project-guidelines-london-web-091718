#MAKE A LIST OF THE SEQUENCE OF COMMANDS

require 'rest-client'
require 'json'
require "pry"


def get_fav_language(user_instance)
  #gets the fav language from user if user logs into CLI for first time
  puts "Please tell us your main programming language:"
  favorite_language = gets.chomp
  user_instance.fav_language = favorite_language
  return favorite_language
  #returns the users favorite language to use in other methods
end

def saving_query(user,language)
  #asks if the user would like to save his info
  puts "Would you like to save the information? (y/n)"
  answer = gets.chomp
  if answer == "y"
    #saves the user to database
    user.save
    "Your profile has been saved."
  elsif answer == "n"
    #tells the user that his data isn't saved
    puts "You are browsing the listings as incognito."
  else
    #if the user is an idiot, ask him again
    puts 'Please answer "y" or "n" '
    saving_query
  end
  user
end


def welcome_user
  #returns user
  puts "Welcome to the GitHub job listings CLI. Please enter your name:"
  username = gets.chomp
  user_search = User.all.find_by(name: username)
  #looks the user up in the DB by name
  if user_search.nil? == false || user_search.length>0
    #if the user exists - welcomes him back
    puts "Welcome back, #{username}."
    current_user = user_search
  else
    #if the user wasn't found - creates new User
    current_user = User.new(name: username)
    puts "Nice to meet you #{username}"
    #asks for his favorite language and asks if he would like to save it
    fav_language = get_fav_language(current_user)
    saving_query(current_user,fav_language)
  end
  current_user
end

def make_query_empty?(query)
  #in case the user doesn't want to search by a certain criteria, make it nil
  if query == 0
    query = nil
  end
end

def search_query
  #asks the user for the search criteria. Changes to nil if "0"
  puts "Please input the details for your search. Enter 0 if you would like to leave the field blank."
  puts "Search by language:"
  lang = gets.chomp
  make_query_empty?(lang)
  puts "By city:"
  city = gets.chomp
  make_query_empty?(city)
  puts "By salary:"
  sal = gets.chomp
  make_query_empty?(sal)
  #collects all the data and shoves in a hash.
  return {salary: sal, city: city, language: lang}
end




####CALLING FUNCTIONS###
user=welcome_user
search_query

binding.pry
0

#Try to implement a loading bar

# def listings_count(returned_results_array_or_hash)
#   puts "A total of #{returned_results_array_or_hash.count} listings has been found."
# end

# url = 'https://api.spotify.com/v1/search?type=artist&q=tycho'
# response = RestClient.get(url)
# JSON.parse(response)
