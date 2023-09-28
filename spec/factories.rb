FactoryBot.define do
  factory :user do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    email {"#{first_name}.#{last_name}@example.com".downcase}
    google_id {Faker::Number.number(digits: 12)}
    googke_token {Faker::Alphanumeric.alpha(number:15)}
    profile_picture {"picture.picture.com"}
    enum oauth_provider: {google: 0} 
  end

  factory :library do
    association :user
  end

  factory :cookbook do
    title {Faker::Book.title}
    isbn {Faker::Barcode.isbn}
    author {Faker::Book.author}
    publisher {Faker::Book.publisher}
    country_cuisine {Faker::Nation.nationality}
    association :library
  end

  factory :recipes do
    name {Faker::Food.dish}
    enum meal_time: {breakfast: 0, brunch: 1, lunch: 2, dinner: 3}
    enum meal_type: {appetizer: 0, salad: 1, entree: 2, dessert: 3, drink: 4}
    enum food_group: {grain: 0, protein: 1, fruit_vegetables: 2, dairy: 3}
    country_of_origin {Faker::Nation.nationality}
    page {Faker::Number.between(from: 10, to: 500)}
    association :cookbook
  end
end