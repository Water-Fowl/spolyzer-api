require "rails_helper"

RSpec.describe 'scoresfinder', :type => :finder do

  let(:unit) { create(:unit) }
  let(:other_unit) { create(:unit) }
  let(:game) { create(:game, :with_scores, units: [unit, other_unit]) } 
  let(:scores) { create_list(:scores, 10, position: Position.first, shot_type: ShotType.first, game: game, unit: unit)}   

  describe '#call' do
    let!(:params) do
       { 
          game_ids: [game.id],
          shot_type_id: game.scores.first.shot_type_id,
          is_net_miss: true
        }
    end
    
    it 'shot_typeとis_net_missでscoreを絞り込む' do
      expect(ScoresFinder.call(params)).not_to be_empty 
    end
  end    
    
end