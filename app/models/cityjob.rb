class CityJob < ActiveRecord::Base

belongs_to :city
belongs_to :job
belongs_to :user

# def self.user.find_by(name:)

  def self.most_popular_cities
    arr=[]
    brr=[]
    CityJob.all.each do |cityjob|
      if cityjob.city_id!=nil
        arr<<cityjob.city_id
      end
    end
    arr.each do |id|
      brr<<City.find_by(id: id).name
    end
    brr.uniq.max_by{ |i| brr.count( i ) }
  end


end
