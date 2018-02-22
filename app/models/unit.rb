class Unit < ApplicationRecord
  has_many :game_units
  has_many :games, through: :game_units

  has_many :unit_users
  has_many :users, through: :unit_users
end
