class GameCreateService
  def initialize(params)
    @params = params
  end

  def execute
    left_side = 0
    right_side = 1

    sport = Sport.find_by(name_ja: @params[:game][:sport_name])
    game = Game.create(name: @params[:game][:name], sport_id: sport.id)

    left_unit = create_units(@params[:units], left_side)
    right_unit = create_units(@params[:units], right_side)
    create_scores(@params[:scores])
    game
  end

  private def create_units(units, side)
    user_count = unit[side.to_s][:count]
    unit = Unit.create(side: side, user_count: user_count, game_id: game.id)
    user_count.times do |i|
      user = unit[side.to_s][:users][i]
      if user
        user_id = user[:id]
        unit.user_units.create(
          user_id: user_id,
        )
      end
    end
    unit
  end

  private def create_scores(scores)
    scores.each do |score|
      # 落ちたsideの反対sideのUnitが、得点したUnit
      @score = Score.create(unit_id: score[:side] == 1 ? left_unit.id : right_unit.id,
                            miss_type: score[:miss_type],
                            shot_type_id: score[:shot_type],
                            game_id: game.id)
      Position.create(score_id: @score.id,
                      dropped_at: score[:dropped_at],
                      side: score[:side])
    end
  end
end
