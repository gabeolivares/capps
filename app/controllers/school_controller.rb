class SchoolController < ApplicationController
  def index
    @school = School.all
  end

  def new
   @school = School.new
  end

  def edit
   @school = School.find(params[:id])
  end

  def create
    #validate params make sure all params are valid
   @school = School.new(school_params)

   if @school.save
      redirect_to :action => 'index'
   else
      @school = School.all
      render :action => 'new'
   end
  end

  def update
   @school = School.find(params[:id])

   if @school.update_attributes(school_param)
      redirect_to :action => 'index', :id => @school
   else
      render :action => 'edit'
   end
  end

  def school_param
      params.require(:school).permit(:name, :nickname, :address, :mascot, :website)
   end
  def delete
   School.find(params[:id]).destroy
   redirect_to :action => 'index'
  end

  def school_params
     params.require(:school).permit(:name, :nickname, :address, :mascot, :website)
  end
end
