class AddUserTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :language
      t.string :city
      t.string :keywords
      t.timestamps
    end
  end
end
