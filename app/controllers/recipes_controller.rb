class RecipesController < ApplicationController
  before_action :logged_in_user

  def new
    @user = User.find(session[:user_id])
    @cookbook = Cookbook.find(params[:cookbook_id])
    
    if params[:recipe]
      @recipe = Recipe.new(recipe_params)
    else
      @recipe = Recipe.new
    end
  end

  def create
    @user = User.find(session[:user_id])
    @cookbook = Cookbook.find(params[:cookbook_id])
    recipe = Recipe.new(recipe_params)

    #creating a chapter
    if chapter_params[:chapter_id] == "new"
      chapter = Chapter.create(name: chapter_params[:new_chapter_field], cookbook_id: params[:cookbook_id])
      recipe.update(chapter_id: chapter.id)
    end
    #errors
    
    if chapter_params[:chapter_id] == "new" && chapter_params[:new_chapter_field].blank?
      flash.alert = "When adding a new chapter, the 'New chapter name' field cannot be left blank."
      redirect_to new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id)
    elsif chapter_params[:chapter_id] == "new" && ["chapter", "new chapter", "add new chapter"].include?(chapter_params[:new_chapter_field].downcase)
      flash.alert = "A new chapter cannot be named '#{chapter_params[:new_chapter_field]}'."
      redirect_to new_user_library_cookbook_recipe_path(@user.id, @user.library.id, @cookbook.id)
    elsif recipe.save
      redirect_to user_library_cookbook_path(@user.id, @user.library.id, @cookbook.id)
    end
    
  end

  private

  def recipe_params
    params.require( :recipe ).permit(
                    :name,
                    :page,
                    :servings,
                    :prep_hours,
                    :prep_minutes,
                    :description,
                    :instructions,
                    :food_group,
                    :meal_type,
                    :chapter_id,
                    meal_time: [],
    )
  end

  def chapter_params
    params.require(:recipe).permit(
                   :chapter_id,
                   :new_chapter_field
    )
  end
end