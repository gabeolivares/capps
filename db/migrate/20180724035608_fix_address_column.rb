class FixAddressColumn < ActiveRecord::Migration
  def change
    rename_column :schools, :adress, :address
  end
end
