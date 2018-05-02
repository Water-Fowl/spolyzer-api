ActiveRecord::Base.transaction do
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
    ['ドロップ', 'drop'],
  ].each do |type|
    ShotType.create(
      name_ja: type.first,
      name_en: type.second,
      sport_id: sport.id
    )
  end
  13.times do |i|
    Position.create(
      is_in: i < 6 ? false : true
    )
  end
end
