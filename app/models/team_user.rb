# frozen_string_literal: true

class TeamUser < ApplicationRecord
  belongs_to :user
  belongs_to :team
end
