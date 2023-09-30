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

      expect(page).to have_link("Add a cookbook to my library", href: new_user_library_cookbook_path(@user.id, @library.id))
    end

    it 'shows books in my library' do
      book1 = create(:cookbook, library: @library)
      book2 = create(:cookbook, library: @library)
      book3 = create(:cookbook, library: @library)
      book4 = create(:cookbook, library: @library)
      book5 = create(:cookbook, library: @library)

      visit user_libraries_path(@user.id)

      expect(page).to have_content("#{book1.title} by #{book1.author}")
      expect(page).to have_content("#{book2.title} by #{book2.author}")
      expect(page).to have_content("#{book3.title} by #{book3.author}")
      expect(page).to have_content("#{book4.title} by #{book4.author}")
      expect(page).to have_content("#{book5.title} by #{book5.author}")
    end
  end
end