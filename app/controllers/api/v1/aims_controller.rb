class Api::V1::AimsController < Api::V1::BaseController
  def index

  end

  def show
  end

  def create
    #今までの試合からAimに該当するGameを紐付ける
    @games = AimsService.execute(params)
  end
end
