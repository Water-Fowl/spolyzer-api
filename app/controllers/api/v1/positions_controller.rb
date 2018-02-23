class Api::V1::PositionsController < ApplicationController
  def show
    @game = Game
      .includes(:scores)
      .includes(:units)
      .includes(:users)
      .where(users: {name: params[:name]})
    @counts = @game.scores
      .joins(:position)
      .group('positions.id')
      .count
  end
end
