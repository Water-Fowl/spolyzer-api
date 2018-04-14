require 'rails_helper'

RSpec.describe Api::V1::ShotTypes::CountsController, type: :controller do
  before :each do
    @game = create(:game, :with_sport, :with_units, :with_scores)
    @user = create(:user)
    @user.activate = true
    request.env["HTTP_ACCEPT"] = 'application/json'
    @auth_header = User.first.create_new_auth_token
  end
  describe 'GET #index' do
    before do
      get :index, { params: { shot_type_id: 1, user_count: 1 }, as: :json}, @auth_header
    end
    it 'http status return 200' do
      expect(response.status).to eq 200
    end
    it 'render template :index' do
      expect(response).to render_template :index
    end
  end
end
