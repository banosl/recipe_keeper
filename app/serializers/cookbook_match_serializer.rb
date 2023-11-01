class CookbookMatchSerializer
  def self.match_data(cookbook_match, library_id)
    {
      title: cookbook_match.title,
      author: cookbook_match.authors,
      publisher: "",
      isbn: "",
      library_id: library_id
    }
  end
end