class AddColumnToScore < ActiveRecord::Migration[5.1]
  def change
    add_column :scores, :time,:integer
  end
end
