# frozen_string_literal: true

class Api::V1::AggregatedScores::BaseController < Api::V1::BaseController
  private

  def aggregate_position(scores)
    if !scores.empty?
      scores
        .group('scores.position_id')
        .count.reduce({}) do |count, (key, value)|
        dropped_at = key
        count ||= {}
        count[dropped_at] ||= value
        count
      end
    else
      scores
    end
  end
end
