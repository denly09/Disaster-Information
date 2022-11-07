class PostCategoryShip < ApplicationRecord
  validates :category_id, presence: true

  belongs_to :post
  belongs_to :category
end
