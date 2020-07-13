def load_city_hash
  puts 'Loading your results...'
  response_string = RestClient.get('https://api.teleport.org/api/urban_areas/slug:#{city.name}/scores/')
  JSON.parse(response_string)
end

#https://api.teleport.org/api/cities/?search=#{city.name}

def load_job_hash
  puts 'Loading your results...'
  response_string = RestClient.get('')
  JSON.parse(response_string)
end

job_seed(load_job_hash)
cityjob_seed(load_cityjob_hash)
city_seed(load_city_hash)

#EasyTranslate.api_key = AIzaSyC8k2GK8mYcrkaoTf8NfqAxPZzj6r3Zif8
