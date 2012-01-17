class RackCountAddState < ActiveRecord::Migration
  def up
    change_table :rack_counts do |t|
      t.string :state, :default => 'draft'
    end
  end

  def down
  end
end
