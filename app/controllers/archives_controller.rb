class ArchivesController < ApplicationController
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

    #CHANGE THIS AFTER SCHOOL YEAR
    @games = Game.where(division: @division_id, sport: params[:id], time: DateTime.new(2019,07,1)..DateTime.new(2020,06,1)).order(:time)
    case params[:year]
    when '0'
      @year = "2018-2019"
      @games = Game.where(division: @division_id, sport: params[:id], time: DateTime.new(2018,07,1)..DateTime.new(2019,06,1)).order(:time)
    when '1'
      @year = "2019-2020"
      @games = Game.where(division: @division_id, sport: params[:id], time: DateTime.new(2019,07,1)..DateTime.new(2020,06,1)).order(:time)
    when '2'
      @year = "2020-2021"
      @games = Game.where(division: @division_id, sport: params[:id], time: DateTime.new(2020,07,1)..DateTime.new(2021,06,1)).order(:time)
    when '3'
      @year = "2021-2022"
      @games = Game.where(division: @division_id, sport: params[:id], time: DateTime.new(2021,07,1)..DateTime.new(2022,06,1)).order(:time)
    end


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
        t[:percentage] = percentage.round(2)
      end
    end
  end

  def standings(team, g, num, teams)
    school = Team.where(id: team).first.name
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

      team = {team: team, school: school, wins: wins, losses: losses, ties: ties}

      @teams.push(team)
    end
  end

  def show_tournament
    @tournament = Tournament.where(sports_id:params[:id], created_at: DateTime.new(2018,07,1)..DateTime.new(2019,06,1)).order(:name)
    case params[:year]
    when '0'
      @year = "2018-2019"
      @tournament = Tournament.where(sports_id:params[:id], created_at: DateTime.new(2018,07,1)..DateTime.new(2019,06,1)).order(:name)
    when '1'
      @year = "2019-2020"
      @tournament = Tournament.where(sports_id:params[:id], created_at: DateTime.new(2019,07,1)..DateTime.new(2020,06,1)).order(:name)

    when '2'
      @year = "2020-2021"
      @tournament = Tournament.where(sports_id:params[:id], created_at: DateTime.new(2020,07,1)..DateTime.new(2021,06,1)).order(:name)
    when '3'
      @year = "2021-2022"
      @tournament = Tournament.where(sports_id:params[:id], created_at: DateTime.new(2021,07,1)..DateTime.new(2022,06,1)).order(:name)
    end
    @sport = Sport.find(params[:id])
  end

  def show_bracket
    @tournament = Tournament.find(params[:id])
    @game_1 = TournamentGame.where(tournament_id:params[:id], game_num: 1).first
    @game_2 = TournamentGame.where(tournament_id:params[:id], game_num: 2).first
    @game_3 = TournamentGame.where(tournament_id:params[:id], game_num: 3).first
    @game_4 = TournamentGame.where(tournament_id:params[:id], game_num: 4).first
    @game_5 = TournamentGame.where(tournament_id:params[:id], game_num: 5).first
    @game_6 = TournamentGame.where(tournament_id:params[:id], game_num: 6).first
    @game_7 = TournamentGame.where(tournament_id:params[:id], game_num: 7).first
    @game_8 = TournamentGame.where(tournament_id:params[:id], game_num: 8).first
    @game_9 = TournamentGame.where(tournament_id:params[:id], game_num: 9).first
    @game_10 = TournamentGame.where(tournament_id:params[:id], game_num: 10).first
    @game_11 = TournamentGame.where(tournament_id:params[:id], game_num: 11).first
    @game_12 = TournamentGame.where(tournament_id:params[:id], game_num: 12).first
  end
end
