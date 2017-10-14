class CreateScoreGames < ActiveRecord::Migration[5.1]
  def change
    create_table :score_games do |t|
      t.integer :left_team_id
      t.integer :right_team_id
      t.datetime :game_time
      t.integer :serve_user_id
      t.boolean :deuce
      t.integer :match_point

      t.timestamps
    end
  end
end
