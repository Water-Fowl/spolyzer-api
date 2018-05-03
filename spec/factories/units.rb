FactoryBot.define do
  factory :unit, class: Unit do
    user_count 1

  end
  trait :with_game do
    association :game, factory: :game
  end
  trait :with_user do
    association :user, factory: :user
  end
end
