require 'test_helper'

class AimsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_aims_path
    assert_response :success
  end

  test "should get show" do
    get api_v1_aim_path
    assert_response :success
  end

  test "should get create" do
    post api_v1_aims_path
    assert_response :success
  end

end
