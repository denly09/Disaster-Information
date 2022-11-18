class AddReferencePostsDistrict < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :address_district
    add_reference :posts, :address_city_municipality
    add_reference :posts, :address_barangay
  end
end
