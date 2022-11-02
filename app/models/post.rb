class Post < ApplicationRecord
  validates :title, presence: true
  validates :contet, presence: true
  validates :address, presence: true

  belong_to :user
end
