class Api::V1::AnalyticsController < Api::V1::BaseController
  def create
    game =  Game.find_by(id: params[:game_id])
    service = AnalysisResultService.new(current_user, game)
    if service.execute
    else
    end
  end
end
