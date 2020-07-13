class CreatePokemons < ActiveRecord::Migration[4.2]

  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :health
      t.integer :attack
    end
  end

end
