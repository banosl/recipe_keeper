class CookbooksController <ApplicationController
  def new
    @user = User.find(params[:user_id])
    if params["commit"]
      @cookbook = Cookbook.new(cookbook_params)
    end
  end

  def create
    user = User.find(params[:user_id])
    cookbook = Cookbook.new(cookbook_params)
    if cookbook.save
      redirect_to user_libraries_path
    end
  end

  def confirm

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