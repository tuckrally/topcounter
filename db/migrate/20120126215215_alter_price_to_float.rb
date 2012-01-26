class AlterPriceToFloat < ActiveRecord::Migration
  def up
    change_table :products do |t|
      t.change :price, :float
    end
  end

  def down
  end
end
