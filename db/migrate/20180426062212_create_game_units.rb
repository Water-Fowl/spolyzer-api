class CreateGameUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :game_units do |t|
      t.integer :game_id
      t.integer :unit_id

      t.timestamps
    end
  end
end
