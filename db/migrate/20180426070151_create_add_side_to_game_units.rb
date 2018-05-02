class CreateAddSideToGameUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :add_side_to_game_units do |t|
      t.integer :side

      t.timestamps
    end
  end
end
