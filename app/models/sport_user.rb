class CategoryUser < ApplicationRecord
  belongs_to :user
  belongs_to :category

  def ids
    [ user.id, category.id ]
  end
end
