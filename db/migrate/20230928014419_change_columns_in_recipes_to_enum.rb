class ChangeColumnsInRecipesToEnum < ActiveRecord::Migration[7.0]
  def change
    rename_column :recipes, :meal_time, :meal_times_del
    rename_column :recipes, :meal_type, :meal_types_del
    rename_column :recipes, :food_group, :food_group_del

    add_column :recipes, :meal_time, :integer
    add_column :recipes, :meal_type, :integer
    add_column :recipes, :food_group, :integer
  end
end
