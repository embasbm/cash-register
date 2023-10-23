FactoryBot.define do
  factory :line_item do
    cart { Cart.first }
    product { Product.first }
    quantity { 1 }
    price_cents { Product.first.price_cents }
  end
end
