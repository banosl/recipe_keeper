class RemoveColumnsFromRecipes < ActiveRecord::Migration[7.0]
  def change
    remove_columns(:recipes, :meal_times_del, :meal_types_del, :food_group_del)
  end
end
