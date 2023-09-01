class SessionsController < ApplicationController
  def create
    user = User.find_or_create_user(user_params)
    session[:user_id] = user.id

    redirect_to user_libraries_path(session[:user_id])
  end
  
  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def user_params
    if !google_user_params[:google_id].nil?
      return google_user_params
    end
  end

  def google_user_params
    {
      first_name: auth_hash[:info][:first_name],
      last_name: auth_hash[:info][:last_name],
      email: auth_hash[:info][:email],
      google_id: auth_hash[:uid],
      google_token: auth_hash[:credentials][:token],
      profile_picture: auth_hash[:info][:image],
      oauth_provider: :google
    }
  end
end