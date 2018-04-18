class Api::V1::AimsController < BaseController
  before_action :set_position_ids, :set_opponent_users_ids

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
    params.permit(:achive_count, :is_my_score, :is_net_miss, :is_out)
  end

  def create_aim
    @aim = Aim.create(user_id: current_api_v1_user.id, aim_params)
  end

  def create_aim_shot_types
    @shot_types_ids.each do |shot_type_id|
      @aim.aim_shot_type.create(shot_type_id: shot_type_id)
    end
  end

  def create_aim_positions
    @position_ids.each do |position_id|
      @aim.aim_position.create(position_id: position_id)
    end
  end

  def create_aim_opponent_users
    @opponent_users_ids.each do |opponent_user_id|
      @aim.aim_opponent_users.create(opponent_user_id: opponent_user_id)
    end
  end

  def set_position_ids
    @position_ids = params[:position_ids]
  end

  def set_opponent_user_ids
    @opponent_users_ids = params[:opponent_users_ids]
  end
end
