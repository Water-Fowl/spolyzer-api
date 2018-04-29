require 'rails_helper'

RSpec.describe User, :type => :model do
    before(:each) do
      @game = create(:game, :with_sport, :with_units, :with_scores)
      Unit.first.users << FactoryBot.create(:user, name: "test1", email: "test1@test.com")
      Unit.second.users << FactoryBot.create(:user, name: "test2", email: "test2@test.com")
      @user1 = Unit.first.users.first
      @user2 = Unit.second.users.first
    end

    let(:user) {User.new(email: "test@test.com")}
    
    it "nameが入っていないと無効" do
      expect(user).to_not be_valid
    end

    let(:user) {User.new(name: "test")}

    it "emailが入っていないと無効" do
      expect(user).to_not be_valid
    end

    describe "latest_result" do
      it "最新の分析結果を検索" do
        #expect(@user1.latest_result.ids).to eq  @user1.analysis_results.order(created_at: :asc).ids
      end
    end

end
