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
          <<~TEXT.chomp
            Characteristics:
            #{recipe.meal_type}
            #{recipe.meal_time.join(" ")}
            #{recipe.food_group}
          TEXT
        )
      end
    end

    it "displays instructions" do
      recipe = @recipes[0]
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, recipe.id)

      within("#instructions_#{recipe.id}") do
        expect(page).to have_content(
          <<~TEXT.chomp
            Instructions:
            #{recipe.instructions}
          TEXT
        )
      end
    end

    it "displays a user submitted photo"

    it "displays ingredients with measurements"
  end

  describe "Visiting the show page when recipe fields are blank" do
    it "If servings and instructions are missing then those categories don't show" do
      recipe = create(:recipe, :salad, :protein, chapter: @chapter, servings: nil, description: nil, instructions: nil)
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, recipe.id)
      
      within("#basic_info_#{recipe.id}") do
        expect(page).to_not have_content("serving")
      end
      within("#instructions_#{recipe.id}") do
        expect(page).to_not have_content("Instructions:")
      end
    end

    it "If a recipe doesn't have any of the meal time, food group, and dish type the characteristics section doesn't show" do
      recipe = create(:recipe, chapter: @chapter, meal_time: [], food_group: nil, meal_type: nil)
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, recipe.id)

      within("#meal_characteristics_#{recipe.id}") do
        expect(page).to_not have_content("Characteristics:")
      end
    end

    it "If at least one of meal time, food group or dish type is present then characteristics section does show" do
      #do multiple site visits with different recipes
      recipe_1 = create(:recipe, chapter: @chapter, food_group: nil, meal_type: nil)
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, recipe_1.id)
      
      within("#meal_characteristics_#{recipe_1.id}") do
        expect(page).to have_content(
          <<~TEXT.chomp
            Characteristics:
            breakfast brunch
          TEXT
        )
      end

      recipe_2 = create(:recipe, :protein, chapter: @chapter, meal_time: [], meal_type: nil)
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, recipe_2.id)
      
      within("#meal_characteristics_#{recipe_2.id}") do
        expect(page).to have_content("Characteristics:\n#{recipe_2.food_group}")
      end

      recipe_3 = create(:recipe, :dessert, chapter: @chapter, meal_time: [], food_group: nil)
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, recipe_3.id)
      
      within("#meal_characteristics_#{recipe_3.id}") do
        expect(page).to have_content("Characteristics:\n#{recipe_2.meal_type}")
      end
    end

    it "If both prep hours and minutes where not filled out, defaulting to 0, the prep time section does't appear" do
      recipe = create(:recipe, :salad, :protein, chapter: @chapter, prep_hours: 0, prep_minutes: 0)
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, recipe.id)

      within("#basic_info_#{recipe.id}") do
        expect(page).to_not have_content("hour")
        expect(page).to_not have_content("minute")
        expect(page).to_not have_content("Time to prepare")
      end
    end

    it "There is a default photo if a user doesn't upload one"

    it "If a recipe doesn't have ingredients, the ingredients section doesn't show"
  end

  describe "Buttons" do
    it "the library link takes the user back to the library" do
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @recipes.first.id)
      expect(page).to have_link("My Library")
      
      click_link("My Library")
      expect(page).to have_current_path(user_libraries_path(@user.id))
    end

    it "back to cookbook button takes user back to the cookbook show page" do
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @recipes.first.id)
      expect(page).to have_button("Back to Cookbook")

      click_button("Back to Cookbook")
      expect(page).to have_current_path(user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id))
    end

    it "edit recipe button takes the user to the edit form" do
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @recipes.first.id)
      expect(page).to have_button("Edit Recipe")

      within("#recipe_options") do
        click_button("Edit Recipe")
        end
      expect(page).to have_current_path(edit_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @recipes.first.id))
    end

    it "delete recipe button brings up a confirmation box after clicking ok it deletes it and redirects user to the cookbook show page
        and the user can see that it's gone", js: true do
      recipe_name = @recipes.first.name
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @recipes.first.id)
      expect(page).to have_button("Delete Recipe")

      within("#recipe_options") do
        accept_confirm do
          click_button("Delete Recipe")
        end
      end
      
      expect(page).to have_current_path(user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id))
      expect(page).to_not have_content(recipe_name)
    end

    it "delete recipe button brings up a confirmation box, after denying it user stays on the recipe page, unnaffected", js: true do
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @recipes.first.id)
      expect(page).to have_button("Delete Recipe")

      within("#recipe_options") do
        dismiss_confirm do
          click_button("Delete Recipe")
        end
      end

      expect(page).to have_current_path(user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @recipes.first.id))
    end

    it "has a log out button" do
      visit user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @recipes.first.id)
      expect(page).to have_button("Log Out")
      
      click_button("Log Out")
      expect(page).to have_current_path(root_path)
    end
  end
end