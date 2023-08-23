class Cookbook < ApplicationRecord
  validates_presence_of :name, :isbn, :author, :publisher
  
  belongs_to :user
  has_many :recipes
end