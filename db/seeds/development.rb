ActiveRecord::Base.transaction do
  13.times do |i|
    Position.create(
      is_in: i < 6 ? false : true
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
  Sport.create(
    name_ja: 'テニス',
    name_en: 'tennis'
  )
  sport = Sport.second
  [
    ['スマッシュ', 'smash'],
    ['ボレー', 'volley'],
    ['トップスピン', 'top spin'],
    ['スライス', 'slice'],
    ['ロブ', 'rob'],
    ['フラットサーブ', 'flat serve'],
    ['スライスサーブ', 'slice serve'],
    ['スピンサーブ', 'spin serve'],
    ['ツイスト', 'twist serve'],
    ['ドロップ', 'drop'],
  ].each do |type|
    ShotType.create(
      name_ja: type.first,
      name_en: type.second,
      sport_id: sport.id
    )
  end

  puts 'creating user....'
  10.times do |i|
    User.create(
      name: "#{i}",
      email: "#{i}test@test.test",
      password: "#{i}testtest",
      sport_id: 1
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
  winner_single_unit = Unit.create(user_count: 1)
  loser_single_unit = Unit.create(user_count: 1)

  winner_single_unit.game_units.create(game_id: game.id, side:0)
  loser_single_unit.game_units.create(game_id: game.id, side:1)

  winner_single_unit.user_units.create(user_id: winner.id)
  loser_single_unit.user_units.create(user_id: loser.id)
  10.times do |i|
    score = winner_single_unit.scores.create(
      game_id: game.id,
      shot_type_id: i,
      is_net_miss: false,
      position_id: i,
      dropped_side: 1,
    )
  end
  9.times do |i|
    score = loser_single_unit.scores.create(
      game_id: game.id,
      shot_type_id: i + 1,
      is_net_miss: false,
      position_id: i + 1,
      dropped_side: 0,
    )
  end

  puts 'creating unit....'
  game = Game.second
  winner_unit = Unit.create(user_count: 2)
  loser_unit  = Unit.create(user_count: 2)
  winner_unit.game_units.create(game_id: game.id, side:0)
  loser_unit.game_units.create(game_id: game.id, side:1)
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
      is_net_miss: false,
      position_id: i,
      dropped_side: 1,
    )
  end
  9.times do |i|
    score = loser_unit.scores.create(
      game_id: game.id,
      shot_type_id: i + 1,
      is_net_miss: false,
      position_id: i + 1,
      dropped_side: 0,
    )
  end

  AnalysisResult.create(
    user_id: 1
  )
end
