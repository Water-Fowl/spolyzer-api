require 'rails_helper'

RSpec.describe "UserSport", type: :request do
  before do
    @sport = create(:sport, name_ja: "テニス", name_en: "tennis")
    @user = create(:user)

    #TODO 共通処理として切り出す
    @headers = { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    auth_header = @user.create_new_auth_token
    @headers.merge! auth_header
  end

  describe "PUT #update" do
    subject(:update_action) do
      put "/api/v1/users/sports/#{@user.id}", params: params, as: :json, headers: @headers
    end

    it 'return 200' do
      update_action
      expect(response.status).to eq 200
    end

    let(:params) {{sport_id: @sport.id}}

    it "userの持つ種目をテニスに変更" do
      expect(@user.sport_id).to eq @sport.id
    end
  end
end
