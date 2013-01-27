class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(100)
  end

  def show
    @product = Product.find params[:id]
    @product_locations = Product.where(:id => params[:id]).joins(:rack_counts).group("rack_counts.id, rack_counts.rack, rack_counts.shelf").select("rack_counts.id as rack_count_id, rack_counts.rack, rack_counts.shelf, sum(1) as item_count")
  end

  def new
    @product = Product.new
  end


  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to product_path(@product)
    else
      redirect_to new_product_path
    end
  end

  def diff

    # Find all product where (sum of scan count) on each line_items != (on_hand_qty - on_customer_order_qty) for each product ID
    #where p.line_items.count != (p.on_hand_qty - p.on_customer_order_qty)

    # ITERATE OVER LINE ITEMS PER PRODUCT IN SQL
    @products_diff = Product.where("coalesce((select sum(1) from line_items where line_items.product_id = products.id), 0) != (products.on_hand_qty - products.on_customer_order_qty)").page(params[:page]).per(100)

    @current_page = params[:page] ? params[:page] : 1
    # OLD ITERATIVE APPROACH
    # Go through all products, for each product do this block - if you find a product where l i count not equal then put the product into the array products_diff
    #Product.all.each do |product|
    #  if product.line_items.count != (product.on_hand_qty - product.on_customer_order_qty)
    #    @products_diff << product
    #  else
    #  end
    #end

  end

end
