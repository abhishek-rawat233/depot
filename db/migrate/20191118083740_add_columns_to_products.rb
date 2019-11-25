class AddColumnsToProducts < ActiveRecord::Migration[6.0]
  def change
    #ToDo: Separate all points in separate migrations
    add_column :products, :enabled, :boolean, default: false
    add_column :products, :discount_price, :decimal
    add_column :products, :permalink, :string
  end
end
