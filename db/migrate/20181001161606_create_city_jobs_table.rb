class CreateCityJobsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :cityjobs do |t|
      t.string :city_id
      t.string :jobs_id
    end
  end
end
