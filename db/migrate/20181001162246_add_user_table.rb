class AddUserTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :fav_language
      t.integer :city_id
      t.integer :jobs_id
    end
  end
end
