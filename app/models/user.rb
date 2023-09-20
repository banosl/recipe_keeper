class User < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email
  validates_uniqueness_of :email

  has_one :library, dependent: :destroy
  
  enum oauth_provider: [:google]

  def self.find_or_create_user(user_params)
    provider = user_params[:oauth_provider] 

    case provider
    when :google
      user = User.find_by(google_id: user_params[:google_id])
      
      if user.nil?
        user = User.create(user_params)
        user.create_library
      end
    end

    user
  end
end