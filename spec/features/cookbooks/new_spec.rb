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
      expect(page).to have_field(:cookbook_authors)
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

  describe "submitting a form" do
    context "saving a cookbook as entered", :vcr do
      it 'can fill out and submit the form. Then the user is redirected to the match page but with matches/confirmation options
      after clicking Save Cookbook, the cookbook is created and the user is redirected to the library and they can see their book listed',
      js: true do
        title = "World of Warcraft The official Cookbook"
        author = "Chelsea Monroe-Cassel"
        publisher = "Insight Editions"
        country_cuisine = "Azeroth"
        isbn = "9781608878048"
        
        visit new_user_library_cookbook_path(@user.id, @library.id)
        within ("#cookbook_form") do
          fill_in :cookbook_title, with: title
          fill_in :cookbook_authors, with: author
          fill_in :cookbook_publisher, with: publisher
          fill_in :cookbook_country_cuisine, with: country_cuisine
          fill_in :cookbook_isbn, with: isbn
          click_button 'Submit'
        end
  
        within ("#cookbook_match") do
          choose :cookbook_user_entry_true
          click_button "Save Cookbook"
        end
    
        expect(page).to have_current_path(user_libraries_path(@user.id))
        
        within "#library" do
          expect(page).to have_table_row("Title" => title, "Author" => author)
        end
      end
    end

    context "isbn defaults as nil", :vcr do
      it "when a user saves a book as entered, with a blank isbn field the default value for cookbook.isbn is nil", js: true do
        title = "Banana Cooking"
        author = "Luca Banos"
        publisher = "I Publish"

        visit new_user_library_cookbook_path(@user.id, @library.id)
        within ("#cookbook_form") do
          fill_in :cookbook_title, with: title
          fill_in :cookbook_authors, with: author
          fill_in :cookbook_publisher, with: publisher
          click_button 'Submit'
        end

        within ("#cookbook_match") do
          choose :cookbook_user_entry_true
          click_button "Save Cookbook"
        end
        
        expect(page).to have_current_path(user_libraries_path(@user.id))
        expect(Cookbook.find_by(title: "Banana Cooking").isbn).to be(nil)
      end
    end

    context "form field errors", :vcr do
      it 'will show an error if a form is submitted without a title, 
      and anything that was populated before will be prefilled' do
          author = "Chelsea Monroe-Cassel"
          publisher = "Insight Editions"
          country_cuisine = "Azeroth"
          isbn = "9781608878048"
        
        visit new_user_library_cookbook_path(@user.id, @library.id)
        
        within ("#cookbook_form") do
          fill_in :cookbook_authors, with: author
          fill_in :cookbook_publisher, with: publisher
          fill_in :cookbook_country_cuisine, with: country_cuisine
          fill_in :cookbook_isbn, with: isbn
          click_button 'Submit'
        end
  
        expect(current_path).to eq(new_user_library_cookbook_path(@user.id, @library.id))
        expect(page).to have_content("Please enter a title for your cookbook.")
  
        within ("#cookbook_form") do
          expect(page).to have_field(:cookbook_authors, with: author)
          expect(page).to have_field(:cookbook_publisher, with: publisher)
          expect(page).to have_field(:cookbook_country_cuisine, with: country_cuisine)
          expect(page).to have_field(:cookbook_isbn, with: isbn)
          expect(page).to have_field(:cookbook_title, with: "")
        end
      end

      it "will show an error if the isbn entered isn't all digits" do
        title = "Cooking for Babies"
        isbn = "abc312459a"

        visit new_user_library_cookbook_path(@user.id, @library.id)

        within ("#cookbook_form") do
          fill_in :cookbook_title, with: title
          fill_in :cookbook_isbn, with: isbn
          click_button 'Submit'
        end

        expect(current_path).to eq(new_user_library_cookbook_path(@user.id, @library.id))
        expect(page).to have_content("Please check the ISBN. It should be all digits.")
      end
      
      it "will show an error if the isbn entered is shorter than 10 digits" do
        title = "Cooking for Apple Lovers"
        isbn = "123456789"

        visit new_user_library_cookbook_path(@user.id, @library.id)

        within ("#cookbook_form") do
          fill_in :cookbook_title, with: title
          fill_in :cookbook_isbn, with: isbn
          click_button 'Submit'
        end

        expect(current_path).to eq(new_user_library_cookbook_path(@user.id, @library.id))
        expect(page).to have_content("Please check the ISBN. It should be either 10 or 13 digits in length.")
      end
      
      it "will show an error if the isbn entered is longer than 13 digits" do
        title = "Cooking in Style"
        isbn = "12345678901234"

        visit new_user_library_cookbook_path(@user.id, @library.id)

        within ("#cookbook_form") do
          fill_in :cookbook_title, with: title
          fill_in :cookbook_isbn, with: isbn
          click_button 'Submit'
        end

        expect(current_path).to eq(new_user_library_cookbook_path(@user.id, @library.id))
        expect(page).to have_content("Please check the ISBN. It should be either 10 or 13 digits in length.")
      end

      it "will show an error if the isbn entered is 12 digits" do
        title = "Cooking When You Don't Feel Like It"
        isbn = "123456789012"

        visit new_user_library_cookbook_path(@user.id, @library.id)

        within ("#cookbook_form") do
          fill_in :cookbook_title, with: title
          fill_in :cookbook_isbn, with: isbn
          click_button 'Submit'
        end

        expect(current_path).to eq(new_user_library_cookbook_path(@user.id, @library.id))
        expect(page).to have_content("Please check the ISBN. It should be either 10 or 13 digits in length.")
      end

      it "will show the no title error over the isbn error if title is blank and isbn is filled out wrong" do
        isbn = "123456789012345"

        visit new_user_library_cookbook_path(@user.id, @library.id)

        within ("#cookbook_form") do
          fill_in :cookbook_isbn, with: isbn
          click_button 'Submit'
        end

        expect(current_path).to eq(new_user_library_cookbook_path(@user.id, @library.id))
        expect(page).to have_content("Please enter a title for your cookbook.")
      end
    end
  end

  # xit 'will redirect to :new and show a message when the app fails to Save a cookbook' do
  #   title = Faker::Book.title
  #   author = Faker::Book.author
  #   publisher = Faker::Book.publisher
  #   country_cuisine = Faker::Nation.nationality
  #   isbn = Faker::Barcode.isbn
  #   library_id = nil
  #   params = {title: title, author: author, publisher: publisher, country_cuisine: country_cuisine, isbn: isbn, library_id: library_id}

  #   visit user_library_cookbooks_path(@user.id, @library.id, cookbook: params, method: :post)

  #   expect(current_path).to eq(new_user_library_cookbook_path(@user.id, @library.id))
  #   expect(page).to have_content("Something went wrong. Please re-enter your cookbook's details.")
  # end
end