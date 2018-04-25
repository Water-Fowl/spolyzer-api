require 'rails_helper'

RSpec.describe Game, :type => :model do
    before(:each) do
      @game = create(:game, :with_sport, :with_units, :with_scores)
    end

    describe "winner" do
      it "勝ったuserをscoresの数をcountして並び変えて取り出す" do

      end
    end

    describe "loser" do
      it "負けたuserをscoresの数をcountして並び変えて取り出す" do

      end
    end

end
