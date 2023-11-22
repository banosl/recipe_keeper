require 'rails_helper'

RSpec.describe Cookbook, type: :model do
  describe 'validations' do
    it {should validate_presence_of :title}
  end

  describe 'relationships' do
    it {should belong_to :library}
    it {should have_many :chapters}
    it {should have_many(:recipes).through(:chapters)}
  end

  describe "instance methods" do
    before :each do
      @user = create(:user, :google)
      @user.create_library
      @cookbook = create(:cookbook, library: @user.library)
      @chapter = create(:chapter, cookbook: @cookbook)
      @recipes = create_list(:recipe, 20, :breakfast, :salad, :dairy, chapter: @chapter)
    end

    it "#recipe_count returns the number of recipes added to the cookbook by the user" do
      expect(@cookbook.recipe_count).to eq(20)
    end
  end
end