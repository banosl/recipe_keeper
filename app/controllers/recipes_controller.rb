class RecipesController < ApplicationController
  before_action :logged_in_user

  def new
    @user = User.find(session[:user_id])
    @cookbook = Cookbook.find(params[:cookbook_id])
    # binding.pry
    if params[:recipe]
      @recipe = Recipe.new(recipe_params)
    else
      @recipe = Recipe.new
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(
                      :name,
                      :meal_time,
                      :meal_type,
                      :food_group,
                      :page,
                      :chapter_id
    )
  end
end