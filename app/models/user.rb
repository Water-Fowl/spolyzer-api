class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  has_many :sport_users
  has_many :sports, through: :sport_users
  has_many :user_units
  has_many :units, through: :user_units
  has_many :games, through: :units
  has_many :scores, through: :units
  has_many :analysis_results

  mount_base64_uploader :image, PhotoUploader

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable

  validates :name,
    presence: true,
    uniqueness: true

  validates :email,
     presence: true,
     uniqueness: true


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

  # TODO: devise token auth でaccess_tokenのupdate
  def generate_access_token!
    raise NotImplementedError
  end
end
