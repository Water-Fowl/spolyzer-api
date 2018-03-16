ActiveRecord::Base.transaction do
  puts 'creating user....'
  10.times do |i|
    User.create(
      name: "#{i}",
      email: "#{i}test@test.test",
      password: "#{i}testtest"
    )
  end

  puts 'creating sport and shot types....'
  Sport.create(
    name_ja: 'バドミントン',
    name_en: 'badminton'
  )
  sport = Sport.first
  [
    ['ヘアピン', 'hairpin'],
    ['スマッシュ', 'smash'],
    ['クリアー', 'clear'],
    ['ドライブ', 'drive'],
    ['プッシュ', 'push'],
    ['ロブ', 'rob'],
    ['サービス', 'service'],
    ['ドロップ', 'drop'],
  ].each do |type|
    ShotType.create(
      name_ja: type.first,
      name_en: type.second,
      sport_id: sport.id
    )
  end
  puts 'creating games....'
  winner = User.first
  loser = User.second
  2.times do
    Game.create(
      sport_id: sport.id,
      name: 'test'
    )
  end

  game = Game.first
  winner_single_unit = Unit.create(side: 0, user_count: 1, game_id: game.id)
  loser_single_unit = Unit.create(side: 1, user_count: 1, game_id: game.id)
  winner_single_unit.user_units.create(user_id: winner.id)
  loser_single_unit.user_units.create(user_id: loser.id)
  10.times do |i|
    score = winner_single_unit.scores.create(
      game_id: game.id,
      shot_type_id: i,
      miss_type: 0
    )
    Position.create(
      dropped_at: i,
      side: 1,
      score_id: score.id
    )
  end
  9.times do |i|
    score = loser_single_unit.scores.create(
      game_id: game.id,
      shot_type_id: i + 1,
      miss_type: 0
    )
    Position.create(
      dropped_at: i + 1,
      side: 0,
      score_id: score.id
    )
  end

  puts 'creating unit....'
  game = Game.second
  winner_unit = Unit.create(side: 0, user_count: 2, game_id: game.id)
  loser_unit  = Unit.create(side: 1, user_count: 2, game_id: game.id)
  2.times do |i|
    winner_unit.user_units.create(
      user_id: i + 1
    )
  end
  2.times do |i|
    loser_unit.user_units.create(
      user_id: i + 3
    )
  end
  10.times do |i|
    score = winner_unit.scores.create(
      game_id: game.id,
      shot_type_id: i,
      miss_type: 0
    )
    Position.create(
      dropped_at: i,
      side: 1,
      score_id: score.id
    )
  end
  9.times do |i|
    score = loser_unit.scores.create(
      game_id: game.id,
      shot_type_id: i + 1,
      miss_type: 0
    )
    Position.create(
      dropped_at: i + 1,
      side: 0,
      score_id: score.id
    )
  end

  AnalysisResult.create(
    user_id: 1
  )
end
