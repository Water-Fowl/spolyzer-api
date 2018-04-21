class Aim < ApplicationRecord
  belongs_to :user

  has_many :aim_opponent_users
  has_many :opponent_users, through: :aim_opponent_users

  has_many :aim_shot_types
  has_many :shot_types, through: :aim_shot_types

  has_many :aim_positions
  has_many :positions, through: :aim_positions

  def games
    games = Game.where("games.created_at >= ?", self.created_at)
    games.of_opponent_users(User.find(self.user_id), self.opponent_users, self.user_count) if self.opponent_users
  end

  def scores
    current_user = User.find(self.user_id)
    scores = Score
      .in_cort(self.is_in)
      .where(position_id: self.position_ids, is_net_miss: self.is_net_miss, shot_type_id: self.shot_type_ids)
    scores = scores.of_opponent_users_games(current_user, self.opponent_users, self.user_count) if self.opponent_users
    scores = scores.of_user_units(current_user) if self.is_my_score else scores.of_not_user_units(current_user)
    scores
  end

  def scores_in_game(game)
    current_user = User.find(self.user_id)
    scores = game.scores
      .in_cort(self.is_in)
      .where(position_id: self.position_ids, is_net_miss: self.is_net_miss, shot_type_id: self.shot_type_ids)
    scores = scores.of_user_units(current_user) if self.is_my_score else scores.of_not_user_units(current_user)
    scores
  end

end
