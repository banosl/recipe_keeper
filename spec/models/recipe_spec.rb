require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :page}
  end

  describe 'relationships' do
    it {should belong_to :chapter}
    it {should have_many :recipe_ingredients}
  end
end