require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :measurement_us}
    it {should validate_presence_of :measurement_metric}
  end

  describe 'relationships' do
    it {should have_many :recipe_ingredients}
  end
end