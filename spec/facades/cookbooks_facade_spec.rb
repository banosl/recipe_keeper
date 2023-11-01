require 'rails_helper'

RSpec.describe CookbooksFacade do
  describe "#cookbook_matches", :vcr do
    it "returns the top 5 results from just the author" do
      author = "inauthor:eng+tie+ang"
      results = CookbooksFacade.cookbook_matches(author)

      expect(results).to be_a(Array)
      expect(results.count).to be <= 5
      results.each do |cookbook|
        expect(cookbook).to be_instance_of(CookbookMatch)
        expect(cookbook.authors).to include("Eng Tie Ang")
      end
    end

    it "returns the top 5 results from just the title" do
      title = "intitle:delightful+thai+cooking"
      results = CookbooksFacade.cookbook_matches(title)

      expect(results).to be_a(Array)
      expect(results.count).to be <= 5
      
      results.each do |cookbook|
        expect(cookbook.title).to be_a(String)
      end
    end

    it "returns the top 5 results from just the isbn" do
      isbn = "isbn:0962781045"
      results = CookbooksFacade.cookbook_matches(isbn)

      expect(results).to be_a(Array)
      expect(results.count).to be <= 5
      
      results.each do |cookbook|
        expect(cookbook.isbn_10).to eq("0962781045")
        expect(cookbook.isbn_13).to eq("9780962781049")
      end
    end
    
    it "returns the top 5 results from just the title and author" do
      search_info = "inauthor:eng+tie+ang+intitle:delightful+thai+cooking"
      results = CookbooksFacade.cookbook_matches(search_info)

      expect(results).to be_a(Array)
      expect(results.count).to be <= 5
      
      results.each do |cookbook|
        expect(cookbook.title).to be_a(String)
        expect(cookbook.authors).to include("Eng Tie Ang")
      end
    end
  end

  describe "#write_search_info" do
    it "returns a single string formatted for google books query param from all the fields entered in the new cookbooks form in lower case" do
      cookbook_params = { title: "Delightful Thai Cooking",
                          author: "Eng Tie Ang",
                          publisher: "Ambrosia Publications",
                          country_cuisine: "",
                          isbn: "0962781045",
                          library_id: "1567"
      }

      search_info = CookbooksFacade.write_search_info(cookbook_params)
      expect(search_info).to eq("intitle:delightful+thai+cooking+inauthor:eng+tie+ang+inpublisher:ambrosia+publications+isbn:0962781045")
    end

    it "returns a single string if only title is not blank" do
      cookbook_params = { title: "Delightful Thai Cooking",
                          author: "",
                          publisher: "",
                          country_cuisine: "",
                          isbn: "",
                          library_id: "1567"
      }

      search_info = CookbooksFacade.write_search_info(cookbook_params)
      expect(search_info).to eq("intitle:delightful+thai+cooking")
    end
  end
end