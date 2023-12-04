require "rails_helper"

RSpec.describe "Cookbook Show Page" do
  before :each do
    @user = create(:user, :google)
    @user.create_library
    @cookbook = create(:cookbook, library: @user.library, isbn: {"ISBN-13": Faker::Barcode.isbn})
    @chapter = create(:chapter, cookbook: @cookbook)
    @recipes = create_list(:recipe, 20, :breakfast, :salad, :dairy, chapter: @chapter)
  end

  describe "Cookbook info" do
    it "Displays the cookbook's title, subtitle, author(s), publisher, isbn, published date, image, language, description, date added to library, number of recipes" do
      visit user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id)
      
      within "#cookbook_image_#{@cookbook.id}" do
        expect(page).to have_css("img[src='https://media.tenor.com/wDD-YmMOjgwAAAAC/pikachu-togepi.gif']")
      end

      within "#cookbook_details_#{@cookbook.id}" do
        expect(page).to have_content(@cookbook.title)
        expect(page).to have_content(@cookbook.subtitle)
        expect(page).to have_content("Author(s): #{@cookbook.authors.to_sentence}")
        expect(page).to have_content("Published by: #{@cookbook.publisher}, #{@cookbook.published_year}")
        expect(page).to have_content("Identifiers: ISBN-13: #{@cookbook.isbn["ISBN-13"]}")
        expect(page).to have_content("Language: #{@cookbook.language}")
        expect(page).to have_content(@cookbook.description)
        expect(page).to have_content("Added on: #{@cookbook.created_at.strftime("%B %d, %Y")}")
        expect(page).to have_content("Number of recipes added: #{@cookbook.recipe_count}")
      end
    end

    it "If a book doesn't have an image, it displays a default 'no image' image" do
      cookbook_no_image = create(:cookbook, library: @user.library, image_link: nil, isbn: {"ISBN-13": Faker::Barcode.isbn})
      visit user_library_cookbook_path(@user.id, @user.library.id, cookbook_no_image.id)
      
      within "#cookbook_image_#{cookbook_no_image.id}" do
        expect(page).to have_css("img[src*='/assets/no_image']")
      end
    end

    it "If published date is nil then 'Published by' is followed by 'Year unknown'" do
      cookbook_nil_published_year = create(:cookbook, library: @user.library, published_date: nil, isbn: {"ISBN-13": Faker::Barcode.isbn})
      visit user_library_cookbook_path(@user.id, @user.library.id, cookbook_nil_published_year.id)

      within("#cookbook_details_#{cookbook_nil_published_year.id}") do
        expect(page).to have_content("Published by: #{cookbook_nil_published_year.publisher}, Year unknown")
      end
    end

    it "If isbn is nil then 'Identifiers' is followed by 'Unknown'" do
      cookbook_nil_isbn = create(:cookbook, library: @user.library)

      visit user_library_cookbook_path(@user.id, @user.library.id, cookbook_nil_isbn.id)

      within ("#cookbook_details_#{cookbook_nil_isbn.id}") do
        expect(page).to have_content("Identifiers: Unknown")
      end
    end
  end

  describe "Recipes Table" do
    it "Displays the recipes in a table with columns for 'name', 'chapter', and page number" do
      visit user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id)
  
      within "#recipes" do
        expect(page).to have_table_row("Name" => @recipes[0].name, "Chapter" => @recipes[0].chapter.name, "Page" => @recipes[0].page)
        expect(page).to have_link(@recipes[0].name, href: user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @recipes[0].id))
        expect(page).to have_table_row("Name" => @recipes[1].name, "Chapter" => @recipes[1].chapter.name, "Page" => @recipes[1].page)
        expect(page).to have_link(@recipes[1].name, href: user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @recipes[1].id))
        expect(page).to have_table_row("Name" => @recipes[2].name, "Chapter" => @recipes[2].chapter.name, "Page" => @recipes[2].page)
        expect(page).to have_link(@recipes[2].name, href: user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @recipes[2].id))
        expect(page).to have_table_row("Name" => @recipes[3].name, "Chapter" => @recipes[3].chapter.name, "Page" => @recipes[3].page)
        expect(page).to have_link(@recipes[3].name, href: user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @recipes[3].id))
        expect(page).to have_table_row("Name" => @recipes[4].name, "Chapter" => @recipes[4].chapter.name, "Page" => @recipes[4].page)
        expect(page).to have_link(@recipes[4].name, href: user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @recipes[4].id))
        expect(page).to have_table_row("Name" => @recipes[5].name, "Chapter" => @recipes[5].chapter.name, "Page" => @recipes[5].page)
        expect(page).to have_link(@recipes[5].name, href: user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @recipes[5].id))
        expect(page).to have_table_row("Name" => @recipes[18].name, "Chapter" => @recipes[18].chapter.name, "Page" => @recipes[18].page)
        expect(page).to have_link(@recipes[18].name, href: user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @recipes[18].id))
        expect(page).to have_table_row("Name" => @recipes[19].name, "Chapter" => @recipes[19].chapter.name, "Page" => @recipes[19].page)
        expect(page).to have_link(@recipes[19].name, href: user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id, @recipes[19].id))
      end
    end
  end

  describe "Buttons" do
    it "Has a button for delete cookbook which produces a pop up confirmation, then when approved it takes the user to their library and the book is no longer listed"

    it "has a button for edit cookbook which directs the user to the edit form"

    it "has a button for return to library"
  end
end