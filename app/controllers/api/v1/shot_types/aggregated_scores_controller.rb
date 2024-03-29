# frozen_string_literal: true

class Api::V1::ShotTypes::AggregatedScoresController < Api::V1::BaseController
  def index
    game_units = GameUnitsFinder.call(current_api_v1_user, game_params)
    scores = ScoresFinder.call(score_params(game_units.pluck(:game_id)))

    render json: scores, each_serializer: ScoreSerializer
  end

  private

  def score_params(game_ids)
    score_params = params.permit(:shot_type_id)
    score_params[:game_ids] = game_ids
    score_params[:is_net_miss] = false
    score_params
  end

  def game_params
    params.permit(:opponent_users_ids, :game_user_count, :outcome, :created_after, :created_before)
  end
end
