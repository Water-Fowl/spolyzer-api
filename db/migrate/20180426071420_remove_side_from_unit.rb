class RemoveSideFromUnit < ActiveRecord::Migration[5.1]
  def change
    remove_column :units, :side, :integer
  end
end
