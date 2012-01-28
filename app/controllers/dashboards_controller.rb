class DashboardsController < ApplicationController
  def index
    @shelves_hand_counted = RackCount.where("hand_count > 0").count
    @shelves_scan_counted = RackCount.joins("left join line_items on rack_counts.id = line_items.rack_count_id").
      select("distinct rack_counts.id").
      where("line_items.id is not null").
      count
      
    @line_items_overall_sum = LineItem.count

    @product_price_list_of_sum = Product.select("(select sum(1) from line_items where product_id = products.id) * price as price_sum").where("(select sum(1) from line_items where product_id = products.id) is not null")

    @product_price_overall_sum = @product_price_list_of_sum.map(&:price_sum).map(&:to_f).inject(:+) || 0
    
    @products_diff_count = Product.where("coalesce((select sum(1) from line_items where line_items.product_id = products.id), 0) != (products.on_hand_qty - products.on_customer_order_qty)").count
    @rack_diff_count = RackCount.where("coalesce((select sum(1) from line_items where line_items.rack_count_id = rack_counts.id), 0) != (coalesce(hand_count, 0))").count
    
    
  end
end
