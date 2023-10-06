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
      expect(page).to have_field(:cookbook_title)
      expect(page).to have_field(:cookbook_author)
      expect(page).to have_field(:cookbook_publisher)
      expect(page).to have_field(:cookbook_country_cuisine)
    end
  end

  it 'can fill out and submit the form then page is redirected to the same page but with matches/confirmation options
      after clicking save, the cookbook is created and the user is redirected to the library and they can see their book listed' do
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
    
    within ("#cookbook_match") do
      choose :cookbook_user_entry_true
      click_button "Save"
    end

    expect(current_path).to eq(user_libraries_path(@user.id))

    within "#library" do
      expect(page).to have_table_row("Title" => title, "Author" => author)
    end
  end

  it 'will show an error if a form is submitted without a title, 
      and anything that was populated before will be prefilled' do
    author = Faker::Book.author
    publisher = Faker::Book.publisher
    country_cuisine = Faker::Nation.nationality
    isbn = Faker::Barcode.isbn

    visit new_user_library_cookbook_path(@user.id, @library.id)
    
    within ("#cookbook_form") do
      fill_in :cookbook_author, with: author
      fill_in :cookbook_publisher, with: publisher
      fill_in :cookbook_country_cuisine, with: country_cuisine
      fill_in :cookbook_isbn, with: isbn
      click_button 'Submit'
    end
    
    expect(current_path).to eq(new_user_library_cookbook_path(@user.id, @library.id))
    expect(page).to have_content("Please enter a title for your cookbook.")
    
    within ("#cookbook_form") do
      expect(page).to have_field(:cookbook_author, with: author)
      expect(page).to have_field(:cookbook_publisher, with: publisher)
      expect(page).to have_field(:cookbook_country_cuisine, with: country_cuisine)
      expect(page).to have_field(:cookbook_isbn, with: isbn)
      expect(page).to have_field(:cookbook_title, with: "")
    end
  end
end