class Api::V1::GamesController < Api::V1::BaseController

  def index
    @games = current_user.games
  end

  def show
    @game = Game.find params[:id]
    @shot_types = @game.sport.shot_types
    @winner_scores = @game.winner.scores.count
    @loser_scores  = @game.loser.scores.count
  end

  def create
    service = GameCreateService.new(params)
    @game = service.execute
    if @game
      # TODO: message
      @message = 'message'
    else
      @message = 'failed'
    end
  end
  def game_params
    params.require(:users, :scores, :game)
  end
end
