FactoryBot.define do
  factory :user do
    nickname { "テスト君" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    introduction { "よろしくね" }
    role { :adopter }
  end
  factory :protector, class: "User" do
    nickname { "テストちゃん" }
    sequence(:email) { |n| "protector#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
    introduction { "よろしくね" }
    role { :protector }
  end
end
