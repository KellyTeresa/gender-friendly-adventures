class ChangeBusinesses < ActiveRecord::Migration
  def change
    rename_column :businesses, :address, :street_address
    add_column :businesses, :city, :string, null: false
    add_column :businesses, :state, :string, null: false
    add_column :businesses, :zip_code, :string, null: false
  end
end
