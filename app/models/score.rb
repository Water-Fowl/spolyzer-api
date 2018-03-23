class Score < ApplicationRecord
  has_one :position

  belongs_to :game
  belongs_to :unit
  has_many :users, through: :unit

  scope :of_opponent_users_games, -> (user, opponent_user, user_count){
    where(
      game_id: Game
      .of_opponent_users(user, opponent_user, user_count)
      .pluck(:id)
    )
  }

  scope :of_user_units, ->(user){
    joins(:users)
    .where(
      users: {
        id: user.id
      }
    )
  }

  scope :of_not_user_units, ->(user){
    joins(:users)
      .where.not(
      users: {
        id: user.id
      }
    )
  }

end
