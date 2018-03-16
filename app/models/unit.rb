class Unit < ApplicationRecord
  belongs_to :game
  has_many :user_units
  has_many :users, through: :user_units
  has_many :scores
end
