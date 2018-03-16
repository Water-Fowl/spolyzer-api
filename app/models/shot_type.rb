class ShotType < ApplicationRecord
  belongs_to :sport
  validates :name_ja, uniqueness: true
  validates :name_en, uniqueness: true
end
