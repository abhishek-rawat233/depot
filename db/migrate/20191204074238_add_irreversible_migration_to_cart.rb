class AddIrreversibleMigrationToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :message, :string, :default => "fill the cart IF YOU CAN"
  end
end
