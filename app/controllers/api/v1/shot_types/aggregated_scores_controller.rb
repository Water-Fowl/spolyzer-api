# frozen_string_literal: true
class Api::V1::ShotTypes::AggregatedScoresController < Api::V1::BaseController
  before_action :set_opponent_users

  def index
    if @opponent_users.present?
      set_scores_with_opponent_users
    else
      set_scores
    end
    set_aggregated_scores
  end

  private

  def set_scores
    @scores = Score.of_user_games(current_api_v1_user, params[:game_user_count])
                  .where(shot_type_id: params[:shot_type_id])
                  .where(is_net_miss: false)
  end

  def set_scores_with_opponent_users
    @scores = Score
              .of_opponent_users_games(
                current_api_v1_user,
                @opponent_users,
                params[:game_user_count]
              )
              .where(shot_type_id: params[:shot_type_id])
              .where(is_net_miss: false)
  end

  def set_opponent_users
    opponent_users_ids = params[:opponent_users_ids].split(',').map(&:to_i)
    @opponent_users = User.find(opponent_users_ids)
  end

  def set_aggregated_scores
    @counts = {}
    @counts[0] = aggregate_position(
      @scores.of_not_user_units(current_api_v1_user)
    )
    @counts[1] = aggregate_position(
      @scores.of_user_units(current_api_v1_user)
    )
  end

  def aggregate_position(scores)
    if !scores.empty?
      scores
        .group('scores.position_id')
        .count.reduce({}) do |count, (key, value)|
        dropped_at = key
        count ||= {}
        count[dropped_at] ||= value
        count
      end
    else
      []
    end
  end

end
