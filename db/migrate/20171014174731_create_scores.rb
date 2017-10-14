class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.integer :scores_user_id
      t.integer :conceded_user_id
      t.integer :action
      t.integer :position
      t.integer :score_game_id

      t.timestamps
    end
  end
end
