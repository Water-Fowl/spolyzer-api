# frozen_string_literal: true

class Game < ApplicationRecord
  belongs_to :record_user, class_name: 'User', foreign_key: 'record_user_id'
  belongs_to :sport
  has_many :game_units
  has_many :units, through: :game_units
  has_many :users, through: :units
  has_many :scores

  def winner
    unit_order_by_score.last
  end

  def loser
    unit_order_by_score.first
  end

  def score_count
    left_scores = units[0].scores.joins(:game).where(games: { id: id }).joins(:position)
    right_scores = units[1].scores.joins(:game).where(games: { id: id }).joins(:position)

    left_score_count = left_scores.where(positions: { is_in: true }).where(is_net_miss: false).count +
                       right_scores.where(positions: { is_in: false }).count +
                       right_scores.where(is_net_miss: true).count

    right_score_count = right_scores.where(positions: { is_in: true }).where(is_net_miss: false).count +
                        left_scores.where(positions: { is_in: false }).count +
                        left_scores.where(is_net_miss: true).count

    scores = { left: left_score_count, right: right_score_count }
  end

  def update_outcome
    score_count = self.score_count
    right_game_unit = game_units.find_by(side: :right)
    left_game_unit = game_units.find_by(side: :left)

    if score_count[:left] > score_count[:right]
      right_game_unit.update(outcome: :lose)
      left_game_unit.update(outcome: :win)
    elsif score_count[:left] < score_count[:right]
      right_game_unit.update(outcome: :win)
      left_game_unit.update(outcome: :lose)
    else
      right_game_unit.update(outcome: :draw)
      left_game_unit.update(outcome: :draw)
    end
  end

  private

  def unit_order_by_score
    @order ||=
      units
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
end
