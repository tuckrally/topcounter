class AddRackToRackCount < ActiveRecord::Migration
  def change
    add_column :rack_counts, :rack, :integer
  end
end
