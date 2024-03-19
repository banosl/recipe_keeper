class Recipe < ApplicationRecord
  # enum meal_time: {breakfast: 0, brunch: 1, lunch: 2, dinner: 3, snack: 4}
  enum meal_type: {appetizer: 0, salad: 1, entree: 2, dessert: 3, drink: 4}
  enum food_group: {grain: 0, protein: 1, fruit_vegetables: 2, dairy: 3, other: 4}
  
  validates_presence_of :name, :meal_time, :meal_type, :food_group, :page

  belongs_to :chapter
  has_many :recipe_ingredients
end