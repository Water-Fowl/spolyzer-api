class Api::V1::GamesController < Api::V1::BaseController

  def create
    oppnent_user = User.find(params[:opponent_user_id])
    service = GameCreateService.new(params)
    result = service.execute
    if result
      # TODO: message
      @message = 'message'
    else
      @message = 'failed'
    end
  end

  def show
    @game = Game.find params[:id]
    @shot_types = @game.sport.shot_types
    @winner_scores = @game.winner.scores.count
    @loser_scores  = @game.loser.scores.count
  end
end
