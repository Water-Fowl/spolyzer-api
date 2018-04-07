class Api::V1::ShotTypes::Counts::OpponentUsersController < Api::V1::BaseController
  def show
    @counts = Analytics::CountWithOpponentUserService.execute(params, current_api_v1_user)
    binding.pry
  end
end
