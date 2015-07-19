class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    create_table :venue_categories do |t|
      t.belongs_to :category, null: false
      t.belongs_to :venue, null: false

      t.timestamps null: false
    end
  end
end
