require 'test_helper'

class Api::V1::GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_games_create_url
    assert_response :success
  end

end
