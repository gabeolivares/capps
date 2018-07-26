class MessageController < ApplicationController
  def index
    @message = Message.all
  end

  def new
   @message = Message.new
  end

  def edit
   @message = Message.find(params[:id])
  end

  def create
    #validate params make sure all params are valid
   @message = Message.new(message_params)

   if @message.save
      redirect_to :action => 'index'
   else
      @message = Message.all
      render :action => 'new'
   end
  end

  def update
   @message = Message.find(params[:id])

   if @message.update_attributes(message_param)
      redirect_to :action => 'index', :id => @message
   else
      render :action => 'edit'
   end
  end

  def message_param
      params.require(:message).permit(:title, :body, :start_date, :end_date, :home)
   end
  def delete
   Message.find(params[:id]).destroy
   redirect_to :action => 'index'
  end

  def message_params
     params.require(:message).permit(:title, :body, :start_date, :end_date, :home)
  end
end
