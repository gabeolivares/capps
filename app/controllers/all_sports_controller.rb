class AllSportsController < ApplicationController
  def index
      @sport = Sport.all
  end
  def show
    @sport = Sport.find(params[:id])
    @game = Game.where(sport: params[:id]).order(time: :asc,location: :asc)
    #@game = Game.where(sport: params[:id]).order(:time)
  end
end
