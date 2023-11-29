class Cookbook < ApplicationRecord
  validates_presence_of :title
  
  belongs_to :library
  has_many :chapters, dependent: :destroy
  has_many :recipes, through: :chapters

  def recipe_count
    recipes.count
  end

  def published_year
    if published_date.nil?
      "Year unknown"
    else
      published_date.length == 4? published_date : DateTime.parse(published_date).to_date.year.to_s
    end
  end
end