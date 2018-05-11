require 'rails_helper'

RSpec.describe "games/AggregatedScore", type: :request do
  before do
    unit = create(:unit)
    @game = create(:game)
    unit.games << @game
    @user = create(:user)
    score =  Score.create(game_id: @game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1)
    @game.scores << score
    score =  Score.create(game_id: @game.id, shot_type_id: 2, dropped_side: 1, unit_id: unit.id, position_id: 2)
    @game.scores << score

    #TODO 共通処理として切り出す
    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    auth_header = @user.create_new_auth_token
    @headers.merge! auth_header
  end

  describe "GET /api/v1/games/:game_id/aggregated_scores　#index" do
      let(:params) do
        {
          game_id: @game.id
        }
      end

      let(:current_api_v1_user){@user}

      subject do
        get "/api/v1/games/#{@game.id}/aggregated_scores", headers: @headers
      end

      it "ステータスコード200を返す" do
        subject
        expect(response).to have_http_status(200)
      end

      it "scoreの集計を送る" do
        subject
        expect(json['counts'].length).to eq 1
      end
  end
end
