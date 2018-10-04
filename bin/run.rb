require_relative '../config/environment'

def history?(argument,user)
  if argument=="history"
    puts CityJob.all.find_by(user_id: user.id)
  end
  argument
end

user=welcome_user
job_query=search_query(user)
loop do
  job_results=job_search_results(job_query)
  list_of_results=result_list(job_results)
  chosen_job=chosen_job(list_of_results)
  cityjob=more_results_with_error_test(chosen_job,job_search_results(job_query))
#  cityjob.user_id=user.id
#  cityjob.save
  #DO NOT TOUCH ABOVE LINE ^
end

#CRITICAL:
  #make possible viewing of history
  #make user able to access search history
  #make him able to access job and city via history
#OPTIONAL:
#(or at least viewing of it)
#functions like search_saved_jobs
#cities_i'm_interested_in, etc...
