# frozen_string_literal: true

class Api::V1::ShotTypesController < Api::V1::BaseController
  def index
    @shot_types = ShotType.where(sport_id: params[:sport_id])
  end

  def show
    @shot_type = @sport.shot_types
  end

  private def set_sport
    @sport = Sport.find params[:id]
  end
end
