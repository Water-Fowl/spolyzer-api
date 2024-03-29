# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :team_users
  has_many :users, through: :team_users
  has_one :category

  validates :name,
            presence: true,
            uniqueness: true
end
