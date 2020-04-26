FactoryBot.define do
  factory :user do
    email  { "rspec_test@test.com" }
    uid { "123" }
    provider { "twitter" }
    username { "anonymous" }
    password { "password" }
  end
end
