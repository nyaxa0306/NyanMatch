FactoryBot.define do
  factory :user do
    nickname { "テスト君" }
    email { Faker::Internet.email }
    password { "password" }
    role { 0 }
  end
end
