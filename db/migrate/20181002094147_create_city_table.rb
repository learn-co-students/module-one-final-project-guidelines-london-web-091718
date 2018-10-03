class CreateCityTable < ActiveRecord::Migration[5.0]

  def change
    create_table :cities do |t|
      t.string :name
      t.string :urban_area
      t.string :country
      t.string :quality_of_life
      t.string :Housing
      t.string :"Cost of Living"
    t.string   :Startups
    t.string   :"Venture Capital"
    t.string   :"Travel Connectivity"
    t.string   :Commute
    t.string   :"Business Freedom"
    t.string    :Safety
    t.string    :Healthcare
    t.string    :Education
    t.string    :"Environmental Quality"
    t.string    :Economy
    t.string    :Taxation
    t.string    :"Internet Access"
    t.string    :"Leisure & Culture"
    t.string    :Tolerance
    t.string    :Outdoors
    end
  end
end
