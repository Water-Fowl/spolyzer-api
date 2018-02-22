class Api::V1::ShotTypesController < Api::V1::BaseController

  def show
    @shot_type = @sport.shot_types
  end

  private def set_sport
    @sport = Sport.find params[:id]
  end
end
