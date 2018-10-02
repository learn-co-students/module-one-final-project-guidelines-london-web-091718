def load_city_hash
  puts 'Loading your results...'
  response_string = RestClient.get('https://api.teleport.org/api/urban_areas/slug:#{city.name}/scores/')
  JSON.parse(response_string)
end

def load_job_hash
  puts 'Loading your results...'
  response_string = RestClient.get('')
  JSON.parse(response_string)
end

job_seed(load_job_hash)
cityjob_seed(load_cityjob_hash)
city_seed(load_city_hash)
