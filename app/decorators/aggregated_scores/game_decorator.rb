class AggregatedScores::GameDecorator
  include BaseDecorator
  attr_reader :scores

  def initialize(scores)
    @scores = scores
  end

  def call
    if !scores.empty?
      scores
        .group(
          'scores.dropped_side',
          'scores.position_id',
          'scores.shot_type_id',
          'scores.is_net_miss'
        )
        .count.each_with_object({}) do |(key, value), count|
        side, dropped_at, shot_type, miss_type = key
        count[side] ||= {}
        count[side][dropped_at] ||= {}
        count[side][dropped_at][shot_type] ||= {}
        count[side][dropped_at][shot_type][miss_type] = value
      end
    else
      []
    end
  end
end
