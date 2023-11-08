class CookbookMatch
  attr_reader :google_id,
              :title,
              :subtitle,
              :authors,
              :publisher,
              :published_date,
              :description,
              :image_link,
              :language

  def initialize(cookbook_search_result)
    @google_id = cookbook_search_result[:id]
    @title = cookbook_search_result[:volumeInfo][:title]
    @subtitle = cookbook_search_result[:volumeInfo][:subtitle]
    @authors = cookbook_search_result[:volumeInfo][:authors]
    @publisher = cookbook_search_result[:volumeInfo][:publisher]
    @published_date = cookbook_search_result[:volumeInfo][:publishedDate]
    @description = cookbook_search_result[:volumeInfo][:description]
    @language = cookbook_search_result[:volumeInfo][:language]
    cookbook_search_result[:volumeInfo][:imageLinks].nil? ? @image_link = nil :  @image_link = cookbook_search_result[:volumeInfo][:imageLinks][:thumbnail]
    @industry_identifiers = cookbook_search_result[:volumeInfo][:industryIdentifiers]
  end

  def isbn
    result = {}
    if @industry_identifiers
      @industry_identifiers.each do |identifier|
        result[identifier[:type].sub("_", "-")] = identifier[:identifier]
      end
    end
    result
  end

  def display_isbn
    result = ""
    isbn.each do |type, num|
      result += "#{type}: #{num}\n"
    end
    result    
  end

  def display_authors
    result = ""
    if @authors
      @authors.each do |author|
        result += ", #{author}"
      end
    end
    result.sub(", ", "")
  end
end