require 'rails_helper'

RSpec.describe Api::V1::GamesController, type: :controller do
  let(:params) do
    {
      units: {
        "0": {users: [{id: 1}], count: 1},
        "1": {users: [{id: 2}], count: 1},
        ids: [1, 2]
      },
      scores: [
        {unit: 0, dropped_at: 1, shot_type: 1, miss_type: 0, side: 0},
        {unit: 0, dropped_at: 2, shot_type: 2, miss_type: 0, side: 0},
        {unit: 1, dropped_at: 3, shot_type: 3, miss_type: 0, side: 1},
        {unit: 1, dropped_at: 4, shot_type: 4, miss_type: 0, side: 1},
        {unit: 1, dropped_at: 5, shot_type: 5, miss_type: 0, side: 1}
      ],
      game: {name: "トレーニングマッチ", sport_name: "バドミントン"}
    }

  end
  subject do
    post :create, {params: params, as: :json}
  end
  describe 'POST #create'
  it '200のコードを返す' do
    subject
    expect(response.status).to eq 200
  end
  it 'Gameが1つ作成される' do
    expect{ subject }.to change(Game, :count).by(1)
  end
  it 'Unitが2つ作成される' do
    expect{ subject }.to change(Unit, :count).by(2)
  end
  it 'Scoreが5つ作成される' do
    expect{ subject }.to change(Score, :count).by(5)
  end
end
