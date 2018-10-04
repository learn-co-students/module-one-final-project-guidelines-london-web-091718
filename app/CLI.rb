#MAKE A LIST OF THE SEQUENCE OF COMMANDS
require 'rest-client'
require 'tty-prompt'
require 'json'
require "pry"

def exit?(parameter)
  #if user types "exit" - quits the app
  if parameter.downcase=="exit"
    puts "Goodbye! Thank you for visiting our tech jobsearch."
    exit(0)
  end
  return parameter
end


def welcome_user
  #returns user
  puts Rainbow("Welcome to our tech jobsearch! Please enter your name:").green
  username = STDIN.gets.chomp
  exit?(username)
  @user=username
  user_search = User.all.find_or_create_by(name: username)
  #looks the user up in the DB by name
  puts "Welcome, #{username}."
  user_search
end


def search_query(user)
  #asks the user what he would like to search for
  city = ''
  lang = ''
  keywords = ''
  search_parameter=Hash.new(0)

  puts Rainbow("Please enter the city:").green
  puts "Press enter to search by language instead. You can enter 'exit' to exit anytime."
  city = STDIN.gets.chomp
  history?(city,user)
  exit?(city)
  search_parameter[:city]=city

  puts Rainbow("Please enter your preferred programming language:").green
  lang = STDIN.gets.chomp
  search_parameter[:language]=lang
  history?(lang,user)
  exit?(lang)
  puts Rainbow("Please enter a keyword e.g 'Full-Stack'").green
  keywords = STDIN.gets.chomp
  search_parameter[:keywords]=keywords

  history?(keywords,user)
  exit?(keywords)
  would_you_like_to_save(user, search_parameter)
  return search_parameter
end



def would_you_like_to_save(user,data_hash)
    #method for requesting user to save data to db:
  puts "Would you like to save these details for future searches? [Y]es or [N]o?"
  ans=STDIN.gets.chomp.downcase
  history?(ans,user)
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
end

def result_list(job_search_results)
  list_of_results= []
  i = 1
  job_search_results.each do |result|
    Job.format_result(result,i, false)
    i+=1
    list_of_results << result
  end
  if list_of_results.length==0
    puts "Sorry, no results found. Please try to search again! The CLI will now close."
    exit(0)
  end
  list_of_results
end

def chosen_job(list_of_results)
  prompt = TTY::Prompt.new
  prompty=prompt.multi_select("Select a listing", list_of_results.map {|m| m["title"]})
  if prompty.length==0
    puts "Please select with space and then hit enter"
    chosen_job(list_of_results)
  end
  chosen_job=list_of_results.find{|hash| hash["title"]==prompty[0]}
  puts Job.format_result(chosen_job, "", true)
  return chosen_job
end

def more_results_with_error_test(chosen_job,job_results_function)
  #job_results_function needs to be passed ^ so we can return to main menu
  puts "Would you like to see more info about the city?"
  city_more=gets.chomp
  history?(city_more,@user)
  exit?(city_more)
  if chosen_job['location'].downcase=="remote"
    "Sorry, this city does not exist. Please restart the CLI."
  end
  if city_more == "n"
    puts "Thanks for using the CLI :)"
    exit(0)
  elsif city_more=="y"
    #loads city info and stores in city db
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
        # show sad_cat.jpg
    else
        puts "Fetching information about #{city_variable}"
        categories =  JSON.parse(resp)["categories"]
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

def store_cityjob_in_database(city,job,city_stats,user="")
  #read this once again ^
  hash={}
  ncm=city_stats.map{|(k,v)| [k.to_sym,v]}
  ncm.each do |arr|
    hash[arr[0]]=arr[1]
  end
  c=City.find_or_create_by(name: city)
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
  new_command=argument
  if argument.downcase=="history"
    puts "Here's the user search history:"
    located_cityjob=CityJob.all.find_by(user: user)
    if located_cityjob
      puts "User: " + located_cityjob.user.name
      puts "Job: " + located_cityjob.job.title
      puts "Location: "+located_cityjob.city.name
    end
    puts "How would you like to continue?"
    new_command=gets.chomp
  end
  new_command
end
