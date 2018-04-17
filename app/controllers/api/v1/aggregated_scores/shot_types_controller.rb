class Api::V1::AggregatedScores::ShotTypesController < Api::V1::AggregatedScores::BaseController
  def show
      scores = Score.of_user_games(current_api_v1_user, params[:game_user_count])
        .where(shot_type_id: params[:id])
        .where(is_net_miss: false)
      @counts = {}
      @counts[0] = aggregated_by_position(scores.of_not_user_units(current_api_v1_user))
      @counts[1] = aggregated_by_position(scores.of_user_units(current_api_v1_user))
  end
end
