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

  it "User can click cancel and be redirected to the library page" do
    visit new_user_library_cookbook_path(@user.id, @library.id)

    expect(page).to have_button("Cancel")

    within "#cookbook_form" do
      click_button "Cancel"
    end

    expect(page).to have_current_path(user_libraries_path(@user.id))
  end

  it 'can fill out and submit the form. Then the user is redirected to the match page but with matches/confirmation options
      after clicking save, the cookbook is created and the user is redirected to the library and they can see their book listed',
      js: true do

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

    expect(page).to have_current_path(user_libraries_path(@user.id))

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

  xit 'will redirect to :new and show a message when the app fails to save a cookbook' do
    title = Faker::Book.title
    author = Faker::Book.author
    publisher = Faker::Book.publisher
    country_cuisine = Faker::Nation.nationality
    isbn = Faker::Barcode.isbn
    library_id = nil
    params = {title: title, author: author, publisher: publisher, country_cuisine: country_cuisine, isbn: isbn, library_id: library_id}

    visit user_library_cookbooks_path(@user.id, @library.id, cookbook: params, method: :post)

    expect(current_path).to eq(new_user_library_cookbook_path(@user.id, @library.id))
    expect(page).to have_content("Something went wrong. Please re-enter your cookbook's details.")
  end
end