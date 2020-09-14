class AllSportsController < ApplicationController
  def index
      @sport = Sport.all
  end
  def show
    if params[:id] == "10"
      @sport = Sport.find(4)
      @sport[:name] = "Boys & Girls Basketball"
      #CHANGE THIS AFTER SCHOOL YEAR
      @game = Game.where(sport: [4,5], time: DateTime.new(2020,07,1)..DateTime.new(2021,06,1)).sort_by{|ev| [ev.time.strftime('%Y'),ev.time.strftime('%m/%d/%Y'),ev.location,ev.time.strftime('%H:%M')]}
    else
      @sport = Sport.find(params[:id])
      #CHANGE THIS AFTER SCHOOL YEAR
      @game = Game.where(sport: params[:id], time: DateTime.new(2020,07,1)..DateTime.new(2021,06,1)).sort_by{|ev| [ev.time.strftime('%Y'),ev.time.strftime('%m/%d/%Y'),ev.location,ev.time.strftime('%H:%M')]}
    end
  end
end
