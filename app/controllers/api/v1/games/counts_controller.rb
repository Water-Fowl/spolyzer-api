class Api::V1::Games::CountsController < Api::V1::BaseController

  def index
    @count = Analytics::CountInGameService.execute(params)
  end
end
