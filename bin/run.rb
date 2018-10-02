require_relative '../config/environment'




def job_search_results(job_query)
  puts "Loading Jobs..."
  url = Job.base_url("#{job_query[:keywords]} #{job_query[:language]}",
  #need to use :cityjobs?
  job_query[:location])
  response = RestClient.get(url)
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
    puts 'Loading your city information...'
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
      puts 'It worked!'
      categories =  JSON.parse(resp)["categories"]
      categories.each do |c|
        puts Rainbow("#{c['name']} : ").color(c['color']) + c['score_out_of_10'].to_i.to_s + " / 10"
      end
    end
  end

end






user=welcome_user
job_query=search_query(user)
job_results=job_search_results(job_query)
list_of_results=result_list(job_results)
chosen_job=chosen_job(list_of_results)
more_results=more_results_with_error_test(chosen_job)
