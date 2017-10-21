class Api::V1::ActionsController < ApplicationController
  
  before_action :authenticate_api_v1_user!

  def show_by_position
    params_position = params.require(:data).permit(:position, :score_game_id, :side)
    position = params_position["position"]
    # 該当するscore_gameを取得
    score_game = ScoreGame.find(params_position[:score_game_id])
    actions_by_position = score_game.score.where(position: position).select("action").to_a
    
    action_list = hash_to_list_by_column("action", hash_list)
    action_count_hash = list_to_count_hash(action_list)
    
    render :json => action_count_hash
  end
    
  def hash_to_list_by_column(column, hash_list)
    list = []
    for hash in hash_list
        list.push(hash[column])
    end
    return list
  end

  def list_to_count_hash(hash_list)
    hash_values = hash_list.uniq
    count_hash = {}
    for hash_value in hash_values
        count_hash[hash_value] =  actions_list.count(action_value)
    end
    return count_hash
  end

end
