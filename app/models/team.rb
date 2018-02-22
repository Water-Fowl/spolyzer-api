class Team < ApplicationRecord
  has_many :team_users
  has_many :users, through: :team_users
  has_one :category

  validates :name,
    presence: true,
    quniqueness: true

end
