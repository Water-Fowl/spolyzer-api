class AddSportIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :sport_id, :integer
  end
end
