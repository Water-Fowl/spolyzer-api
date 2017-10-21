class ScoreGameToUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_score_game_to_user, only: [:show, :update, :destroy]
  # GET /score_game_to_users
  def index
    @score_game_to_users = ScoreGameToUser.all

    render json: @score_game_to_users
  end

  # GET /score_game_to_users/1
  def show
    render json: @score_game_to_user
  end

  # POST /score_game_to_users
  def create
    @score_game_to_user = ScoreGameToUser.new(score_game_to_user_params)

    if @score_game_to_user.save
      render json: @score_game_to_user, status: :created, location: @score_game_to_user
    else
      render json: @score_game_to_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /score_game_to_users/1
  def update
    if @score_game_to_user.update(score_game_to_user_params)
      render json: @score_game_to_user
    else
      render json: @score_game_to_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /score_game_to_users/1
  def destroy
    @score_game_to_user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score_game_to_user
      @score_game_to_user = ScoreGameToUser.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def score_game_to_user_params
      params.require(:score_game_to_user).permit(:user_id, :score_game_id)
    end
end
