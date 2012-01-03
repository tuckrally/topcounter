class CreateRackCounts < ActiveRecord::Migration
  def change
    create_table :rack_counts do |t|
      t.string :initials
      t.string :rack
      t.text :comments

      t.timestamps
    end
  end
end
