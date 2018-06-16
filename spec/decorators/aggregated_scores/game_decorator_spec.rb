# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GameDecorator', type: :decorator do
  describe '#call' do
    context "scoresが存在する場合" do

      let(:unit) { create(:unit) }
      let(:other_unit) { create(:unit) }
      let(:game) { create(:game, :with_scores, units: [unit, other_unit]) } 
      let(:scores) { create_list(:scores, 10, position: Position.first, shot_type: ShotType.first, game: game, unit: unit)}   

      it 'side,dropped_at,shot_type,miss_typeによってscoreを分類する' do
        expect(AggregatedScores::GameDecorator.call(game.scores)).not_to be_empty 
      end
    end


      let(:scores) { [] }

  end
end
