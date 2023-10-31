require "rails_helper"

RSpec.describe GoogleBooksService do
  describe "#get_book_matches", :vcr do
    it "returns a response with no more than 5 book matches" do
      search_info = "inauthor:eng+tie+ang+intitle:delightful+thai+cooking+isbn:0962781045"
      response = GoogleBooksService.get_book_matches(search_info)

      expect(response).to be_a(Hash)
      expect(response[:items]).to be_a(Array)
      expect(response[:items].count).to eq(1)

      response[:items].each do |cookbook|
        expect(cookbook).to have_key(:id)
        expect(cookbook).to have_key(:volumeInfo)
        expect(cookbook[:volumeInfo]).to have_key(:title)
        expect(cookbook[:volumeInfo]).to have_key(:authors)
        expect(cookbook[:volumeInfo]).to have_key(:publishedDate)
        expect(cookbook[:volumeInfo]).to have_key(:description)
        expect(cookbook[:volumeInfo]).to have_key(:industryIdentifiers)
        expect(cookbook[:volumeInfo]).to have_key(:categories)
        expect(cookbook[:volumeInfo]).to have_key(:imageLinks)
        expect(cookbook[:volumeInfo]).to have_key(:language)
      end
    end
  end
end