class AddSchoolToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :school_id, :int
  end
end
