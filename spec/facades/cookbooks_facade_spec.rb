require 'rails_helper'

RSpec.describe CookbooksFacade do
  describe "#cookbook_matches", :vcr do
    it "returns the top 5 results from just the author" do
      author = "inauthor:eng+tie+ang"
      results = CookbooksFacade.cookbook_matches(author)

      expect(results).to be_a(Array)
      expect(results.count).to be <= 5
      
      results.each do |cookbook|
        expect(cookbook.authors).to contain("Eng Tie Ang")
      end
    end

    it "returns the top 5 results from just the title" do
      title = "intitle:delightful+thai+cooking"
      results = CookbooksFacade.cookbook_matches(title)

      expect(results).to be_a(Array)
      expect(results.count).to be <= 5
      
      results.each do |cookbook|
        expect(cookbook.title).to contain("Delightful Thai Cooking")
      end
    end

    it "returns the top 5 results from just the isbn" do
      isbn = "isbn:0962781045"
      results = CookbooksFacade.cookbook_matches(isbn)

      expect(results).to be_a(Array)
      expect(results.count).to be <= 5
      
      results.each do |cookbook|
        expect(cookbook.isbn).to eq("0962781045")
      end
    end
    
    it "returns the top 5 results from just the title and author" do
      search_info = "inauthor:eng+tie+ang+intitle:delightful+thai+cooking"
      results = CookbooksFacade.cookbook_matches(search_info)

      expect(results).to be_a(Array)
      expect(results.count).to be <= 5
      
      results.each do |cookbook|
        expect(cookbook.title).to contain("Delightful Thai Cooking")
        expect(cookbook.authors).to contain("Eng Tie Ang")
      end
    end
  end
end