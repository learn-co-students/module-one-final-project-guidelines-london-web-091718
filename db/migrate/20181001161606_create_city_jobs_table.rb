class CreateCityJobsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :city_jobs do |t|
      t.string :name
      t.integer :city_id
      t.integer :job_id
    end
  end
end
