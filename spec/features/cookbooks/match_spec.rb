require 'rails_helper'

RSpec.describe "cookbook #match" do
  before :each do
    @user = create(:user, :google)
    @library = @user.create_library
  end

  describe "User visits the cookbook match page after submitting cookbook details in #new" do
    it "Shows the details of the cookbook submitted by the user to review 
        and can click the radio button and submit" do
        title = Faker::Book.title
        author = Faker::Book.author
        publisher = Faker::Book.publisher
        country_cuisine = Faker::Nation.nationality
        isbn = Faker::Barcode.isbn

      visit new_user_library_cookbook_path(@user.id, @library.id)
      within ("#cookbook_form") do
        fill_in :cookbook_title, with: title
        fill_in :cookbook_author, with: author
        fill_in :cookbook_publisher, with: publisher
        fill_in :cookbook_country_cuisine, with: country_cuisine
        fill_in :cookbook_isbn, with: isbn
        click_button 'Submit'
      end

      expect(current_path).to eq(match_new_user_library_cookbook_path(@user.id, @library.id))

        within ("#user_entries") do
          expect(page).to have_content("Title: #{title}")
          expect(page).to have_content("Author: #{author}")
          expect(page).to have_content("Publisher: #{publisher}")
          expect(page).to have_content("ISBN: #{isbn}")
          expect(page).to have_content("Nation of Origin: #{country_cuisine}")
        end
        within ("#cookbook_match") do
          choose :cookbook_user_entry_true
          expect(page).to_not have_field(:cookbook_title)
          expect(page).to_not have_field(:cookbook_author)
          expect(page).to_not have_field(:cookbook_publisher)
          expect(page).to_not have_field(:cookbook_country_cuisine)
          click_button 'Save'
        end
        
        expect(current_path).to eq(user_libraries_path(@user.id))
    end
  end
end