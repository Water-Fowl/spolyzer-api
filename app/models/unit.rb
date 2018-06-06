# frozen_string_literal: true

class Unit < ApplicationRecord
  has_many :game_units
  has_many :games, through: :game_units
  has_many :user_units
  has_many :users, through: :user_units
  has_many :scores

  scope :of_doubles_users, ->(users) {
    joins(:users)
      .where(id: users[0].units.pluck(:id))
      .where(users: { id: users[1].id })
  }

  # get unit by users. if users.length is 2, it returns doubles unit.
  def self.of_users(users)
    case users.length
    when 2
      of_doubles_users(users)
    when 1
      users[0].units
    end
  end

  def self.find_or_create_with_users(users)
    unit = of_users(users).first

    unless unit
      unit = Unit.create(user_count: users.count)
      users.each do |user|
        unit.user_units.create(user_id: user[:id])
      end
    end

    unit
  end
end
