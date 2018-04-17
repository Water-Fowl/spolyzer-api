class Api::V1::AggregatedScores::BaseController < Api::V1::BaseController

  private
  def aggregated_by_position(scores)
    if not scores.empty?
      count_positions = scores
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
