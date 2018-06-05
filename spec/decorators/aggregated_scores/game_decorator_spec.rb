require "rails_helper"

RSpec.describe 'GameDecorator', :type => :decorator do

  describe '#call' do
    before do

    end
    context "scoresが存在する場合" do

      let(:game) { create(:game).extend GameDecorator}
      let(:scores) { Score.create(game_id: 1, shot_type_id: 1, dropped_side: 1, unit_id: 1, position_id: 1, is_net_miss: false)  }

      before do
        game.scores = scores
      end

      it 'side,dropped_at,shot_type,miss_typeによってscoreを分類する' do
        expect(game.call).not_to be_empty
      end
    end

    context "scoresが存在しない場合" do

      let(:game) { create(:game).extend GameDecorator }

      it '空の配列を返す' do
        expect(game.call).to be_empty
      end
    end
  end
end
