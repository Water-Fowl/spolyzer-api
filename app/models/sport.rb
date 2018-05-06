# frozen_string_literal: true

class Sport < ApplicationRecord
  has_many :shot_types
  has_many :users
end
