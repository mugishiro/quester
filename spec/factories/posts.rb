FactoryBot.define do
  factory :post do
    content { "test text" }
    association :user
  end
end
