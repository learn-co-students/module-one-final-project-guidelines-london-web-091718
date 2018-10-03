require_relative '../config/environment'


user=welcome_user
job_query=search_query(user)
loop do
  job_results=job_search_results(job_query)
  list_of_results=result_list(job_results)
  chosen_job=chosen_job(list_of_results)
  more_results_with_error_test(chosen_job,job_search_results(job_query))
end

#implement looping into history
#functions like search_saved_jobs
#cities_i'm_interested_in, etc...
#SELECT CITY input letter gets the last entry in the list
