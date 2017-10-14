require 'test_helper'

class ScoreGameToUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @score_game_to_user = score_game_to_users(:one)
  end

  test "should get index" do
    get score_game_to_users_url, as: :json
    assert_response :success
  end

  test "should create score_game_to_user" do
    assert_difference('ScoreGameToUser.count') do
      post score_game_to_users_url, params: { score_game_to_user: { score_game_id: @score_game_to_user.score_game_id, user_id: @score_game_to_user.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show score_game_to_user" do
    get score_game_to_user_url(@score_game_to_user), as: :json
    assert_response :success
  end

  test "should update score_game_to_user" do
    patch score_game_to_user_url(@score_game_to_user), params: { score_game_to_user: { score_game_id: @score_game_to_user.score_game_id, user_id: @score_game_to_user.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy score_game_to_user" do
    assert_difference('ScoreGameToUser.count', -1) do
      delete score_game_to_user_url(@score_game_to_user), as: :json
    end

    assert_response 204
  end
end
