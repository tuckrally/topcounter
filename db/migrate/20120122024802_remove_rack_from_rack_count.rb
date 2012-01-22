class RemoveRackFromRackCount < ActiveRecord::Migration
  def up
    remove_column :rack_counts, :rack
  end

  def down
    add_column :rack_counts, :rack, :string
  end
end
