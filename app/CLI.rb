#MAKE A LIST OF THE SEQUENCE OF COMMANDS

require 'rest-client'
require 'json'
require "pry"


def get_fav_language(user_instance)
  #gets the fav language from user if user logs into CLI for first time
  puts "Please tell us your main programming language:"
  favourite_language = STDIN.gets.chomp
  user_instance.fav_language = favourite_language
  return favourite_language
  #returns the users favorite language to use in other methods
end

def saving_query(user,language)
  #CURRENTLY UNUSED
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
  #CURRENTLY UNUSED
  if query == 0
    query = nil
  end
end

def search_query(user)
  #as of now this method does not save anything to db, just searches.
  puts "Would you like to search by [C]ity, [L]anguage or [J]ob keyword? /n [E]xit"
  city = ''
  language = ''
  job = ''
  search_parameter=Hash.new(0)
  #TRY USING WHILE OR SOMETHING THAT DOES NOT EXIT
  loop do
    choice = STDIN.gets.chomp.upcase
    case choice
    when 'C'
      puts "Please enter the city:"
      city = STDIN.gets.chomp
      search_parameter  [:city]=city
    when 'L'
      puts "Please enter your favourite programming language:"
      lang = STDIN.gets.chomp
      search_parameter[:language]=lang
    when 'J'
      puts "Please enter a keyword e.g 'Full-Stack'"
      keywords = STDIN.gets.chomp
      search_parameter[:keywords]=keywords
      #when writing calling method check for spelling (i.e. join(-), split, join(' '), etc...)
    when 'E'
      "Goodbye! Thank you for visiting our tech jobsearch."
      # Would you like to search again?"
      exit(0)
    else
      search_query(user)
    end
    return search_parameter
    #returns search hash {type => actual_query}
  end
  would_you_like_to_save(user, search_parameter)
end


  #method for requesting user to save data to db:
  def would_you_like_to_save(user,data_hash)
    puts "Would you like to save these details for future searches? [Y]es or [N]o"
    ans=STDIN.gets.chomp.downcase
      if ans == "y"
        user.update(data_hash)
      elsif ans == "n"
      else
        puts "Please choose y or n"
        would_you_like_to_save(user,data_hash)
      end
  end

  # puts Rainbow("\nSymptoms of #{self.name}\n").color("#203259").bright + Rainbow(Format.wrap("\n\n#{self.symptoms[10..-1]}", 70)).color("#191921").gsub('\n  \t\t\n  \t\t', " ")


########################
####CALLING FUNCTIONS###

#patrick=User.second
# user=welcome_user
# job_query=search_query(user)
#job_search=Patrick's_method(job_query)

#######################
#######################


# url = 'https://api.spotify.com/v1/search?type=artist&q=tycho'
# response = RestClient.get(url)
# JSON.parse(response)
