class RecipesController < ApplicationController
  before_action :logged_in_user

  def new
    @user = User.find(session[:user_id])
    @cookbook = Cookbook.find(params[:cookbook_id])
    # @chapters = @cookbook.chapters.map {|chapter| chapter.name}.append("Add New Chapter").insert(0,"Chapters")
    
    if params[:recipe]
      @recipe = Recipe.new(recipe_params)
    else
      @recipe = Recipe.new
    end
  end

  def create
    user = User.find(session[:user_id])
    cookbook = Cookbook.find(params[:cookbook_id])
    recipe = Recipe.new(recipe_params)
    
    # binding.pry
    if recipe.save
      redirect_to user_library_cookbook_path(user.id, user.library.id, cookbook.id)
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
                    :new_chapter,
                    meal_time: [],
    )
  end
end