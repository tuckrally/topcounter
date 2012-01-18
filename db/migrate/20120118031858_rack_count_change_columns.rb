class RackCountChangeColumns < ActiveRecord::Migration
  def up
    change_table :rack_counts do |t|
      t.rename :shelf_number, :shelf 
    end
  end


  def down
  end
end
