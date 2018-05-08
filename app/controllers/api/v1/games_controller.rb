# frozen_string_literal: true

class Api::V1::GamesController < Api::V1::BaseController

  def index
    @games = current_api_v1_user.games
  end

  def create
    @scores = params[:scores]
    @sport = Sport.find params[:sport_id]
    @units = params[:units]

    create_game

    @left_unit = find_or_create_units(:left)
    @right_unit = find_or_create_units(:right)

    create_scores

    create_outcome

  end

  private

  def create_game
    @game = Game.create(name: game_params[:name], sport_id: @sport.id)
  end

  def find_or_create_units(side)

    user_count = @units[side][:count]

    users = []
    user_count.times do |i|
      user = @units[side][:users][i]
      users.push(User.find(user[:id]))
    end

    unit = Unit.find_or_create_with_users(users)
    unit.game_units.create(game_id: @game.id, side: side)
    unit
  end

  def create_scores
    @scores.each do |score|
      if score[:is_net_miss]
        unit_id = score[:side] == 1 ? @right_unit.id : @left_unit.id
      else
        unit_id = score[:side] == 1 ? @left_unit.id : @right_unit.id
      end

      @score = Score.create(
        unit_id: unit_id,
        is_net_miss: score[:is_net_miss],
        shot_type_id: score[:shot_type],
        position_id: score[:dropped_at],
        dropped_side: score[:side],
        game_id: @game.id
      )
    end
  end

  def game_params
    params.require(:game).permit(:name)
  end

  def score_params
    params.require(:scores).permit(
      :is_net_miss,
      :shot_type_id,
      :position_id,
      :dropped_side)
  end

  def create_outcome

    score_count = @game.score_count
    right_game_unit = @game.game_units.find_by(side: :right)
    left_game_unit = @game.game_units.find_by(side: :left)

    if score_count[:left] > score_count[:right]
      right_game_unit.update(outcome: :lose)
      left_game_unit.update(outcome: :win)
    elsif score_count[:left] < score_count[:right]
      right_game_unit.update(outcome: :win)
      left_game_unit.update(outcome: :lose)
    else
      right_game_unit.update(outcome: :draw)
      left_game_unit.update(outcome: :draw)
    end

  end
end
