class AddSideToScores < ActiveRecord::Migration[5.1]
  def change
    add_column :scores, :side, :integer
  end
end
