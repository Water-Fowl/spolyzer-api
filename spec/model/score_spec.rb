require 'rails_helper'

RSpec.describe "Score", :type => :model do

  let(:unit) { create(:unit) }
  let(:game) { create(:game) }
  let(:user) { create(:user) }

  before  do
    unit.games << game
    game.units << create(:unit)
    Unit.first.users << create(:user)
    Unit.second.users << create(:user)
  end

  describe "scopes" do


    describe "of_user_games" do
      it "userが含まれている試合のscoreを返す" do
        expect(Score.of_user_games(Unit.first.users.first, 1).pluck(:id)).to eq Unit.first.users.first.games.first.scores.pluck(:id)
      end
    end

    describe "of_user_units" do
      it "userが含まれているunitのscoreを返す" do
        expect(Score.of_user_units(Unit.first.users.first).pluck(:id)).to eq Unit.first.scores.pluck(:id)
      end
    end

    describe "of_not_user_units" do
      it "userが含まれていないunitを返す" do
        expect(Score.of_not_user_units(Unit.first.users.first).pluck(:id)).to eq Unit.second.scores.pluck(:id)
      end
    end

  end

end
