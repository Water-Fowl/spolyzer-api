class Api::V1::Aims::AggregatedScoresController < ApplicationController
  def index
    @aim = Aim.find(params[:aim_id])
    @scores = @aim.scores
    @aggregated_scores = aggregated_by_game
  end

  private
  def aggregated_by_game
    if !@scores.empty?
      @scores
        .group('scores.game_id')
        .count.reduce({}) do |count, (key, value)|
        game_id = key
        count ||= {}
        count[game_id] ||= value
        count
      end
    else
      []
    end
  end
end
