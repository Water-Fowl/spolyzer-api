class AddConfigUserIdToScoreGames < ActiveRecord::Migration[5.1]
  def change
    add_column :score_games, :defeat_user_id, :integer
    add_column :score_games, :victory_user_id, :integer
  end
end
