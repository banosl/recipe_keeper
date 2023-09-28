require 'rails_helper'

RSpec.describe 'library index' do
  before :each do
    @user = User.create({first_name: "Leo", last_name: "Banos Garcia", email: "leo@leo.com"})
    @library = @user.create_library
  end

  describe 'visiting a users library' do
    it 'shows a users library page with names library at the top' do
      visit user_libraries_path(@user.id)
   
      expect(page).to have_content("#{@user.first_name}'s Library")
    end

    it 'shows a button to add a cookbook' do
      visit user_libraries_path(@user.id)
      save_and_open_page

      expect(page).to have_link("Add a cookbook to my library", href: new_user_library_cookbook_path(@user.id, @library.id))
    end
  end
end