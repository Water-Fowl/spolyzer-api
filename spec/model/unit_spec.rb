require 'rails_helper'

RSpec.describe Unit, :type => :model do

  before(:each) do
    create(:unit, user_count: 2)
    create(:unit, user_count: 2)
    create(:unit)
    @game = create(:game)
    Unit.first.games << @game
    Unit.second.games << @game
    Unit.first.users << create(:user, name: "test1", email: "test1@test.com")
    Unit.first.users << create(:user, name: "test2", email: "test2@test.com")
    Unit.second.users << create(:user, name: "test3", email: "test3@test.com")
    Unit.second.users << create(:user, name: "test4", email: "test4@test.com")
    @users = User.first, User.second

    @game = create(:game)
    Unit.find(3).games << @game
    Unit.find(3).users << create(:user, name: "test5", email: "test5@test.com")
    @user = [Unit.find(3).users.first]
  end

  describe "scopes" do
    describe "of_doubles_users" do
      it "指定した二人が含まれるunitの検索" do
        expect(Unit.of_doubles_users(@users).ids).to eq Unit.where(id: Unit.first.id).ids
      end
    end


    describe "self.of_users" do
      it "opponent_usersをもつUnitを検索。opponent_usersが2つあった場合はダブルスとして検索。" do
        expect(Unit.of_users(@users).ids).to eq Unit.where(id: Unit.first.id).ids
      end

      it "opponent_usersをもつUnitを検索。opponent_usersが１つの場合"  do
        expect(Unit.of_users(@user).ids).to eq Unit.where(id: Unit.find(3).id).ids
      end
    end

  end

end
