class AddDefaultValueToEnabledInProducts < ActiveRecord::Migration[6.0]
  def change
    change_column :products, :enabled, :boolean, default: false
  end
end
