require_relative '../config/environment'


user=welcome_user
job_query=search_query(user)
job_results=job_search_results(job_query)
list_of_results=result_list(job_results)
chosen_job=chosen_job(list_of_results)
more_results=more_results_with_error_test(chosen_job)
