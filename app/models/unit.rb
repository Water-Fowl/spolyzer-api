class Unit < ApplicationRecord
  belongs_to :game
  has_many :user_units
  has_many :users, through: :user_units
  has_many :scores

  scope :of_doubles_users, -> (users){
    joins(:users)
      .where(id: users[0].units.pluck(:id))
      .where(users: {id: users[1].id})
  }


  # opponent_usersをもつUnitを検索。opponent_usersが2つあった場合はダブルスとして検索。
  def self.of_users(opponent_users)
    case opponent_users.length
    when 2
      self.of_doubles_users(opponent_users)
    when 1
      opponent_users[0].units
    end
  end

end
