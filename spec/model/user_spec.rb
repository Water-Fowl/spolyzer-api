require 'rails_helper'

RSpec.describe User, :type => :model do
    before(:each) do
      @game = create(:game, :with_sport, :with_units, :with_scores)
      Unit.first.users << FactoryBot.create(:user, name: "test1", email: "test1@test.com")
      Unit.second.users << FactoryBot.create(:user, name: "test2", email: "test2@test.com")
      @user1 = Unit.first.users.first
      @user2 = Unit.second.users.first
    end

    describe "latest_result" do
      it "最新の分析結果を検索" do

      end
    end

    describe "total_score" do
      it "指定したuserのgameの合計点数を返す" do
        #binding.pry
        #expect(@user1.total_score(@game.id)).to eq @game.scores.where(unit_id: Unit.first.id)
      end
    end

end
