require 'rails_helper'

RSpec.describe "games/AggregatedScore", type: :request do

  let(:game) { create(:game) }
  let(:user) { create(:user) }
  let(:unit) { create(:unit) }

  before do
    unit.games << game 

    #TODO 共通処理として切り出す
    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    auth_header = user.create_new_auth_token
    @headers.merge! auth_header
  end

  describe "GET /api/v1/games/:game_id/aggregated_scores　#index" do

      let(:params) do
        {
          game_id: game.id
        }
      end

      before do
        game.scores << scores
      end

      subject do
        get "/api/v1/games/#{game.id}/aggregated_scores", headers: @headers
      end

      it "ステータスコード200を返す" do
        subject
        expect(response).to have_http_status(200)
      end


      context "全て同じscoreの場合" do
        let(:scores) { [Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1)]}
      
        it "scoreの集計を送る" do
          subject
          expect(json['counts'].count).to eq 1
        end
      end
      
      context "drppped_side: 0が２つ、1が３つの場合" do
        let(:scores) { [Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 0, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 0, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1)]}
      
        it "scoreの集計を送る" do
          subject

          
          binding.pry
          
          expect(json['counts'].first.count).to eq 2 
        end
      end

      context "shot_type_idが全て異なる場合" do
        let(:scores) { [Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 2, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 3, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 4, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 5, dropped_side: 1, unit_id: unit.id, position_id: 1)]}
      
        it "scoreの集計を送る" do
          subject
          expect(json['counts']['1']['1'].length).to eq 5
        end
      end
      
  end
end
