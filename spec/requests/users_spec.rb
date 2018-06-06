require 'rails_helper'
require "./spec/support/shared_stuff.rb"

RSpec.describe "Users", type: :request do

  include_context 'header'

  let(:new_sport) { create(:sport, name_ja: 'テニス', name_en: 'tennis') }

  describe "GET /api/v1/users/:user_id #show" do

    subject do
      get "/api/v1/users/#{user.id}", headers: headers
    end

    it "ステータスコード200を返す" do
      subject
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT /api/v1/users/:user_id #update' do

    let(:params) do
      {
        name: 'changed_name',
        email: 'changed_email@test.com',
        image: user.image,
        sport_id: new_sport.id
      }
    end

    subject do
      put "/api/v1/users/#{user.id}", params: params, as: :json, headers: headers
    end

    it 'ステータスコード200を返す' do
      subject
      expect(response.status).to eq 200
    end

    it '更新されたユーザー情報を送る' do
      subject
      expect(json['user']['name']).to eq(params[:name])
      expect(json['user']['sport_id']).to eq(params[:sport_id])
    end
  end
end