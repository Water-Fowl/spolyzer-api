# frozen_string_literal: true

class Api::V1::ShotTypesController < Api::V1::BaseController
  def index
    shot_types = ShotType.where(sport_id: params[:sport_id])
    render json: shot_types
  end
end
