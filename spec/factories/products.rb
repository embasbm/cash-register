FactoryBot.define do
  factory :product do
    code { "GR1" }
    name { "Green Tea" }
    price_cents { 311 }
    amount { 10 }
  end
end
