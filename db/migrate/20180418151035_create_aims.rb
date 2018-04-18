class CreateAims < ActiveRecord::Migration[5.1]
  def change
    create_table :aims do |t|
      t.integer :user_id, null: false
      t.boolean :is_in, null: false
      t.boolean :is_net_miss, null: false
      t.boolean :is_my_score, null: false
      t.boolean :is_achieve, default: false
      t.string :title, null: false
      t.integer :achieve_count, null: false

      t.timestamps
    end
  end
end
