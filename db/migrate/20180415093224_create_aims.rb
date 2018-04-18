class CreateAims < ActiveRecord::Migration[5.1]
  def change
    create_table :aims do |t|
      t.integer :user_id
      t.integer :miss_type
      t.boolean :is_my_score
      t.boolean :aim_count
      t.boolean :is_archive
      t.string :title

      t.timestamps
    end
  end
end
