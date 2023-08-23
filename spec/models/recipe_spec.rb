require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :meal_time}
    it {should validate_presence_of :meal_type}
    it {should validate_presence_of :food_group}
    it {should validate_presence_of :country_of_origin}
    it {should validate_presence_of :page}
  end

  describe 'relationships' do
    it {should belong_to :cookbook}
    it {should have_many :recipe_ingredients}
  end
end