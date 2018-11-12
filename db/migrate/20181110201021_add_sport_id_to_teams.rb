class AddSportIdToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :sport_id, :int
  end
end
