class AddHiddenToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :hidden, :boolean
  end
end
