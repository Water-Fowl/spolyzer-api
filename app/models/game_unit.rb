class GameUnit < ApplicationRecord
  enum side: { left: 0, right: 1 }
  enum outcome: { win: 2, draw: 1, lose: 0 }
  belongs_to :game
  belongs_to :unit

  def self.get_by_opponent_users(current_user, opponent_users, game_user_count)
    opponent_units = Unit
      .joins(:users)
      .where.not(users: {id: current_api_v1_user.id})
      .where(users: {id: @opponent_users.pluck(:id)})
      .where(user_count: game_user_count)

    opponent_game_units = GameUnit.where(unit_id: opponent_units.pluck(:id))
  end

  def self.get_by_user(current_user, game_user_count)
    current_units = Unit
      .joins(:users)
      .where(users: {id: current_user.id})
      .where(user_count: game_user_count)

    game_units = GameUnit.where(unit_id: current_units.pluck(:id))
  end

end
