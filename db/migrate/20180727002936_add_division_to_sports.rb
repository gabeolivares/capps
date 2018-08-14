class AddDivisionToSports < ActiveRecord::Migration
  def change
    add_reference :sports, :division, index: true, foreign_key: true
  end
end
