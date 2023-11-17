class GoogleBooksService
  def self.get_book_matches(search_info)
    cached_match = Rails.cache.read("match_params_#{search_info}")
    return json_parse(cached_match) if cached_match
    
    response = conn.get('volumes', {q: search_info, maxResults: 5, printType: "books"})
    Rails.cache.write("match_params_#{search_info}", response.body, expires_in: 30.minutes)
    json_parse(response.body)
  end
  
  private
  
  def self.conn
    Faraday.new(url: "https://www.googleapis.com/books/v1/",
      headers: {'Content-Type' => 'application/json'})
  end

  def self.json_parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end