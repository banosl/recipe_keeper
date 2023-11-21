require "rails_helper"

RSpec.describe Chapter, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should belong_to :cookbook}
    it {should have_many :recipes}
  end
end