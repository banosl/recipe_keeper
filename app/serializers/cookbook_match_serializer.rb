class CookbookMatchSerializer
  def self.match_data(cookbook_match, library_id)
    {
      title: cookbook_match.title,
      subtitle: cookbook_match.subtitle,
      authors: cookbook_match.authors,
      publisher: cookbook_match.publisher,
      published_date: cookbook_match.published_date,
      description: cookbook_match.description,
      image_link: cookbook_match.image_link,
      language: cookbook_match.language,
      isbn: cookbook_match.isbn,
      google_id: cookbook_match.google_id,
      library_id: library_id
    }
  end
end