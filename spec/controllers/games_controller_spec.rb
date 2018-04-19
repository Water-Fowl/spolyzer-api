require 'rails_helper'

  describe 'GamesControllerのcreateアクション' do
    before :each do
      @scores = [
        attributes_for(:score),
        attributes_for(:score),
        attributes_for(:score)
      ]

      @sport = attributes_for(:sport)

      @units = attributes_for(:units)
    end




    it "新たなGameを作成し、保存する" do
      @scores.nil?
    end
end
