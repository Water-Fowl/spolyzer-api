class User < ActiveRecord::Base
  has_many :score_games, through: :score_game_to_user
  has_many :score_games
    # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
        #:confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User
end
