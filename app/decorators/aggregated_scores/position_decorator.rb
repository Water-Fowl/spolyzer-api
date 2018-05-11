class AggregatedScores::PositionDecorator
  include BaseDecorator
  attr_reader :scores

  def initialize(scores)
    @scores = scores
  end

  def call
    if !scores.empty?
      scores.group('scores.position_id').count.reduce({}) do |count, (key, value)|
        dropped_at = key
        count ||= {}
        count[dropped_at] ||= value
        count
      end
    else
      []
    end
  end

end
