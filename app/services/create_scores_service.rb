class CreateScoresService
  include BaseService

  attr_reader :params, :game_id, :left_unit, :right_unit, :current_api_v1_user

  def initialize(params, game_id, left_unit, right_unit, current_api_v1_user)
    @params = params
    @game_id = game_id
    @left_unit = left_unit
    @right_unit = right_unit
  end

  def call
    params.each do |score_params|
      if score_params[:is_net_miss]
        unit_id = score_params[:side] == 1 ? right_unit.id : left_unit.id
      else
        unit_id = score_params[:side] == 1 ? left_unit.id : right_unit.id
      end
      Score.create(
        game_id: game_id,
        unit_id: unit_id,
        is_net_miss: score_params[:is_net_miss],
        shot_type_id: score_params[:shot_type],
        position_id: score_params[:dropped_at],
        dropped_side: score_params[:side],
      )
    end
  end

end
