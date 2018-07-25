class HomepageController < ApplicationController
  def index
    @school = School.all
  end
end
