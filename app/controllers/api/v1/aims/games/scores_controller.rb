class Api::V1::Aims::Games::ScoresController < ApplicationController
  def index
    @aim = Aim.find(params[:aim_id])
    @game = Game.find(params[:game_id])
    @scores = @aim.scores_in_game(@game)
  end
end
