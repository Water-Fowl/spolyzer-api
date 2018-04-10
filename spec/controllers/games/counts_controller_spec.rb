require 'rails_helper'

RSpec.describe Api::V1::Games::CountsController, type: :controller do
  before :each do
    @game = create(:game, :with_sport, :with_units, :with_scores)
  end
  describe 'GET #index' do
    subject do
      get :index, { params: { game_id: @game.id }, as: :json}
    end
    it 'http status' do
      subject
      expect(response.status).to eq 200
    end
  end
end
