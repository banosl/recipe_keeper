FactoryBot.define do
  factory :user do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    email {"#{first_name}.#{last_name}@example.com".downcase}
    google_id {Faker::Number.number(digits: 12)}
    google_token {Faker::Alphanumeric.alpha(number:15)}
    profile_picture {"picture.picture.com"}
    
    trait :google do
      oauth_provider {:google}
    end
  end

  factory :library do
    association :user
  end

  factory :cookbook do
    title {Faker::Book.title}
    subtitle {Faker::Book.title}
    authors {[Faker::Book.author]}
    publisher {Faker::Book.publisher}
    country_cuisine {Faker::Nation.nationality}
    published_date {Faker::Date.in_date_period}
    image_link {"https://media.tenor.com/wDD-YmMOjgwAAAAC/pikachu-togepi.gif"}
    language {Faker::Nation.language}
    description {Faker::Food.description}
    association :library
  end

  factory :chapter do
    name {Faker::Food.ingredient}
    association :cookbook
  end

  factory :recipe do
    name {Faker::Food.dish}
    page {Faker::Number.between(from: 10, to: 500)}
    servings {Faker::Number.between(from: 2, to: 50)}
    prep_hours {Faker::Number.between(from: 0, to: 24)}
    prep_minutes {Faker::Number.between(from: 0, to: 60)}
    description {Faker::TvShows::DrWho.quote}
    instructions {Faker::TvShows::DrWho.quote}
    meal_time {["breakfast", "brunch"]}

    trait :appetizer do
      meal_type {:appetizer}
    end

    trait :salad do
      meal_type {:salad}
    end
    
    trait :entree do
      meal_type {:entree}
    end

    trait :dessert do
      meal_type {:dessert}
    end

    trait :drink do
      meal_type {:drink}
    end

    trait :grain do
      food_group {:grain}
    end

    trait :protein do
      food_group {:protein}
    end
    trait :fruit_vegetables do
      food_group {:fruit_vegetables}
    end
    trait :dairy do
      food_group {:dairy}
    end
    trait :other do
      food_group {:other}
    end

    association :chapter
  end
end