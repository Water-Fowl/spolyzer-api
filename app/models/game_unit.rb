class GameUnit < ApplicationRecord
  enum side: { left: 0, right: 1 }
  enum outcome: { win: 2, draw: 1, lose: 0 }
  belongs_to :game
  belongs_to :unit
end
