class Api::V1::AimsController < Api::V1::BaseController

  def index
    @aims = current_api_v1_user.aims
  end

  def create
    create_aim
    create_aim_positions
    create_aim_opponent_users
    create_aim_shot_types
  end

  private

  def create_aim
    @aim = Aim.new(aim_params)
    @aim.user = current_api_v1_user
    @aim.save
  end

  def create_aim_positions
    params[:position_ids].each do |position_id|
      @aim.aim_positions.create(position_id: position_id)
    end
  end

  def create_aim_opponent_users
    params[:opponent_users_ids].each do |opponent_user_id|
      @aim.aim_opponent_users.create(opponent_user_id: opponent_user_id)
    end
  end

  def create_aim_shot_types
    params[:shot_types_ids].each do |shot_type_id|
      @aim.aim_shot_types.create(shot_type_id: shot_type_id)
    end
  end

  def aim_params
    params.permit(
      :achieve_count,
      :is_my_score,
      :is_net_miss,
      :is_in,
      :user_count
    )
  end

end
