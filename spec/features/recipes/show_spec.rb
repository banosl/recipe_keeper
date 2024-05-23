require 'rails_helper'

RSpec.describe "Recipe show page" do
  before :each do
    @user = create(:user, :google)
    @user.create_library
    @cookbook = create(:cookbook, library: @user.library, isbn: {"ISBN-13": Faker::Barcode.isbn})
    @chapter = create(:chapter, cookbook: @cookbook)
    @recipes = create_list(:recipe, 5, :salad, :dairy, chapter: @chapter)
    sign_in_as(@user)
  end

  before :each do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:google_oauth2, uid: @user.google_id, info: {first_name: @user.first_name, last_name: @user.last_name, email: @user.email}, credentials: {token: @user.google_token})
  end

  describe "Visiting the recipe show page with all fields entered" do
    it "displays recipe name, description, page, chapter, servings, prep time" do
      recipe = create(:recipe, :salad, :protein, chapter: @chapter, prep_hours: 6, prep_minutes: 25)
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, recipe.id)

      expect(page).to have_content(recipe.name)
      
      within("#basic_info_#{recipe.id}") do
        expect(page).to have_content("#{recipe.description}")
        expect(page).to have_content("Page #{recipe.page}")
        expect(page).to have_content("Chapter: #{recipe.chapter.name}")
        expect(page).to have_content("#{recipe.servings} servings")
        expect(page).to have_content("Time to prepare: #{recipe.prep_hours} hours and #{recipe.prep_minutes} minutes")
      end
    end

    it "if there is only 1 serving the the page will use the singular of 'serving'" do
      recipe = create(:recipe, :salad, :protein, chapter: @chapter, servings: 1)
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, recipe.id)

      within("#basic_info_#{recipe.id}") do
        expect(page).to have_content("#{recipe.servings} serving")
        expect(page).to_not have_content("#{recipe.servings} servings")
      end
    end

    it "if there is only 1 hour of prep the the page will use the singular of 'hour'" do
      recipe = create(:recipe, :salad, :protein, chapter: @chapter, prep_hours: 1, prep_minutes: 5)
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, recipe.id)

      within("#basic_info_#{recipe.id}") do
        expect(page).to have_content("Time to prepare: #{recipe.prep_hours} hour and #{recipe.prep_minutes} minutes")
      end
    end

    it "if there is only 1 minute of prep the the page will use the singular of 'minute'" do
      recipe = create(:recipe, :salad, :protein, chapter: @chapter, prep_hours: 5, prep_minutes: 1)
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, recipe.id)

      within("#basic_info_#{recipe.id}") do
        expect(page).to have_content("Time to prepare: #{recipe.prep_hours} hours and #{recipe.prep_minutes} minute")
      end
    end

    it "displays meal times, food groups, meal type" do
      recipe = @recipes[1]
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, recipe.id)

      within("#meal_characteristics_#{recipe.id}") do
        expect(page).to have_content(
          `Characteristics:\n
          #{recipe.meal_type}\n
          #{recipe.meal_time.join(" ")}\n
          #{recipe.food_group}`
        )
      end
    end

    it "displays instructions" do
      recipe = @recipes[0]
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, recipe.id)

      within("#instructions_#{recipe.id}") do
        expect(page).to have_content(
          `Instructions:
          #{recipe.instructions}`
        )
      end
    end

    it "displays a user submitted photo"

    it "displays ingredients with measurements"
  end

  describe "Visiting the show page when fields are blank" do
    it "If a description, servings, and instructions are missing then those categories don't show"

    it "If a recipe doesn't have any of the meal time, food group, and dish type the characteristics section doesn't show"

    it "If at least one of meal time, food group or dish type is present then characteristics section does show"
      #do multiple site visits with different recipes

    it "if the recipe prep time only has minutes it doesn't show 'hours' on the page"
    
    it "if the recipe prep time only has hours it doesn't show 'minutes' on the page"
  end

  describe "Buttons" do
    it "the library link takes the user back to the library"

    it "back to cookbook button takes user back to the cookbook show page"

    it "edit recipe button takes the user to the edit form"

    it "delete recipe button deletes it and redirects user to the cookbook show page and the user can see that it's gone"

    it "has a log out button"
  end
end