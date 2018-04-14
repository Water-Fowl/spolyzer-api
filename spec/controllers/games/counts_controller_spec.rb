require 'rails_helper'

RSpec.describe Api::V1::Games::CountsController, type: :controller do
  before :each do
    @game = create(:game, :with_sport, :with_units, :with_scores)
    request.env["HTTP_ACCEPT"] = 'application/json'
  end
  describe 'GET #index' do
    before do
      get :index, { params: { game_id: @game.id }, as: :json}
    end
    it 'http status return 200' do
      expect(response.status).to eq 200
    end
    it 'render template :index' do
      expect(response).to render_template :index
    end
  end
end
