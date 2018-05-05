require 'rails_helper'

RSpec.describe "Score", :type => :model do
  before(:each) do
    @unit = create(:unit)
    @game = create(:game)
    @unit.games << @game
    @game.units << create(:unit)
    @user = create(:user)
    Unit.first.users << FactoryBot.create(:user, name: "test1", email: "test4@test.com")
    Unit.second.users << FactoryBot.create(:user, name: "test2", email: "test5@test.com")
  end
  describe "scopes" do

    describe "of_opponent_users_games" do
      it "user vs opponent_users の試合におけるスコアの検索" do
        expect(Score.of_opponent_users_games(Unit.first.users.first, Unit.second.users, 1).pluck(:id)).to eq @game.scores.pluck(:id)
      end
    end

    describe "of_user_games" do
      it "userが含まれている試合のscore検索" do
        expect(Score.of_user_games(Unit.first.users.first, 1).pluck(:id)).to eq Unit.first.users.first.games.first.scores.pluck(:id)
      end
    end

    describe "of_user_units" do
      it "userが含まれているunitのscoreの検索" do
        expect(Score.of_user_units(Unit.first.users.first).pluck(:id)).to eq Unit.first.scores.pluck(:id)
      end
    end

    describe "of_not_user_units" do
      it "userが含まれていないunitの検索" do
        expect(Score.of_not_user_units(Unit.first.users.first).pluck(:id)).to eq Unit.second.scores.pluck(:id)
      end
    end

  end

end
