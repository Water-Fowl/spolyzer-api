class AddPositionIdToScore < ActiveRecord::Migration[5.1]
  def change
    add_column :scores, :position_id, :integer
  end
end
