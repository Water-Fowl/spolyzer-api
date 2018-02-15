class GameCreateService
  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def execute
    if game = Game.create(name: params[:game_name]) &&
      GameUser.create(game_id: game.id, user_id: @current_user.id) &&
      GameUser.create(game_id: game.id, user_id: oppnent_user.id)
      true
    else
      false
    end
  end

  def oppnent_user
    @oppnent_user ||= User.find(params[:oppnent_user_id])
  end
end
