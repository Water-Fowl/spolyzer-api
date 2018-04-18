# frozen_string_literal: true

class Api::V1::AggregatedScores::ShotTypes::OpponentUsersController < Api::V1::AggregatedScores::BaseController
  before_action :set_opponent_users, :set_game_user_count, :set_shot_type_id, :set_scores

  def show
    @counts = {}
    @counts[0] = aggregate_position(@scores.of_not_user_units(current_api_v1_user))
    @counts[1] = aggregate_position(@scores.of_user_units(current_api_v1_user))
    @counts
  end

  private

  def set_scores
    @scores = Score
              .of_opponent_users_games(
                current_api_v1_user,
                @opponent_users,
                @game_user_count
              )
              .where(shot_type_id: @shot_type_id)
              .where(is_net_miss: false)
  end

  def set_opponent_users
    opponent_user_ids = params[:id].split(',').map(&:to_i)
    @opponent_users = User.find(opponent_user_ids)
  end

  def set_game_user_count
    @game_user_count = params[:game_user_count]
  end

  def set_shot_type_id
    @shot_type_id = params[:shot_type_id]
  end
end
