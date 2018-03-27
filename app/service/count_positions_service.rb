class CountPositionsService

  def initialize(params, user)
    @params = params
    @user = user
  end

  def execute
    opponent_user_ids = @params[:user_ids].split(",").map{|id| id.to_i }
    opponent_users = User.find(opponent_user_ids)
    game_user_count = @params[:game_user_count]
    analyze_term = [term(@params[:term].to_i).ago..Time.now]

    if not opponent_user_ids.empty?
      scores = Score
        .of_opponent_users_games(@user, opponent_users, game_user_count)
        .where(created_at: analyze_term)
    else
      scores = Score.of_user_games(@user, game_user_count)
    end

    runs_scored = scores
      .of_user_units(@user)
      .where(shot_type_id: @params[:shot_type_id])
      .where(miss_type: 0)
      .joins(:position)

    runs_against = scores
      .of_not_user_units(@user)
      .where(shot_type_id: @params[:shot_type_id])
      .where(miss_type: 0)
      .joins(:position)

    return reshape(runs_scored), reshape(runs_against)
  end

  private
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

  def term(id)
    case id
    when 0
      1.day
    when 1
      1.week
    when 2
      1.month
    end
  end
end
