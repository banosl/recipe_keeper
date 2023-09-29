require 'rails_helper'

RSpec.describe "New Cookbook form page" do
  before :each do
    @user = create(:user, :google)
    @library = @user.create_library
  end

  it "has the fields for adding a new cookbook" do
    visit new_user_library_cookbook_path(@user.id, @library.id)
    
    expect(page).to have_content("Add a New Cookbook")
    within ("#cookbook_form") do
      expect(page).to have_field(:title)
      expect(page).to have_field(:author)
      expect(page).to have_field(:publisher)
      expect(page).to have_field(:country_cuisine)
    end
  end

  it 'can fill out and submit the form and page is redirected to matches/confirmation page' do
    title = Faker::Book.title
    author = Faker::Book.author
    publisher = Faker::Book.publisher
    country_cuisine = Faker::Nation.nationality
    isbn = Faker::Barcode.isbn

    visit new_user_library_cookbook_path(@user.id, @library.id)
    within ("#cookbook_form") do
      fill_in :title, with: title
      fill_in :author, with: author
      fill_in :publisher, with: publisher
      fill_in :country_cuisine, with: country_cuisine
      fill_in :isbn, with: isbn
      click_button 'Submit'
    end
    save_and_open_page
    expect(path).to eq(new_user_library_cookbook_path(@user.id, @library.id))
    
    within ("#entries") do
      expect(page).to have_content("Title: #{title}")
      expect(page).to have_content("Author: #{author}")
      expect(page).to have_content("Publisher: #{publisher}")
      expect(page).to have_content("ISBN: #{isbn}")
      expect(page).to have_content("Nation of Origin: #{country_cuisine}")
    end

      expect(page).to not_have_field(:title)
      expect(page).to not_have_field(:author)
      expect(page).to not_have_field(:publisher)
      expect(page).to not_have_field(:country_cuisine)
  end

  # it 'will show an error if a form is submitted without a title'

end