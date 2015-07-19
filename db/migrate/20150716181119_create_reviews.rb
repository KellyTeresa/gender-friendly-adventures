class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :venue, null: false
      t.belongs_to :user, null: false
      t.integer :terminology
      t.integer :bathrooms
      t.boolean :gv_staff
      t.integer :overall, null: false
      t.text :comment, null: false

      t.timestamps null: false
    end
  end
end
