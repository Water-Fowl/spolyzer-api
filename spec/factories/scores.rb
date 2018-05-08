FactoryBot.define do
  factory :left_score, class: Score do
    is_net_miss true
    dropped_side 1
  end

  factory :right_score, class: Score do
    is_net_miss true
    dropped_side 0
  end
end
