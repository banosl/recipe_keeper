require 'rails_helper'

RSpec.describe Cookbook, type: :model do
  describe 'validations' do
    it {should validate_presence_of :title}
  end

  describe 'relationships' do
    it {should belong_to :library}
    it {should have_many :chapters}
    it {should have_many(:recipes).through(:chapters)}
  end
end