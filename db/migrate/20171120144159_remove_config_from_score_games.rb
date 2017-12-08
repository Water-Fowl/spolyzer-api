class RemoveConfigFromScoreGames < ActiveRecord::Migration[5.1]
  def change
    remove_column :score_games, :last_score_of_left, :integer
    remove_column :score_games, :last_score_of_right, :integer
    remove_column :score_games, :left_team_id, :integer
    remove_column :score_games, :right_team_id, :integer
    remove_column :score_games, :defeat_user_id, :integer
    remove_column :score_games, :victory_user_id, :integer
  end
end
