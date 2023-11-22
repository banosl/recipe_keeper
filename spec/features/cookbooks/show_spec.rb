require "rails_helper"

RSpec.describe "Cookbook Show Page" do
  before :each do
    @user = create(:user, :google)
    @user.create_library
    @cookbook = create(:cookbook, library: user.library)
    @chapter = create(:chapter, cookbook: @cookbook)
    @recipes = create_list(:recipe, 20, :breakfast, :salad, :dairy, chapter: @chapter)
  end
  describe "Cookbook info" do
    it "Displays the cookbook's title, subtitle, author(s), publisher, isbn, published date, image, language, description, date added to library, number of recipes" do
      visit user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id)

      within "#cookbook_details_#{@cookbook.id}" do
        expect(page).to have_content(@cookbook.title)
        expect(page).to have_content(@cookbook.subtitle)
        expect(page).to have_content("Author(s): {@cookbook.authors.to_sentence}")
        expect(page).to have_content("Published by: #{@cookbook.publisher}")
        expect(page).to have_content(@cookbook.isbn)
        expect(page).to have_content("Published: #{@cookbook.published_date}")
        expect(page).to have_content(@cookbook.image)
        expect(page).to have_content("Language: #{@cookbook.language}")
        expect(page).to have_content(@cookbook.description)
        expect(page).to have_content("Added on: #{@cookbook.created_at}")
        expect(page).to have_content("Number of recipes added: #{@cookbook.recipes_count}")
      end
    end

    it "If a book doesn't have a subtitle or description the page doesn't even say 'subtitle' or 'description'"

    it "If a book doesn't have an image, it displays a default 'no image' image"
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