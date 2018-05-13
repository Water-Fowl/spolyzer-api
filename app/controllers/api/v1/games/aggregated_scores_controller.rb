# frozen_string_literal: true

class Api::V1::Games::AggregatedScoresController < Api::V1::BaseController
  def index
    game = Game.find params[:game_id]
    scores = game.scores
    @counts = AggregatedScores::GameDecorator.call(scores)
  end

end
