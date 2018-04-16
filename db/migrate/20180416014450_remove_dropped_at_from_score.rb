class RemoveDroppedAtFromScore < ActiveRecord::Migration[5.1]
  def change
    remove_column :scores, :dropped_at, :integer, null: false
  end
end
