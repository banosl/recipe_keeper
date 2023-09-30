class LibrariesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @cookbooks = @user.library.cookbooks
  end
end