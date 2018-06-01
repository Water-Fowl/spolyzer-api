require "rails_helper"

RSpec.describe 'scoresfinder', :type => :finder do

  let(:unit) { create(:unit) }
  let(:other_unit) { create(:unit) }
  let(:game) { create(:game, :with_scores, units: [unit, other_unit]) } 

  describe '#call' do
    let!(:params) do
       { 
          game_ids: [game.id],
          shot_type_id: game.scores.first.shot_type_id,
          is_net_miss: true
        }
    end
    
    it 'return Score searched by shot_type and is_net_miss' do
      expect(ScoresFinder.call(params).pluck(:id)).to eq game.scores.pluck(:id)
    end
  end    
end