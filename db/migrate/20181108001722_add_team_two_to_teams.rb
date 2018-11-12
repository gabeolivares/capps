class AddTeamTwoToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :team_two, :boolean
  end
end
