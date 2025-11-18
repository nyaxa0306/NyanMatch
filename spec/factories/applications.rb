FactoryBot.define do
  factory :application do
    message { "テスト" }
    status { :pending }
    association :user
    association :cat
  end
end
