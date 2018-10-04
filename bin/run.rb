require_relative '../config/environment'

user = welcome_user

loop do
  results = main_menu(user)
  chosen_job = choose_job(results, user)
end


#CRITICAL:
  #make possible viewing of history
  #make user able to access search history
  #make him able to access job and city via history
#OPTIONAL:
#(or at least viewing of it)
#functions like search_saved_jobs
#cities_i'm_interested_in, etc...
