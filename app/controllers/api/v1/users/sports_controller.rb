# frozen_string_literal: true

class Api::V1::Users::SportController < Api::V1::BaseController

  def update
    current_api_v1_user.update(sports_params)
  end

  private
  def sports_params
    sports_params = params.permit(:sport_id)
  end
end
