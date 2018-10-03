class Pokemon < ActiveRecord::Base
  belongs_to :user_pokemons
  has_many :users, through: :user_pokemons
end
