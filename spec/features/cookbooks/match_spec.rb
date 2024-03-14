require 'rails_helper'

RSpec.describe "cookbook #match", type: :feature do
  before :each do
    @user = create(:user, :google)
    @user.create_library

    @title = "Great British Cooking"
    @subtitle = "A Wellkept Secret"
    @author = "Jane Garmey"
    @publisher = "Harper Collins"
    @country_cuisine = "British"
    @isbn = "9780062039019"

    sign_in_as(@user)
    click_link "Add a cookbook to my library"
      
    within ("#cookbook_form") do
      fill_in :cookbook_title, with: @title
      fill_in :cookbook_authors, with: @author
      fill_in :cookbook_publisher, with: @publisher
      fill_in :cookbook_country_cuisine, with: @country_cuisine
      fill_in :cookbook_isbn, with: @isbn
      click_button 'Submit'
    end
  end

  describe "User visits the cookbook match page after submitting cookbook details in #new", :vcr do
    it "Shows the details of the cookbook submitted by the user to review 
    and chooses to save the book as is, but the save button doesn't appear until a radio button is selected", js: true do
      within ("#user_entries") do
        expect(page).to have_content("Title: #{@title}")
        expect(page).to have_content("Authors: #{@author}")
        expect(page).to have_content("Publisher: #{@publisher}")
        expect(page).to have_content("ISBN: #{@isbn}")
        expect(page).to have_content("Nation of Origin: #{@country_cuisine}")
      end
      
      within ("#cookbook_match") do
        expect(page).to have_button("Save Cookbook", disabled: true)
        expect(page).to_not have_field(:cookbook_title)
        expect(page).to_not have_field(:cookbook_authors)
        expect(page).to_not have_field(:cookbook_publisher)
        expect(page).to_not have_field(:cookbook_country_cuisine)
        choose :cookbook_user_entry_true
        expect(page).to have_button("Save Cookbook", disabled: false)
        click_button("Save Cookbook")
      end
        
      expect(page).to have_current_path(user_libraries_path(@user.id))
      within "#library" do
        expect(page).to have_table_row("Title" => @title, "Author(s)" => @author)
      end
    end

    it "User can click cancel and be redirected to the library page" do
      expect(page).to have_button("Cancel")
  
      within "#cookbook_match" do
        click_button "Cancel"
      end
  
      expect(page).to have_current_path(user_libraries_path(@user.id))
    end
  end
  
  describe "match page with options from google books", :vcr do
    before :each do
      @user = create(:user, :google)
      @library = @user.create_library
      sign_in_as(@user)

      visit new_user_library_cookbook_path(@user.id, @library.id)
      within ("#cookbook_form") do
        fill_in :cookbook_title, with: "The Super Chicken Cookbook"
        click_button 'Submit'
      end
    end

    it "choose a radio button", js: true  do
      expect(page).to have_content("Is this your cookbook?")
      choose :cookbook_user_entry_match_2
    end

    it "user can view up to 5 options of cookbooks from the google api after entering their book info", js: true do
      within ("#cookbook_match") do
      choose :cookbook_user_entry_match_2
        click_button("Save Cookbook")
      end

      within "#library" do
        expect(page).to have_table_row("Title" => "The Super Chicken Cookbook", "Author(s)" => "Claudia Carlin")
      end
    end
  end
end