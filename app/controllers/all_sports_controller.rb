class AllSportsController < ApplicationController
  def index
      @sport = Sport.all
  end
  def show
    @sport = Sport.find(params[:id])
    @game = Game.where(sport: params[:id]).order(location: :asc,time: :asc)
    #@game = Game.where(sport: params[:id]).order(:time)
  end
end
