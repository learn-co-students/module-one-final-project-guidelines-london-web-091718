require_relative '../config/environment'


user=welcome_user
@user=user
job_query=search_query(user)
loop do
  job_results=job_search_results(job_query)
  list_of_results=result_list(job_results)
  chosen_job=chosen_job(list_of_results)
  cityjob=more_results_with_error_test(chosen_job,job_search_results(job_query))
  cityjob.user=user
  cityjob.save
end

#CRITICAL:
  #make user able to access search history - somewhat works
#OPTIONAL:
#(or at least viewing of it)
#functions like search_saved_jobs
#cities_i'm_interested_in, etc...
