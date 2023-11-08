class CookbooksFacade
  def self.cookbook_matches(cookbook_params)
    search_info = write_search_info(cookbook_params)
    response = GoogleBooksService.get_book_matches(search_info)
    matches = []
    
    if response[:totalItems] != 0
      response[:items].map do |cookbook_info|
        matches << CookbookMatch.new(cookbook_info)
      end
    end
    matches
  end

  def self.write_search_info(cookbook_params)
    search_info = ""
    if cookbook_params[:title] != ""
      search_info += "intitle:#{cookbook_params[:title].downcase.gsub(" ", "+")}"
    end

    if cookbook_params[:authors] != ""
      search_info += "+inauthor:#{cookbook_params[:authors][0].downcase.gsub(" ", "+")}"
    end

    if cookbook_params[:publisher] != ""
      search_info += "+inpublisher:#{cookbook_params[:publisher].downcase.gsub(" ", "+")}"
    end

    if cookbook_params[:isbn] != ""
      search_info += "+isbn:#{cookbook_params[:isbn]}"
    end
    search_info
  end
end