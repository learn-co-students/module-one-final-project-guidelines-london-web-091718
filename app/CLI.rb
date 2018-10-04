#MAKE A LIST OF THE SEQUENCE OF COMMANDS
require 'tty-prompt'
require 'rest-client'
require 'json'
require "pry"
@@user=""

def exit?(parameter)
  if parameter.downcase=="exit"
    puts "Goodbye! Thank you for visiting our tech jobsearch."
    exit(0)
  end
  return parameter
end


def get_fav_language(user_instance)
  #gets the fav language from user if user logs into CLI for first time
  puts "Please tell us your main programming language:"
  favourite_language = STDIN.gets.chomp
  exit?(favourite_language)
  user_instance.fav_language = favourite_language
  return favourite_language
  #returns the users favorite language to use in other methods
end

def saving_query(user,language)
  #CURRENTLY UNUSED
  #asks if the user would like to save his info
  puts "Would you like to save the information? (y/n)"
  answer = STDIN.gets.chomp
  exit?(answer)
  if answer == "y"
    @@user=user
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
  exit?(username)
  user_search = User.all.find_or_create_by(name: username)
  #looks the user up in the DB by name
  puts "Welcome, #{username}."
  user_search
end



def search_query(user)
  city = ''
  lang = ''
  keywords = ''
  search_parameter=Hash.new(0)


  puts Rainbow("Please enter the city:").green
  puts "Press enter to search by language instead. You can enter 'exit' to exit anytime."
  city = STDIN.gets.chomp
  exit?(city)
  history?(city,user)
  search_parameter[:city]=city

  puts Rainbow("Please enter your preferred programming language:").green
  lang = STDIN.gets.chomp
  search_parameter[:language]=lang

  exit?(lang)
  history?(lang,user)
  puts Rainbow("Please enter a keyword e.g 'Full-Stack'").green
  keywords = STDIN.gets.chomp
  search_parameter[:keywords]=keywords

  exit?(keywords)
  history?(keywords,user)
  puts search_parameter
  would_you_like_to_save(user, search_parameter)
  return search_parameter

end


  #method for requesting user to save data to db:
  def would_you_like_to_save(user,data_hash)
    puts "Would you like to save these details for future searches? [Y]es or [N]o"
    ans=STDIN.gets.chomp.downcase
    exit?(ans)
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
    list_of_results
  end

  def chosen_job(list_of_results)
    # FORCE IT TO_INTEGERT
    #take care of this (if finds 0 results or if user inputs fdsfdsfsd )
    puts "Select a number from the above list to view further job details"
    chosen_job_num = gets
    if (chosen_job_num.to_i.is_a? Integer)==false
      puts "Please select a valid listing!"
      chosen_job(list_of_results)
    elsif chosen_job_num.to_i>list_of_results.length
      puts "Please select a valid listing!"
      chosen_job(list_of_results)
    else
      chosen_job = list_of_results[chosen_job_num.to_i - 1]
      puts Job.format_result(list_of_results[chosen_job_num.to_i - 1], chosen_job_num, true)
      puts ""
    end
      return chosen_job
  end


  def more_results_with_error_test(chosen_job,job_results_function)
    #list of results needs to be passed ^ so we can return to main menu
    puts "Would you like to see more info about the city?"
    city_more=gets.chomp
    exit?(city_more)
    if city_more == "n"
    elsif city_more=="y"
      puts "Loading city information..."
      city_variable = chosen_job['location'].downcase.split(",").split("(").split("-")[0][0][0].split(" ").join("-")
      # binding.pry
      begin
        resp =RestClient.get("https://api.teleport.org/api/urban_areas/slug:#{city_variable}/scores/")
      rescue RestClient::Unauthorized, RestClient::Forbidden => err
        puts 'Access denied'
        return err.response
      rescue RestClient::ExceptionWithResponse => err
        puts 'Sorry, we are unable to find any info on that City at themoment :(. We will return you back to the results page.'
        #if it fails to find anything, take the user back to the searchscreen (run method on line 20 again)
        # show sad_cat.jpg
      else
          puts "Fetching information about #{city_variable}"
          categories =  JSON.parse(resp)["categories"]
        #  binding.pry
          categories.each do |c|
            puts Rainbow("#{c['name']} : ").color(c['color']) + c['score_out_of_10'].to_i.to_s + " / 10"
          end#each
          store_cityjob_in_database(chosen_job["location"], chosen_job["title"],formatting_categories(categories))
      end#rescue
    else
      puts "please provide a valid command"
      more_results_with_error_test(chosen_job,job_results_function)
    end#if
  end#def


  def formatting_categories(categories)
    #used to format categories into an acceptable hash format to direectly update the Class cityjobs
    cats=Hash.new(0)
    categories.each do |c|
      key=c["name"]
      value=c["score_out_of_10"]
      cats[key]=value.to_s.to_i.to_s + " /10"
    end
    cats
  end

def store_cityjob_in_database(city,job,city_stats,url="")
  #read this once again ^
  hash={}
  ncm=city_stats.map{|(k,v)| [k.to_sym,v]}
  ncm.each do |arr|
    hash[arr[0]]=arr[1]
  end
  #binding.pry

  c=City.new
  c.name=city
  j=Job.new
  j.title=job
  cityjob=CityJob.new
  cityjob.name=("#{city} - #{job}")
  cityjob.city=c
  cityjob.job=j
  cityjob.city.update(hash)
  c.save
  j.save
  cityjob.save
  puts "Your search has been added to your search history"
  puts "Enter anything to return back to the result list"
  puts ""
  gets
  puts "Returning you to the results list..."
  puts ""
  return cityjob
end

def history?(argument,user)
#  binding.pry
  if argument=="history"
    puts user
  end
end
