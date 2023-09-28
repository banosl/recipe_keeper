require 'rails_helper'

RSpec.describe Cookbook, type: :model do
  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :author}
    it {should validate_presence_of :publisher}
  end

  describe 'relationships' do
    it {should belong_to :library}
    it {should have_many :recipes}
  end
end