class AddCityJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :city_jobs do |t|
      t.integer :city_id
      t.integer :job_id
    end
  end
end
