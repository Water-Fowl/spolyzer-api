require 'rails_helper'

RSpec.describe Position, type: :request do
  before(:each) do
    @game = create(:game, :with_sport, :with_units, :with_scores)
    @user = create(:user)
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

  let(:current_api_v1_user){@user}

  describe "counts" do
    it "現在のユーザーのスコアの集計" do
      binding.pry
      expect(Position.first.counts).to eq 1
    end

    it "現在のユーザーの相手のスコアの集計" do

    end
  end
end
