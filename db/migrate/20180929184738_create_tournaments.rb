class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :desc
      t.integer :bracket_type
      t.integer :division_id
      t.integer :sports_id
      t.boolean :visible
      t.timestamps null: false
    end
  end
end
