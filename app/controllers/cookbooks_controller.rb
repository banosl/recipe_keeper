class CookbooksController <ApplicationController
  def new
    @user = User.find(params[:user_id])
    @cookbook = Cookbook.new
    
    if params[:cookbook] && params[:cookbook][:title].blank?
      redirect_to(new_user_library_cookbook_path(@user.id, @user.library.id))
      flash.alert = "Please enter a title for your cookbook."
    elsif params[:commit] && params[:cookbook] 
      @cookbook_check = Cookbook.new(cookbook_params)
    end
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