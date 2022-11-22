class Post < ApplicationRecord
  default_scope { where(delete_at: nil) }
  validates :title, presence: true
  validates :content, presence: true
  after_validation :generate_short_url

  belongs_to :user
  has_many :comments
  has_many :post_category_ships
  has_many :categories, through: :post_category_ships
  belongs_to :region, class_name: 'Address::Region', foreign_key: 'address_region_id'
  belongs_to :province, class_name: 'Address::Province', foreign_key: 'address_province_id', optional: true
  belongs_to :city_municipality, class_name: 'Address::CityMunicipality', foreign_key: 'address_city_municipality_id'
  belongs_to :barangay, class_name: 'Address::Barangay', foreign_key: 'address_barangay_id', optional: true
  mount_uploader :image, ImageUploader
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
