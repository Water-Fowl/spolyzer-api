class Game < ApplicationRecord
  belongs_to :sport
  has_many :units
  has_many :users, through: :units
  has_many :scores

  def winner
    user_order_by_score.last
  end

  def loser
    user_order_by_score.first
  end

  private

  def user_order_by_score
    @order ||= self
      .users
      .sort do |user|
        user.scores.where(game_id: self.id).count
      end
  end

  scope :of_user, -> (user_id){
    joins(:users)
    .where(users: {id: user_id})
  }

  scope :of_doubles_users, -> (user_ids){
    joins(:units)
      .where(units: {id: Unit
      .of_doubles_users(user_ids)
      .pluck(:id)
    })
  }

  scope :of_opponent_user, -> (user_id, opponent_user_id, user_count){
    joins(:units)
      .where(units: {id: Unit
      .of_user(opponent_user_id)
      .where.not(id: user_id)
      .where(user_count: user_count)
      .pluck(:id)
    })
    .of_user(user_id)
  }

end
