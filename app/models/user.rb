class User < ActiveRecord::Base

has_many :cities, through: :cityjobs
has_many :jobs, through: :cityjobs
has_many :cityjobs
#adjust the database to have city name

  def self.number_of_registered_users
    User.count
  end



end
