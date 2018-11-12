class TeamsController < ApplicationController
  def index
      @sport = Sport.all
  end
  def show
    @divisions_one = Division.where(grade: 1)
    @divisions_two = Division.where(grade: 2)
    @division_name = params[:division_name]
    @division_grade = "5th & 6th Grade" if params[:division_grade] == "1"
    @division_grade = "7th & 8th Grade" if params[:division_grade] == "2"
    @division_grade_id = params[:division_grade]
    @division_id = Division.find_by(name: @division_name, grade: @division_grade_id)
    @sport = Sport.find(params[:id])

    unless @division_id.blank?
      @teams = Team.where(primary: true)
    end
  end

  def new
    school_id = params['school_id']
    team = Team.find(school_id)
  end

  def create
    div_name = params['division_name']
    div_grade = params['division_grade']
    school_id = params['school_id']
    sport_id = params['sport_id']
    @division = Division.find_by(name: div_name, grade: div_grade)
    team1 = params['team']['name1']
    team2 = params['team']['name2']
    hidePrimary = params['team']['hidden']
    hideSecondary = hidePrimary == false ? true : false
    @team1 = Team.new(school_id: school_id, division: @division.id, primary: false, hidden: hideSecondary, team_one: true, name: team1, sport_id: sport_id)
    @team2 = Team.new(school_id: school_id, division: @division.id, primary: false, hidden: hideSecondary, team_two: true, name: team2, sport_id: sport_id)
    if @team1.save && @team2.save
      @updatePrimary = Team.where(primary: true, school_id: school_id).first
      @updatePrimary.update(hidden: hidePrimary)
       redirect_to :action => 'show', :id => sport_id, :division_grade => div_grade, :division_name => div_name
    else
       flash[:error] = "Error splitting team"
       render :action => 'show', :id => sport_id, :division_grade => div_grade, :division_name => div_name
    end
  end

  def edit
    school_id = params['school_id']
    @team = Team.where(school_id: school_id, primary: true).first
    @team1 = Team.where(school_id: school_id, team_one: true).first
    @team2 = Team.where(school_id: school_id, team_two: true).first
    puts @team1.name
    puts @team2.name
  end

  def update
    div_name = params['division_name']
    div_grade = params['division_grade']
    school_id = params['school_id']
    sport_id = params['sport_id']
    team1_id = params['team1_id']
    team2_id = params['team2_id']
    @division = Division.find_by(name: div_name, grade: div_grade)
    team1name = params['team']['team1']
    team2name = params['team']['team2']
    hidePrimary = params['team']['hidden']
    hideSecondary = hidePrimary == 'false' ? true : false
    puts @division.id
    puts hidePrimary
    puts hideSecondary
    @team1 = Team.find(team1_id)
    @team2 = Team.find(team2_id)
    @updatePrimary = Team.where(primary: true, school_id: school_id).first
    @updatePrimary.update(hidden: hidePrimary)

    if @updatePrimary.update(hidden: hidePrimary) && @team2.update(name: team2name, hidden: hideSecondary) && @team1.update(name: team1name, hidden: hideSecondary)
       redirect_to :action => 'show', :id => sport_id, :division_id => sport_id, :division_grade => div_grade, :division_name => div_name
    else
       flash[:error] = "We were unable to update the teams. Please make sure all fields are filled."
       render :action => 'show', :id => sport_id, :division_grade => div_grade, :division_name => div_name
    end

  end
end
