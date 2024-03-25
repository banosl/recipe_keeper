require 'rails_helper'

RSpec.describe "Add a recipe form page" do
  before :each do
    @user = create(:user, :google)
    @user.create_library
    @cookbook = create(:cookbook, library: @user.library, isbn: {"ISBN-13": Faker::Barcode.isbn})
    @chapter_1 = create(:chapter, cookbook: @cookbook)
    @chapter_2 = create(:chapter, cookbook: @cookbook)
    sign_in_as(@user)
  end

  describe "Form Fields" do
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

    it "There are check boxes for meal times, they can be checked" do
      visit new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id)
      within("#meal_times") do
        expect(page).to have_field(:recipe_meal_time_breakfast)
        expect(page).to have_field(:recipe_meal_time_brunch)
        expect(page).to have_field(:recipe_meal_time_lunch)
        expect(page).to have_field(:recipe_meal_time_dinner)
        expect(page).to have_field(:recipe_meal_time_snack)
        check :recipe_meal_time_breakfast
        expect(page).to have_checked_field(:recipe_meal_time_breakfast)
        check :recipe_meal_time_brunch
        expect(page).to have_checked_field(:recipe_meal_time_brunch)
        check :recipe_meal_time_lunch
        expect(page).to have_checked_field(:recipe_meal_time_lunch)
        check :recipe_meal_time_dinner
        expect(page).to have_checked_field(:recipe_meal_time_dinner)
        check :recipe_meal_time_snack
        expect(page).to have_checked_field(:recipe_meal_time_snack)
      end
    end

    it "There are radio buttons for food group" do
      visit new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id)
      within("#food_group") do
        expect(page).to have_field(:recipe_food_group_grain)
        expect(page).to have_field(:recipe_food_group_protein)
        expect(page).to have_field(:recipe_food_group_fruit_vegetables)
        expect(page).to have_field(:recipe_food_group_dairy)
        expect(page).to have_field(:recipe_food_group_other)
      end
    end

    it "There are radio buttons for meal type" do
      visit new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id)
      within("#meal_type") do
        expect(page).to have_field(:recipe_meal_type_appetizer)
        expect(page).to have_field(:recipe_meal_type_salad)
        expect(page).to have_field(:recipe_meal_type_entree)
        expect(page).to have_field(:recipe_meal_type_dessert)
        expect(page).to have_field(:recipe_meal_type_drink)
      end
    end
    
    it "There is a drop down list for chapter available plus an option to add a new chapter", js: true do
      visit new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id)
      within("#chapter") do
        expect(page).to have_select(:recipe_chapter_id, with_options: [@chapter_1.name, @chapter_2.name, "Add New Chapter"])
      end
    end

    it "When New Chapter is chosen, a new field appears for a user to enter the name for the new chapter.", js: true do
      visit new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id)
      within("#chapter") do
        expect(page).to have_select(:recipe_chapter_id, selected: "Chapters")
        expect(page).to_not have_field(:recipe_new_chapter_field, disabled: true)
        expect(page).to_not have_content("New chapter name:")
        select @chapter_1.name, from: :recipe_chapter_id
        select "Add New Chapter", from: :recipe_chapter_id
        expect(page).to have_select(:recipe_chapter_id, selected: "Add New Chapter")
        expect(page).to have_field(:recipe_new_chapter_field, disabled: false)
        expect(page).to have_content("New chapter name:")
      end
    end
    
    it "There is a large text box for adding recipe instructions" do
      visit new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id)
      within("#instructions") do
        expect(page).to have_field(:recipe_instructions)
      end
    end

    it "There is a text box for name, page, servings, prep time, respectively" do
      visit new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id)
      within("#text_questions") do
        expect(page).to have_field(:recipe_name)
        expect(page).to have_field(:recipe_page)
        expect(page).to have_field(:recipe_servings)
        expect(page).to have_field(:recipe_prep_hours)
        expect(page).to have_field(:recipe_prep_minutes)
        expect(page).to have_field(:recipe_description)
      end
    end

    it "There is an option for uploading a photo or photos"
  end

  context "submitting a form" do
    context "a successful form submission" do
      xit "ingredients can be entered one per line with the measurement on the same line separated by a comma
      after submission ingredients individually create a recipe_ingredient"

      it 'A user fills out a form with name, page, servings, prep time, meal times, food group, meal type, existing chapter and instructions', js: true do
        visit new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id)
        @recipe = Faker::Food.dish
        @page = Faker::Number.number(digits: 3)

        within('#text_questions') do
          fill_in :recipe_name, with: @recipe
          fill_in :recipe_page, with: @page
          fill_in :recipe_servings, with: Faker::Number.number(digits: 1)
          fill_in :recipe_prep_hours, with: Faker::Number.between(from: 1, to: 24)
          fill_in :recipe_prep_minutes, with: Faker::Number.between(from: 1, to: 60)
          fill_in :recipe_description, with: Faker::Food.description
        end
        within('#chapter') do
          select @chapter_1.name, from: :recipe_chapter_id
        end
        within('#meal_times') do
          check :recipe_meal_time_breakfast
          check :recipe_meal_time_dinner
        end
        within('#food_group') do
          choose :recipe_food_group_protein
        end
        within('#meal_type') do
          choose :recipe_meal_type_entree
        end
        within('#instructions') do
          fill_in :recipe_instructions, with: Faker::ChuckNorris.fact
        end
        click_button('Add Recipe')
        expect(page).to have_current_path(user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id))
        within('#recipes') do
          expect(page).to have_table_row("Name" => @recipe, "Chapter" => @chapter_1.name, "Page" => @page)
          expect(page).to have_link(@recipe, href: user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @cookbook.recipes[0].id))
        end
      end

      it "When 'Add New Chapter' is chosen, and the add chapter name field is filled when submitted, a new chapter is created.", js: true do
        visit new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id)
        @recipe = Faker::Food.dish
        @page = Faker::Number.number(digits: 3)
        @chapter = Faker::Food.ethnic_category

        within('#text_questions') do
          fill_in :recipe_name, with: @recipe
          fill_in :recipe_page, with: @page
          fill_in :recipe_servings, with: Faker::Number.number(digits: 1)
          fill_in :recipe_prep_hours, with: Faker::Number.between(from: 1, to: 24)
          fill_in :recipe_prep_minutes, with: Faker::Number.between(from: 1, to: 60)
          fill_in :recipe_description, with: Faker::Food.description
        end
        within('#chapter') do
          expect(page).to_not have_select(:recipe_chapter_id, options: [@chapter])
          select "Add New Chapter", from: :recipe_chapter_id
          fill_in :recipe_new_chapter_field, with: @chapter
        end
        within('#meal_times') do
          check :recipe_meal_time_breakfast
          check :recipe_meal_time_dinner
        end
        within('#food_group') do
          choose :recipe_food_group_protein
        end
        within('#meal_type') do
          choose :recipe_meal_type_entree
        end
        within('#instructions') do
          fill_in :recipe_instructions, with: Faker::ChuckNorris.fact
        end
        click_button('Add Recipe')
        expect(page).to have_current_path(user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id))
        within('#recipes') do
          expect(page).to have_table_row("Name" => @recipe, "Chapter" => @chapter, "Page" => @page)
          expect(page).to have_link(@recipe, href: user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @cookbook.recipes[0].id))
        end
      end

      it "Servings, prep time, description, meal time, food group, meal type, and instructions can be left blank", js: true do
        visit new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id)
        @recipe = Faker::Food.dish
        @page = Faker::Number.number(digits: 3)
        
        within('#text_questions') do
          fill_in :recipe_name, with: @recipe
          fill_in :recipe_page, with: @page
        end
        within('#chapter') do
          select @chapter_1.name, from: :recipe_chapter_id
        end
        click_button('Add Recipe')
        expect(page).to have_current_path(user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id))
        within('#recipes') do
          expect(page).to have_table_row("Name" => @recipe, "Chapter" => @chapter_1.name, "Page" => @page)
          expect(page).to have_link(@recipe, href: user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @cookbook.recipes[0].id))
        end
      end
    end

    context "errors for an unsuccessful form submission" do
      before :each do
        @recipe = Faker::Food.dish
        @page = Faker::Number.number(digits: 3)
        visit new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id)
      end

      it "If new chapter is selected, the add chapter field cannot be empty", js: true do
        within('#text_questions') do
          fill_in :recipe_name, with: @recipe
          fill_in :recipe_page, with: @page
        end
        within('#chapter') do
          select "Add New Chapter", from: :recipe_chapter_id
        end
        click_button('Add Recipe')

        expect(page).to have_current_path(new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id))
        expect(page).to have_content("When adding a new chapter, the 'New chapter name' field cannot be left blank.")
      end

      it "A new chapter cannot be named 'New Chapter, Add New Chapter, or Chapter'", js: true do
        within('#text_questions') do
          fill_in :recipe_name, with: @recipe
          fill_in :recipe_page, with: @page
        end
        within('#chapter') do
          select "Add New Chapter", from: :recipe_chapter_id
          fill_in :recipe_new_chapter_field, with: "Add New Chapter"
        end
        click_button('Add Recipe')

        expect(page).to have_current_path(new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id))
        expect(page).to have_content("A new chapter cannot be named 'Add New Chapter'.")
      end

      it "A user must select a chapter and it cannot be 'Chapters'", js: true do
        within('#text_questions') do
          fill_in :recipe_name, with: @recipe
          fill_in :recipe_page, with: @page
        end
        click_button('Add Recipe')

        expect(page).to have_current_path(new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id))
        expect(page).to have_content("Please select a chapter.")
      end

      it "Servings, Prep hours, Prep minutes, and Page must be an number" do
        within('#text_questions') do
          fill_in :recipe_name, with: @recipe
          fill_in :recipe_page, with: "Bob"
          fill_in :recipe_servings, with: "Bob"
          fill_in :recipe_prep_hours, with: "Bob"
          fill_in :recipe_prep_minutes, with: "Bob"
        end
        within('#chapter') do
          select @chapter_1.name, from: :recipe_chapter_id
        end
        click_button('Add Recipe')

        expect(page).to have_current_path(new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id))
        expect(page).to have_content("Page must be a number")
        expect(page).to have_content("Servings must be a number")
        expect(page).to have_content("Prep hours must be a number")
        expect(page).to have_content("Prep minutes must be a number")
      end

      it "Prep time should be entered as digits with hours only from 1  to 24 and minutes from 1 to 60", js: true do
        within('#text_questions') do
          fill_in :recipe_name, with: @recipe
          fill_in :recipe_page, with: @page
          fill_in :recipe_prep_hours, with: 25
          fill_in :recipe_prep_minutes, with: 65
        end
        within('#chapter') do
          select @chapter_1.name, from: :recipe_chapter_id
        end
        click_button('Add Recipe')

        expect(page).to have_current_path(new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id))
        expect(page).to have_content("Prep hours must be within the range of 0 to 24")
        expect(page).to have_content("Prep minutes must be within the range of 0 to 60")
      end

      it "A recipe must have a name", js: true do
        within('#text_questions') do
          fill_in :recipe_page, with: @page
        end
        within('#chapter') do
          select @chapter_1.name, from: :recipe_chapter_id
        end
        click_button('Add Recipe')

        expect(page).to have_current_path(new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id))
        expect(page).to have_content("Name can't be blank")
      end

      it "A recipe must have a page number", js: true do
        within('#text_questions') do
          fill_in :recipe_name, with: @recipe
        end
        within('#chapter') do
          select @chapter_1.name, from: :recipe_chapter_id
        end
        click_button('Add Recipe')

        expect(page).to have_current_path(new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id))
        expect(page).to have_content("Page can't be blank")
      end
    end
  end

  context "Buttons" do
    it "There is a submit button" do
      visit new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id)
      expect(page).to have_button("Add Recipe")
    end

    it "There is a cancel button that takes the user back to the cookbook show page" do
      visit new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id)

      expect(page).to have_button("Cancel")
      click_button("Cancel")
      expect(page).to have_current_path(user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id))
    end
  end
end