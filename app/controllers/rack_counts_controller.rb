class RackCountsController < ApplicationController
  def index
    @rack_counts = RackCount.all
    
    @line_items_overall_sum = LineItem.count
      
    @product_price_list_of_sum = Product.select("(select sum(1) from line_items where product_id = products.id) * price as price_sum").where("(select sum(1) from line_items where product_id = products.id) is not null")

    @product_price_overall_sum = @product_price_list_of_sum.map(&:price_sum).map(&:to_f).inject(:+)
      
  end
  
  def show
    @rack_count = RackCount.find params[:id]
  end
  
  def new
    @rack_count = RackCount.new
  end

  def create

    # If rack count rack and shelf combo are unique in system, then 
    # Find all rack counts where rack = current rack and shelf = 
      
      @dupe_check = RackCount.where(:rack => params[:rack_count][:rack], :shelf => params[:rack_count][:shelf])

      if @dupe_check.nil? || @dupe_check.count==0
        @rack_count = RackCount.new(params[:rack_count])

        if @rack_count.save
          redirect_to rack_count_path(@rack_count)
        else
          redirect_to new_rack_count_path
        end

      else

      end  



  end

  def add_hand_count
    @rack_count = RackCount.find params[:id]
  end

  def update
  
    # Find the rack count based on POST param
     @rack_count = RackCount.find params[:id]

     # Update the rack count
     @rack_count.update_attributes (params[:rack_count])

     # Go back to the rack_count/id page
     redirect_to rack_count_path(@rack_count)
  
  end

  def diff
    # ITERATE OVER LINE ITEMS PER PRODUCT IN SQL
    @rack_count_diff = RackCount.where("coalesce((select sum(1) from line_items where line_items.rack_count_id = rack_counts.id), 0) != (coalesce(hand_count, 0))")



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
