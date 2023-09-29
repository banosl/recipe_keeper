class CookbooksController <ApplicationController
  def new
    @user = User.find(params[:user_id])
    binding.pry
  end

  #between new and create there is a confirmation of info and a call to book api to find matches

  def create
    user = User.find(params[:user_id])
    cookbook = Cookbook.new(cookbook_params)
    # binding.pry
    if cookbook.save
      redirect_to user_libraries_path
    end
  end

  private

  def cookbook_params
    params.permit(:title,
                  :author,
                  :publisher,
                  :country_cuisine,
                  :isbn,
                  :library_id)
  end
end