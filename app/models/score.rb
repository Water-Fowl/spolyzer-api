class Score < ApplicationRecord
  has_one :position

  belongs_to :game
  belongs_to :user
end
