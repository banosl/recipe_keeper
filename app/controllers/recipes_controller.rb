class RecipesController < ApplicationController
  before_action :logged_in_user
  
  def new
    @user = User.find(session[:user_id])
  end
end