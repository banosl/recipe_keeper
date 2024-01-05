require 'rails_helper'

RSpec.describe 'library index' do
  before :each do
    @user = create(:user, :google)
    @library = @user.create_library
  end

  before :each do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(:google_oauth2, uid: @user.google_id, info: {email: @user.email}, credentials: {token: @user.google_token})
  end

  describe 'visiting a users library' do
    it 'shows a users library page with [names] library at the top' do
      visit user_libraries_path(@user.id)
      click_button "Google Sign In"
   
      expect(page).to have_content("#{@user.first_name}'s Library")
    end

    it 'shows a button to add a cookbook' do
      visit user_libraries_path(@user.id)
      click_button "Google Sign In"

      expect(page).to have_link("Add a cookbook to my library", href: new_user_library_cookbook_path(@user.id, @library.id))
    end

    it 'shows books in my library and books are listed as a table and each is a link to the book show page' do
      book1 = create(:cookbook, library: @library)
      book2 = create(:cookbook, library: @library)
      book3 = create(:cookbook, library: @library)
      book4 = create(:cookbook, library: @library)
      book5 = create(:cookbook, library: @library)

      visit user_libraries_path(@user.id)
      click_button "Google Sign In"
      
      within "#library" do
        expect(page).to have_table_row("Title" => book1.title, "Author(s)" => book1.authors.to_sentence)
        expect(page).to have_link(book1.title, href: user_library_cookbook_path(@user.id, @library.id, book1.id))
        expect(page).to have_table_row("Title" => book2.title, "Author(s)" => book2.authors.to_sentence)
        expect(page).to have_link(book2.title, href: user_library_cookbook_path(@user.id, @library.id, book2.id))
        expect(page).to have_table_row("Title" => book3.title, "Author(s)" => book3.authors.to_sentence)
        expect(page).to have_link(book3.title, href: user_library_cookbook_path(@user.id, @library.id, book3.id))
        expect(page).to have_table_row("Title" => book4.title, "Author(s)" => book4.authors.to_sentence)
        expect(page).to have_link(book4.title, href: user_library_cookbook_path(@user.id, @library.id, book4.id))
        expect(page).to have_table_row("Title" => book5.title, "Author(s)" => book5.authors.to_sentence)
        expect(page).to have_link(book5.title, href: user_library_cookbook_path(@user.id, @library.id, book5.id))
        expect(page).to_not have_table_row("Title" => "be the dream", "Author(s)" => "bob")
      end
    end

    it "if a cookbook is saved from the API with authors as nil, the table displays 'Authors Unknown'" do
      book1 = create(:cookbook, library: @library, authors: nil)

      visit user_libraries_path(@user.id)
      click_button "Google Sign In"

      within "#library" do
        expect(page).to have_table_row("Title" => book1.title, "Author(s)" => "Unknown")
      end
    end
  end
end