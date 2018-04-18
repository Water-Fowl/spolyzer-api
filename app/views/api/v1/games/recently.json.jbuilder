# frozen_string_literal: true

json.games @games do |game|
  json.call(game, :id, :name, :created_at)
end
