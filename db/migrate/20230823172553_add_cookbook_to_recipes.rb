class AddCookbookToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :cookbook, null: false, foreign_key: true
  end
end
