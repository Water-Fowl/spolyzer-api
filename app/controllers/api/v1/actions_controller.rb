class Api::V1::ActionsController < ApplicationController
  def show_by_position
    params_position = params.require(:data).permit(:position, :score_game_id, :side)
    position = params_position["position"]
    # 該当するscore_gameを取得
    score_game = ScoreGame.find(params_position[:score_game_id])
    scores_by_position = score_game.score.where(position: position)
    
    render :json => scores_by_position
  end
end
