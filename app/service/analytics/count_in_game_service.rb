module Analytics
  class CountInGameService < ::BaseService

    def execute
      game = Game.find(@params[:game_id])
      count = game
        .scores
        .joins(:position)
        .group('positions.side', 'positions.dropped_at', 'scores.shot_type_id', 'scores.miss_type')
        .count
      count = reshape(count)

    end

    private
    def reshape(count)
      count.reduce({}) do |count, (key, value)|
        side, dropped_at, shot_type, miss_type = key
        count[side] ||= {}
        count[side][dropped_at] ||= {}
        count[side][dropped_at][shot_type] ||= {}
        count[side][dropped_at][shot_type][miss_type] = value
        count
      end
    end
  end
end