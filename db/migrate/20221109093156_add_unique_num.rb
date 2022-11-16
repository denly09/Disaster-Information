class AddUniqueNum < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :unique_num, :string
  end
end