class AddAttributesToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :servings, :integer
    add_column :recipes, :prep_hours, :integer
    add_column :recipes, :prep_minutes, :integer
    add_column :recipes, :description, :text
    add_column :recipes, :instructions, :text
  end
end
