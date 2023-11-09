require "rails_helper"

RSpec.describe CookbookMatch do
  before :each do
    @cookbook_search_result = {
      kind: "books#volume",
      id: "qsEOAAAACAAJ",
      volumeInfo: {
          title: "Delightful Cooking",
          subtitle: "Yummy",
          authors: [
              "Leo Banos", "Luca Banos"
          ],
          publishedDate: "1990",
          publisher: "Luca's Books",
          description: "On a frosty day, Luca likes to make something yummy",
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
              "Cookery, Mexican"
          ],
          imageLinks: {
              smallThumbnail: "http://books.luca.com/image_1",
              thumbnail: "http://books.luca.com/image_11"
          },
          language: "en",
        }
      }
      
      @cookbook_match = CookbookMatch.new(@cookbook_search_result)
  end

  it "has attributes and exists" do
    expect(@cookbook_match).to be_instance_of(CookbookMatch)
    expect(@cookbook_match.title).to eq("Delightful Cooking")
    expect(@cookbook_match.subtitle).to eq("Yummy")
    expect(@cookbook_match.authors).to eq(["Leo Banos", "Luca Banos"])
    expect(@cookbook_match.publisher).to eq("Luca's Books")
    expect(@cookbook_match.published_date).to eq("1990")
    expect(@cookbook_match.description).to eq("On a frosty day, Luca likes to make something yummy")
    expect(@cookbook_match.image_link).to eq("http://books.luca.com/image_11")
    expect(@cookbook_match.language).to eq("en")
    expect(@cookbook_match.google_id).to eq("qsEOAAAACAAJ")
  end

  it "attributes are nil if there the result doesn't have them" do
    cookbook_search_result = {
      kind: "books#volume",
      id: "qsEOAAAACAAJ",
      volumeInfo: {
          title: "Delightful Cooking"
        }
      }
    cookbook_match = CookbookMatch.new(cookbook_search_result)

    expect(cookbook_match.title).to eq("Delightful Cooking")
    expect(cookbook_match.subtitle).to eq(nil)
    expect(cookbook_match.authors).to eq(nil)
    expect(cookbook_match.publisher).to eq(nil)
    expect(cookbook_match.published_date).to eq(nil)
    expect(cookbook_match.description).to eq(nil)
    expect(cookbook_match.image_link).to eq(nil)
    expect(cookbook_match.language).to eq(nil)
  end
    
  describe "isbn and authors methods" do
    it "#format_isbn formats the isbn attribute into a hash from the info in the search_results" do
      expect(@cookbook_match.isbn).to eq({
        "ISBN-10" => "1234567890",
        "ISBN-13" => "1234567890123"
      })
    end

    it "formats the isbn hash into a string" do
      expect(@cookbook_match.display_isbn).to eq("ISBN-10: 1234567890\nISBN-13: 1234567890123\n")
    end

    it "#display_authors formats them as a string" do
      expect(@cookbook_match.display_authors).to eq("Leo Banos, Luca Banos")
    end
  end
end