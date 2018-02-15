class Api::V1::ShotTypesController < Api::V1::BaseController

  def show
    @action = @sport.shot_types
  end

  private def set_sport
    @sport = Sport.find params[:sport_id]
  end
end
