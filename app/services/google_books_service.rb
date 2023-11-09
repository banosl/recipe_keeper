class GoogleBooksService
  def self.get_book_matches(search_info)
    response = conn.get('volumes', {q: search_info, maxResults: 5, printType: "books"})
    json_parse(response)
  end
  
  private
  
  def self.conn
    Faraday.new(url: "https://www.googleapis.com/books/v1/",
      headers: {'Content-Type' => 'application/json'})
  end

  def self.json_parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end