class CookbookMatch
  attr_reader :google_id,
              :title,
              :authors,
              :published_date,
              :description,
              :image_link,
              :language

  def initialize(cookbook_search_result)
    @google_id = cookbook_search_result[:id]
    @title = cookbook_search_result[:volumeInfo][:title]
    @authors = cookbook_search_result[:volumeInfo][:authors]
    @published_date = cookbook_search_result[:volumeInfo][:publishedDate]
    @description = cookbook_search_result[:volumeInfo][:description]
    @isbn = cookbook_search_result[:volumeInfo][:industryIdentifiers]
    @image_link = cookbook_search_result[:volumeInfo][:imageLinks][:thumbnail]
    @language = cookbook_search_result[:volumeInfo][:language]
  end

  def isbn_10
    find_isbn("ISBN_10")
  end

  def isbn_13
    find_isbn("ISBN_13")
  end

  def find_isbn(type)
    @isbn.find do |h|
      if h[:type] == type
       return h[:identifier]
      end
    end
  end
end