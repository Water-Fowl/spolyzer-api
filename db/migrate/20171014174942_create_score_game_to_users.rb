class CreateScoreGameToUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :score_game_to_users do |t|
      t.integer :user_id
      t.integer :score_game_id

      t.timestamps
    end
  end
end
