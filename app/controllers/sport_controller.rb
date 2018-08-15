class SportController < ApplicationController
  def index
    @sport = Sport.all
  end

  def new
    @locations = Location.all.order(:name)

   @sport = Sport.new
  end

  def edit
    game_id = params['game_id']
    @game = Game.find(game_id)
  end

  def create
    div_name = params['division_name']
    div_grade = params['division_grade']
    sport_id = params['sport_id']
    @division = Division.find_by(name: div_name, grade: div_grade)
    #if division nil?
    #if sport nil error message_end_date
    #ALSO APPEND TO GAME PARAM AS DIVISION BUT APPEND ID


    game = game_param
    game[:division] = @division.id
    game[:sport] = sport_id

    @game = Game.new(game)

    if @game.save
       redirect_to :action => 'show', :id => sport_id, :division_id => sport_id, :division_grade => div_grade
    else
       @game = Game.all
       render :action => 'show', :id => sport_id, :division_id => sport_id, :division_grade => div_grade
    end

  end

  def update
    div_name = params['division_name']
    div_grade = params['division_grade']
    sport_id = params['sport_id']
    game_id = params[:id]
    @division = Division.find_by(name: div_name, grade: div_grade)

    game = game_update_param
    game[:division] = @division.id
    game[:sport] = sport_id

    @game = Game.find(game_id)

    if @game.update_attributes(game)
       redirect_to :action => 'show', :id => sport_id, :division_id => sport_id, :division_grade => div_grade
    else
       @game = Game.all
       render :action => 'show', :id => sport_id, :division_id => sport_id, :division_grade => div_grade
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

    @games = Game.where(division: @division_id, sport: params[:id]).order(:time)
    @sport = Sport.find(params[:id])
  end
  def sport_param
      params.require(:sport).permit(:name, :nickname, :address, :mascot, :website)
   end

   def delete
     div_name = params['division_name']
     div_grade = params['division_grade']
     sport_id = params['sport_id']
     game_id = params['game_id']

     Game.find(game_id).destroy

     redirect_to :action => 'show', :id => sport_id, :division_id => sport_id, :division_grade => div_grade
   end

  def game_param
      params.require(:game).permit(:opp1, :opp2, :location, :time, :confrence)
  end
  def game_update_param
      params.require(:game).permit(:opp1,:score_opp1, :opp2, :score_opp2, :location, :time, :confrence)
  end

  def sport_params
     params.require(:sport).permit(:name, :nickname, :address, :mascot, :website)
  end
  end
