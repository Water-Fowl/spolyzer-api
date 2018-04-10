module Analytics
  class CountService < BaseService
    def execute
      scores = Score.of_user_games(@user, @params[:game_user_count])
        .where(shot_type_id: @params[:shot_type_id])
        .where(miss_type: 0)
      counts = {}
      counts[0] = reshape(scores.of_not_user_units(@user))
      counts[1] = reshape(scores.of_user_units(@user))
      counts
    end
  end
end
