class HomepageController < ApplicationController
  def index
    @school = School.order(:name)
  end
end
