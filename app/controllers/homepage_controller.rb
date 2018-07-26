class HomepageController < ApplicationController
  def index
    @school = School.order(:name)
    @message = Message.where(home: true).first
  end
end
