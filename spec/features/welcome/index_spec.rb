require 'rails_helper'

RSpec.describe WelcomeController, type: :feature do
  describe 'visiting welcome page' do
    it 'displays Recipe Keeper at the top center of the page' do
      visit '/'
      
      expect(page).to have_content("Recipe Keeper")
    end

    it 'shows a link to sign in in the top right corner of page' do
      visit '/'
      
      expect(page).to have_content("Sign In")
      expect(page).to have_link("Sign In", :href=>"/sign_in")
    end
  end
end