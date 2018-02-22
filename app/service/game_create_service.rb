class GameCreateService
  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def execute
    if game = Game.create(name: params[:game_name]) &&
      GameUser.create(game_id: game.id, user_id: @current_user.id) &&
      GameUser.create(game_id: game.id, user_id: opponent_user.id)
      true
    else
      false
    end
  end


  private def opponent_user
    @opponent_user ||= User.find(params[:opponent_user_id])
  end
end
