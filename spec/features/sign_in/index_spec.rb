require 'rails_helper'

RSpec.describe "Sign In Index Page" do
  describe 'visiting the sign in page' do
    it 'Should have a button for sign in with google' do
      visit sign_in_index_path

      expect(page).to have_button("Google Sign In")
    end
  end
end