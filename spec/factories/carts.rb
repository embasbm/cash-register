FactoryBot.define do
  factory :cart do
    total_price { 130 }
    user { User.first }
  end
end
