FactoryBot.define do
  factory :unit, class: Unit do
    side 1
    user_count 1
  end
  trait :with_game do
    association :game, factory: :game
  end
end
