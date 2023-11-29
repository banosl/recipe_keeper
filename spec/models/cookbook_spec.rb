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
      @cookbook = create(:cookbook, library: @user.library, published_date: "2019-03-27")
      @chapter = create(:chapter, cookbook: @cookbook)
      @recipes = create_list(:recipe, 20, :breakfast, :salad, :dairy, chapter: @chapter)
    end
    
    it "#recipe_count returns the number of recipes added to the cookbook by the user" do
      expect(@cookbook.recipe_count).to eq(20)
    end
  
    it "#published_year will determine if the info from google books api gives a full date or just the year and return just the year" do
      cookbook_year = create(:cookbook, library: @user.library, published_date: "1782")
      cookbook_nil_year = create(:cookbook, library: @user.library, published_date: nil)
      
      expect(@cookbook.published_year).to eq("2019")
      expect(cookbook_year.published_year).to eq("1782")
      expect(cookbook_nil_year.published_year).to eq("Year unknown")
    end
  end
end