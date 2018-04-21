class AimOpponentUser < ApplicationRecord
  belongs_to :opponent_user, class_name: "User"
  belongs_to :aim
end
