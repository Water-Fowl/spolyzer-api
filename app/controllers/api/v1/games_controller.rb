# frozen_string_literal: true

class Api::V1::GamesController < Api::V1::BaseController

  def index
    @games = current_api_v1_user.games
  end

  def create
    @scores = params[:scores]
    @sport = Sport.find params[:sport_id]
    @units = params[:units]

    left_side = 0
    right_side = 1

    create_game
    @left_unit = create_units(left_side)
    @right_unit = create_units(right_side)
    create_scores
  end

  private

  def create_game
    @game = Game.create(name: params[:game][:name], sport_id: @sport.id)
  end

  def create_units(side)
    user_count = @units[side.to_s][:count]

    unit = Unit.create(
      side: side,
      user_count: user_count,
      game_id: @game.id
    )

    user_count.times do |i|
      user = @units[side.to_s][:users][i]
      unit.user_units.create(user_id: user[:id])
    end

    unit
  end

  def create_scores
    @scores.each do |score|
      @score = Score.create(
        unit_id: score[:side] == 1 ? @left_unit.id : @right_unit.id,
        is_net_miss: score[:is_net_miss],
        shot_type_id: score[:shot_type],
        position_id: score[:dropped_at],
        dropped_side: score[:side],
        game_id: @game.id
      )
    end
  end

  def game_params
    params.require(:users, :scores, :game)
  end

end
