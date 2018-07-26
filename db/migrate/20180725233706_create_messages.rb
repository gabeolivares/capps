class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.string :body
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :home

      t.timestamps null: false
    end
  end
end
