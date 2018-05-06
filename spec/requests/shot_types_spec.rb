require 'rails_helper'

RSpec.describe "ShotTypes", type: :request do

  before(:each) do
    @left_unit = create(:unit)
    @right_unit = create(:unit)
    @game = create(:game, :with_scores, units: [@left_unit, @right_unit])
    @left_unit.games << @game
    @right_unit.games << @game
    @user = create(:user)

    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    auth_header = @user.create_new_auth_token
    @headers.merge! auth_header
  end

  describe "GET /api/v1/shot_types" do


      subject(:index_action) do
        get "/api/v1/shot_types", params: params, as: :json, headers: @headers
      end

      it "should return 200 status" do
        index_action
        expect(response).to have_http_status(200)
      end

  end
end
