class AddNSetsToScore < ActiveRecord::Migration[5.1]
  def change
    add_column :scores, :n_sets, :integer
  end
end
