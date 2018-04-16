module Analytics
  class CountService < Analytics::BaseService
    def execute
      scores = Score.of_user_games(@user, @params[:game_user_count])
        .where(shot_type_id: @params[:shot_type_id])
        .where(is_net_miss: false)
      counts = {}
      counts[0] = reshape(scores.of_not_user_units(@user))
      counts[1] = reshape(scores.of_user_units(@user))
      counts
    end
  end
end
