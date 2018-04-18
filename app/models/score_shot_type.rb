# frozen_string_literal: true

class ScoreShotType < ApplicationRecord
  belongs_to :shot_type, class_name: ''
end
