class GameCreateService
  def initialize(params)
    @params = params
  end

  def execute
    left_side = 0
    right_side = 1

    #TODO Sport ID
    sport = Sport.find_by(name_ja: @params[:game][:sport_name])
    game = Game.create(name: @params[:game][:name], sport_id: sport.id)

    left_user_count = @params[:units][left_side.to_s][:count]
    left_unit = Unit.create(side: left_side, user_count: left_user_count, game_id: game.id)

    left_user_count.times do |i|
      left_user = @params[:units][left_side.to_s][:users][i]
      if left_user
        left_user_id = left_user[:id]
        left_unit.user_units.create(
          user_id: left_user_id,
        )
      end
    end

    right_user_count = @params[:units][right_side.to_s][:count]
    right_unit = Unit.create(side: right_side, user_count: right_user_count, game_id: game.id)

    right_user_count.times do |i|
      right_user = @params[:units][right_side.to_s][:users][i]
      if right_user
        right_user_id = right_user[:id]
        right_unit.user_units.create(
          user_id: right_user_id,
        )
      end
    end

    @params[:scores].each do |score|
      # 落ちたsideの反対sideのUnitが、得点したUnit
      @score = Score.create(unit_id: score[:side] == 1 ? left_unit.id : right_unit.id,
                            miss_type: score[:miss_type],
                            shot_type_id: score[:shot_type],
                            game_id: game.id)
      Position.create(score_id: @score.id,
                      dropped_at: score[:dropped_at],
                      side: score[:side])
    end
    game
  end


  private def opponent_user
    @opponent_user ||= User.find(params[:opponent_user_id])
  end
end
