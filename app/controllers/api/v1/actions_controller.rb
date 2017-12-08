class Api::V1::ActionsController < ApplicationController  
#  before_action :authenticate_api_v1_user!

  def show_by_position

    actions_list = ["ヘアピン","スマッシュ", "クリアー","ドライブ","プッシュ","ロブ","サービス","ドロップ",'ネットイン(スマッシュ)','ネットイン(ドライブ)','ミス(サービス)']
    params_position = params.require(:data).permit(:position, :side, :score_game_id=> [])
    position = params_position["position"]
    side = params_position["side"]
    # 該当するscore_gameを取得
    score_game_ids = params_position[:score_game_id]
    actions_by_position = Score.includes(:score_game).where(score_games: {id: score_game_ids}).where(position: position).where(side: side).select("action").to_a

    action_list = hash_to_list_by_column("action", actions_by_position)
    action_count_hash_with_index = list_to_count_hash(action_list)
    action_count = {}
    action_count_hash_with_index.each{|key,value|
        action_count[actions_list[key]] = value
    }
    render json: {status:0,message:"ok", action_count: action_count}
  end

  def show_by_status
    actions_list = ["ヘアピン","スマッシュ", "クリアー","ドライブ","プッシュ","ロブ","サービス","ドロップ",'ネットイン(スマッシュ)','ネットイン(ドライブ)','ミス(サービス)']
    column_list = ['lose', 'win', 'all']
    
    params_status = params.require(:data).permit(:user_id, :opponent_user, :victory, :position)
    position = params_status["position"]
    user_id = params_status["user_id"]
    opponent_user_id = params_status["opponent_user"]
    victory = params_status["victory"]
    
    current_user = User.find(user_id)
    opponent_user = User.find(opponent_user_id)

    score_game = current_user.get_games(column=column_list[2])
    score_game = current_user.get_games_with(score_game, user=opponent_user)
    render json: { status:0, message: 'ok', score_game_ids: score_game.ids }
  end

    

  def actions_hash_to_count_hash(actions, actions_list)
    action_list = hash_to_list_by_column("action", actions)
    action_count_hash_with_index = list_to_count_hash(action_list)
    action_count = {}
    action_count_hash_with_index.each{|key,value|
        action_count[actions_list[key]] = value
    }
    return action_count
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
