class Post < ApplicationRecord
  default_scope { where(delete_at: nil) }
  validates :title, presence: true
  validates :content, presence: true
  validates :address, presence: true
  after_validation :generate_short_url

  belongs_to :user
  has_many :comments
  has_many :post_category_ships
  has_many :categories, through: :post_category_ships

  def destroy
    update(delete_at: Time.now)
  end

  private

  def generate_short_url
    loop do
      @string_unique = sprintf "%04d", rand(2 - 9999)
      break unless Post.exists?(unique_num: @string_unique)
    end
    self.unique_num = @string_unique
  end
end
