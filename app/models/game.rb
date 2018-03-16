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
end
