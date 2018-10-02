class AddUserTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :fav_language
      t.string :city
      t.string :keywords
    end
  end
end
