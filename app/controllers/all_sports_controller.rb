class AllSportsController < ApplicationController
  def index
      @sport = Sport.all
  end
  def show
    if params[:id] == "10"
      @sport = Sport.find(4)
      @sport[:name] = "Boys & Girls Basketball"
      @game = Game.where(sport: [4,5]).sort_by{|ev| [ev.time.strftime('%Y'),ev.time.strftime('%m/%d/%Y'),ev.location,ev.time.strftime('%H:%M')]}
    else
      @sport = Sport.find(params[:id])
      @game = Game.where(sport: params[:id]).sort_by{|ev| [ev.time.strftime('%Y'),ev.time.strftime('%m/%d/%Y'),ev.location,ev.time.strftime('%H:%M')]}
    end
  end
end
