class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  has_many :sport_users
  has_many :sports, through: :sport_users
  has_many :game_users
  has_many :games, through: :game_users
  has_many :analysis_results
  has_many :scores

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

  def latest_result
    self.analysis_results.order(created_at: :asc).try(:first)
  end

  def total_score(game_id)
    self
      .games
      .find_by_id(game_id)
      .scores
      .where(user_id: self.id)
  end

  def generate_access_token!
    hash = {}
    begin
      access_token = SecureRandom.hex
      hash[:access_token] = access_token
    end while self.class.exists?(tokens: hash.to_json)
    self.update_attribute(:tokens, hash.to_json)
  end
end
