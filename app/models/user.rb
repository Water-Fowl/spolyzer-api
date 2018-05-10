# frozen_string_literal: true

class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  belongs_to :sport, optional: true
  has_many :user_units
  has_many :units, through: :user_units
  has_many :games, through: :units
  has_many :scores, through: :units
  has_many :analysis_results

  mount_uploader :image, PhotoUploader

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name,
            presence: true,
            uniqueness: true

  validates :email,
            presence: true,
            uniqueness: true

  def latest_result
    analysis_results.order(created_at: :asc).try(:first)
  end

  # TODO: devise token auth でaccess_tokenのupdate
  def generate_access_token!
    raise NotImplementedError
  end
end
