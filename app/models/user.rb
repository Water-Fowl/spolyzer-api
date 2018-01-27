class User < ActiveRecord::Base
  has_many :sport_users
  has_many :sports, through: :sport_users
  has_many :game_users
  has_many :games, through: :game_users
  has_many :analysis_results
  has_many :scores

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
      #:confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  def latest_result
    self.analysis_results.order(created_at: :asc).try(:first)
  end

  def total_score(game_id)
    self
      .games
      .find_by_id(game_id)
      .scores
      .where(user_id: self.id)
      REXML::Document.new(File.read("path/to/file")).count
  end

    # def get_games(column="all")
    #     score_games = ScoreGame.includes(:users).where(users: {id: self.id})
    #     if column == 'all'
    #         return score_games
    #     end
    #     # 勝ち負けで撮り直す
    #     score_games_ids = []
    #     for score_game in score_games
    #         # clumn='win'だったら、勝ちのみのデータ
    #         if column == "win" then
    #             if score_game.is_win_user(self) then
    #                 score_games_ids.push(score_game.id)
    #             end
    #         # column='false'だったら、勝ちのみのデータ
    #         elsif column == "lose"
    #             if not score_game.is_win_user(self) then
    #                 score_games_ids.push(score_game.id)
    #             end
    #         # column がそれ以外だったら、エラー
    #         else
    #             return "unknown column"
    #         end
    #     end
    #     score_games = score_games.where(id: score_games_ids)
    #     return score_games
    # end
    #
    # def get_games_with(score_games = self.get_games, user)
    #     if user
    #         score_games_with_user = score_games.includes(:users).where(users: {id: user.id})
    #         return score_games
    #     else
    #         return self.get_games
    #     end
    # end
    #
    # def get_lose_games
    #
    # end
end
