class City < ActiveRecord::Base

  has_many :cityjobs
  has_many :jobs, through: :cityjobs


 def self.show_stats_for_city(name)
   city=City.all.find_by(name: name)
 end



end
