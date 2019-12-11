class AddProductCountToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :products_count, :integer, default: 0, null: false
  end
end
