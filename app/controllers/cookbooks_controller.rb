class CookbooksController <ApplicationController
  def show
    @user = User.find(params[:user_id])
    @cookbook = Cookbook.find(params[:id])
  end
  
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
    form_errors

    @cookbook = Cookbook.new(cookbook_params)
    @google_books_matches = CookbooksFacade.cookbook_matches(cookbook_params)
    @count = 1
  end

  def create
    user = User.find(params[:user_id])
    google_books_matches = CookbooksFacade.cookbook_matches(cookbook_params)

    if create_cookbook(google_books_matches, user).save
      redirect_to user_libraries_path
    else
      flash.alert = "Something went wrong. Please re-enter your cookbook's details."
      render :new
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @cookbook = Cookbook.find(params[:id])
  end

  def update
    binding.pry
  end

  def destroy
    user = User.find(params[:user_id])
    cookbook = Cookbook.find(params[:id])
    cookbook.destroy
    redirect_to user_libraries_path(user.id)
  end

  private

  def cookbook_params
    params.require(:cookbook).permit(
                      :title,
                      :publisher,
                      :country_cuisine,
                      :isbn,
                      :library_id,
                      authors: []
    )
  end

  def cookbook_match_params
    params.require(:cookbook).permit(
                      :user_entry,
                      :title,
                      :subtitle,
                      :authors,
                      :publisher,
                      :country_cuisine,
                      :isbn,
                      :description,
                      :language,
                      :google_id,
                      :library_id
    )                                
  end

  def form_errors
    if params[:cookbook]
      if params[:cookbook][:title].blank?
        redirect_to new_user_library_cookbook_path(@user.id, @user.library.id, cookbook: cookbook_params)
        flash.alert = "Please enter a title for your cookbook."
      elsif !params[:cookbook][:isbn].blank?
        isbn_form_errors
      end
    end
  end

  def isbn_form_errors
    isbn = params[:cookbook][:isbn]
    length = isbn.length
    if !isbn.scan(/\D/).empty?
      redirect_to new_user_library_cookbook_path(@user.id, @user.library.id, cookbook: cookbook_params)
      flash.alert = "Please check the ISBN. It should be all digits."
    elsif length < 10 || length > 13 || length == 12
      redirect_to new_user_library_cookbook_path(@user.id, @user.library.id, cookbook: cookbook_params)
      flash.alert = "Please check the ISBN. It should be either 10 or 13 digits in length."
    end
  end

  def create_cookbook(google_books_matches, user)
    if cookbook_match_params[:user_entry] == "true"
      cookbook = Cookbook.new(cookbook_params)
      cookbook.update!(isbn: nil)
    else
      index = cookbook_match_params[:user_entry].last.to_i - 1
      data = CookbookMatchSerializer.match_data(google_books_matches[index], user.library.id)
      cookbook = Cookbook.new(data)
    end
    cookbook
  end
end