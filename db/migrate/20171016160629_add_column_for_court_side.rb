class AddColumnForCourtSide < ActiveRecord::Migration[5.1]
  def change
    add_column :score_game_to_users, :court, :integer
  end
end
