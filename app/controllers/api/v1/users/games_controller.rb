class Api::V1::Users::GamesController < Api::V1::BaseController
  def index
    @games = current_api_v1_users.games
  end
end
