class Api::V1::GamesController < ApplicationController
  def create
    #Permit Parameters
    user = params.require(:game).permit(:user_id,:token)
    game_info = params.require(:game).require(:score).permit(:left_team_id,:right_team_id,:game_time,:serve_user_id,:match_point,:deuce,:left_1,:left_2,:right_1,:right_2,:point_left,:point_right)
    game_score = params.require(:game).require(:score).permit(:action => [],:position => [],:time => [],:scores_users => [],:conceded_users =>[])
    #User Authorization
    ##Write Here....

    #Registor ScoreGame info
    g = ScoreGame.create(game_info)

    #Registor Scores
    game_score["action"].zip(game_score["position"],game_score["time"],game_score["scores_users"],game_score["conceded_users"]) do |a|
      req = {action:a[0],position:a[1],time:a[2],scores_user_id:a[3],conceded_user_id:a[4],score_game_id:g.id}
      Score.create(req)
    end

  end
end
