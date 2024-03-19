class ChangeMealTimeInRecipesToStringArray < ActiveRecord::Migration[7.0]
  def change
    rename_column :recipes, :meal_time, :meal_times_del
    add_column :recipes, :meal_time, :string, array: true
  end
end
