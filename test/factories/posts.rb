FactoryBot.define do
  factory :post do
    title { "" }
    content { "MyText" }
    customer { nil }
    room { nil }
  end
end
