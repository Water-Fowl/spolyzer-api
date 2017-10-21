class Api::V1::ActionsController < ApplicationController
  before_action :authenticate_api_v1_user!
  def show_by_position
    params_position = params.require(:data).permit(:position, :score_game_id, :side)
    position = params_position["position"]
    # 該当するscore_gameを取得
    score_game = ScoreGame.find(params_position[:score_game_id])
    actions_by_position = score_game.score.where(position: position).select("action").to_a
    actions_list = [] 
    for hash in actions_by_position
        actions_list.push(hash["action"])        
    end
    action_values = actions_list.uniq
    action_count_hash = {}
    for action_value in action_values
        action_count_hash[action_value] =  actions_list.count(action_value)
    end
    render :json => action_count_hash
  end
end
