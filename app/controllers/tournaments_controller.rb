class TournamentsController < ApplicationController
  def index
      @sport = Sport.all
  end
  def show
    @sport = Sport.find(params[:id])
    @tournament = Tournament.where(sports_id:params[:id])
  end
  def new
  end
  def show_tournament
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

  def create
    sport_id = params['sport_id']
    if params['tournament']['bracket_type'].blank?
      flash[:error] = "We were unable to create the tournament. Please make sure all fields are filled."
      redirect_to :back
    else
      tournament = tour_param
      tournament[:sports_id] = sport_id

      @tournament = Tournament.new(tournament)

      case params['tournament']['bracket_type']

      #4 teams bracket
      when '1'
        if @tournament.save
          game_num = 1
          4.times do
            tournament_game = {}
            tournament_game[:game_num] = game_num
            tournament_game[:tournament_id] = @tournament.id

            @tournament_game = TournamentGame.new(tournament_game)
            game_num += 1
            @tournament_game.save
          end

          redirect_to :action => 'show', :id => sport_id
       else
          @tournament = Tournament.all
          flash[:error] = "Error creating tournament"
          render :action => 'show', :id => sport_id
       end
        #CREATE 4 TOURNAMENT Games
        #GAME 1 WINNER goes to Game 3 LOSER goes to game 4
        #GAME 2 WINNER goes to Game 3 LOSER goes to game 4

      #5 teams bracket
      when '2'
        if @tournament.save
          game_num = 1
          5.times do
            tournament_game = {}
            tournament_game[:game_num] = game_num
            tournament_game[:tournament_id] = @tournament.id

            @tournament_game = TournamentGame.new(tournament_game)
            game_num += 1
            @tournament_game.save
          end

          redirect_to :action => 'show', :id => sport_id
       else
          @tournament = Tournament.all
          flash[:error] = "Error creating tournament"
          render :action => 'show', :id => sport_id
       end
        #CREATE 4 TOURNAMENT Games
        #GAME 1 WINNER GOES TO GAME 2
        #GAME 2 WINNER GOES TO GAME 4
        #GAME 3 WINNER GOES TO GAME 4

      #6 teams, no consolation
    when '3'
      if @tournament.save
        game_num = 1
        5.times do
          tournament_game = {}
          tournament_game[:game_num] = game_num
          tournament_game[:tournament_id] = @tournament.id

          @tournament_game = TournamentGame.new(tournament_game)
          game_num += 1
          @tournament_game.save
        end

        redirect_to :action => 'show', :id => sport_id
     else
        @tournament = Tournament.all
        flash[:error] = "Error creating tournament"
        render :action => 'show', :id => sport_id
     end
        #CREATE 5 TOURNAMENT Games
        # GAME 1 WINNER GOES TO GAME 3
        # GAME 2 WINNER GOES TO GAME 4
        # GAME 3 WINNER GOES TO GAME 5
        # GAME 4 WINNER GOES TO GAME 5

      #6 teams consolation bracket
    when '4'
      if @tournament.save
        game_num = 1
        8.times do
          tournament_game = {}
          tournament_game[:game_num] = game_num
          tournament_game[:tournament_id] = @tournament.id

          @tournament_game = TournamentGame.new(tournament_game)
          game_num += 1
          @tournament_game.save
        end

        redirect_to :action => 'show', :id => sport_id
     else
        @tournament = Tournament.all
        flash[:error] = "Error creating tournament"
        render :action => 'show', :id => sport_id
     end
        #CREATE 8 TOURNAMENT Games
        #GAME 1 WINNER GOES TO GAME 3
        #GAME 1 LOSER GOES TO GAME 6
        #GAME 2 WINNER goes to GAME 4
        #GAME 2 LOSER goes to GAME 7
        #GAME 3 Winner goes to Game 5
        #GAME 3 LOSER GOES to GAME 7
        #GAME 4 Winner goes to GAME 5
        #GAME 4 LOSER goes to GAME 6
        #GAME 6 WInner goes to GAME 8
        #GAME 7 WINNER goes to GAME 8

      #7 teams, no consolation
    when '5'
      if @tournament.save
        game_num = 1
        6.times do
          tournament_game = {}
          tournament_game[:game_num] = game_num
          tournament_game[:tournament_id] = @tournament.id

          @tournament_game = TournamentGame.new(tournament_game)
          game_num += 1
          @tournament_game.save
        end

        redirect_to :action => 'show', :id => sport_id
     else
        @tournament = Tournament.all
        flash[:error] = "Error creating tournament"
        render :action => 'show', :id => sport_id
     end
        #CREATE 6 TOURNAMENT Games
        #Game 1 WINNER goes to game 4
        #GAME 2 WINNER GOES TO GAME 5
        #GAME 3 WINNER GOES TO GAME 5
        #GAME 4 WINNER GOES TO GAME 6
        #GAME 5 WINNER GOES TO GAME 6

      #7 teams consolation bracket
    when '6'
      if @tournament.save
        game_num = 1
        10.times do
          tournament_game = {}
          tournament_game[:game_num] = game_num
          tournament_game[:tournament_id] = @tournament.id

          @tournament_game = TournamentGame.new(tournament_game)
          game_num += 1
          @tournament_game.save
        end

        redirect_to :action => 'show', :id => sport_id
     else
        @tournament = Tournament.all
        flash[:error] = "Error creating tournament"
        render :action => 'show', :id => sport_id
     end
        #CREATE 10 TOURNAMENT Games
        #GAME 1 WINNER GOES TO GAME 4
        #GAME 1 LOSER GOES TO GAME 7
        # GAME 2 WINNER GOES TO GAME 5
        # GAME 2 LOSER GOES TO GAME 6
        # GAME 3 WINNER GOES TO GAME 5
        # GAME 3 LOSER GOES TO GAME 6
        # GAME 4 WINNER GOES TO GAME 10
        # GAME 4 LOSER GOES TO GAME 8
        # GAME 5 WINNER GOES TO GAME 10
        # GAME 5 LOSER GOES TO GAME 7
        # GAME 6 WINNER GOES TO GAME 8
        # GAME 7 WINNER GOES TO GAME 9
        # GAME 8 WINNER GOES TO GAME 9

      #8 teams, no consolation
    when '7'
        if @tournament.save
          game_num = 1
          7.times do
            tournament_game = {}
            tournament_game[:game_num] = game_num
            tournament_game[:tournament_id] = @tournament.id

            @tournament_game = TournamentGame.new(tournament_game)
            game_num += 1
            @tournament_game.save
          end

          redirect_to :action => 'show', :id => sport_id
       else
          @tournament = Tournament.all
          flash[:error] = "Error creating tournament"
          render :action => 'show', :id => sport_id
       end
        #CREATE 7 TOURNAMENT GAMES
        #GAME 1 WINNER GOES TO GAME 5
        #GAME 2 WINNER GOES TO GAME 5
        # GAME 3  WINNER GOES TO GAME 6
        #GAME 4 WINNER GOES TO  GAME 6
        # GAME 5 WINNER goes to GAME 7
        #GAME 6 winner goes to game 7

      #8 teams, consolation bracket
    when '8'
      if @tournament.save
        game_num = 1
        12.times do
          tournament_game = {}
          tournament_game[:game_num] = game_num
          tournament_game[:tournament_id] = @tournament.id

          @tournament_game = TournamentGame.new(tournament_game)
          game_num += 1
          @tournament_game.save
        end

        redirect_to :action => 'show', :id => sport_id
     else
        @tournament = Tournament.all
        flash[:error] = "Error creating tournament"
        render :action => 'show', :id => sport_id
     end
        # CREATE 12 TOURNAMENT Games
        # GAME 1 WINNER GOES TO GAME 5
        # GAME 1 LOSER GOES TO GAME 8
        # GAME 2 WINNER GOES TO GAME 5
        # GAME 2 LOSER GOES TO GAME 8
        # GAME 3 WINNER GOES TO GAME 6
        # GAME 3 LOSER GOES TO GAME 9
        # GAME 4 WINNER GOES TO GAME 6
        # GAME 4 LOSER GOES TO GAME 9
        # GAME 5 WINNER GOES TO GAME 7
        # GAME 5 LOSER GOES GAME 10
        # GAME 6 WINNER GOES TO GAME 7
        # GAME 6 LOSER GOES GAME 11
        # GAME 8 WINNER GOES TO GAME 10
        # GAME 9 WINNER GOES TO GAME 11
        # GAME 10 WINNER GOES TO GAME 12
        # GAME 11 WINNER GOES TO GAME 12

      end

    end
  end

  def delete
    sport_id = params['sport_id']
    tournament_id = params['id']
    Tournament.find(tournament_id).destroy

    redirect_to :action => 'show', :id => sport_id
  end

  def edit_tournament
    @tournament = Tournament.find_by(id:params[:id])
  end

  def edit
    @tournament_game = TournamentGame.find_by(id:params[:id])
  end

  def update_tournament_game
    @tournament_game = TournamentGame.find_by(id:params[:id])
    if @tournament_game.update_attributes(tour_game_param)
       redirect_to :action => 'show_tournament', :id => params['tournament_id'], :sport_id => params['sport_id']
    else
       render :action => 'edit', :id => params['tournament_id'], :sport_id => params['sport_id']
    end
  end
  def update_tournament
    @tournament = Tournament.find_by(id:params[:id])
    if @tournament.update_attributes(tour_param)
       redirect_to :action => 'show_tournament', :id => params['id'], :sport_id => params['sport_id']
    else
       render :action => 'edit_tournament', :id => params['tournament_id'], :sport_id => params['sport_id'], :tournament_id => params['tournament_id']
    end
  end

  def tour_game_param
    params.require(:tournament_game).permit(:opp1, :score_opp1, :opp2, :score_opp2)
  end
  def tour_param
      params.require(:tournament).permit(:name, :desc, :bracket_type, :time, :visible)
  end
end
