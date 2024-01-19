class ApplicationController < ActionController::Base
  include SessionHelper

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to sign_in_index_path
    end
  end
end
