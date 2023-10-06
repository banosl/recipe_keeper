class CookbooksController <ApplicationController
  def new
    @user = User.find(params[:user_id])
    @cookbook = Cookbook.new
  end

  def match
    @user = User.find(params[:user_id])
    if params[:cookbook] && params[:cookbook][:title].blank?
      binding.pry
      redirect_to new_user_library_cookbook_path(@user.id, @user.library.id)
      flash.alert = "Please enter a title for your cookbook."
    end
    @cookbook = Cookbook.new(cookbook_params)
  end

  def create
    user = User.find(params[:user_id])
    cookbook = Cookbook.new(cookbook_params)
    if cookbook.save
      redirect_to user_libraries_path
    end
  end

  private

  def cookbook_params
    params.require(:cookbook).permit(:title,
                  :author,
                  :publisher,
                  :country_cuisine,
                  :isbn,
                  :library_id)
  end
end