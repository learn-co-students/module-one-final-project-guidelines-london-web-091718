class User < ActiveRecord::Base

has_many :cities, through: :cityjobs
has_many :jobs, through: :cityjobs
#adjust the database to have city name

end
