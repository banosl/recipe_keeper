require 'rails_helper'

RSpec.describe Library do
  describe 'relationships' do
    it {should have_many :cookbooks}
  end
end