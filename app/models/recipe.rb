class Recipe < ApplicationRecord
  enum meal_type: {appetizer: 0, salad: 1, entree: 2, dessert: 3, drink: 4}
  enum food_group: {grain: 0, protein: 1, fruit_vegetables: 2, dairy: 3, other: 4}
  
  validates_presence_of :name, :page
  validates :page, numericality: true, if: -> {page.present?}
  validates :servings, numericality: {only_integer: true}, if: -> {servings.present?}
  validates :prep_hours, numericality: {only_integer: true, in: (0..24)}, if: -> {prep_hours.present?}
  validates :prep_minutes, numericality: {only_integer: true, in: (0..60)}, if: -> {prep_minutes.present?}

  belongs_to :chapter
  has_many :recipe_ingredients
end