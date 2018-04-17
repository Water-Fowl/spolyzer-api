module Analytics
  class CountWithOpponentUserService < Analytics::BaseService
    def execute
      opponent_user_ids = @params[:id].split(",").map{|id| id.to_i }
      opponent_users = User.find(opponent_user_ids)
      game_user_count = @params[:game_user_count]
      scores = Score
        .of_opponent_users_games(@user, opponent_users, game_user_count)
        .where(shot_type_id: @params[:shot_type_id])
        .where(is_net_miss: false)
      counts = {}
      counts[0] = reshape(scores.of_not_user_units(@user))
      counts[1] = reshape(scores.of_user_units(@user))
      counts
    end
  end
end
