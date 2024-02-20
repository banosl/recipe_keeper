require 'rails_helper'

RSpec.describe "Add a recipe form page" do
  before :each do
    @user = create(:user, :google)
    @user.create_library
    @cookbook = create(:cookbook, library: @user.library, isbn: {"ISBN-13": Faker::Barcode.isbn})
    @chapter = create(:chapter, cookbook: @cookbook)
    sign_in_as(@user)
  end

  context "Form Fields" do
    it "There is a text box for entering ingredients separated by comma with an example entry"

    it "There are check boxes for meal times"

    it "There are radio buttons for food group"
    
    it "There is a drop down list for chapter and the option to add a new one"
    
    it "Large text box for adding recipe instructions"

    it "There is a text box for page, servings, prep time, respectively"

    it "There is an option for uploading a photo or photos"
  end

  context "submitting a form" do
    context "a successful form submission" do
      it "ingredients can be entered one per line with the measurement on the same line separated by a comma
      after submission ingredients individually create a recipe_ingredient"
    end

    context "errors for an unsuccessful form submission" do
      it "i"
    end
  end

  context "Buttons" do
    it "There is a submit button"

    it "There is a cancel button that takes the user back to the cookbook show page"
  end
end