require 'rails_helper'

RSpec.describe CookbookMatchSerializer do
  describe "#match_data" do
    it "Takes a cookbook match poro and turns it into a hash" do
      cookbook_search_result = {
      kind: "books#volume",
      id: "qsEOAAAACAAJ",
      volumeInfo: {
          title: "Delightful Thai Cooking",
          authors: [
              "Eng Tie Ang"
          ],
          publishedDate: "1990",
          description: "Thai food is becoming increasingly popular, and this great new cookbook tellshow to prepare more than 100 delicious Thai dishes, most of which can be madein less than an hour. Includes detailed instructions, line drawings and colorphotographs.",
          industryIdentifiers: [
              {
                  type: "ISBN_10",
                  identifier: "0962781045"
              },
              {
                  type: "ISBN_13",
                  identifier: "9780962781049"
              }
          ],
          categories: [
              "Cookery, Thai"
          ],
          imageLinks: {
              smallThumbnail: "http://books.google.com/books/content?id=qsEOAAAACAAJ&printsec=frontcover&img=1&zoom=5&source=gbs_api",
              thumbnail: "http://books.google.com/books/content?id=qsEOAAAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
          },
          language: "en",
        }
      }
      
      cookbook_match = CookbookMatch.new(cookbook_search_result)
      user = create(:user, :google)
      library = user.create_library

      serialized = CookbookMatchSerializer.match_data(cookbook_match, library.id)

      expect(serialized).to eq({cookbook: {
        title: "Delightful Thai Cooking",
        author: ["Eng Tie Ang"],
        publisher: "",
        isbn: "",
        library_id: library.id
      }

      })
    end
  end
end