FactoryBot.define do
  factory :reply do
    content { "test text" }
    association :post
  end
end
