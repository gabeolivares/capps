class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :opp1
      t.integer :opp2
      t.integer :location
      t.boolean :confrence
      t.datetime :date
      t.integer :division
      t.integer :score_opp1
      t.integer :score_opp2
      t.datetime :time

      t.timestamps null: false
    end
  end
end
