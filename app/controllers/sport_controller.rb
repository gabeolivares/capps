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

    unless (params['game']['time(1i)'] == "" || params['game']['time(2i)'] == "" || params['game']['time(3i)'] == "")
      game = game_param
      game[:division] = @division.id
      game[:sport] = sport_id

      @game = Game.new(game)

      if @game.save
         redirect_to :action => 'show', :id => sport_id, :division_id => sport_id, :division_grade => div_grade, :division_name => div_name
      else
         @game = Game.all
         flash[:error] = "Error creating game"
         render :action => 'show', :id => sport_id, :division_id => sport_id, :division_grade => div_grade, :division_name => div_name
      end
    else
      flash[:error] = "We were unable to create the game. Please make sure all fields are filled."
      redirect_to :back
    end
  end

  def update
    div_name = params['division_name']
    div_grade = params['division_grade']
    sport_id = params['sport_id']
    game_id = params[:id]
    @division = Division.find_by(name: div_name, grade: div_grade)

    unless (params['game']['time(1i)'] == "" || params['game']['time(2i)'] == "" || params['game']['time(3i)'] == "")
      game = game_update_param
      game[:division] = @division.id
      game[:sport] = sport_id

      @game = Game.find(game_id)

      if @game.update_attributes(game)
         redirect_to :action => 'show', :id => sport_id, :division_id => sport_id, :division_grade => div_grade, :division_name => div_name
      else
         @game = Game.all
         flash[:error] = "We were unable to update the game. Please make sure all fields are filled."
         render :action => 'show', :id => sport_id, :division_id => sport_id, :division_grade => div_grade, :division_name => div_name
      end
    else

      flash[:error] = "We were unable to update the game. Please make sure all fields are filled."
      redirect_to :back
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

    @teams = []
    @games.each do |g|
      standings(g.opp1, g, 1, @teams) if g.confrence == true
      standings(g.opp2, g, 2, @teams) if g.confrence == true
    end

    @teams.each do |t|
      percentage = (t[:wins] + (0.5 * t[:ties])) / (t[:wins] + t[:losses] + t[:ties]) * 100.00
      if percentage.nan?
        t[:percentage] = 0
      else
        t[:percentage] = percentage
      end
    end

  end


  def standings(team, g, num, teams)
    school = School.where(id: team).first.nickname
    if teams.any? {|t| t[:school] == school}
      update_team = teams.select {|t| t[:school] == school }
      ut = update_team.first
      wins = ut[:wins]
      losses = ut[:losses]
      ties = ut[:ties]
      g.score_opp1 = 0 if g.score_opp1.nil?
      g.score_opp2 = 0  if g.score_opp2.nil?

      if num == 1
        if g.score_opp1 > g.score_opp2
          wins += 1
        elsif g.score_opp1 < g.score_opp2
          losses += 1
        elsif g.score_opp1 == g.score_opp2
          ties += 1 unless (g.score_opp1 && g.score_opp2 == 0)
        end
      end

      if num == 2
        if g.score_opp2 > g.score_opp1
          wins += 1
        elsif g.score_opp2 < g.score_opp1
          losses += 1
        elsif g.score_opp2 == g.score_opp1
          ties += 1 unless (g.score_opp1 && g.score_opp2 == 0)
        end
      end

      team = {school: school, wins: wins, losses: losses, ties: ties}

      @teams.find{|t| t[:school] == school}[:wins] = wins
      @teams.find{|t| t[:school] == school}[:losses] = losses
      @teams.find{|t| t[:school] == school}[:ties] = ties
    else
      wins = 0
      losses = 0
      ties = 0
      g.score_opp1 = 0 if g.score_opp1.nil?
      g.score_opp2 = 0  if g.score_opp2.nil?

      if num == 1
        if g.score_opp1 > g.score_opp2
          wins += 1
        elsif g.score_opp1 < g.score_opp2
          losses += 1
        elsif g.score_opp1 == g.score_opp2
          ties += 1 unless (g.score_opp1 && g.score_opp2 == 0)
        end
      end

      if num == 2
        if g.score_opp2 > g.score_opp1
          wins += 1
        elsif g.score_opp2 < g.score_opp1
          losses += 1
        elsif g.score_opp2 == g.score_opp1
          ties += 1 unless (g.score_opp1 && g.score_opp2 == 0)
        end
      end

      team = {school: school, wins: wins, losses: losses, ties: ties}

      @teams.push(team)
    end
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

     redirect_to :action => 'show', :id => sport_id, :division_id => sport_id, :division_grade => div_grade, :division_name => div_name
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
