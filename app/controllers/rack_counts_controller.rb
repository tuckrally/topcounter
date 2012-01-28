class RackCountsController < ApplicationController
  def index
    @rack_counts = RackCount.all(:order => "rack, shelf ASC")
    
    @line_items_overall_sum = LineItem.count
      
    @product_price_list_of_sum = Product.select("(select sum(1) from line_items where product_id = products.id) * price as price_sum").where("(select sum(1) from line_items where product_id = products.id) is not null")

    @product_price_overall_sum = @product_price_list_of_sum.map(&:price_sum).map(&:to_f).inject(:+)
      
    @rack_count = RackCount.new
  end
  
  def show
    @rack_count = RackCount.find params[:id]
  end
  
  def new
    @rack_count = RackCount.new
  end
  
  def import_racks
    if params[:key] && params[:key] == "evan"
      data = Excel.new('../inventory_rack_layout.xls')
      data.default_sheet = data.sheets.index('Sheet1') + 1

      shelf_list = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
      2.upto(data.last_row) do |line|
        rack_number = data.cell(line, 'A')
        shelf_count = data.cell(line, 'B')

        shelf_count.to_i.times do |i|
          puts "Creating Rack #{rack_number.to_i} with Shelf #{shelf_list[i]}"
          rack = RackCount.create(:rack => rack_number.to_i, :shelf => shelf_list[i])
        end
      end
    end
  end

  def create

    # If rack count rack and shelf combo are unique in system, then 
    # Find all rack counts where rack = current rack and shelf = 
      
      @dupe_check = RackCount.where(:rack => params[:rack_count][:rack], :shelf => params[:rack_count][:shelf])

      if @dupe_check.nil? || @dupe_check.count==0
        @rack_count = RackCount.new(params[:rack_count])

        if @rack_count.save
          redirect_to rack_count_path(@rack_count)
        end
        
      else
        flash[:errors] = "That rack/shelf is already in the system."
        redirect_to rack_counts_path        
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
