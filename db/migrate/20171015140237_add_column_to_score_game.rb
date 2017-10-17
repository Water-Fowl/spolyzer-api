class AddColumnToScoreGame < ActiveRecord::Migration[5.1]
  def change
    add_column :score_games, :left_1, :integer
    add_column :score_games, :left_2, :integer
    add_column :score_games, :right_1, :integer
    add_column :score_games, :right_2, :integer
    add_column :score_games, :point_left, :integer
    add_column :score_games, :point_right, :integer
  end
end
