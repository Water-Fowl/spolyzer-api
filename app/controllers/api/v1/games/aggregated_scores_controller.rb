class Api::V1::Games::AggregatedScoresController < Api::V1::BaseController

  def index
    game = Game.find params[:game_id]
    scores = game.scores
    @counts = aggregated(scores)
  end

  private
  def aggregated(scores)
    scores
      .group('scores.dropped_side', 'scores.position_id', 'scores.shot_type_id', 'scores.is_net_miss')
      .count.reduce({}) do |count, (key, value)|
      side, dropped_at, shot_type, miss_type = key
      count[side] ||= {}
      count[side][dropped_at] ||= {}
      count[side][dropped_at][shot_type] ||= {}
      count[side][dropped_at][shot_type][miss_type] = value
      count
    end
  end
end
