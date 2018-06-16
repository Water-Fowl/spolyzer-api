require "rails_helper"

RSpec.describe 'PositionDecorator', :type => :decorator do

  describe '#call' do
    context "scoresが存在する場合" do

        let(:unit) { create(:unit) }
        let(:other_unit) { create(:unit) }
        let(:game) { create(:game, :with_scores, units: [unit, other_unit]) } 
        let(:scores) { create_list(:scores, 10, position: Position.first, shot_type: ShotType.first, game: game, unit: unit)}   

      it 'dropped_atによってscoreを分類する' do
        expect(AggregatedScores::PositionDecorator.call(game.scores)).not_to be_empty 
      end
    end

    context "scoresが存在しない場合" do

      let(:scores) { [] }  

      it '空の配列を返す' do
        expect(AggregatedScores::PositionDecorator.call(scores)).to be_empty
      end
    end
  end
end
