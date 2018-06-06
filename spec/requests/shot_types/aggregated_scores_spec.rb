# frozen_string_literal: true

require 'rails_helper'
require './spec/support/shared_stuff.rb'

RSpec.describe 'shot_types/AggregatedScore', type: :request do
  include_context 'header'

  let(:opponent_user) { create(:user) }
  let(:unit) { create(:unit) }
  let(:game) { create(:game) }
  let!(:game_unit) { GameUnit.create(unit_id: unit.id, game_id: game.id, side: 0, outcome: 2) }
  let(:opponent_unit) { create(:unit) }
  let(:score) do
    Score.create(
      game_id: game.id,
      shot_type_id: 1,
      dropped_side: 1,
      unit_id: unit.id,
      position_id: 1
    )
  end

  before do
    opponent_unit.games << game
    unit.users << user
    opponent_unit.users << opponent_user
    game.scores << score
    unit.scores << score
  end

  describe 'GET /api/v1/shot_types/:shot_type_id/aggregated_scores #index' do
    let(:params) do
      {
        game_user_count: 1,
        shot_type_id: '1',
        opponent_users_ids: [opponent_user.id],
        created_after: game_unit.created_at.to_s,
        created_before: game_unit.created_at.to_s,
        game_ids: [1],
        is_net_miss: true,
        outcome: 2
      }
    end

    let(:current_api_v1_user) { user }

    subject do
      get '/api/v1/shot_types/:shot_type_id/aggregated_scores',
          params: params,
          as: :json,
          headers: headers
    end

    it 'ステータスコード200を返す' do
      is_expected.to eq 200
    end

    it 'shot_type毎の集計を送る' do
      subject
      expect(json['counts']).not_to be_empty
    end
  end
end
