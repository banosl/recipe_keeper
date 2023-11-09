# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_11_08_202157) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cookbooks", force: :cascade do |t|
    t.string "title"
    t.string "isbn"
    t.string "authors", array: true
    t.string "publisher"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "country_cuisine"
    t.bigint "library_id", null: false
    t.string "published_date"
    t.string "image_link"
    t.string "language"
    t.string "google_id"
    t.string "subtitle"
    t.string "description"
    t.index ["library_id"], name: "index_cookbooks_on_library_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.string "measurement_us"
    t.string "measurement_metric"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "libraries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_libraries_on_user_id", unique: true
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.float "quantity_us"
    t.float "quantity_metric"
    t.bigint "recipe_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.string "country_of_origin"
    t.integer "page"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "cookbook_id", null: false
    t.integer "meal_time"
    t.integer "meal_type"
    t.integer "food_group"
    t.index ["cookbook_id"], name: "index_recipes_on_cookbook_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "google_id"
    t.string "google_token"
    t.string "profile_picture"
    t.integer "oauth_provider"
  end

  add_foreign_key "cookbooks", "libraries"
  add_foreign_key "libraries", "users"
  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipes", "cookbooks"
end
