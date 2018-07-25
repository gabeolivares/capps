class LocationController < ApplicationController
  def index
    @location = Location.all
  end

  def new
   @location = Location.new
  end

  def edit
   @location = Location.find(params[:id])
  end

  def create
    #validate params make sure all params are valid
   @location = Location.new(location_params)

   if @location.save
      redirect_to :action => 'index'
   else
      @location = Location.all
      render :action => 'new'
   end
  end

  def update
   @location = Location.find(params[:id])
   if @location.update_attributes(location_param)
      redirect_to :action => 'index', :id => @location
   else
      render :action => 'edit'
   end
  end

  def location_param
      params.require(:location).permit(:name, :address1, :address2)
   end

  def delete
   Location.find(params[:id]).destroy
   redirect_to :action => 'index'
  end

  def location_params
     params.require(:location).permit(:name, :address1, :address2)
  end
end
