class AddHandCountToRackCounts < ActiveRecord::Migration
  def up
    change_table :rack_counts do |t|
      t.string :hand_count
    end
  end
end
