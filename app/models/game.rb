class Game < ApplicationRecord
  has_many :game_users
  has_many :users, through: :match_users
  has_many :scores
end
