class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name
      t.integer :grade
      t.integer :gender
      t.integer :school_year

      t.timestamps null: false
    end
  end
end
