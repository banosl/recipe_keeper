require 'rails_helper'

RSpec.describe CookbookMatchSerializer do
  describe "#match_data" do
    it "Takes a cookbook match poro and turns it into a hash" do
      cookbook_search_result = {
      kind: "books#volume",
      id: "abcdefghijklm",
      volumeInfo: {
          title: "Delightful Cooking",
          subtitle: "Luca's Choice",
          authors: [
              "Leo Banos"
          ],
          publishedDate: "1990",
          publisher: "Kuma Books",
          description: "Cooking for Luca and his buddies.",
          industryIdentifiers: [
              {
                  type: "ISBN_10",
                  identifier: "1234567890"
              },
              {
                  type: "ISBN_13",
                  identifier: "1234567890123"
              }
          ],
          categories: [
              "Cookery"
          ],
          imageLinks: {
              smallThumbnail: "http://thebook.com/1",
              thumbnail: "http://thebook.com/11"
          },
          language: "en",
        }
      }
      
      cookbook_match = CookbookMatch.new(cookbook_search_result)
      user = create(:user, :google)
      library = user.create_library

      serialized = CookbookMatchSerializer.match_data(cookbook_match, library.id)

      expect(serialized).to eq(
        {
          title: "Delightful Cooking",
          subtitle: "Luca's Choice",
          author: ["Leo Banos"],
          publisher: "Kuma Books",
          published_date: "1990",
          description: "Cooking for Luca and his buddies.",
          image_link: "http://thebook.com/11",
          language: "en",
          isbn: {
            "ISBN-10" => "1234567890",
            "ISBN-13" => "1234567890123"
          },
          google_id: "abcdefghijklm",
          library_id: library.id
        }
      )
    end
  end
end