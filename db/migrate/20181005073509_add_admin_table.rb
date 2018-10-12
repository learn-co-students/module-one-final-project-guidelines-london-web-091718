class AddAdminTable < ActiveRecord::Migration[5.0]
  def change
    create_table :admins do |t|
      t.string :username
      t.string :password
    end
  end
end
