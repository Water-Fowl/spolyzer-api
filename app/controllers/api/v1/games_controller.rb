class Api::V1::GamesController < ApplicationController
  before_action :authenticate_api_v1_user!

  def create
    # Permit Parameters
    players = params.require(:game).require(:players).permit(:left_user_id_1,:left_user_id_2,:right_user_id_1,:right_user_id_2)
    score_game_params = params.require(:game).require(:score_game).permit(:left_team_id,:right_team_id,:game_time,:serve_user_id,:match_point,:deuce,:last_score_of_left,:last_score_of_right)
    scores_params = params.require(:game).require(:scores).permit(:action=> [], :position=> [], :time_to_drop_shuttle=> [],:score_users=> [], :conceded_users=> [])
    #User Authorization
    ##Write Here....

    #Registor ScoreGame info
    score_game = ScoreGame.create(score_game_params)
    
    #Retate with users table
    #もし左サイドなら0右サイドなら1
    
    #Userがまだできてないので一旦コメントアウト
    create_score_game_to_users(players, score_game)

    action_list = scores_params["action"]
    position_list = scores_params["position"]
    time_to_drop_shuttle_list = scores_params["time_to_drop_shuttle"]
    score_user_list = scores_params["score_users"]
    conceded_user_list = scores_params["conceded_users"]
    #Registor Scores
    action_list.zip(position_list, time_to_drop_shuttle_list, score_user_list, conceded_user_list) do |score_params| 
      req = {action:score_params[0], position:score_params[1], time_to_drop_shuttle:score_params[2], scores_user_id:score_params[3], conceded_user_id:score_params[4], score_game_id:score_game.id}
      Score.create(req)
    end
    render json: {status:0,message:"ok", score_game_id: score_game.id}
  end
end

def create_score_game_to_users(players, score_game)
    ScoreGameToUser.create(user_id:players["left_user_id_1"],court:0,score_game_id:score_game.id)
    ScoreGameToUser.create(user_id:players["left_user_id_2"],court:0,score_game_id:score_game.id)
    ScoreGameToUser.create(user_id:players["right_user_id_1"],court:1,score_game_id:score_game.id)
    ScoreGameToUser.create(user_id:players["right_user_id_2"],court:1,score_game_id:score_game.id) 
end
