class ProductAddColumns < ActiveRecord::Migration
  def up

    change_table :products do |t|
       t.string :department
       t.string :vendor
       t.integer :on_hand_qty
       t.integer :on_customer_order_qty
       end

  end

  def down
  end
end
