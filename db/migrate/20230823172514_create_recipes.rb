class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :meal_time
      t.string :meal_type
      t.string :food_group
      t.string :country_of_origin
      t.integer :page

      t.timestamps
    end
  end
end
