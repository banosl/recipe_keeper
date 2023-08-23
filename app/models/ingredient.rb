class Ingredient < ApplicationRecord
  validates_presence_of :name, :measurement_us, :measurement_metric

  has_many :recipe_ingredients
end