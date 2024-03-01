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
    xit "There is a text box for entering ingredients separated by comma with an example entry" do
      #i want to build a microservice api for ingredients with their nutrition data
      #for now i will skip ingredients
      within("#recipe_form") do
        expect(page).to have_field(:recipe_ingredients)
        #the ingredients field may have a different name later on
        expect(page).to have_content("Enter one ingredient per line with its measurement separated by a comma")
        #expect the page to have an image where I'll have an example or like a gif with an example
      end
    end

    it "There are check boxes for meal times" do
      within("recipe_form") do
        #field names might be off
        expect(page).to have_checkbox(:recipe_breakfast)
        expect(page).to have_field(:recipe_brunch)
        expect(page).to have_field(:recipe_lunch)
        expect(page).to have_field(:recipe_dinner)
        expect(page).to have_field(:recipe_snack)
      end
    end

    xit "There are radio buttons for food group" do
      within("recipe_form") do
        #field names might be off
        expect(page).to have_radio_button(:recipe_food_group_grain)
        expect(page).to have_field(:recipe_food_group_protein)
        expect(page).to have_field(:recipe_food_group_fruit_vegetables)
        expect(page).to have_field(:recipe_food_group_dairy)
      end
    end

    xit "There are radio buttons for meal type" do
      within("recipe_form") do
        #field names might be off
        expect(page).to have_field(:recipe_meal_type_appetizer)
        expect(page).to have_field(:recipe_meal_type_salad)
        expect(page).to have_field(:recipe_meal_type_entree)
        expect(page).to have_field(:recipe_meal_type_dessert)
        expect(page).to have_field(:recipe_meal_type_drink)
      end
    end
    
    xit "There is a drop down list for chapter available" do
      within("recipe_form") do
        expect(page).to have_field(:recipe_chapter)
        #one for each option
      end
    end
    
    xit "There is the option to add a new chapter in the drop down list" do
      within("recipe_form") do
        #expect an add chapter option
      end
    end
    
    it "Large text box for adding recipe instructions"

    it "There is a text box for page, servings, prep time, respectively"

    it "There is an option for uploading a photo or photos"
  end

  context "submitting a form" do
    context "a successful form submission" do
      it "ingredients can be entered one per line with the measurement on the same line separated by a comma
      after submission ingredients individually create a recipe_ingredient"
    end
    #a test here per user input
    context "errors for an unsuccessful form submission" do
      it "i"
    end
  end

  context "Buttons" do
    it "There is a submit button"

    it "There is a cancel button that takes the user back to the cookbook show page"
  end
end