# frozen_string_literal: true

class SportUser < ApplicationRecord
  belongs_to :user
  belongs_to :category

  def ids
    [user.id, category.id]
  end
end
