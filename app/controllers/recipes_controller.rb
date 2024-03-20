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
    # if chapter_params[:chapter]
    #   chapter = Chapter.find_by(cookbook_id: cookbook.id, name: chapter_params[:chapter])
    # elsif chapter_params[:new_chapter]
    #   chapter = Chapter.create({cookbook_id: cookbook.id, name: chapter_params[:new_chapter]})
    # end
    binding.pry
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
    params.require( :recipe ).permit(
                    :chapter,
                    :new_chapter
    )
  end
end