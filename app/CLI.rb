
def welcome_user
  puts "Welcome to the GitHub job listings CLI. Please enter your name:"
  username = gets.chomp
  #shove username into the user db

  puts "Hello #{username}"
end

def get_fav_language
  #gets the fav language from user
  puts "Please tell us your main programming language:"
  language = gets.chomp
  #assign to user in db
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
