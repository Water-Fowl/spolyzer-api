class Api::V1::Games::CountsController < Api::V1::BaseController

  def index
    @count = CountShotTypeService.new(params).execute
  end
end
