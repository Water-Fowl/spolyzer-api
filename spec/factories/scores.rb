FactoryBot.define do
  factory :left_score, class: Score do
    miss_type 0
    shot_type_id 1
  end

  factory :right_score, class: Score do
    miss_type 0
    shot_type_id 2
  end

  trait :with_left_position do
    after :create do |score|
      create(:left_position, score)
    end
  end

  trait :with_right_position do
    after :create do |score|
      create(:right_position, score)
    end
  end

end
