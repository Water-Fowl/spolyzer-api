class ScoreGamesController < ApplicationController
  before_action :set_score_game, only: [:show, :update, :destroy]

  # GET /score_games
  def index
    @score_games = ScoreGame.all

    render json: @score_games
  end

  # GET /score_games/1
  def show
    render json: @score_game
  end

  # POST /score_games
  def create
    @score_game = ScoreGame.new(score_game_params)
    if @score_game.save
      render json: @score_game, status: :created, location: @score_game
    else
      render json: @score_game.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /score_games/1
  def update
    if @score_game.update(score_game_params)
      render json: @score_game
    else
      render json: @score_game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /score_games/1
  def destroy
    @score_game.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score_game
      @score_game = ScoreGame.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def score_game_params
      params.require(:score_game).permit(:left_team_id, :right_team_id, :game_time, :serve_user_id, :deuce, :match_point)
    end
    
    def score_game_to_user_params(user_id, score_game_id)
      params.require(:score_game_to_user).permit(user_id, score_game_id)
    end
end
