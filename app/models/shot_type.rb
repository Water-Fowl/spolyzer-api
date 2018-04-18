# frozen_string_literal: true

class ShotType < ApplicationRecord
  belongs_to :sport
  has_many :scores
end
