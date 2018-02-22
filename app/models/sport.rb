class Sport < ApplicationRecord
  has_many :shot_types
  has_many :sport_users
  has_many :users, through: :sport_users
end
