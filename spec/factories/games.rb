# frozen_string_literal: true

FactoryBot.define do
  factory :game do |game|
    game.name '練習試合'
    association :sport, factory: :sport
  end

  trait :with_scores do
    transient do
      left_side_scores_count 10
      right_side_scores_count 9
    end

    after :create do |game, evaluator|
      create_list(:left_score, evaluator.left_side_scores_count, position: Position.first, shot_type: ShotType.first, game: game, unit: game.units.first)
      create_list(:right_score, evaluator.right_side_scores_count, position: Position.first, shot_type: ShotType.first, game: game, unit: game.units.second)
    end
  end
end
