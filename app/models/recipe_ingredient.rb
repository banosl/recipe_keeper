class RecipeIngredient < ApplicationRecord
  validates_presence_of :quantity_us, :quantity_metric

  belongs_to :recipe
  belongs_to :ingredient
end