class GameUnit < ApplicationRecord
  enum side: { left: 0, right: 1 }
  belongs_to :game
  belongs_to :unit
end
