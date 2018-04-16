class AddIsInToPositions < ActiveRecord::Migration[5.1]
  def change
    add_column :positions, :is_in, :boolean
  end
end
