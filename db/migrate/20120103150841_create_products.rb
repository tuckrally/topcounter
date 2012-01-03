class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :upc
      t.string :description
      t.string :color
      t.string :size
      t.integer :price

      t.timestamps
    end
  end
end
