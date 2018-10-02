class CreateCityTable < ActiveRecord::Migration[5.0]

  def change
    create_table :cities do |t|
      t.string :name
      t.string :urban_area
      t.string :country
      t.integer :quality_of_life
      t.integer :housing
      t.integer :cost_of_living
      t.integer :startups
      t.integer :venture_capital
      t.integer :travel_connectivity
      t.integer :commute
      t.integer :business_freedom
      t.integer :safety
      t.integer :healthcare
      t.integer :education
      t.integer :environmental_quality
      t.integer :economy
      t.integer :taxation
      t.integer :internet_access
      t.integer :leisure
      t.integer :tolerance
      t.integer :outdoors
      t.string :summary
    end
  end
end
