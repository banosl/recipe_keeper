class UpdateNullTimeValuesInRecipes < ActiveRecord::Migration[7.0]
  def change
    recipes = Recipe.where(prep_hours: nil)
    recipes.each do |recipe|
      recipe.update(prep_hours: 0)
    end

    recipes = Recipe.where(prep_minutes: nil)
    recipes.each do |recipe|
      recipe.update(prep_minutes: 0)
    end
  end
end
