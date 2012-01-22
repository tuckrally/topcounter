class AddHandCountInitialsToRackCount < ActiveRecord::Migration
  def change
    add_column :rack_counts, :hand_count_initials, :string
  end
end
