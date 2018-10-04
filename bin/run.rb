require_relative '../config/environment'


user=welcome_user
new_user=User.find_or_create_by(name: user)
job_query=search_query(user)
loop do
  job_results=job_search_results(job_query)
  list_of_results=result_list(job_results)
  chosen_job=chosen_job(list_of_results)
  cityjob=more_results_with_error_test(chosen_job,job_search_results(job_query))
  # cityjob.user_id=new_user.id
  #cityjob.save
end
#remove from schema first 3 city stats as they are useless

#implement looping into history
#functions like search_saved_jobs
#cities_i'm_interested_in, etc...
#SELECT CITY input letter gets the last entry in the list
