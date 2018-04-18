require 'rails_helper'
require 'request_helper'

RSpec.describe "Games", type: :request do
  describe "GET /games/:game_id/counts" do
    before(:each) do
      @game = create(:game, :with_sport, :with_units, :with_scores)
      @user = create(:user)

      #TODO 共通処理として切り出す
      @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      auth_header = @user.create_new_auth_token
      @headers.merge! auth_header
    end

    subject do
      get "/api/v1/games/#{@game.id}/aggregated_scores", headers: @headers
    end

    it "return 200" do
      subject
      expect(response).to have_http_status(200)
    end

  end

  describe 'POST #create' do
    before do
      create(:sport)
      @user = create(:user)

      @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      auth_header = @user.create_new_auth_token
      @headers.merge! auth_header
    end
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
    subject do
      post "/api/v1/games", params: params, as: :json, headers: @headers
    end
    it 'return 200' do
      subject
      expect(response.status).to eq 200
    end
    it 'Gameが1つ作成される' do
      expect{ subject }.to change(Game, :count).by(1)
    end
    it 'Unitが2つ作成される' do
      expect{ subject }.to change(Unit, :count).by(2)
    end
    it 'Scoreが5つ作成される' do
      expect{ subject }.to change(Score, :count).by(5)
    end
  end
end
