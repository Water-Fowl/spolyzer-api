class CountPositionsService
  include Const

  def initialize(params, user_to_analyze)
    @params = params
    @user_to_analyze = user_to_analyze
  end

  def execute
    opponent_user_ids = @params[:user_ids].split(",").map{|id| id.to_i }
    opponent_users = User.find(opponent_user_ids)
    game_user_count = @params[:game_user_count]
    analyze_term = [term_const(@params[:term].to_i).ago..Time.now]

    scores = Score
      .of_opponent_users_games(@user_to_analyze, opponent_users, game_user_count)
      .where(created_at: analyze_term)

    runs_scored = scores
      .of_user_units(@user_to_analyze)
      .where(shot_type_id: @params[:shot_type_id])
      .where(miss_type: 0)
      .joins(:position)

    runs_against = scores
      .of_not_user_units(@user_to_analyze)
      .where(shot_type_id: @params[:shot_type_id])
      .where(miss_type: 0)
      .joins(:position)

    return self.reshape(runs_scored), self.reshape(runs_against)
  end

  private_class_method
  def reshape(scores)
    if not scores.empty?
      count_positions = scores
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
