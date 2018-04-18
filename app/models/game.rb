# frozen_string_literal: true

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
    @order ||=
      users
      .sort do |user|
        user.scores.where(game_id: id).count
      end
  end

  scope :of_user, ->(user) {
    joins(:users)
      .where(users: { id: user.id })
  }

  # user vs opponent_usersの試合のうち、opponent_usersのUnitの人数をuser_countで指定して検索する
  # userのGameの中で、opponent_usersのUnitであり、userのUnitではない (対戦相手であるため) Unitを持ったGameを探す
  scope :of_opponent_users, ->(user, opponent_users, user_count) {
    joins(:units)
      .where(units: { id: Unit
      .of_users(opponent_users)
      .joins(:users)
      .where
      .not(users: { id: user.id })
      .where(user_count: user_count)
      .pluck(:id) })
      .of_user(user)
  }
end
