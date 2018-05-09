require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/:user_id #show" do
    before do
      create(:sport)
      @user = create(:user)

      #TODO 共通処理として切り出す
      @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      auth_header = @user.create_new_auth_token
      @headers.merge! auth_header
    end

    subject(:show_action) do
      get "/api/v1/users/#{@user.id}", headers: @headers
    end

    it "return 200" do
      show_action
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT #update' do
    before do
      create(:sport, name_ja: 'テニス', name_en: 'tennis')
      @user = create(:user)

      @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      auth_header = @user.create_new_auth_token
      @headers.merge! auth_header
    end

    let(:params) do
      {
        name: 'changed_name',
        email: 'changed_email@test.com',
        image: @user.image,
        sport_id: 2
      }
    end

    subject do
      put "/api/v1/users/#{@user.id}", params: params, as: :json, headers: @headers
    end

    it 'return 200' do
      subject
      expect(response.status).to eq 200
    end

    it '更新されたユーザー情報を返す' do
      subject
      expect(json['user']['name']).to eq(params[:name])
      expect(json['user']['sport_id']).to eq(params[:sport_id])
    end
  end
end
