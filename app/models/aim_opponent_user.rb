class AimOpponentUser < ApplicationRecord
  has_many :aims
  has_many :opponent_users
end
