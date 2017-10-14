class ScoreGame < ApplicationRecord
    has_many :score
    has_many :score_game_to_users
    has_many :users, through: :score_game_to_users
end
