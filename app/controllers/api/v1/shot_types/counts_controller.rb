class Api::V1::ShotTypes::CountsController < Api::V1::BaseController
  def index
    @counts = CountPositionsService.execute(params, current_api_v1_user)
  end
end
