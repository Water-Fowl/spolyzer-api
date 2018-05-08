# frozen_string_literal: true
class Api::V1::ShotTypes::AggregatedScoresController < Api::V1::BaseController

  def index
    set_opponent_users
    game_units = set_game_units

    if @opponent_users.present?
      opponent_game_units = set_opponent_game_units
      game_ids = game_units.pluck(:game_id) & opponent_game_units.pluck(:game_id)
    end
    game_ids ||= game_units.pluck(:game_id)

    set_scores(game_ids)
    set_aggregated_scores
  end

  private

  def set_opponent_users
    opponent_users_ids = params[:opponent_users_ids].split(',').map(&:to_i)
    @opponent_users = User.find(opponent_users_ids)
  end

  def set_game_units
    game_units = GameUnit.where(unit_id: Unit
      .joins(:users)
      .where(users: {id: current_api_v1_user.id})
      .where(user_count: params[:game_user_count])
      .pluck(:id))

    unless params[:outcome] == "all"
      game_units = game_units.where(outcome: params[:outcome])
    end

    game_units.where(created_at: [Time.parse(params[:created_after])..Time.parse(params[:created_before])])
  end

  def set_opponent_game_units
      opponent_units = Unit
        .joins(:users)
        .where.not(users: {id: current_api_v1_user.id})
        .of_users(@opponent_users)
        .where(user_count: params[:game_user_count])

      opponent_game_units = GameUnit.where(unit_id: opponent_units.pluck(:id))
  end

  def set_scores(game_ids)
    @scores = Score
      .where(game_id: game_ids)
      .where(shot_type_id: params[:shot_type_id])
      .where(is_net_miss: false)
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
      scores.group('scores.position_id').count.reduce({}) do |count, (key, value)|
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
