class Changerackcountinitials < ActiveRecord::Migration
  def up
    rename_column :rack_counts, :initials, :scan_count_initials
  end

  def down
  end
end
