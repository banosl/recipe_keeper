require 'rails_helper'

RSpec.describe CookbooksFacade do
  before :each do
    @cookbook_params = { title: "Delightful Thai Cooking",
                          author: "Eng Tie Ang",
                          publisher: "Ambrosia Publications",
                          country_cuisine: "",
                          isbn: "0962781045",
                          library_id: "1567"
      }
  end

  describe "#cookbook_matches", :vcr do
    it "returns the top 5 results from the cookbook params" do
      results = CookbooksFacade.cookbook_matches(@cookbook_params)

      expect(results).to be_a(Array)
      expect(results.count).to be <= 5
      results.each do |cookbook|
        expect(cookbook).to be_instance_of(CookbookMatch)
        expect(cookbook.authors).to include("Eng Tie Ang")
        expect(cookbook.title).to be_a(String)
        expect(cookbook.isbn["ISBN-10"]).to eq("0962781045")
        expect(cookbook.isbn["ISBN-13"]).to eq("9780962781049")
      end
    end

    it "returns an empty array when response items count is 0" do
      cookbook_params = { title: "Apple Pie Like Mom's",
                          author: "",
                          publisher: "",
                          country_cuisine: "",
                          isbn: "1",
                          library_id: "1567"
      }
      results = CookbooksFacade.cookbook_matches(cookbook_params)

      expect(results).to eq([])
    end
  end

  describe "#write_search_info" do
    it "returns a single string formatted for google books query param from all the fields entered in the new cookbooks form in lower case" do
      search_info = CookbooksFacade.write_search_info(@cookbook_params)
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