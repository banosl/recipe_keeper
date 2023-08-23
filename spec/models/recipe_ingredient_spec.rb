require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  describe 'validations' do
    it {should validate_presence_of :quantity_us}
    it {should validate_presence_of :quantity_metric}
  end

  describe 'relationships' do
    it {should belong_to :recipe}
    it {should belong_to :ingredient}
  end
end