class AddLanguageToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :language, :integer, default: 0
  end
end
