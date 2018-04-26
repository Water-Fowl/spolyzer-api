require 'rails_helper'

RSpec.describe Unit, :type => :model do

  before(:each) do
    @game = create(:game, :with_sport, :with_units, :with_scores)
    Unit.first.users << FactoryBot.create(:user, name: "test1", email: "test1@test.com")
    Unit.first.users << FactoryBot.create(:user, name: "test2", email: "test2@test.com")
    Unit.second.users << FactoryBot.create(:user, name: "test3", email: "test3@test.com")
    Unit.second.users << FactoryBot.create(:user, name: "test4", email: "test4@test.com")
    @users = User.first, User.second
  end

  describe "scopes" do
    describe "of_doubles_users" do
      it "指定した二人が含まれるunitの検索" do
        expect(Unit.of_doubles_users(@users).ids).to eq Unit.where(id: Unit.first.id).ids
      end
    end

    describe "self.of_users" do
      it "opponent_usersをもつUnitを検索。opponent_usersが2つあった場合はダブルスとして検索。" do
        @game2 = create(:game,:with_sport, :with_units, :with_scores)
        Unit.find(3).users << FactoryBot.create(:user, name: "test5", email: "test5@test.com")
        Unit.find(4).users << FactoryBot.create(:user, name: "test6", email: "test6@test.com")
        @users2 = [Unit.find(4).users.first]
        expect(Unit.of_users(@users).ids).to eq Unit.where(id: Unit.first.id).ids

        expect(Unit.of_users(@users2).ids).to eq Unit.where(id: Unit.find(4).id).ids

      end
    end

  end

end
