class Changevenues < ActiveRecord::Migration
  def change
    rename_column :venues, :address, :street_address
    add_column :venues, :city, :string, null: false
    add_column :venues, :state, :string, null: false
    add_column :venues, :zip_code, :string, null: false
  end
end
