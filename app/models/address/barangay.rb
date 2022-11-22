class Address::Barangay < ApplicationRecord
  validates :name, presence: true
  validates :code, uniqueness: true

  belongs_to :city_municipality, optional: true
  has_many :posts, class_name: 'Post', foreign_key: 'address_barangay_id'
end
