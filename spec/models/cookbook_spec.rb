require 'rails_helper'

RSpec.describe Cookbook, type: :model do
  describe 'validations' do
    it {should validate_presence_of :title}
  end

  describe 'relationships' do
    it {should belong_to :library}
    it {should have_many :recipes}
  end

  describe "Instance Methods" do
    it "#display_authors formats the array of authors to a string" do
      cookbook = Cookbook.new({title: "James and the Cooking Art of Canada", authors: ["James Buchannan", "Bon James", "James James"]})

      expect(cookbook.display_authors).to eq("James Buchannan, Bon James, James James")
    end
  end
end