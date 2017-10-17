class RemoveColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :score_games, :left_1, :integer
    remove_column :score_games, :left_2, :integer
    remove_column :score_games, :right_1, :integer
    remove_column :score_games, :right_2, :integer
  end
end
