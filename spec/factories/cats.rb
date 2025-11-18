FactoryBot.define do
  factory :cat do
    name { "テストちゃん" }
    age { 5 }
    gender { "female" }
    prefecture_id { 1 }
    association :user
  end
end
