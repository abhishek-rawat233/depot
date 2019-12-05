class AddCategoryToProducts < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :category, null: false, foreign_key: true, default: 9
  end
end
