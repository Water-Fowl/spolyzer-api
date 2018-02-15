ActiveRecord::Base.transaction do
  10.times do |i|
    User.create(
      email: "#{i}test@test.test",
      password: "#{i}testtest"
    )
  end
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
  winner = User.first
  loser = User.second
  game = Game.create(
    name: 'test'
  )
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
end
