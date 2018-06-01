# frozen_string_literal: true

class Api::V1::GamesController < Api::V1::BaseController
  def index
    @games = current_api_v1_user.games
  end

  def create
    @scores = params[:scores]
    @sport = Sport.find params[:sport_id]
    @units = params[:units]

    create_game

    left_unit, right_unit = CreateUnitsService.call(units_params, @game.id)

    CreateScoresService.call(scores_params, @game.id, left_unit, right_unit)

    @game.update_outcome
  end

  private

  def create_game
    @game = Game.create(
      name: game_params[:name],
      sport_id: @sport.id,
      record_user_id: current_api_v1_user.id
    )
  end

  def game_params
    params.require(:game).permit(:name)
  end

  def units_params
    params.require(:units)
  end

  def scores_params
    params.require(:scores)
  end
end
