def welcome_user
  #returns user
  system "clear"
  puts Rainbow("Welcome to our tech jobsearch! Please enter your name:").green
  username = STDIN.gets.chomp
  #looks the user up in the DB by name
  user = User.all.find_or_create_by(name: username)
  puts Rainbow("\nWelcome, #{username}.").green
  user
end

def show_history(user)
  puts "Here's the user search history:"
  located_cityjob=CityJob.all.where(user: user)
  if located_cityjob
    located_cityjob.each do |history|
      puts "User: " + history.user.name
      puts "Job: " + history.job.title
      puts "Location: "+history.city.name
    end
  end
  main_menu(user)
end

def leave_app
  puts Rainbow("\nGoodbye! Thank you for visiting our tech jobsearch.\n").green
  exit(0)
end

def exit?(parameter)
  #if user types "exit" - quits the app
  if parameter.downcase=="exit"
    leave_app
  end
end

def main_menu(user)
  # system "clear"
  # loop do
    puts "\nMain Menu"
    prompt = TTY::Prompt.new
    selection = prompt.select("\nWhat would you like to do?") do |menu|
      menu.default 1

      menu.choice 'Seach for a new job', 1
      menu.choice 'View search history', 2
      menu.choice 'Exit', 3
    end

    case selection
    when 1
      search_query(user)
    when 2
      show_history(user)
    when 3
      leave_app
    end
  # end

end


def search_query(user)
  exit_text = "  #{Rainbow("You can enter 'exit' to exit anytime.").color('#999999')}"

  #asks the user what he would like to search for
  city = ''
  lang = ''
  keywords = ''

  search_parameter=Hash.new(0)

  puts Rainbow("\nPlease enter the city:").green + exit_text
  city = STDIN.gets.chomp
  exit?(city)
  search_parameter[:city]=city

  puts Rainbow("\nPlease enter your preferred programming language:").green + exit_text
  lang = STDIN.gets.chomp
  exit?(lang)
  search_parameter[:language]=lang

  puts Rainbow("\nPlease enter a keyword e.g 'Full-Stack'").green + exit_text
  keywords = STDIN.gets.chomp
  exit?(keywords)
  search_parameter[:keywords]=keywords

  would_you_like_to_save(user, search_parameter)

  # return search_parameter
  job_search_results = search_source(search_parameter)

  checked_results = check_results(job_search_results, user)

  # chosen_job = choose_job(checked_results)
end



def would_you_like_to_save(user,data_hash)
  prompt = TTY::Prompt.new
  selection = prompt.select(Rainbow("\nWould you like to save these details for future searches?").green) do |menu|
    menu.default 1

    menu.choice 'Yes', 1
    menu.choice 'No', 2
    menu.choice 'Go back to Main Menu', 3
  end

  case selection
  when 1
    user.update(data_hash)
  when 2

  when 3
    main_menu(user)
  end
end


def search_source(job_query)
  puts Rainbow("\nLoading Jobs...\n").green
  url = Job.base_url(job_query[:keywords],job_query[:language],job_query[:city])
  response = RestClient.get(url)
  JSON.parse(response)
end

def check_results(job_search_results, user)
  list_of_results= []
  i = 1
  job_search_results.each do |result|
    Job.format_result(result,i, false)
    i += 1
    list_of_results << result
  end
  if list_of_results.length == 0
    puts "Sorry, no results found. Please try to search again!"
    main_menu(user)
  end
  list_of_results
end

def choose_job(list_of_results, user)
  prompt = TTY::Prompt.new
  prompty = prompt.select("Select a listing", list_of_results.map {|m| m["title"]})
  if prompty.length==0
    puts "Please select with space and then hit enter"
    choose_job(list_of_results, user)
  end
  chosen_job = list_of_results.find{|hash| hash["title"] == prompty}
  puts Job.format_result(chosen_job, "", true)
  # return chosen_job
  more_results_with_error_test(chosen_job, list_of_results, user)
end

def more_results_with_error_test(chosen_job, list_of_results, user)

  prompt = TTY::Prompt.new
  city_more = prompt.select(Rainbow("\nWould you like to see more info about the city?").green) do |menu|
    menu.default 1
    menu.choice 'Yes', 1
    menu.choice 'No', 2
    menu.choice 'Go back to Main Menu', 3
    menu.choice 'Exit', 4
  end

  if chosen_job['location'].downcase=="remote"
    "Sorry, either this job is remote or this city does not exist. Try another listing."
    choose_job(list_of_results, user)
  else
    new_city = City.find_or_create_by(name: chosen_job["location"])
    new_job = Job.find_or_create_by(title: chosen_job["title"])
    cityjob = CityJob.new(name: "#{chosen_job["location"]} - #{chosen_job["title"]}", city_id: new_city.id, job_id: new_job.id, user_id: user.id)
    cityjob.save
  end

  case city_more
  when 1
    #loads city info and stores in city db
    puts "Loading city information..."
    city_variable = chosen_job['location'].downcase.split(",").split("(").split("-")[0][0][0].split(" ").join("-")
    begin
      resp =RestClient.get("https://api.teleport.org/api/urban_areas/slug:#{city_variable}/scores/")
    rescue RestClient::Unauthorized, RestClient::Forbidden => err
      puts 'Access denied'
      return err.response
    rescue RestClient::ExceptionWithResponse => err
      puts "\nSorry, we are unable to find any info on that City at the moment :(. We will return you back to the results page."
      choose_job(list_of_results, user)
    else
      puts "Fetching information about #{city_variable}..."
      categories =  JSON.parse(resp)["categories"]
      categories.each do |c|
          puts Rainbow("#{c['name']} : ").color(c['color']) + c['score_out_of_10'].to_i.to_s + " / 10"
      end#each
      new_city.update(formatting_categories(categories))
      puts "\nYour search has been added to your search history.\n"
      choose_job(list_of_results, user)
    end#rescue
  when 2
    choose_job(list_of_results, user)
  when 3
    main_menu(user)
  when 4
    leave_app
  end
end#def

def formatting_categories(categories)
  #used to format categories into an acceptable hash format to direectly update the Class cityjobs
  cats = Hash.new(0)
  categories.each do |c|
   key = c["name"]
   value = c["score_out_of_10"]
   cats[key] = value.to_s.to_i.to_s + " /10"
  end
  cats
end

# def store_cityjob_in_database(city,job,city_stats,user="")
#   read this once again ^
#   hash={}
#   ncm=city_stats.map{|(k,v)| [k.to_sym,v]}
#   ncm.each do |arr|
#     hash[arr[0]]=arr[1]
#   end
#   c=City.find_or_create_by(name: city)
#   j=Job.new
#   j.title=job
#   cityjob=CityJob.new
#   cityjob.name=("#{city} - #{job}")
#   cityjob.city=c
#   cityjob.job=j
#   cityjob.city.update(hash)
#   c.save
#   j.save
#   cityjob.save
#   puts "Your search has been added to your search history."
#
#
#   puts "Enter anything to return back to the result list"
#   puts ""
#   gets
#   puts "Returning you to the results list..."
#   puts ""
#   return cityjob
# end
