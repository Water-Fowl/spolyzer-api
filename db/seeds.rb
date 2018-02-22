ActiveRecord::Base.transaction do
  puts 'creating user....'
  10.times do |i|
    User.create(
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
    ['ネットイン', 'net_in'],
    ['ミス', 'miss']
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
  GameUser.create(
    game_id: game.id,
    user_id: winner.id
  )
  GameUser.create(
    game_id: game.id,
    user_id: loser.id
  )

  10.times do
    winner.scores.create(
      game_id: game.id
    )
  end
  9.times do
    loser.scores.create(
      game_id: game.id
    )
  end

  puts 'creating unit....'

  winner_unit = Unit.create
  loser_unit  = Unit.create
  2.times do |i|
    winner_unit.unit_users.create(
      user_id: i + 1
    )
  end
  2.times do |i|
    loser_unit.unit_users.create(
      user_id: i + 3
    )
  end
  Game.second.game_units.create(unit_id: winner_unit.id)
  Game.second.game_units.create(unit_id: loser_unit.id)
end
