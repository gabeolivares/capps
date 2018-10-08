class CreateTournamentGames < ActiveRecord::Migration
  def change
    create_table :tournament_games do |t|
      t.integer :tournament_id
      t.integer :opp1
      t.integer :opp2
      t.integer :location
      t.datetime :date
      t.integer :division
      t.integer :score_opp1
      t.integer :score_opp2
      t.datetime :time
      t.integer :seed_opp1
      t.integer :seed_opp2
    end
  end
end
