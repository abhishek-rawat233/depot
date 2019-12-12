class CreateHitCounters < ActiveRecord::Migration[6.0]
  def change
    create_table :hit_counters do |t|
      t.integer :hit_count, default: 0

      t.timestamps
    end
  end
end
