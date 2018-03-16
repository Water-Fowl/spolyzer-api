class Api::V1::ShotTypesController < Api::V1::BaseController

  def index
    @shot_types = ShotType.where(sport_id: params[:sport_id])
  end
  def show
    @shot_type = @sport.shot_types
  end

  def counts
    @count = CountShotTypeService.new(params).execute
#    game = Game.find params[:id]
#    @count = game
#      .scores
#      .joins(:position)
#      .group('positions.side', 'positions.dropped_at', 'scores.shot_type_id', 'scores.miss_type')
#      .count.reduce({}) do |count, (key, value)|
#      side, dropped_at, shot_type, miss_type = key
#      count[side] ||= {}
#      count[side][dropped_at] ||= {}
#      count[side][dropped_at][shot_type] ||= {}
#      count[side][dropped_at][shot_type][miss_type] = value
#      count
#    end
  end

  private def set_sport
    @sport = Sport.find params[:id]
  end
end
