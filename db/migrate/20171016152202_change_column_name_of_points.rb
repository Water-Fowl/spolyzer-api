class ChangeColumnNameOfPoints < ActiveRecord::Migration[5.1]
  def change
    rename_column :score_games, :point_left,:last_score_of_left
    rename_column :score_games, :point_right, :last_score_of_right
  end
end
