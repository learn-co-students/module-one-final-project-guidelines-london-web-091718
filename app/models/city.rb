class City < ActiveRecord::Base

  has_many :cityjobs
  has_many :jobs, through: :cityjobs

end
