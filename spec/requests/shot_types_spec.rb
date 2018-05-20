require 'rails_helper'

RSpec.describe "ShotTypes", type: :request do

  let(:user) { create(:user) }

  before(:each) do
    left_unit = create(:unit)
    right_unit = create(:unit)
    game = create(:game, :with_scores, units: [left_unit, right_unit])
    left_unit.games << game
    right_unit.games << game

    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    auth_header = user.create_new_auth_token
    @headers.merge! auth_header
  end

  let(:shot_types) { ShotType.where(sport_id: 1) }

  describe "GET /api/v1/shot_types #index" do


      subject do
        get "/api/v1/shot_types", params: params, as: :json, headers: @headers
      end

      it "ステータスコード200を返す" do
        subject
        expect(response).to have_http_status(200)
      end

      let(:params) { {sport_id: 1} }

      it "shot_typesを送る" do
        subject
        expect(json['shot_types'].pluck('id')).to eq shot_types.pluck(:id)
      end

  end
end
