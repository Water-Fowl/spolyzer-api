class Unit < ApplicationRecord
  has_many :game_units
  has_many :games, through: :game_units

  has_many :user_units
  has_many :users, through: :user_units
end
