class AddSideToGameUnit < ActiveRecord::Migration[5.1]
  def change
    add_column :game_units, :side, :integer
  end
end
