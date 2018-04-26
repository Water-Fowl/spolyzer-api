require 'rails_helper'

RSpec.describe Game, :type => :model do
    before do
      @game = create(:game, :with_sport, :with_units, :with_scores)
    end

    describe "winner" do
      it "勝ったuserをscoresの数をcountして並び変えて取り出す" do
        expect(@game.winner).to eq @game.units.first
      end
    end

    describe "loser" do
      it "負けたuserをscoresの数をcountして並び変えて取り出す" do
        expect(@game.loser).to eq @game.units.second
      end
    end

end
