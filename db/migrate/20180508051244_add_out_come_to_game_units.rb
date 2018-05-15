class AddOutComeToGameUnits < ActiveRecord::Migration[5.1]
  def change
    add_column :game_units, :outcome, :integer
  end
end
