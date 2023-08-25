class Library < ApplicationRecord
  has_many :cookbooks, dependent: :destroy
end