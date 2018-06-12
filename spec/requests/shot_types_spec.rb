# frozen_string_literal: true

require 'rails_helper'
require './spec/support/shared_stuff.rb'

RSpec.describe 'ShotTypes', type: :request do
  include_context 'header'

  let(:left_unit) { create(:unit) }
  let(:right_unit) { create(:unit) }
  let(:game) { create(:game, :with_scores, units: [left_unit, right_unit], record_user_id: user.id) }
  let(:shot_types) { ShotType.where(sport_id: 1) }

  describe 'GET /api/v1/shot_types #index' do
    
    let(:params) { { sport_id: 1 } }

    subject do
      get '/api/v1/shot_types', params: params, as: :json, headers: headers
    end

    it 'ステータスコード200を返す' do
      subject
      expect(response).to have_http_status(200)
    end

    it "shot_typesを送る" do
        subject
        expect(json.pluck('id')).to eq shot_types.pluck(:id)
    end
  end
end
