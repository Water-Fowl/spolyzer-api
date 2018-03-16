class CountPositionsService
  def initialize(params, user_to_analyze)
    @params = params
    @user_to_analyze = user_to_analyze
  end

  def execute
    user_ids = @params[:user_ids].split(",").map{|id| id.to_i }
    scores = Score
      .of_users_games(user_ids)
      .includes(:position)

    runs_scored = scores
      .of_user_units(user_to_analyze.id)
      .where(miss_type: 0)

    runs_against = scores
      .of_not_user_units(user_to_analyze.id)
      .where(miss_type: 0)
    return self.reshape(runs_scored), self.reshape(runs_against)
  end

  private_class_method
  def reshape(scores)
    count_positions = scores
      .group('positions.dropped_at')
      .count.reduce({}) do |count, (key, value)|
      dropped_at = key
      count ||= {}
      count[dropped_at] ||= value
      count
    end
  end
end
