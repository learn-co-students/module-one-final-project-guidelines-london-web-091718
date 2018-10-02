class City < ActiveRecord::Base

  has_many :job_cities
  has_many :jobs, through: :job_cities

end
