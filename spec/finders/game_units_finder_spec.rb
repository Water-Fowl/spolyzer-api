require "rails_helper"

RSpec.describe 'GameUnitsFinder', :type => :finder do
  
  let(:game) { create(:game) }  
  let(:unit) { create(:unit) }  
  let(:opponent_unit) { create(:unit) }
  let(:current_user) { create(:user) }
  let(:opponent_user) { create(:user) }
  let!(:game_units) { [GameUnit.create(game_id: game.id, unit_id: unit.id, side: 1, outcome: 2),GameUnit.create(game_id: game.id, unit_id: unit.id, side: 0, outcome: 2)] } 
  let!(:user_unit) { UserUnit.create(unit_id: unit.id, user_id: current_user.id) }
  let!(:game_opponent_unit) { GameUnit.create(game_id: game.id, unit_id: opponent_unit.id, side: 0, outcome: 0) } 
  let!(:opponent_user_unit) { UserUnit.create(unit_id: opponent_unit.id, user_id: opponent_user.id) }

  describe '#call' do
    let(:params) do
        { 
            opponent_users_ids: opponent_user.id.to_s,
            game_user_count: 1,
            outcome: 2,
            created_after: game_units.second.created_at.to_s,
            created_before: game_units.first.created_at.to_s
        }
    end
    
    it 'return GameUnit searched by params' do
      searched_game_unit = GameUnitsFinder.call(current_user, params)
      expect(searched_game_unit.pluck(:id)).to eq game_units.pluck(:id) 
    end
  end
end