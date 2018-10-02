require_relative '../config/environment'

user=welcome_user
job_query=search_query(user)

puts "Loading Jobs..."
# list jobs
url = Job.base_url("#{job_query[:keywords]} #{job_query[:language]}", job_query[:location])
response = RestClient.get(url)
data = JSON.parse(response)
list_of_results= []
i=1
data.each do |d|
  Job.format_result(d,i, false)
  i+=1
  list_of_results << d
end

# def chosen_job(list_of_results)
chosen_job = ''
while chosen_job != 'q'
  puts "Would you like to find out any more details about a Job? If so, please enter the number from the above list ^ "
  #check if the user selected the correct listing
  chosen_job = gets.chomp
  puts Job.format_result(list_of_results[chosen_job.to_i - 1], false)
  puts ""
  puts ""
  puts ""
  #offer the user to open the listing in his browser using the :url
end

# chosen_job(list_of_results)

# binding.pry
#
# p "fml"
