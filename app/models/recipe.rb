class Recipe < ApplicationRecord
  validates_presence_of :name, :meal_time, :meal_type, :food_group, :country_of_origin, :page

  belongs_to :cookbook
  has_many :recipe_ingredients
end