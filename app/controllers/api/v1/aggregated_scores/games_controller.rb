class Api::V1::AggregatedScores::GamesController < Api::V1::AggregatedScores::BaseController

  def show
    game = Game.find params[:id]
    scores = game.scores
    @counts = aggregated(scores)
  end

end
