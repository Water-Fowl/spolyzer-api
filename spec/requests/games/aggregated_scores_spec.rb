require 'rails_helper'
require "./spec/support/shared_stuff.rb"

RSpec.describe "games/AggregatedScore", type: :request do

  include_context 'header'

  let(:game) { create(:game, record_user_id: user.id) }
  let(:unit) { create(:unit) }

  before do
    unit.games << game 
  end

  describe "GET /api/v1/games/:game_id/aggregated_scores　#index" do

      let(:params) do
        {
          game_id: game.id
        }
      end

      subject do
        get "/api/v1/games/#{game.id}/aggregated_scores", headers: headers
      end

      let(:scores) { Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1) }

      it "ステータスコード200を返す" do
        subject
        expect(response).to have_http_status(200)
      end

      describe '返ってくるjsonの検証' do

        before do
          game.scores << scores
        end
        context "全て同じscoreの場合" do
          let(:scores) { [Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1)]}
        
          it "scoreの集計を送る" do
            subject
            expect(json.pluck('shot_type_id')).to eq scores.pluck(:shot_type_id)
          end
        end
        
        context "droppped_side: 0が２つ、1が３つの場合" do
          let(:scores) { [Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 0, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 0, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1)]}
        
          it "scoreの集計を送る" do
            subject
            expect(json.pluck('dropped_side')).to eq scores.pluck(:dropped_side) 
          end
        end

        context "shot_type_idが全て異なる場合" do
          let(:scores) { [Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 2, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 3, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 4, dropped_side: 1, unit_id: unit.id, position_id: 1), Score.create(game_id: game.id, shot_type_id: 5, dropped_side: 1, unit_id: unit.id, position_id: 1)]}
        
          it "scoreの集計を送る" do
            subject
            expect(json.pluck('shot_type_id')).to eq scores.pluck(:shot_type_id)
          end
        end
      end
  end
end
