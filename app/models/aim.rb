class Aim < ApplicationRecord
  belongs_to :users
  has_many :aim_opponent_users
  has_many :opponent_users, through: :aim_opponent_users
  has_many :aim_shot_types
  has_many :shot_types, through: :aim_shot_types
  has_many :aim_positions
  has_many :positions, through: :aim_positions

  def games
    games = Game.where("created_at >= ?", self.created_at)
    games.of_opponent_users(User.find(self.user_id), self.users, self.user_count) if self.users
  end

  def scores_in_game(game)
    if games.is_my_score
      game.scores
        .of_user_unit(User.find(self.user_id))
        .in_cort(self.in_cort)
        .where(is_net_miss: self.is_net_miss, shot_type_id: self.shot_type_ids)
    else
      game.scores
        .of_not_user_unit(User.find(self.user_id))
        .in_cort(self.in_cort)
        .where(is_net_miss: self.is_net_miss, shot_type_id: self.shot_type_ids)
    end
  end

end
