require 'rails_helper'

RSpec.describe "ShotTypes", type: :request do
  describe "GET /aggregated_scores/shot_types/:shot_type_id" do

    let(:params) do
      { user_count: 1 }
    end

    before(:each) do
      @game = create(:game, :with_sport, :with_units, :with_scores)
      @user = create(:user)

      @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      auth_header = @user.create_new_auth_token
      @headers.merge! auth_header
    end

    subject do
      get "/api/v1/aggregated_scores/shot_types/1", params: params, as: :json, headers: @headers
    end
    it "should return 200 status" do
      subject
      expect(response).to have_http_status(200)
    end
  end
end
