# frozen_string_literal: true

class AnalysisResult < ApplicationRecord
  belongs_to :user
  belongs_to :sport
end
