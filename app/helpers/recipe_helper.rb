module RecipeHelper
  def display_prep_time(recipe)
    if recipe.prep_hours == 1 && recipe.prep_minutes == 1
      return "Time to prepare: #{recipe.prep_hours} hour and #{recipe.prep_minutes} minute"
    elsif recipe.prep_hours == 1 
      return "Time to prepare: #{recipe.prep_hours} hour and #{recipe.prep_minutes} minutes"
    elsif recipe.prep_minutes == 1
      return "Time to prepare: #{recipe.prep_hours} hours and #{recipe.prep_minutes} minute"
    else
      return "Time to prepare: #{recipe.prep_hours} hours and #{recipe.prep_minutes} minutes"
    end
  end

  def display_servings(recipe)
    if @recipe.servings == 1
      return "#{@recipe.servings} serving"
    elsif !@recipe.servings.nil?
      return "#{@recipe.servings} servings"
    end
  end
end