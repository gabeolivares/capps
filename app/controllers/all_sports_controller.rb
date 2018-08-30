class AllSportsController < ApplicationController
  def index
      @sport = Sport.all
  end
  def show
    @sport = Sport.find(params[:id])
    @game = Game.where(sport: params[:id]).order(location: :desc,time: :asc)
    #@game = Game.where(sport: params[:id]).order(:time)
  end
end
