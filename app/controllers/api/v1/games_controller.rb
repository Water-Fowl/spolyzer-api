class Api::V1::GamesController < ApplicationController

  def create
    #Permit Parameters
    user = params.require(:game).permit(:user_id,:token)
    players = params.require(:game).require(:score).permit(:left_user_id_1,:left_user_id_2,:right_user_id_1,:right_user_id_2)
    game_info = params.require(:game).require(:score).permit(:left_team_id,:right_team_id,:game_time,:serve_user_id,:match_point,:deuce,:last_score_of_left,:last_score_of_right)
    game_score = params.require(:game).require(:score).permit(:action => [],:position => [],:time_to_drop_shuttle => [],:scores_users => [],:conceded_users =>[])
    #User Authorization
    ##Write Here....

    #Registor ScoreGame info
    g = ScoreGame.create(game_info)

    #Retate with users table
    ScoreGameToUser.create(user_id:players["left_user_id_1"],score_game_id:g.id)
    ScoreGameToUser.create(user_id:players["left_user_id_2"],score_game_id:g.id)
    ScoreGameToUser.create(user_id:players["right_user_id_1"],score_game_id:g.id)
    ScoreGameToUser.create(user_id:players["right_user_id_2"],score_game_id:g.id)

    #Registor Scores
    game_score["action"].zip(game_score["position"],game_score["time_to_drop_shuttle"],game_score["scores_users"],game_score["conceded_users"]) do |a|
      req = {action:a[0],position:a[1],time_to_drop_shuttle:a[2],scores_user_id:a[3],conceded_user_id:a[4],score_game_id:g.id}
      Score.create(req)
    end
    render json: {status:0,message:"ok"}
  end
end
