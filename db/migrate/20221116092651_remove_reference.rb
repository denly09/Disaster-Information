class RemoveReference < ActiveRecord::Migration[7.0]
  def change
    remove_reference :address_barangays, :region
  end
end
