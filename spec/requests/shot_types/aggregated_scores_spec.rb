require 'rails_helper'

RSpec.describe "shot_types/AggregatedScore", type: :request do
  before do
    @unit = create(:unit)
    @game = create(:game)
    @unit.games << @game

    @opponent_unit = create(:unit)
    @opponent_unit.games << @game

    @user = create(:user)
    @opponent_user = create(:user)

    @unit.users << @user
    @opponent_unit.users << @opponent_user

    @score =  Score.create(game_id: @game.id, shot_type_id: 1, dropped_side: 1, unit_id: @unit.id, position_id: 1)
    @game.scores << @score
    #TODO 共通処理として切り出す
    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    auth_header = @user.create_new_auth_token
    @headers.merge! auth_header
  end

  describe "GET /api/v1/shot_types/:shot_type_id/aggregated_scores" do
    describe "index" do
      let(:params){{
          game_user_count: 2,
          shot_type_id: 1,
          opponent_users_ids: "2"
        }}

      let(:current_api_v1_user){@user}

      subject do
        get "/api/v1/shot_types/:shot_type_id/aggregated_scores",  params: params, as: :json,headers: @headers
      end

      it "return 200" do
        subject
        expect(response).to have_http_status(200)
      end

      it "正しくscoreを分類して、集計する" do
        subject
        expect(json['counts'].length).to eq 2
      end
    end
  end
end