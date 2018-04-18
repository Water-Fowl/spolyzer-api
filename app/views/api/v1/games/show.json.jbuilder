# frozen_string_literal: true

json.game @game, :id, :name, :created_at, :updated_at
json.shot_type @shot_types, :name_ja, :name_en
json.winner_score @game.winner.scores.count
json.loser_score @game.loser.scores.count
