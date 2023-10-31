class CookbooksFacade
  def self.cookbook_matches(search_info)
    response = GoogleBooksService.get_book_matches(search_info)
    
    response[:items].map do |cookbook_info|
      CookbookMatch.new(cookbook_info)
    end
  end
end