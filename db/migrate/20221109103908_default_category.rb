class DefaultCategory < ActiveRecord::Migration[7.0]
  def change
    Category.find_or_create_by(name: 'Covid')
    Category.find_or_create_by(name: 'Earthquake')
    Category.find_or_create_by(name: 'Typhoon')
  end
end
