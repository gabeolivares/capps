class AddPrimaryToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :primary, :boolean
  end
end
