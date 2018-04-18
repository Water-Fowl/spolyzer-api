class CreateAimPositions < ActiveRecord::Migration[5.1]
  def change
    create_table :aim_positions do |t|
      t.integer :position_id
      t.integer :aim_id

      t.timestamps
    end
  end
end
