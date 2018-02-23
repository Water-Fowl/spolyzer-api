class Api::V1::Positions::CountsController < ApplicationController
  def show
    @counts ||= Score
      .includes(:user)
      .where(users: {name: params[:name]})
      .joins(:position)
      .group('positions.dropped_at', 'positions.side')
      .count
  end
end
