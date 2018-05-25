require 'rails_helper'

RSpec.describe Unit, :type => :model do

  let(:unit) { create(:unit, user_count: 2) }
  let(:opponent_unit) { create(:unit, user_count: 2) }
  let(:single_unit) { create(:unit, user_count: 1)  }
  let(:user) { create(:user) }
  let(:users) { [create(:user), create(:user)] }
  let(:opponent_users) { [create(:user), create(:user)] }
  let(:new_user) { create(:user) }

  before do
    unit.users << users
    opponent_unit.users << opponent_users
    single_unit.users << user
  end


    describe "self.of_users(users)" do
      context 'usersが2つあった場合' do
        it "usersをもつUnitを返す" do
          expect(Unit.of_users(users).ids).to eq [unit.id]
        end
      end

      context 'usersが１つの場合' do
        it "usersをもつUnitを返す"  do
          expect(Unit.of_users([user]).ids).to eq [single_unit.id]
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
