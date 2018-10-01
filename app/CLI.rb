def get_fav_language(user_instance)
  #gets the fav language from user if user logs into CLI for first time
  puts "Please tell us your main programming language:"
  favorite_language = gets.chomp
  user_instance.fav_language=favorite_language
  return favorite_language
  #returns the users favorite language to use in other methods
end

def saving_query(user,language)
  #asks if the user would like to save his info
  puts "Would you like to save the information? (y/n)"
  answer=gets.chomp
  if answer=="y"
    #saves the user to database
    user.save
    "Your profile has been saved."

  elsif answer=="n"
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
  puts "Welcome to the GitHub job listings CLI. Please enter your name:"
  username = gets.chomp
  user_search=User.all.find_by(name: username)
  #looks the user up in the DB by name
  if user_search==true
    #if the user exists - welcomes him back
    puts "Welcome back, #{username}."
    current_user=user_search
  else
    #if the user wasn't found - creates new User
    current_user=User.new(name: username)
    puts "Nice to meet you #{username}"
    #asks for his favorite language and asks if he would like to save it
    fav_language=get_fav_language(current_user)
    saving_query(current_user,fav_language)
  end
  current_user
end


def search_query
  #asks the
  puts "How would you like to search for listings? You can search by"
  puts "l - by language"
  puts "c - by city"
  puts "s - by salary"
  gets.chomp
end

#Try to implement a loading bar

def listings_count(returned_results_array_or_hash)
  puts "A total of #{returned_results_array_or_hash.count} listings has been found."
end
