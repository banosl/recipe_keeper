class Cookbook < ApplicationRecord
  validates_presence_of :title
  
  belongs_to :library
  has_many :recipes, dependent: :destroy
end