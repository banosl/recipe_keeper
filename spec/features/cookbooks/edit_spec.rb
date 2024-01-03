require 'rails_helper'

RSpec.describe "Edit Cookbook Page" do
  before :each do
    @user = create(:user, :google)
    @user.create_library
    @cookbook = create(:cookbook, library: @user.library, isbn: {"ISBN-13": Faker::Barcode.isbn})
    @chapter = create(:chapter, cookbook: @cookbook)
    @recipes = create_list(:recipe, 20, :breakfast, :salad, :dairy, chapter: @chapter)
  end

  describe "Edit form" do
    it "Existing info about the cookbook is prepopulated in the form" do
      visit edit_user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id)

      within "#edit_#{@cookbook.id}" do
        expect(page).to have_field(:cookbook_title, with: @cookbook.title)
        expect(page).to have_field(:cookbook_subtitle, with: @cookbook.subtitle)
        expect(page).to have_field(:cookbook_authors, with: @cookbook.authors.to_sentence)
        expect(page).to have_field(:cookbook_publisher, with: @cookbook.publisher)
        expect(page).to have_field(:cookbook_published_date, with: @cookbook.published_year)
        expect(page).to have_field(:cookbook_language, with: @cookbook.language)
        expect(page).to have_field(:cookbook_description, with: @cookbook.description)
      end
    end

    it "The form updates the cookbook info after clicking submit" do
      visit edit_user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id)

      within "#edit_#{@cookbook.id}" do
        fill_in :cookbook_title, with: "Luca and the Tiny Peaches Cookbook"
        fill_in :cookbook_subtitle, with: "In May"
        fill_in :cookbook_authors, with: "Leo Banos"
        fill_in :cookbook_publisher, with: "Karki Chronicles"
        fill_in :cookbook_published_date, with: "2023"
        fill_in :cookbook_language, with: "German"
        fill_in :cookbook_description, with: "There once was a man that liked peaches way too much."

        click_button "Update"
      end

      expect(page).to have_current_path(user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id))

      within "#cookbook_details_#{@cookbook.id}" do
        expect(page).to have_content("Luca and the Tiny Peaches Cookbook")
        expect(page).to have_content("In May")
        expect(page).to have_content("Author(s): Leo Banos")
        expect(page).to have_content("Published by: Karki Chronicles, 2023")
        expect(page).to have_content("Language: German")
        expect(page).to have_content("There once was a man that liked peaches way too much.")
      end
    end

    it "User can update authors with multiple authors" do
      visit edit_user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id)

      within "#edit_#{@cookbook.id}" do
        fill_in :cookbook_authors, with: "Luca Tiwa, Leo Bingo"
        click_button "Update"
      end

      expect(page).to have_current_path(user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id))

      within "#cookbook_details_#{@cookbook.id}" do
        expect(page).to have_content("Author(s): Luca Tiwa, Leo Bingo")
      end
      
    end

    it "Will show 'Author unknown' if the author(s) are deleted" do
      visit edit_user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id)

      within "#edit_#{@cookbook.id}" do
        fill_in :cookbook_authors, with: ""
        click_button "Update"
      end

      expect(page).to have_current_path(user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id))

      within "#cookbook_details_#{@cookbook.id}" do
        expect(page).to have_content("Author(s): Unknown")
      end
    end

    it "User can click cancel and return to the cookbook show page with no changes" do
      visit edit_user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id)

      within "#edit_#{@cookbook.id}" do
        click_button "Cancel"
      end

      expect(page).to have_current_path(user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id))
      expect(page).to have_content(@cookbook.title)
    end

    it "User can upload their own picture"
  end

  describe "Edit form errors" do
    it "It will show error if the form is submitted without a title"

  end
end