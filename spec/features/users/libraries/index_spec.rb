require 'rails_helper'

RSpec.describe 'library index' do
  before :each do
    @user = User.create({first_name: "Leo", last_name: "Banos Garcia", email: "leo@leo.com"})
    @library = @user.create_library
  end

  describe 'visiting a users library' do
    it 'shows a users library page with names library at the top' do
      # binding.pry
      visit user_libraries_path(@user.id)

      expect(page).to have_content("Leo's Library")
    end
  end
end