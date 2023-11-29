require "rails_helper"

RSpec.describe "Cookbook Show Page" do
  before :each do
    @user = create(:user, :google)
    @user.create_library
    @cookbook = create(:cookbook, library: @user.library)
    @chapter = create(:chapter, cookbook: @cookbook)
    @recipes = create_list(:recipe, 20, :breakfast, :salad, :dairy, chapter: @chapter)
  end

  describe "Cookbook info" do
    it "Displays the cookbook's title, subtitle, author(s), publisher, isbn, published date, image, language, description, date added to library, number of recipes" do
      visit user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id)
      
      within "#cookbook_image_#{@cookbook.id}" do
        expect(page).to have_css("img[src='https://media.tenor.com/wDD-YmMOjgwAAAAC/pikachu-togepi.gif']")
      end

      within "#cookbook_details_#{@cookbook.id}" do
        expect(page).to have_content(@cookbook.title)
        expect(page).to have_content(@cookbook.subtitle)
        expect(page).to have_content("Author(s): #{@cookbook.authors.to_sentence}")
        expect(page).to have_content("Published by: #{@cookbook.publisher}, #{@cookbook.published_year}")
        expect(page).to have_content(@cookbook.isbn)
        expect(page).to have_content("Language: #{@cookbook.language}")
        expect(page).to have_content(@cookbook.description)
        expect(page).to have_content("Added on: #{@cookbook.created_at.strftime("%B %d, %Y")}")
        expect(page).to have_content("Number of recipes added: #{@cookbook.recipe_count}")
      end
    end

    it "If a book doesn't have an image, it displays a default 'no image' image" do
      cookbook_no_image = create(:cookbook, library: @user.library, image_link: nil)
      visit user_library_cookbook_path(@user.id, @user.library.id, cookbook_no_image.id)
      
      within "#cookbook_image_#{cookbook_no_image.id}" do
        expect(page).to have_css("img[src*='/assets/no_image']")
      end
    end

    it "If published date is nil then 'Published by' is followed by 'Year unknown'" do
      cookbook_nil_published_year = create(:cookbook, library: @user.library, published_date: nil)
      visit user_library_cookbook_path(@user.id, @user.library.id, cookbook_nil_published_year.id)

      within("#cookbook_details_#{cookbook_nil_published_year.id}") do
        expect(page).to have_content("Published by: #{cookbook_nil_published_year.publisher}, Year unknown")
      end
    end
  end

  describe "Recipes Table" do
    it "Displays the recipes in a table with columns for 'name', 'chapter', and page number"
  end

  describe "Buttons" do
    it "Has a button for delete cookbook which produces a pop up confirmation, then when approved it takes the user to their library and the book is no longer listed"

    it "has a button for edit cookbook which directs the user to the edit form"

    it "has a button for return to library"
  end
end