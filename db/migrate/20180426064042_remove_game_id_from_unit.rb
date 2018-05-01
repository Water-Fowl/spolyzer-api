class RemoveGameIdFromUnit < ActiveRecord::Migration[5.1]
  def change
    remove_column :units, :game_id, :integer
  end
end
