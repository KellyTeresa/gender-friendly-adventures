class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :summary, null: false
      t.text :description
      t.string :website
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
