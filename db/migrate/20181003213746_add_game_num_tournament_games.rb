class AddGameNumTournamentGames < ActiveRecord::Migration
  def change
    add_column :tournament_games, :game_num, :int
  end
end
