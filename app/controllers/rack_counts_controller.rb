class RackCountsController < ApplicationController
  def index
    redirect_to new_rack_count_path
  end
  
  def show
    @rack_count = RackCount.find params[:id]
    @line_item = LineItem.new
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

end
