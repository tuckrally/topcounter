class RackCountAddColumns < ActiveRecord::Migration
  def up
    change_table :rack_counts do |t|
      t.rename  :state, :status
      t.integer :shelf_number 
    end
  end

  def down
  end
  
end
