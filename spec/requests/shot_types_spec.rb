require 'rails_helper'

RSpec.describe "ShotTypes", type: :request do
  describe "GET /shot_types/:shot_type_id/counts" do
    let(:params) do
      { user_count: 1 }
    end
    before(:each) do
      @game = create(:game, :with_sport, :with_units, :with_scores)
      @user = create(:user)
    end
    subject do
      get "/api/v1/shot_types/1/counts", params: params, as: :json, headers: headers
    end
    it "should return 200 status" do
      subject
      expect(response).to have_http_status(200)
    end
  end
end
