class Unit < ApplicationRecord
  has_many :game_units
  has_many :games, through: :game_units

  has_many :user_units
  has_many :users, through: :user_units

  validates: game_units_and_user_units_equal?

  def game_units_and_user_units_equal?(game_id, unit_id_1, unit_id_2)
    GameUnit.where(game_id: game_id).where(unit_id: unit_id_1).count == GameUnit.where(game_id: game_id).where(unit_id: unit_id_1).count
  end
end
