class AimOpponentUser < ApplicationRecord
  belongs_to :opponent_users, class_name: "User"
  belongs_to :aims
end
