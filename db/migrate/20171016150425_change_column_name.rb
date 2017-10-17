class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :scores, :time, :time_to_drop_shuttle
  end
end
