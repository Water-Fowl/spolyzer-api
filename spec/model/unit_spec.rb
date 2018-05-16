require 'rails_helper'

RSpec.describe Unit, :type => :model do

  before(:each) do
    create(:unit, user_count: 2)
    create(:unit, user_count: 2)
    create(:unit)
    game = create(:game)

    Unit.first.games << game
    Unit.second.games << game
    Unit.first.users << create(:user)
    Unit.first.users << create(:user)
    Unit.second.users << create(:user)
    Unit.second.users << create(:user)


    game = create(:game)
    Unit.find(3).games << game
    Unit.find(3).users << create(:user)
  end

  let(:unit) { Unit.first }
  let(:users) { unit.users }
  let(:user) { [Unit.find(3).users.first] }
  let(:new_user) { create(:user) }

  describe "scopes" do
    describe "of_doubles_users" do
      it "指定した二人が含まれるunitを返す" do
        expect(Unit.of_doubles_users(users).ids).to eq Unit.where(id: Unit.first.id).ids
      end
    end
  end


    describe "self.of_users(users)" do
      context 'opponent_usersが2つあった場合' do
        it "opponent_usersをもつUnitを返す" do
          expect(Unit.of_users(users).ids).to eq Unit.where(id: Unit.first.id).ids
        end
      end

      context 'opponent_usersが１つの場合' do
        it "opponent_usersをもつUnitを返す"  do
          expect(Unit.of_users(user).ids).to eq Unit.where(id: Unit.find(3).id).ids
        end
      end
    end

    describe 'self.find_or_create_with_users(users)' do
      context 'self.of_usersで返されるunitが存在する場合' do
        it 'unitを返す' do
          expect(Unit.find_or_create_with_users(users).id).to eq unit.id
        end
      end

      subject { Unit.find_or_create_with_users([new_user]) }

      context 'self.of_usersで返されるunitが存在しない場合' do
        it 'unitが作成される' do
          expect{subject}.to change(Unit, :count).by(1)
        end

        it '新しく作成されたunitを返す' do
          expect(subject.id).to eq new_user.units.first.id
        end
      end
    end


end
