require "rails_helper"

RSpec.describe 'GameDecorator', :type => :decorator do

  let(:game) { create(:game) }
  let(:scores) { [Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: 1, position_id: 1, is_net_miss: false),Score.create(game_id: game.id, shot_type_id: 1, dropped_side: 1, unit_id: 1, position_id: 1, is_net_miss: false)] }

  describe '#call' do
    context "scoresが存在する場合" do

      before do
        game.scores << scores 
      end 

      it 'side,dropped_at,shot_type,miss_typeによってscoreを分類する' do
        expect(AggregatedScores::GameDecorator.call(game.scores)).not_to be_empty 
      end
    end

    context "scoresが存在しない場合" do
      it '空の配列を返す' do
        expect(AggregatedScores::GameDecorator.call(game.scores)).to be_empty
      end
    end
  end
end
