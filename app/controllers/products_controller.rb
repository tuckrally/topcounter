class ProductsController < ApplicationController
  def index
    @products = Product.all
  end
  
  def show
    @product = Product.find params[:id]
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

end
