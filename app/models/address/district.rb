class Address::District < ApplicationRecord
  validates :name, presence: true
  validates :code, uniqueness: true

  belongs_to :region
  has_many  :city_municipalities
  has_many :posts, class_name: 'Post', foreign_key: 'address_district_id'
end
