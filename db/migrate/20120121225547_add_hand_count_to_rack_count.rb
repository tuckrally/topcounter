class AddHandCountToRackCount < ActiveRecord::Migration
  def change
    add_column :rack_counts, :hand_count, :integer
  end
end
