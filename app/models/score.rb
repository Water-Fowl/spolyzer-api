class Score < ApplicationRecord
  has_one :position

  belongs_to :game
  belongs_to :unit
  has_many :users, through: :unit

  scope :of_users_games, -> (user_ids){
    includes(:users)
    .includes(:unit)
    .where(
      game_id: Game
      .includes(:users)
      .where(users: {id: user_ids})
      .pluck(:id)
    )
  }

  scope :of_user_units, ->(user_id){
    where(
      units: {
        id: Unit
        .includes(:users)
        .where(users: {id: user_id})
        .pluck(:id)
      }
    )
  }

  scope :of_not_user_units, ->(user_id){
    where.not(
      units: {
        id: Unit
        .includes(:users)
        .where(users: {id: user_id})
        .pluck(:id)
      }
    )
  }

end
