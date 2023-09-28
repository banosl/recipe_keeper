class Cookbook < ApplicationRecord
  validates_presence_of :title, :author, :publisher
  
  belongs_to :library
  has_many :recipes, dependent: :destroy
end