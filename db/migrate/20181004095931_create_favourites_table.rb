class CreateFavouritesTable < ActiveRecord::Migration[5.0]
  def change
    create_table :favourites do |t|
      t.integer :user_id
      t.integer :movie_id
    end
  end
end
