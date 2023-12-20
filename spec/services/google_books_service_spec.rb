require "rails_helper"

RSpec.describe GoogleBooksService do
  describe "#get_book_matches", :vcr do
    it "returns a response with no more than 5 book matches" do
      search_info = "intitle:thai+cooking"
      response = GoogleBooksService.get_book_matches(search_info)
      expect(response).to be_a(Hash)
      expect(response[:items]).to be_a(Array)
      expect(response[:items].count).to eq(5)

      response[:items].each do |cookbook|
        expect(cookbook).to have_key(:id)
        expect(cookbook).to have_key(:volumeInfo)
        expect(cookbook[:volumeInfo]).to have_key(:title)
        expect(cookbook[:volumeInfo]).to have_key(:authors)
        expect(cookbook[:volumeInfo]).to have_key(:publisher)
        expect(cookbook[:volumeInfo]).to have_key(:industryIdentifiers)
        expect(cookbook[:volumeInfo]).to have_key(:imageLinks)
        expect(cookbook[:volumeInfo]).to have_key(:language)
      end

      expect(response[:items][0][:volumeInfo]).to have_key(:subtitle)
    end
  end
end