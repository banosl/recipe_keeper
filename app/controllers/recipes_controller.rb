class RecipesController < ApplicationController
  before_action :logged_in_user

  def new
    @user = User.find(session[:user_id])
    @cookbook = Cookbook.find(params[:cookbook_id])
    @chapters = @cookbook.chapters.map {|chapter| chapter.name}.append("Add New Chapter").insert(0,"Chapters")
    
    if params[:recipe]
      @recipe = Recipe.new(recipe_params)
    else
      @recipe = Recipe.new
    end
  end

  def create
    user = User.find(session[:user_id])
    cookbook = Cookbook.find(params[:cookbook_id])
    binding.pry
  end

  private

  def recipe_params
    params.require(:recipe).permit(
                      :name,
                      :page,
                      :servings,
                      :prep_hours,
                      :prep_minutes,
                      :description,
                      :new_chapter,
                      :breakfast,
                      :brunch,
                      :lunch,
                      :dinner,
                      :snack,
                      :food_group,
                      :meal_type,
                      :chapter_id
    )
  end
end