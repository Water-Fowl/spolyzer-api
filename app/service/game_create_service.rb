class GameCreateService < BaseService

  def execute
    left_side = 0
    right_side = 1

    sport = Sport.find_by(name_ja: @params[:game][:sport_name])
    game = Game.create(name: @params[:game][:name], sport_id: sport.id)

    left_unit = create_units(@params[:units], left_side, game)
    right_unit = create_units(@params[:units], right_side, game)
    create_scores(@params[:scores], game, left_unit, right_unit)
    game
  end

  private def create_units(units, side, game)
    user_count = units[side.to_s][:count]
    unit = Unit.create(side: side, user_count: user_count, game_id: game.id)
    user_count.times do |i|
      user = units[side.to_s][:users][i]
      if user
        user_id = user[:id]
        unit.user_units.create(
          user_id: user_id,
        )
      end
    end
    unit
  end

  private def create_scores(scores, game, left_unit, right_unit)
    scores.each do |score|
      # 落ちたsideの反対sideのUnitが、得点したUnit
      @score = Score.create(unit_id: score[:side] == 1 ? left_unit.id : right_unit.id,
                            miss_type: score[:miss_type],
                            shot_type_id: score[:shot_type],
                            dropped_at: score[:dropped_at],
                            dropped_side: score[:side],
                            game_id: game.id)
    end
  end
end
