class CreateUserPokemons < ActiveRecord::Migration[4.2]

  def change
    create_table :user_pokemons do |t|
      t.integer :pokemon_id
      t.integer :user_id
      t.integer :won, :default => 0
    end
  end

end
