class DropHitCounter < ActiveRecord::Migration[6.0]
  def change
    drop_table :hit_counters
  end
end
