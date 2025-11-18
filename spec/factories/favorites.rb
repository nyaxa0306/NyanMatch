FactoryBot.define do
  factory :favorite do
    association :user
    association :cat
  end
end
