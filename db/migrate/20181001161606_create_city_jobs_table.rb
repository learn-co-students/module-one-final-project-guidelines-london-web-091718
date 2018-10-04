class CreateCityJobsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :city_jobs do |t|
      t.string :name
      t.integer :city_id
      t.integer :job_id
      t.integer :user_id
      t.timestamps
    end
  end
end
