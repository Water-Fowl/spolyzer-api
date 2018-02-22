json.game @game, :name, :created_at, :updated_at
json.shot_type @game.sport.shot_types, :name_ja, :name_en
json.winner_score @game.winner.scores.count
json.loser_score @game.loser.scores.count
