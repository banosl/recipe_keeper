require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :page}
    it {should validate_numericality_of :page}
    it {should validate_numericality_of :servings}
    it {should validate_numericality_of :prep_hours}
    it {should validate_numericality_of :prep_minutes}
  end

  describe 'relationships' do
    it {should belong_to :chapter}
    it {should have_many :recipe_ingredients}
  end
end