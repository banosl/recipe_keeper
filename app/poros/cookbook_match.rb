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
    @language = cookbook_search_result[:volumeInfo][:language]
    cookbook_search_result[:volumeInfo][:imageLinks].nil? ? @image_link = nil :  @image_link = cookbook_search_result[:volumeInfo][:imageLinks][:thumbnail]
    @industry_identifiers = cookbook_search_result[:volumeInfo][:industryIdentifiers]
  end

  def isbn
    result = {}
    @industry_identifiers.each do |identifier|
      result[identifier[:type].downcase] = identifier[:identifier]
    end
    result
  end
end