class RemoveHandCountFromRackCount < ActiveRecord::Migration
  def up
    remove_column :rack_counts, :hand_count
  end

  def down
    add_column :rack_counts, :hand_count, :string
  end
end
