class Api::V1::ShotTypes::Counts::OpponentUsersController < Api::V1::BaseController
  def index
    @counts = CountPositionsService.new(params, current_api_v1_user).counts_with_opponent_users
  end
end
