class RemoveColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :deleted_at
  end
end
