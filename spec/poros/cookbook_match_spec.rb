require "rails_helper"

RSpec.describe CookbookMatch do
  before :each do
    @cookbook_search_result = {
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
      
      @cookbook_match = CookbookMatch.new(@cookbook_search_result)
  end

  it "has attributes and exists" do
    expect(@cookbook_match).to be_instance_of(CookbookMatch)
    expect(@cookbook_match.title).to eq("Delightful Thai Cooking")
    expect(@cookbook_match.authors).to eq(["Eng Tie Ang"])
    expect(@cookbook_match.published_date).to eq("1990")
    expect(@cookbook_match.description).to eq("Thai food is becoming increasingly popular, and this great new cookbook tellshow to prepare more than 100 delicious Thai dishes, most of which can be madein less than an hour. Includes detailed instructions, line drawings and colorphotographs.",)
    expect(@cookbook_match.image_link).to eq("http://books.google.com/books/content?id=qsEOAAAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api")
    expect(@cookbook_match.language).to eq("en")
    expect(@cookbook_match.google_id).to eq("qsEOAAAACAAJ")
  end

  it "attributes are nil if there the result doesn't have them" do
    cookbook_search_result = {
      kind: "books#volume",
      id: "qsEOAAAACAAJ",
      volumeInfo: {
          title: "Delightful Thai Cooking"
        }
      }
    cookbook_match = CookbookMatch.new(cookbook_search_result)

    expect(cookbook_match.title).to eq("Delightful Thai Cooking")
    expect(cookbook_match.authors).to eq(nil)
    expect(cookbook_match.published_date).to eq(nil)
    expect(cookbook_match.description).to eq(nil)
    expect(cookbook_match.image_link).to eq(nil)
    expect(cookbook_match.language).to eq(nil)
  end
    
  describe "isbn methods" do
    it "#format_isbn formats the isbn attribute into a hash from the info in the search_results" do
      expect(@cookbook_match.isbn).to eq({
        "isbn_10" => "0962781045",
        "isbn_13" => "9780962781049"
      })
    end
  end
end