module ShotTypes
  class CountService
    def initialize(params, user)
      @params = params
      @user = user
    end

    def execute
      scores = Score.of_user_games(@user)
        .where(shot_type_id: @params[:shot_type_id])
        .where(miss_type: 0)
      counts = {}
      counts[0] = reshape(scores.of_user_units(@user))
      counts[1] = reshape(scores.of_not_user_units(@user))
    end
  end
