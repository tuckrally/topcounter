class AlterShelfToVarChar < ActiveRecord::Migration
  def up
    change_table :rack_counts do |t|
      t.change :shelf, :string
    end
  end

  def down
  end
end
