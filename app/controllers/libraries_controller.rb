class LibrariesController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find(session[:user_id])
    @cookbooks = @user.library.cookbooks
  end
end