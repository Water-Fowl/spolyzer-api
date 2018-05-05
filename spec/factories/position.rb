FactoryBot.define do
  factory :left_position, class: Position do
    dropped_at 10
    side 0
  end

  factory :right_position, class: Position do
    dropped_at 10
    side 1
  end
end
