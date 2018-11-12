class AddTeamOneToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :team_one, :boolean
  end
end
