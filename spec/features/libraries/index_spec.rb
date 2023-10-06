require 'rails_helper'

RSpec.describe 'library index' do
  before :each do
    @user = User.create({first_name: "Leo", last_name: "Banos Garcia", email: "leo@leo.com"})
    @library = @user.create_library
  end

  describe 'visiting a users library' do
    it 'shows a users library page with [names] library at the top' do
      visit user_libraries_path(@user.id)
   
      expect(page).to have_content("#{@user.first_name}'s Library")
    end

    it 'shows a button to add a cookbook' do
      visit user_libraries_path(@user.id)

      expect(page).to have_link("Add a cookbook to my library", href: new_user_library_cookbook_path(@user.id, @library.id))
    end

    it 'shows books in my library and books are listed as a table and each is a link to the book show page' do
      book1 = create(:cookbook, library: @library)
      book2 = create(:cookbook, library: @library)
      book3 = create(:cookbook, library: @library)
      book4 = create(:cookbook, library: @library)
      book5 = create(:cookbook, library: @library)

      visit user_libraries_path(@user.id)
      
      within "#library" do
        expect(page).to have_table_row("Title" => book1.title, "Author" => book1.author)
        expect(page).to have_link(book1.title, href: user_library_cookbook_path(@user.id, @library.id, book1.id))
        expect(page).to have_table_row("Title" => book2.title, "Author" => book2.author)
        expect(page).to have_link(book2.title, href: user_library_cookbook_path(@user.id, @library.id, book2.id))
        expect(page).to have_table_row("Title" => book3.title, "Author" => book3.author)
        expect(page).to have_link(book3.title, href: user_library_cookbook_path(@user.id, @library.id, book3.id))
        expect(page).to have_table_row("Title" => book4.title, "Author" => book4.author)
        expect(page).to have_link(book4.title, href: user_library_cookbook_path(@user.id, @library.id, book4.id))
        expect(page).to have_table_row("Title" => book5.title, "Author" => book5.author)
        expect(page).to have_link(book5.title, href: user_library_cookbook_path(@user.id, @library.id, book5.id))
        expect(page).to_not have_table_row("Title" => "be the dream", "Author" => "bob")
      end
    end
  end
end