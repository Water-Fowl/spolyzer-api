class Api::V1::AimsController < Api::V1::BaseController
  before_action :set_positions_ids, :set_shot_types_ids, :set_opponent_users_ids

  def index
    current_api_v1_user.aims
  end

  def create
    create_aim
    create_aim_positions
    create_aim_opponent_users
    create_aim_shot_types
  end

  private

  def aim_params
    params.permit(
      :achieve_count,
      :is_my_score,
      :is_net_miss,
      :is_in,
      :user_count
    )
  end

  def create_aim
    @aim = Aim.create(
      user_id: current_api_v1_user.id,
      achieve_count: aim_params[:achieve_count],
      is_my_score: aim_params[:is_my_score],
      is_net_miss: aim_params[:is_net_miss],
      is_in: aim_params[:is_in],
      user_count: aim_params[:user_count],
    )
  end

  def create_aim_shot_types
    @shot_types_ids.each do |shot_type_id|
      @aim.aim_shot_types.create(shot_type_id: shot_type_id)
    end
  end

  def create_aim_positions
    @positions_ids.each do |position_id|
      @aim.aim_positions.create(position_id: position_id)
    end
  end

  def create_aim_opponent_users
    @opponent_users_ids.each do |opponent_user_id|
      @aim.aim_opponent_users.create(opponent_user_id: opponent_user_id)
    end
  end

  def set_positions_ids
    @positions_ids = params[:positions_ids]
  end

  def set_shot_types_ids
    @shot_types_ids = params[:shot_types_ids]
  end

  def set_opponent_users_ids
    @opponent_users_ids = params[:opponent_users_ids]
  end
end
