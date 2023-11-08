class Cookbook < ApplicationRecord
  validates_presence_of :title
  
  belongs_to :library
  has_many :recipes, dependent: :destroy

  def display_authors
    result = ""
    authors.each do |name|
      result += ", #{name}"
    end
    result.sub(", ", "")
  end
end