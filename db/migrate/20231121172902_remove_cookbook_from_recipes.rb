class RemoveCookbookFromRecipes < ActiveRecord::Migration[7.0]
  def change
    remove_reference :recipes, :cookbook, null: false, foreign_key: true
  end
end
