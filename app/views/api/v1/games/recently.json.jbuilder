json.games @games do |game|
  json.(game, :id, :name, :created_at)
end
