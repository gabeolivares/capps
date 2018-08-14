class SportController < ApplicationController
  def index
    @sport = Sport.all
  end

  def new
    @locations = Location.all.order(:name)
    p @locations
   @sport = Sport.new
  end

  def edit
    @sport = Sport.find(params[:id])
  end

  def create

    div_name = params['division_name']
    div_grade = params['division_grade']
    sport_id = params['sport_id']
    @division = Division.find_by(name: div_name, grade: div_grade)
    p @division
    p @division.id
    #if division nil?
    #if sport nil error message_end_date
    #ALSO APPEND TO GAME PARAM AS DIVISION BUT APPEND ID

    p game_param
    p sport_id
    game = game_param
    game[:division] = @division.id
    game[:sport] = sport_id
    p game
    @game = Game.new(game)

    if @game.save
       redirect_to :action => 'index'
    else
       @game = Game.all
       render :action => 'index'
    end

  end

  def update
   @sport = Sport.find(params[:id])

   if @sport.update_attributes(sport_param)
      redirect_to :action => 'index', :id => @sport
   else
      render :action => 'edit'
   end
  end

  def show
    @divisions_one = Division.where(grade: 1)
    @divisions_two = Division.where(grade: 2)
    @division_name = params[:division_name]
    @division_grade = "5th & 6th Grade" if params[:division_grade] == "1"
    @division_grade = "7th & 8th Grade" if params[:division_grade] == "2"
    @division_grade_id = params[:division_grade]
    @division_id = Division.find_by(name: @division_name, grade: params[:division_grade])
    p @division_id

    @games = Game.where(division: @division_id, sport: params[:id]).order(:time)
    p @games
    @sport = Sport.find(params[:id])
  end
  def sport_param
      params.require(:sport).permit(:name, :nickname, :address, :mascot, :website)
   end

  def delete
   Sport.find(params[:id]).destroy
   redirect_to :action => 'index'
  end
  def game_param
      params.require(:game).permit(:opp1, :opp2, :location, :time, :confrence)
   end
  def sport_params
     params.require(:sport).permit(:name, :nickname, :address, :mascot, :website)
  end
  end
