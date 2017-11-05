class Api::V1::ActionsController < ApplicationController  
  before_action :authenticate_api_v1_user!

  def show_by_position

    actions_list = ["ヘアピン","スマッシュ", "クリアー","ドライブ","プッシュ","ロブ","サービス","ドロップ",'ネットイン(スマッシュ)','ネットイン(ドライブ)','ミス(サービス)']
    params_position = params.require(:data).permit(:position, :score_game_id, :side)
    position = params_position["position"]
    side = params_position["side"]
    # 該当するscore_gameを取得
    score_game = ScoreGame.find(params_position[:score_game_id])
    actions_by_position = score_game.score.where(position: position).where(side: side).select("action").to_a

    action_list = hash_to_list_by_column("action", actions_by_position)
    action_count_hash_with_index = list_to_count_hash(action_list)
    action_count = {}
    action_count_hash_with_index.each{|key,value|
        action_count[actions_list[key]] = value
    }
    render json: {status:0,message:"ok", action_count: action_count}
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
        count_hash[hash_value] =  hash_list.count(hash_value)
    end
    return count_hash
  end

end
