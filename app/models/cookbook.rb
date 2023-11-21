class Cookbook < ApplicationRecord
  validates_presence_of :title
  
  belongs_to :library
  has_many :chapters, dependent: :destroy
  has_many :recipes, through: :chapters
end