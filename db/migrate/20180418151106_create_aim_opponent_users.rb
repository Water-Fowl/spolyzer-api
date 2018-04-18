class CreateAimOpponentUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :aim_opponent_users do |t|
      t.integer :user_id
      t.integer :aim_id

      t.timestamps
    end
  end
end
