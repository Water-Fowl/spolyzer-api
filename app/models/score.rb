# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :game
  belongs_to :unit
  belongs_to :position
  belongs_to :shot_type
  has_many :users, through: :unit

  scope :of_user_games, ->(user, user_count) {
    where(
      game_id: Game.joins(:units)
      .where(units: { id: user.units.where(user_count: user_count).pluck(:id) })
      .pluck(:id)
    )
  }

  scope :of_user_units, ->(user) {
    joins(:users)
      .where(
        users: {
          id: user.id
        }
      )
  }

  scope :of_not_user_units, ->(user) {
    joins(:users)
      .where.not(
        users: {
          id: user.id
        }
      )
  }
end
