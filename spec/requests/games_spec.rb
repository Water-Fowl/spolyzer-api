require 'rails_helper'
require "./spec/support/shared_stuff.rb"

RSpec.describe "Games", type: :request do
  
  include_context 'header'

  let(:unit) { create(:unit) }
  let(:game) { create(:game, record_user_id: user.id) }
  let(:opponent_unit) { create(:unit) }
  let(:opponent_user) { create(:user) }
  let(:score) { Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1) } 

  before do
    unit.games << game
    opponent_unit.games << game
    unit.users << user
    opponent_unit.users << opponent_user
    game.scores << score
  end

  describe "GET /api/v1/games #index" do

    let(:current_api_v1_user) { user }
    
    subject do
      get "/api/v1/games", headers: headers
    end

    it "ステータスコード200を返す" do
      subject
      expect(response).to have_http_status(200)
    end

    it "現在のユーザから取れるgameの情報を送る" do
      subject
      expect(json.length).to eq 1
    end
  end

  describe 'POST /api/v1/games #create' do

    let(:params) do
      {
        units: {
          left: {users: [{id: create(:user).id}], count: 1},
          right: {users: [{id: create(:user).id}], count: 1},
          ids: [3, 4]
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
      post "/api/v1/games", params: params, as: :json, headers: headers
    end

    it 'ステータスコード200を返す' do
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
