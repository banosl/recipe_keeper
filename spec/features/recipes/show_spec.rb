require 'rails_helper'

Rspec.describe "Recipe show page" do
  describe "Visiting the recipe show page with all fields entered" do
    it "displays recipe name, description, page, chapter, servings, prep time"

    it "displays meal times, food groups, dish type"

    it "displays instructions"
  end

  describe "Visiting the show page when fields are blank" do
    it "If a description, servings, prep time, meal time, food group, dish type, and instructions are missing then those categories don't show"
  end

  describe "Buttons" do
    it "the library link takes the user back to the library"

    it "back to cookbook button takes user back to the cookbook show page"

    it "edit recipe button takes the user to the edit form"

    it "delete recipe button deletes it and redirects user to the cookbook show page and the user can see that it's gone"
  end
end