class Library < ApplicationRecord
  belongs_to :user
  has_many :cookbooks, dependent: :destroy
end