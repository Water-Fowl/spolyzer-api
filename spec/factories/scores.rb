FactoryBot.define do
  factory :left_score, class: Score do
    miss_type 0
    shot_type_id 1
    dropped_at 1
    dropped_side 1
  end

  factory :right_score, class: Score do
    miss_type 0
    shot_type_id 2
    dropped_at 2
    dropped_side 0
  end
end
