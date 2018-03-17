class Unit < ApplicationRecord
  belongs_to :game
  has_many :user_units
  has_many :users, through: :user_units
  has_many :scores

  scope :of_doubles_users, -> (user_ids){
    joins(:users)
      .where(id: Unit.joins(:users).where(users: {id: user_ids[0]}).pluck(:id))
      .where(users: {id: user_ids[1]})
  }

  scope :of_user, -> (user_id){
    joins(:users)
      .where(users: {id: user_id})
  }
end
