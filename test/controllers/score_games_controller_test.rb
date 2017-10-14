require 'test_helper'

class ScoreGamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @score_game = score_games(:one)
  end

  test "should get index" do
    get score_games_url, as: :json
    assert_response :success
  end

  test "should create score_game" do
    assert_difference('ScoreGame.count') do
      post score_games_url, params: { score_game: { deuce: @score_game.deuce, game_time: @score_game.game_time, left_team_id: @score_game.left_team_id, match_point: @score_game.match_point, right_team_id: @score_game.right_team_id, serve_user_id: @score_game.serve_user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show score_game" do
    get score_game_url(@score_game), as: :json
    assert_response :success
  end

  test "should update score_game" do
    patch score_game_url(@score_game), params: { score_game: { deuce: @score_game.deuce, game_time: @score_game.game_time, left_team_id: @score_game.left_team_id, match_point: @score_game.match_point, right_team_id: @score_game.right_team_id, serve_user_id: @score_game.serve_user_id } }, as: :json
    assert_response 200
  end

  test "should destroy score_game" do
    assert_difference('ScoreGame.count', -1) do
      delete score_game_url(@score_game), as: :json
    end

    assert_response 204
  end
end
