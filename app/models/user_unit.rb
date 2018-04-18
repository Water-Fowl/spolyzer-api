# frozen_string_literal: true

class UserUnit < ApplicationRecord
  belongs_to :user
  belongs_to :unit
end
