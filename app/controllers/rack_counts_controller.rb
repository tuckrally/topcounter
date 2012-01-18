class RackCountsController < ApplicationController
  def index
    @rack_counts = RackCount.all
  end
  
  def show
    @rack_count = RackCount.find params[:id]
  end
  
  def new
    @rack_count = RackCount.new
  end


  def create
    @rack_count = RackCount.new(params[:rack_count])
    if @rack_count.save
      redirect_to rack_count_path(@rack_count)
    else
      redirect_to new_rack_count_path
    end
  end

  def add_line_item
    
        
    # Find the rack count based on POST param
    @rack_count = RackCount.find params[:id]
      
    # Get the product based on UPC from the rack count POST param
    @product = Product.find_by_upc params[:product_upc]
    
    # Create the line_item and add product ID and rack count ID

    if !@product.nil?
      @rack_count.line_items.create(:product_id => @product.id)
    else
      flash[:errors] = "That product isn't in the system." 
    end

    # Go back to the rack_count/id page
    redirect_to rack_count_path(@rack_count)

  end



  def remove_line_item
    
        
    # Find the rack count based on POST param
    @rack_count = RackCount.find params[:id]
      
    # Get the line_item from the rack count POST param
    @line_item = LineItem.find_by_id params[:line_item_id]
        
    # Delete the line_item and add product ID and rack count ID
    @line_item.destroy

    # Go back to the rack_count/id page
    redirect_to rack_count_path(@rack_count)

  end



end
