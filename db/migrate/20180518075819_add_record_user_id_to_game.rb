class AddRecordUserIdToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :record_user_id, :integer
  end
end
