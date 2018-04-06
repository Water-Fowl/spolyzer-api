class CountPositionsService

  def initialize(params, user)
    @params = params
    @user = user
  end

  def counts_with_opponent_users
    opponent_user_ids = @params[:ids].split(",").map{|id| id.to_i }
    opponent_users = User.find(opponent_user_ids)
    game_user_count = @params[:game_user_count]
    scores = Score
      .of_opponent_users_games(@user, opponent_users, game_user_count)
      .where(shot_type_id: @params[:shot_type_id])
      .where(miss_type: 0)
    counts = {}
    counts[0] = reshape(scores.of_user_units(@user))
    counts[1] = reshape(scores.of_not_user_units(@user))
  end

  def counts
    scores = Score.of_user_games(@user)
      .where(shot_type_id: @params[:shot_type_id])
      .where(miss_type: 0)
    counts = {}
    counts[0] = reshape(scores.of_user_units(@user))
    counts[1] = reshape(scores.of_not_user_units(@user))
  end

  private
  def reshape
    if not scores.empty?
      count_positions = scores
        .joins(:position)
        .group('positions.dropped_at')
        .count.reduce({}) do |count, (key, value)|
        dropped_at = key
        count ||= {}
        count[dropped_at] ||= value
        count
      end
    else
      scores
    end
  end
end
