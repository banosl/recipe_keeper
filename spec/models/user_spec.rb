require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
  end

  describe 'relationships' do
    it {should have_one :library}
  end

  describe "#find_or_create_user" do
    before :each do
      @google_user_params = {
        first_name: "Carlos",
        last_name: "Segura",
        email: "carlos@gmail.com",
        google_id: "214435612436",
        google_token: "1234jkj;a3la-21j4",
        profile_picture: "address.com",
        oauth_provider: :google
      }
      
      @user_1 = User.find_or_create_user(@google_user_params)
    end
    
    it 'creates a google user' do
      expect(@user_1).to be_a(User)
      expect(@user_1.first_name).to eq("Carlos")
      expect(@user_1.last_name).to eq("Segura")
      expect(@user_1.email).to eq("carlos@gmail.com")
      expect(@user_1.google_id).to eq("214435612436")
      expect(@user_1.google_token).to eq("1234jkj;a3la-21j4")
      expect(@user_1.profile_picture).to eq("address.com")
      expect(@user_1.oauth_provider).to eq("google")
    end

    it 'finds a google user' do
      found_user = User.find_or_create_user({google_id: "214435612436", oauth_provider: :google})

      expect(found_user).to be_a(User)
      expect(found_user.first_name).to eq("Carlos")
      expect(found_user.last_name).to eq("Segura")
      expect(found_user.email).to eq("carlos@gmail.com")
      expect(found_user.google_id).to eq("214435612436")
      expect(found_user.google_token).to eq("1234jkj;a3la-21j4")
      expect(found_user.profile_picture).to eq("address.com")
      expect(found_user.oauth_provider).to eq("google")
    end
  end
end