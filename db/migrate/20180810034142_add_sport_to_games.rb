class AddSportToGames < ActiveRecord::Migration
  def change
    add_column :games, :sport, :int
  end
end
