FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "tester-#{n}@example.com" }
    uid { "123" }
    provider { "twitter" }
    username { "test_username" }
    nickname { "test_nickname" }
    password { "password" }
  end
end
