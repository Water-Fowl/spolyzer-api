class AddIsNetMissToScore < ActiveRecord::Migration[5.1]
  def change
    add_column :scores, :is_net_miss, :boolean, default: false
  end
end
