class User < ActiveRecord::Base
  has_many :pokemons, through: :user_pokemons
  has_many :user_pokemons
end
