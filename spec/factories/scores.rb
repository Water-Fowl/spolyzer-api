FactoryBot.define do

  factory :score do
    game_id 1
    shot_type_id 1
    dropped_side 0
    unit_id attributes_for(:unit_id)
    position_id 1
    is_net_miss false
  end
end
