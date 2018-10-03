class CityJob < ActiveRecord::Base

belongs_to :city
belongs_to :job
belongs_to :user

end
