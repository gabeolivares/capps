class AllSportsController < ApplicationController
  def index
      @sport = Sport.all
  end
  def show
    @sport = Sport.find(params[:id])
    p "hereeeeeeeeeeee"
    @game = Game.where(sport: params[:id]).sort_by{|ev| [ev.time.strftime('%m/%d/%Y'),ev.location,ev.time.strftime('%H:%M')]}

    #p @game.sort_by{|ev| ev.time.strftime('%H:%M')}

    #@game = Game.where(sport: params[:id]).order(time: :asc, location: :asc)
    #@game.sort_by{|ev| ev.time.strftime('%H:%M')}
    #@game = Game.where(sport: params[:id]).order(:time)
  end
end
