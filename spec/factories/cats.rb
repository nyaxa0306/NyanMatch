FactoryBot.define do
  factory :cat do
    name { "テストちゃん" }
    age { 5 }
    gender { "female" }
    association :user
  end
end
