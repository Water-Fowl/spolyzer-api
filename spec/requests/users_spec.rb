require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /games/:game_id/counts" do
    before(:each) do
      create(:sport)
      @user = create(:user)

      #TODO 共通処理として切り出す
      @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      auth_header = @user.create_new_auth_token
      @headers.merge! auth_header
    end

    subject do
      get "/api/v1/users/#{@user.id}", headers: @headers
    end

    it "return 200" do
      subject
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT #update' do
    before(:each) do
      create(:sport)
      @user = create(:user)

      @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      auth_header = @user.create_new_auth_token
      @headers.merge! auth_header
    end

    subject do
      put "/api/v1/users/#{@user.id}s", params: params, as: :json, headers: @headers
    end
    it 'return 200' do
      subject
      expect(response.status).to eq 200
    end
  end
end
