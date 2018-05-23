require 'rails_helper'

RSpec.describe "Score", :type => :model do

  let(:unit) { create(:unit) }
  let(:not_user_unit) { create(:unit) }
  let(:game) { create(:game) }
  let(:user) { create(:user) }
  let(:not_user) { create(:user) }
  let(:score) { Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: unit.id, position_id: 1, is_net_miss: false) }
  let(:not_user_unit_score) { Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: not_user_unit.id, position_id: 1, is_net_miss: false) }

  before  do
    unit.games << game
    game.units << not_user_unit
    unit.users << user
    not_user_unit.users << not_user
    game.scores << [score, not_user_unit_score]
  end

  describe "scopes" do


    describe "of_user_games" do
      it "userが含まれている試合のscoreを返す" do
        expect(Score.of_user_games(user, 1).pluck(:id)).to eq game.scores.pluck(:id)
      end
    end

    describe "of_user_units" do
      it "userが含まれているunitのscoreを返す" do
        expect(Score.of_user_units(user).pluck(:id)).to eq unit.scores.pluck(:id)
      end
    end

    describe "of_not_user_units" do
      it "userが含まれていないunitのscoreを返す" do
        expect(Score.of_not_user_units(user).pluck(:id)).to eq not_user_unit.scores.pluck(:id)
      end
    end

  end

end
