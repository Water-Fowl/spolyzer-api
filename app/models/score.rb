class Score < ApplicationRecord
  has_one :position

  belongs_to :game
  belongs_to :unit
  has_many :users, through: :unit

  scope :of_user_games, -> (user_id){
    where(
      game_id: Game
      .of_user(user_id)
      .pluck(:id)
    )
  }

  scope :of_doubles_users_games, -> (users_id){
    where(
      game_id: Game
      .of_doubles_users(users_id)
      .pluck(:id)
    )
  }

  scope :of_opponent_user_games, -> (user_id, opponent_user_id, user_count){
    where(
      game_id: Game
      .of_opponent_user(user_id, opponent_user_id, user_count)
      .pluck(:id)
    )
  }

  scope :of_user_units, ->(user_id){
    joins(:users)
    .where(
      users: {
        id: user_id
      }
    )
  }

  scope :of_not_user_units, ->(user_id){
    joins(:users)
      .where.not(
      users: {
        id: user_id
      }
    )
  }

end
