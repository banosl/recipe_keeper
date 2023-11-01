class CookbooksController <ApplicationController
  def new
    @user = User.find(params[:user_id])
    if params[:cookbook]
      @cookbook = Cookbook.new(cookbook_params)
    else
      @cookbook = Cookbook.new
    end
  end

  def match
    @user = User.find(params[:user_id])
    if params[:cookbook] && params[:cookbook][:title].blank?
      redirect_to new_user_library_cookbook_path(@user.id, @user.library.id, cookbook: cookbook_params)
      flash.alert = "Please enter a title for your cookbook."
    end
    @cookbook = Cookbook.new(cookbook_params)
    @google_books_matches = CookbooksFacade.cookbook_matches(cookbook_params)
    @count = 1
  end

  def create
    user = User.find(params[:user_id])
    cookbook = Cookbook.new(cookbook_params)
    if cookbook.save
      redirect_to user_libraries_path
    else
      flash.alert = "Something went wrong. Please re-enter your cookbook's details."
      render :new
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