class AddColumnsToCarts < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :line_items_count, :integer, default: 0, null: false
  end
end
