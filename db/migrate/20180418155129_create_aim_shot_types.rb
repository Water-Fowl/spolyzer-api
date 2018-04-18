class CreateAimShotTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :aim_shot_types do |t|
      t.integer :shot_type_id
      t.integer :aim_id

      t.timestamps
    end
  end
end
