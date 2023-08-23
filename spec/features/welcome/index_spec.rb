require 'rails_helper'

RSpec.describe WelcomeController, type: :feature do
  describe 'visiting welcome page' do
    it 'displays Recipe Keeper at the top center of the page' do
      visit '/'
      save_and_open_page
      expect(page).to have_content("Recipe Keeper")
    end

    it 'shows a link to sign up in the top right corner of page'

    it 'shows a link to sign in in the top right corner of page'
  end
end