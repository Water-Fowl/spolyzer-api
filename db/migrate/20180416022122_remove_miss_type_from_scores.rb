class RemoveMissTypeFromScores < ActiveRecord::Migration[5.1]
  def change
    remove_column :scores, :miss_type, :integer
  end
end
