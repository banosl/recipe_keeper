class DeleteMealTimeDelFromRecipes < ActiveRecord::Migration[7.0]
  def change
    remove_column :recipes, :meal_times_del
  end
end
