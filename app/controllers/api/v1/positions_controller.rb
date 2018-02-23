class Api::V1::PositionsController < ApplicationController
  def counts
    @counts ||= Score
      .includes(:user)
      .where(users: {name: params[:name]})
      .joins(:position)
      .group('positions.dropped_at', 'positions.side')
      .count
  end
end
