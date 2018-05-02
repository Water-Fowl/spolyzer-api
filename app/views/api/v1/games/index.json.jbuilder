# frozen_string_literal: true

json.games @games do |game|
  json.game game
  json.score_count game.score_count
  json.left_users game.units[0].users
  json.right_users game.units[1].users
end
