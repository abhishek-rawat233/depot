class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.references :parent, null: true

      t.timestamps
    end
  end
end
