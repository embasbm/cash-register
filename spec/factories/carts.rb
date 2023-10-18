FactoryBot.define do
  factory :cart do
    total_price { 0 }
    user { User.first }
  end
end
