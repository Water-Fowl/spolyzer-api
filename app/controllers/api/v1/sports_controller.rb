# frozen_string_literal: true

class Api::V1::SportsController < Api::V1::BaseController
  skip_before_action :authenticate_api_v1_user!

  def index
    sports = Sport.all
    render json: sports, each_serializer: SportSerializer
  end

  def show
    sport = Sport.find(params[:id])
    render json: sport
  end
end
