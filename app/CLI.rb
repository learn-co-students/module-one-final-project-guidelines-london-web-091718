#MAKE A LIST OF THE SEQUENCE OF COMMANDS

require 'rest-client'
require 'json'
require "pry"


def exit?(parameter)
  if parameter=="exit"
    puts "Goodbye! Thank you for visiting our tech jobsearch."
    exit(0)
  end
end


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

def make_query_empty?(query)
  #CURRENTLY UNUSED
  if query == 0
    query = nil
  end
end

def welcome_user
  #returns user
  puts "Welcome to our tech jobsearch! Please enter your name:"
  username = STDIN.gets.chomp
  user_search = User.all.find_or_create_by(name: username)
  #looks the user up in the DB by name
  puts "Welcome, #{username}."
  user_search
end



def search_query(user)
  city = ''
  language = ''
  job = ''
  search_parameter=Hash.new(0)


  puts Rainbow("Please enter the city:").green
  puts "Press enter to search by language instead. Enter 'exit' to exit"
  city = STDIN.gets.chomp
  search_parameter[:city]=city

  exit?(city)
  puts Rainbow("Please enter your favourite programming language:").green
  puts "Press enter to search by keyword instead. Enter 'exit' to exit"
  lang = STDIN.gets.chomp
  search_parameter[:language]=lang

  exit?(lang)
  puts Rainbow("Please enter a keyword e.g 'Full-Stack'").green
  puts "Press enter if you have finished. Enter 'exit' to exit"
  keywords = STDIN.gets.chomp
  search_parameter[:keywords]=keywords

  exit?(keywords)
  puts search_parameter
  would_you_like_to_save(user, search_parameter)
  return search_parameter

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


  def job_search_results(job_query)
    puts "Loading Jobs..."
    url = Job.base_url(job_query[:keywords],job_query[:language],job_query[:city])
    response = RestClient.get(url)
    puts url
    JSON.parse(response)
    #binding.pry
  #  binding.pry
  end

  def result_list(job_search_results)
    list_of_results= []
    i = 1
    job_search_results.each do |result|
      Job.format_result(result,i, false)
      i+=1
      list_of_results << result
    end
  end

  def chosen_job(list_of_results)
    chosen_job_num = 800
    while chosen_job_num != 'q' && (chosen_job_num.is_a? Integer)
      puts "Select a number from the above list to view further job details"
      #check if the user selected the correct listing
      chosen_job_num = gets.chomp
      chosen_job = list_of_results[chosen_job_num.to_i - 1]
      puts Job.format_result(list_of_results[chosen_job_num.to_i - 1], chosen_job_num, true)
      puts ""
      #offer the user to open the listing in his browser using the :url
      return chosen_job
    end
  end


  # =========================================================

  def more_results_with_error_test(chosen_job)
    puts "Would you like to see more info about the city?"
    city_more=gets.chomp
    if city_more=="y"
      puts "Loading city information..."
      city_variable = chosen_job['location'].downcase.split(",").split("(").split("-")[0][0][0].split(" ").join("-")
      # binding.pry
        begin
          resp = RestClient.get("https://api.teleport.org/api/urban_areas/slug:#{city_variable}/scores/")
        rescue RestClient::Unauthorized, RestClient::Forbidden => err
          puts 'Access denied'
          return err.response
        rescue RestClient::ExceptionWithResponse => err
          puts 'Sorry, we are unable to find any info on that City at the moment :('
          #if it fails to find anything, take the user back to the search screen (run method on line 20 again)
          # show sad_cat.jpg
        else
          puts "Fetching information about #{city_variable}"
          categories =  JSON.parse(resp)["categories"]

          categories.each do |c|
            puts Rainbow("#{c['name']} : ").color(c['color']) + c['score_out_of_10'].to_i.to_s + " / 10"
          end#each
          binding.pry
          0
          current_cityjob=CityJob.city.find_or_create(name: city_variable)
          current_cityjob.update(categories)
          current_cityjob.save
          puts "The city and its stats have been added to the database. More functionality unlocked."

          puts "Please use the website to apply for the job if you are interested. Search again if you wishsee other listings."
          #RETURN PERSON BACK TO MENU
        end#rescue
      elsif city_more=="n"#if

    end#if
  end#def


  # puts Rainbow("\nSymptoms of #{self.name}\n").color("#203259").bright + Rainbow(Format.wrap("\n\n#{self.symptoms[10..-1]}", 70)).color("#191921").gsub('\n  \t\t\n  \t\t', " ")




########################
####CALLING FUNCTIONS###



#######################
#######################


# url = 'https://api.spotify.com/v1/search?type=artist&q=tycho'
# response = RestClient.get(url)
# JSON.parse(response)
