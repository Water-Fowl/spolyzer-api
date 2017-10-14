class ScoreGameToUser < ApplicationRecord
    belongs_to :user
    belongs_to :score_game
end
