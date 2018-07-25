class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :nickname
      t.string :adress
      t.string :mascot
      t.string :website

      t.timestamps null: false
    end
  end
end
