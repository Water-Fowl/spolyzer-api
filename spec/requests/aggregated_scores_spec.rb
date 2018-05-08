require 'rails_helper'

RSpec.describe "AggregatedScore", type: :request do
  before do
    @unit = create(:unit)
    @game = create(:game)
    @unit.games << @game
    @user = create(:user)

    #TODO 共通処理として切り出す
    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    auth_header = @user.create_new_auth_token
    @headers.merge! auth_header
  end

  describe "GET games/:game_id/show" do
    describe "index" do
      let(:params) do
        {
          units: {
            "0": {users: [{id: 1}], count: 1},
            "1": {users: [{id: 2}], count: 1},
            ids: [1, 2]
          },
          scores: [
            {unit: 0, dropped_at: 1, shot_type: 1, miss_type: 0, side: 0},
            {unit: 0, dropped_at: 2, shot_type: 2, miss_type: 0, side: 0},
            {unit: 1, dropped_at: 3, shot_type: 3, miss_type: 0, side: 1},
            {unit: 1, dropped_at: 4, shot_type: 4, miss_type: 0, side: 1},
            {unit: 1, dropped_at: 5, shot_type: 5, miss_type: 0, side: 1}
          ],
          game: {name: "トレーニングマッチ"} ,
          sport_id: 1
        }
      end

      let(:current_api_v1_user){@user}

      subject do
        get "/api/v1/games/#{@game.id}/aggregated_scores", headers: @headers
      end

      it "return 200" do
        subject
        expect(response).to have_http_status(200)
      end
    end
  end
end
