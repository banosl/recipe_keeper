class AddChapterToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_reference :recipes, :chapter, null: false, foreign_key: true
  end
end
