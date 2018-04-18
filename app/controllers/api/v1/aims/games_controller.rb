class Api::V1::Aims::GamesController < ApplicationController
  def index
    @aim = Aim.find(params[:aim_id])
    @games = @aim.games
  end
end
